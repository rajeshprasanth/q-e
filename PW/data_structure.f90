!
! Copyright (C) 2001-2010 Quantum ESPRESSO group
! This file is distributed under the terms of the
! GNU General Public License. See the file `License'
! in the root directory of the present distribution,
! or http://www.gnu.org/copyleft/gpl.txt .
!
!
!-----------------------------------------------------------------------
SUBROUTINE data_structure( gamma_only )
  !-----------------------------------------------------------------------
  ! this routine sets the data structure for the fft arrays
  ! (both the smooth and the dense grid)
  ! In the parallel case, it distributes columns to processes, too
  !
  USE kinds,      ONLY : DP
  USE io_global,  ONLY : stdout
  USE mp,         ONLY : mp_max
  USE mp_global,  ONLY : me_pool, nproc_pool, inter_pool_comm, intra_pool_comm, root_pool
  USE mp_global,  ONLY : get_ntask_groups
  USE fft_base,   ONLY : dfftp, dffts
  USE cell_base,  ONLY : bg, tpiba
  USE klist,      ONLY : xk, nks
  USE gvect,      ONLY : gcutm, gvect_init
  USE gvecs,      ONLY : gcutms, gvecs_init
  USE stick_set,  ONLY : pstickset
  USE wvfct,      ONLY : ecutwfc
  USE grid_dimensions,        ONLY : dense
  USE smooth_grid_dimensions, ONLY : smooth

#ifdef SOLVENT
  USE mp_global,  ONLY : me_pool, nproc_pool
#endif

  !
  IMPLICIT NONE
  LOGICAL, INTENT(in) :: gamma_only
  REAL (DP) :: gkcut
  INTEGER :: ik, ngm_, ngs_, ngw_ , nogrp
  !
  ! ... calculate gkcut = max |k+G|^2, in (2pi/a)^2 units
  !
  IF (nks == 0) THEN
     !
     ! if k-points are automatically generated (which happens later)
     ! use max(bg)/2 as an estimate of the largest k-point
     !
     gkcut = 0.5d0 * max ( &
        sqrt (sum(bg (1:3, 1)**2) ), &
        sqrt (sum(bg (1:3, 2)**2) ), &
        sqrt (sum(bg (1:3, 3)**2) ) )
  ELSE
     gkcut = 0.0d0
     DO ik = 1, nks
        gkcut = max (gkcut, sqrt ( sum(xk (1:3, ik)**2) ) )
     ENDDO
  ENDIF
  gkcut = (sqrt (ecutwfc) / tpiba + gkcut)**2
  !
  ! ... find maximum value among all the processors
  !
  CALL mp_max (gkcut, inter_pool_comm )
  !
  ! ... set up fft descriptors, including parallel stuff: sticks, planes, etc.
  !
  nogrp = get_ntask_groups()
  !
  CALL pstickset( gamma_only, bg, gcutm, gkcut, gcutms, &
                  dfftp, dffts, ngw_ , ngm_ , ngs_ , dense, smooth, me_pool, root_pool, nproc_pool, intra_pool_comm,   &
                  nogrp )
  !
  !     on output, ngm_ and ngs_ contain the local number of G-vectors
  !     for the two grids. Initialize local and global number of G-vectors
  !
  call gvect_init ( ngm_ , intra_pool_comm )
  call gvecs_init ( ngs_ , intra_pool_comm );
  !

#ifdef __SOLVENT
  CALL solvent_initgrid( dfftp%nr1, dfftp%nr2, dfftp%nr3, dfftp%nr1x, &
               dfftp%nr2x, dfftp%nr3x, me_pool, nproc_pool, dfftp%npp )
#endif

END SUBROUTINE data_structure

