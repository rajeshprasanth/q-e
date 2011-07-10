!
! Copyright (C) 2002-2005 Quantum ESPRESSO group
! This file is distributed under the terms of the
! GNU General Public License. See the file `License'
! in the root directory of the present distribution,
! or http://www.gnu.org/copyleft/gpl.txt .
!
!
!----------------------------------------------------------------------------
SUBROUTINE init_run()
  !----------------------------------------------------------------------------
  !
  ! ... this routine initialise the cp code and allocates (calling the
  ! ... appropriate routines) the memory
  !
  USE kinds,                    ONLY : DP
  USE control_flags,            ONLY : nbeg, nomore, lwf, iprsta, iprint, &
                                       ndr, tfor, tprnfor, tpre, &
                                       force_pairing, newnfi, tnewnfi, ndw
  USE cp_electronic_mass,       ONLY : emass, emass_cutoff
  USE ions_base,                ONLY : na, nax, nat, nsp, iforce, pmass, ityp, cdms
  USE ions_positions,           ONLY : tau0, taum, taup, taus, tausm, tausp, &
                                       vels, velsm, velsp, fion, fionm,      &
                                       atoms0, atomsm, atomsp
  USE gvecw,                    ONLY : ngw, ngw_g, ggp
  USE smallbox_gvec,                    ONLY : ngb
  USE gvecs,                    ONLY : ngms
  USE gvect,                    ONLY : ngm
  USE gvect,       ONLY : gstart
  USE grid_dimensions,          ONLY : dense
  USE fft_base,                 ONLY : dfftp
  USE electrons_base,           ONLY : nspin, nbsp, nbspx, nupdwn, f
  USE uspp,                     ONLY : nkb, vkb, deeq, becsum,nkbus
  USE core,                     ONLY : rhoc
  USE smooth_grid_dimensions,   ONLY : smooth
  USE wavefunctions_module,     ONLY : c0_bgrp, cm_bgrp, phi_bgrp
  USE ensemble_dft,             ONLY : tens, z0t
  USE cg_module,                ONLY : tcg
  USE electrons_base,           ONLY : nudx, nbnd
  USE efield_module,            ONLY : tefield, tefield2
  USE uspp_param,               ONLY : nhm
  USE ions_nose,                ONLY : xnhp0, xnhpm, vnhp, nhpcl, nhpdim
  USE cell_base,                ONLY : h, hold, hnew, velh, tpiba2, ibrav, &
                                       alat, celldm, at, bg
  USE cp_main_variables,        ONLY : lambda, lambdam, lambdap, ema0bg, &
                                       sfac, eigr, taub, &
                                       irb, eigrb, rhog, rhos, rhor,     &
                                       acc, acc_this_run, wfill, &
                                       edft, nfi, vpot, ht0, htm, iprint_stdout
  USE cp_main_variables,        ONLY : allocate_mainvar, nlax, descla, nrlx, nlam
  USE energies,                 ONLY : eself, enl, ekin, etot, enthal, ekincm
  USE dener,                    ONLY : detot
  USE time_step,                ONLY : dt2, delt, tps
  USE electrons_nose,           ONLY : xnhe0, xnhem, vnhe
  USE electrons_base,           ONLY : nbspx_bgrp
  USE cell_nose,                ONLY : xnhh0, xnhhm, vnhh
  USE funct,                    ONLY : dft_is_meta
  USE metagga,                  ONLY : crosstaus, dkedtaus, gradwfc
  !
  USE efcalc,                   ONLY : clear_nbeg
  USE local_pseudo,             ONLY : allocate_local_pseudo
  USE cp_electronic_mass,       ONLY : emass_precond
  USE wannier_subroutines,      ONLY : wannier_startup
  USE cp_interfaces,            ONLY : readfile
  USE ions_base,                ONLY : ions_cofmass
  USE ensemble_dft,             ONLY : id_matrix_init, allocate_ensemble_dft, h_matrix_init
  USE efield_module,            ONLY : allocate_efield, allocate_efield2
  USE cg_module,                ONLY : allocate_cg
  USE wannier_module,           ONLY : allocate_wannier  
  USE io_files,                 ONLY : tmp_dir, prefix
  USE io_global,                ONLY : ionode, stdout
  USE printout_base,            ONLY : printout_base_init
  USE wave_types,               ONLY : wave_descriptor_info
  USE xml_io_base,              ONLY : restart_dir, create_directory, change_directory
  USE orthogonalize_base,       ONLY : mesure_diag_perf, mesure_mmul_perf
  USE ions_base,                ONLY : ions_reference_positions, cdmi, taui
  USE mp_global,                ONLY : nimage, my_image_id, nbgrp, me_image, intra_image_comm
  USE mp,                       ONLY : mp_barrier
  USE wrappers
  USE ldaU_cp
  !
  IMPLICIT NONE
  !
  INTEGER            :: i
  CHARACTER(LEN=256) :: dirname
  REAL(DP)           :: a1(3), a2(3), a3(3)
  LOGICAL            :: ftest
  !
  !
  CALL start_clock( 'initialize' )
  !
  ! ... initialize directories
  !
  IF( nimage > 1 ) THEN
     !
     ! ... When bgrps are used, open a directory for each one
     !
     WRITE( dirname, FMT = '( I5.5 )' ) my_image_id
     tmp_dir = TRIM( tmp_dir ) // '/' // TRIM( dirname )
     CALL create_directory( tmp_dir )
     !CALL change_directory( tmp_dir )
     IF( me_image == 0 ) THEN
        INQUIRE( FILE='plumed.dat', EXIST=ftest )
        IF( ftest ) THEN
          i = f_link( '../../plumed.dat', TRIM(tmp_dir)//'/'//'plumed.dat' )
        END IF 
     END IF
     CALL mp_barrier( intra_image_comm )
     !
  END IF

  CALL plugin_initialization()

  IF( nbgrp > 1 .AND. force_pairing ) &
     CALL errore( ' init_run ', ' force_pairing with parallelization over bands not implemented yet ', 1 )
  !
  CALL printout_base_init( tmp_dir, prefix )
  !
  dirname = restart_dir( tmp_dir, ndw )
  !
  ! ... Create main restart directory
  !
  CALL create_directory( dirname )
  !
  ! ... initialize g-vectors, fft grids 
  ! ... The number of g-vectors are based on the input celldm!
  !
  CALL init_dimensions()
  !
  ! ... initialize atomic positions and cell
  !
  CALL init_geometry()
  !
  ! ... mesure performances of parallel routines
  !
  CALL mesure_mmul_perf( nudx )
  !
  CALL mesure_diag_perf( nudx )
  !
  IF ( lwf ) CALL clear_nbeg( nbeg )
  !
  !=======================================================================
  !     allocate and initialize nonlocal potentials
  !=======================================================================
  !
  CALL nlinit()
  !
  !=======================================================================
  !     allocation of all arrays not already allocated in init and nlinit
  !=======================================================================
  !
  CALL allocate_mainvar( ngw, ngw_g, ngb, ngms, ngm, dense%nr1,dense%nr2,dense%nr3, dfftp%nr1x, &
                         dfftp%nr2x, dfftp%npl, dense%nrxx, smooth%nrxx, nat, nax, nsp,   &
                         nspin, nbsp, nbspx, nupdwn, nkb, gstart, nudx, &
                         tpre, nbspx_bgrp )
  !
  CALL allocate_local_pseudo( ngms, nsp )
  !
  !  initialize wave functions descriptors and allocate wf
  !
  ALLOCATE( c0_bgrp( ngw, nbspx ) )
  ALLOCATE( cm_bgrp( ngw, nbspx ) )
  ALLOCATE( phi_bgrp( ngw, nbspx ) )
  !
  IF ( iprsta > 2 ) THEN
     !
     CALL wave_descriptor_info( wfill, 'wfill', stdout )
     !
  END IF
  !
  ! Depending on the verbosity set the frequency of
  ! verbose information to stdout
  !
  IF( iprsta < 1 ) iprint_stdout = 100 * iprint
  IF( iprsta ==1 ) iprint_stdout = 10 * iprint
  IF( iprsta > 1 ) iprint_stdout = iprint
  !
  acc          = 0.D0
  acc_this_run = 0.D0
  !
  edft%ent  = 0.D0
  edft%esr  = 0.D0
  edft%evdw = 0.D0
  edft%ekin = 0.D0
  edft%enl  = 0.D0
  edft%etot = 0.D0
  !
  ALLOCATE( becsum(  nhm*(nhm+1)/2, nat, nspin ) )
  ALLOCATE( deeq( nhm, nhm, nat, nspin ) )
  IF ( tpre ) THEN
     ! ALLOCATE( drhovan( nhm*(nhm+1)/2, nat, nspin, 3, 3 ) )
  END IF
  !
  ALLOCATE( vkb( ngw, nkb ) )
  !
  IF ( dft_is_meta() .AND. tens ) &
     CALL errore( ' init_run ', 'ensemble_dft not implimented for metaGGA', 1 )
  !
  IF ( dft_is_meta() .AND. nbgrp > 1 ) &
     CALL errore( ' init_run ', 'band parallelization not implimented for metaGGA', 1 )
  !
  IF ( dft_is_meta() .AND. tpre ) THEN
     !
     ALLOCATE( crosstaus( smooth%nrxx, 6, nspin ) )
     ALLOCATE( dkedtaus(  smooth%nrxx, 3, 3, nspin ) )
     ALLOCATE( gradwfc(   smooth%nrxx, 3 ) )
     !
  END IF
  !
  IF ( lwf ) THEN
     IF( nbgrp > 1 ) &
        CALL errore( ' init_run ', ' wannier with band paralleliztion not implemented ', 1 )
     CALL allocate_wannier( nbsp, smooth%nrxx, nspin, ngm )
  END IF
  !
  IF ( tens .OR. tcg ) THEN
     IF( nbgrp > 1 ) &
        CALL errore( ' init_run ', ' ensemble_dft with band paralleliztion not implemented ', 1 )
     CALL allocate_ensemble_dft( nkb, nbsp, ngw, nudx, nspin, nbspx, smooth%nrxx, nat, nlax, nrlx )
  END IF
  !
  IF ( tcg ) THEN 
     IF( nbgrp > 1 ) &
        CALL errore( ' init_run ', ' cg with band paralleliztion not implemented ', 1 )
     CALL allocate_cg( ngw, nbspx,nkbus )
  END IF
  !
  IF ( tefield ) THEN
     IF( nbgrp > 1 ) &
        CALL errore( ' init_run ', ' efield with band paralleliztion not implemented ', 1 )
     CALL allocate_efield( ngw, ngw_g, nbspx, nhm, nax, nsp )
  END IF
  IF ( tefield2 ) THEN
     IF( nbgrp > 1 ) &
        CALL errore( ' init_run ', ' efield with band paralleliztion not implemented ', 1 )
     CALL allocate_efield2( ngw, nbspx, nhm, nax, nsp )
  END IF
  !
  IF ( ALLOCATED( deeq ) ) deeq(:,:,:,:) = 0.D0
  !
  IF ( ALLOCATED( lambda  ) ) lambda  = 0.D0
  IF ( ALLOCATED( lambdam ) ) lambdam = 0.D0
  !
  taum  = tau0
  taup  = 0.D0
  tausm = taus
  tausp = 0.D0
  vels  = 0.D0
  velsm = 0.D0
  velsp = 0.D0
  !
  hnew = h
  !
  cm_bgrp  = ( 0.D0, 0.D0 )
  c0_bgrp  = ( 0.D0, 0.D0 )
  phi_bgrp = ( 0.D0, 0.D0 )
  !
  IF ( tens ) then
     CALL id_matrix_init( descla, nspin )
     CALL h_matrix_init( descla, nspin )
  ENDIF
  !
  a1(:)=at(:,1)*alat; a2(:)=at(:,2)*alat; a3(:)=at(:,3)*alat 
  IF ( lwf ) CALL wannier_startup( ibrav, alat, a1, a2, a3, &
                                   bg(:,1), bg(:,2), bg(:,3) )
  !
  ! ... Calculate: ema0bg = ecutmass /  MAX( 1.0d0, (2pi/alat)^2 * |G|^2 )
  !
  CALL emass_precond( ema0bg, ggp, ngw, tpiba2, emass_cutoff )
  !
  CALL print_legend( )
  !
  CALL ldaU_init()
  !
  IF ( nbeg < 0 ) THEN
     !
     !======================================================================
     !     Initialize from scratch nbeg = -1
     !======================================================================
     !
     nfi = 0
     !
     CALL from_scratch( )
     !
  ELSE
     !
     !======================================================================
     !     nbeg = 0, nbeg = 1
     !======================================================================
     !
     i = 1  
     CALL readfile( i, h, hold, nfi, c0_bgrp, cm_bgrp, taus,   &
                    tausm, vels, velsm, acc, lambda, lambdam, xnhe0, xnhem, &
                    vnhe, xnhp0, xnhpm, vnhp,nhpcl,nhpdim,ekincm, xnhh0, xnhhm,&
                    vnhh, velh, fion, tps, z0t, f )
     !
     CALL from_restart( )
     !
  END IF
  !
  !=======================================================================
  !     restart with new averages and nfi=0
  !=======================================================================
  !
  ! ... reset some variables if nbeg < 0 
  ! ... ( new simulation or step counter reset to 0 )
  !
  IF ( nbeg <= 0 ) THEN
     !
     acc = 0.D0
     nfi = 0
     !
  END IF
  !
  IF ( .NOT. tfor .AND. .NOT. tprnfor ) fion(:,:) = 0.D0
  !
  IF ( tnewnfi ) nfi = newnfi 
  !
  nomore = nomore + nfi
  !
  !  Set center of mass for scaled coordinates
  !
  CALL ions_cofmass( taus, pmass, na, nsp, cdms )
  !
  IF ( nbeg <= 0 .OR. lwf ) THEN
     !
     CALL ions_reference_positions( tau0 )
     !
  END IF
  !
  CALL stop_clock( 'initialize' )
  !
  RETURN
  !
END SUBROUTINE init_run
