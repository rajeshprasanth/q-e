! Copyright (C) 2004 Giovanni Bussi
!
! This library is free software; you can redistribute it and/or
! modify it under the terms of the GNU Lesser General Public
! License as published by the Free Software Foundation; either
! version 2.1 of the License, or (at your option) any later version.
!
# 47 "iotk_attr.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_attr.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_attr.spp"

# 59 "iotk_attr.spp"

#ifdef __IOTK_REAL1
#if 0 <= __IOTK_MAXRANK

# 64 "iotk_attr.spp"
! This is needed as a workaround for bugged pack 
subroutine iotk_private_pack_REAL1(out,in,n,l)
    use iotk_base
    implicit none
    integer,                                    intent(in)  :: n,l
# 73 "iotk_attr.spp"
    REAL (kind=__IOTK_REAL1), intent(out) :: out(n)
    REAL (kind=__IOTK_REAL1), intent(in)  :: in(n)
# 76 "iotk_attr.spp"
    out = in
end subroutine iotk_private_pack_REAL1

# 81 "iotk_attr.spp"
subroutine iotk_write_REAL1(val,string,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_xtox_interf
  use iotk_fmt_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  REAL(kind=__IOTK_REAL1), intent(in) :: val(:)
#ifdef __IOTK_WORKAROUND6
  character(len=*)              :: string
#else
  character(len=*), intent(out) :: string
#endif
  integer, intent(out) :: ierr
  character(len=100) :: tmpval
  integer :: index,iostat
  ierr = 0
  iostat = 0 
  string(1:1) = iotk_eos
  if(size(val)==0) return
  if(len(string)==0) then
    call iotk_error_issue(ierr,"iotk_write",__FILE__,__LINE__)
# 103 "iotk_attr.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.7 ")
    return
  end if
  do index=1,size(val)
# 120 "iotk_attr.spp"
    write(tmpval,trim(iotk_wfmt("REAL",kind(val),size(val),-1)),iostat=iostat) val(index)
    if(iostat/=0) then
      call iotk_error_issue(ierr,"iotk_write",__FILE__,__LINE__)
# 122 "iotk_attr.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.7 ")
# 122 "iotk_attr.spp"
call iotk_error_msg(ierr,' ')
# 122 "iotk_attr.spp"
call iotk_error_write(ierr,"iostat",iostat)
      return
    end if
    call iotk_strcat(string,trim(adjustl(tmpval))//" ",ierr)
    if(ierr/=0) then
      call iotk_error_issue(ierr,"iotk_write",__FILE__,__LINE__)
# 127 "iotk_attr.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.7 ")
      return
    end if
# 131 "iotk_attr.spp"
  end do
! taglio l'ultimo spazio
  string(iotk_strlen(string):iotk_strlen(string)) = iotk_eos
end subroutine iotk_write_REAL1
# 137 "iotk_attr.spp"

# 141 "iotk_attr.spp"
subroutine iotk_read_REAL1(val,string,index,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_xtox_interf
  use iotk_misc_interf
  implicit none
  REAL(kind=__IOTK_REAL1), intent(inout) :: val(:)
  character(len=*), intent(in) :: string
  integer, intent(inout) :: index
  integer, intent(out) :: ierr
  logical :: check
  integer :: pos,pos1,iostat
  integer :: maxindex
# 158 "iotk_attr.spp"
  pos = 0
  pos1= 0
  ierr = 0
  iostat = 0
# 165 "iotk_attr.spp"
    maxindex = size(val)
# 167 "iotk_attr.spp"
! PER ORA CONSIDERA LE VIRGOLE COME SPAZII
  do
    pos = verify(string(pos1+1:)," ,")+pos1
    if(pos==pos1) exit
    pos = pos - 1
    pos1 = scan(string(pos+1:)," ,")+pos
    if(pos1==pos) pos1 = len(string) + 1
!LEGGI string(pos+1:pos1-1)
    index = index+1
    if(index>maxindex) then
      call iotk_error_issue(ierr,"iotk_read",__FILE__,__LINE__)
# 177 "iotk_attr.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.7 ")
# 177 "iotk_attr.spp"
call iotk_error_msg(ierr,'Too many data')
    end if
# 184 "iotk_attr.spp"
    read(string(pos+1:pos1-1),"(G100.95)",iostat=iostat) val(index)
# 200 "iotk_attr.spp"
    if(iostat/=0) then
      call iotk_error_issue(ierr,"iotk_read",__FILE__,__LINE__)
# 201 "iotk_attr.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.7 ")
# 201 "iotk_attr.spp"
call iotk_error_msg(ierr,'Error reading from string')
# 201 "iotk_attr.spp"
call iotk_error_write(ierr,"string",string(pos+1:pos1-1))
# 201 "iotk_attr.spp"
call iotk_error_write(ierr,"iostat",iostat)
      return
    end if
# 205 "iotk_attr.spp"
    if(pos1>=len(string)) exit
  end do
end subroutine iotk_read_REAL1
# 210 "iotk_attr.spp"

# 213 "iotk_attr.spp"
subroutine iotk_write_attr_REAL1_0(attr,name,val,dummy,first,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*), intent(inout) :: attr
  character(*), intent(in)    :: name
  REAL(kind=__IOTK_REAL1), intent(in)  :: val 
  type(iotk_dummytype), optional :: dummy
  logical, optional, intent(in)  :: first
  integer, optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen
  integer :: vallen
  integer :: namlen
  integer :: iostat
  character :: delim
# 235 "iotk_attr.spp"
  character(iotk_vallenx) :: tmpval
  ierrl = 0
  iostat = 0
  if(present(first)) then
    if(first) attr(1:1) = iotk_eos
  end if
  if(.not.iotk_check_name(name)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Wrong tag name')
# 242 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",trim(name))
    goto 1
  end if
  attlen = iotk_strlen(attr)
  if(attlen==len(attr)) attlen = len_trim(attr)
  namlen = len_trim(name)
# 262 "iotk_attr.spp"
  delim = '"'
# 264 "iotk_attr.spp"
  call iotk_write((/val/),tmpval,ierrl)
# 268 "iotk_attr.spp"
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 269 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 273 "iotk_attr.spp"
  vallen = iotk_strlen(tmpval)
  if(attlen+vallen+namlen+5>len(attr)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute dummy argument is too short')
    goto 1
  end if
  attr(attlen+1:attlen+vallen+namlen+5) = " "//trim(name)//"="//delim//tmpval(1:vallen)//delim//iotk_eos
1 continue
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_attr_REAL1_0

# 288 "iotk_attr.spp"
subroutine iotk_scan_attr_REAL1_0(attr,name,val,dummy,found,default,eos,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_read
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*),             intent(in)  :: attr
  character(*),             intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL(kind=__IOTK_REAL1)                        :: val 
#else
  REAL(kind=__IOTK_REAL1), intent(out)           :: val 
#endif
  type(iotk_dummytype), optional :: dummy
  logical,        optional, intent(out) :: found
  REAL(kind=__IOTK_REAL1), optional, intent(in)  :: default 
  logical,        optional, intent(in)  :: eos
  integer,        optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen,pos,equal
  character :: delim
  logical :: foundl
  character(iotk_vallenx) :: valc
# 317 "iotk_attr.spp"
  integer :: index
  REAL(kind=__IOTK_REAL1), allocatable :: tmpval (:)
# 320 "iotk_attr.spp"
  ierrl = 0
  attlen=iotk_strlen(attr)
  foundl = .false.
  equal = 0
  do
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) exit
    equal = equal + pos
    pos = scan(attr(equal+1:attlen),"=")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,'')
# 330 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",attr(equal+1:attlen))
      goto 1
    end if
    equal = equal + pos
    if(trim(attr(equal-pos:equal-1))==trim(name)) foundl = .true.
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 337 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    equal = equal + pos
    delim = attr(equal:equal)
    if(delim/="'" .and. delim/='"') then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 343 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    pos = scan(attr(equal+1:attlen),delim)
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 348 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    if(foundl) exit
    equal = equal + pos
  end do
  if(foundl) then
    call iotk_strcpy(valc,attr(equal+1:equal+pos-1),ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 357 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
  else
    goto 1
  end if
# 380 "iotk_attr.spp"
  allocate(tmpval(1))
  index = 0
  call iotk_read(tmpval,valc(1:iotk_strlen(valc)),index,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 384 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 390 "iotk_attr.spp"
  if(index/=1) then
# 392 "iotk_attr.spp"
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute size does not match')
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",valc)
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"size",size(tmpval))
    goto 1
  end if
# 396 "iotk_attr.spp"
  val = tmpval(1)
# 400 "iotk_attr.spp"
  deallocate(tmpval)
# 402 "iotk_attr.spp"
1 continue
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute not found')
# 406 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if
  if(present(default) .and. .not. foundl) then
# 419 "iotk_attr.spp"
    val = default
# 421 "iotk_attr.spp"
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_attr_REAL1_0
# 429 "iotk_attr.spp"

#endif
#endif

subroutine iotk_attr_dummy_REAL1_0
  write(0,*)
end subroutine iotk_attr_dummy_REAL1_0

# 45 "iotk_attr.spp"

# 47 "iotk_attr.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_attr.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_attr.spp"

# 59 "iotk_attr.spp"

#ifdef __IOTK_REAL1
#if 1 <= __IOTK_MAXRANK

# 137 "iotk_attr.spp"

# 210 "iotk_attr.spp"

# 213 "iotk_attr.spp"
subroutine iotk_write_attr_REAL1_1(attr,name,val,dummy,first,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*), intent(inout) :: attr
  character(*), intent(in)    :: name
  REAL(kind=__IOTK_REAL1), intent(in)  :: val (:)
  type(iotk_dummytype), optional :: dummy
  logical, optional, intent(in)  :: first
  integer, optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen
  integer :: vallen
  integer :: namlen
  integer :: iostat
  character :: delim
# 235 "iotk_attr.spp"
  character(iotk_vallenx) :: tmpval
  ierrl = 0
  iostat = 0
  if(present(first)) then
    if(first) attr(1:1) = iotk_eos
  end if
  if(.not.iotk_check_name(name)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Wrong tag name')
# 242 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",trim(name))
    goto 1
  end if
  attlen = iotk_strlen(attr)
  if(attlen==len(attr)) attlen = len_trim(attr)
  namlen = len_trim(name)
# 262 "iotk_attr.spp"
  delim = '"'
# 266 "iotk_attr.spp"
  call iotk_write(pack(val,mask=.true.),tmpval,ierrl)
# 268 "iotk_attr.spp"
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 269 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 273 "iotk_attr.spp"
  vallen = iotk_strlen(tmpval)
  if(attlen+vallen+namlen+5>len(attr)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute dummy argument is too short')
    goto 1
  end if
  attr(attlen+1:attlen+vallen+namlen+5) = " "//trim(name)//"="//delim//tmpval(1:vallen)//delim//iotk_eos
1 continue
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_attr_REAL1_1

# 288 "iotk_attr.spp"
subroutine iotk_scan_attr_REAL1_1(attr,name,val,dummy,found,default,eos,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_read
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*),             intent(in)  :: attr
  character(*),             intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL(kind=__IOTK_REAL1)                        :: val (:)
#else
  REAL(kind=__IOTK_REAL1), intent(out)           :: val (:)
#endif
  type(iotk_dummytype), optional :: dummy
  logical,        optional, intent(out) :: found
  REAL(kind=__IOTK_REAL1), optional, intent(in)  :: default (:)
  logical,        optional, intent(in)  :: eos
  integer,        optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen,pos,equal
  character :: delim
  logical :: foundl
  character(iotk_vallenx) :: valc
# 317 "iotk_attr.spp"
  integer :: index
  REAL(kind=__IOTK_REAL1), allocatable :: tmpval (:)
# 320 "iotk_attr.spp"
  ierrl = 0
  attlen=iotk_strlen(attr)
  foundl = .false.
  equal = 0
  do
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) exit
    equal = equal + pos
    pos = scan(attr(equal+1:attlen),"=")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,'')
# 330 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",attr(equal+1:attlen))
      goto 1
    end if
    equal = equal + pos
    if(trim(attr(equal-pos:equal-1))==trim(name)) foundl = .true.
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 337 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    equal = equal + pos
    delim = attr(equal:equal)
    if(delim/="'" .and. delim/='"') then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 343 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    pos = scan(attr(equal+1:attlen),delim)
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 348 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    if(foundl) exit
    equal = equal + pos
  end do
  if(foundl) then
    call iotk_strcpy(valc,attr(equal+1:equal+pos-1),ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 357 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
  else
    goto 1
  end if
# 380 "iotk_attr.spp"
  allocate(tmpval(size(val)))
  index = 0
  call iotk_read(tmpval,valc(1:iotk_strlen(valc)),index,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 384 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 390 "iotk_attr.spp"
  if(index/=size(val)) then
# 392 "iotk_attr.spp"
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute size does not match')
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",valc)
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"size",size(tmpval))
    goto 1
  end if
# 398 "iotk_attr.spp"
  val = reshape (source=tmpval,shape=shape(val))
# 400 "iotk_attr.spp"
  deallocate(tmpval)
# 402 "iotk_attr.spp"
1 continue
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute not found')
# 406 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if
  if(present(default) .and. .not. foundl) then
# 419 "iotk_attr.spp"
    val = default
# 421 "iotk_attr.spp"
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_attr_REAL1_1
# 429 "iotk_attr.spp"

#endif
#endif

subroutine iotk_attr_dummy_REAL1_1
  write(0,*)
end subroutine iotk_attr_dummy_REAL1_1

# 45 "iotk_attr.spp"

# 47 "iotk_attr.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_attr.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_attr.spp"

# 59 "iotk_attr.spp"

#ifdef __IOTK_REAL1
#if 2 <= __IOTK_MAXRANK

# 137 "iotk_attr.spp"

# 210 "iotk_attr.spp"

# 213 "iotk_attr.spp"
subroutine iotk_write_attr_REAL1_2(attr,name,val,dummy,first,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*), intent(inout) :: attr
  character(*), intent(in)    :: name
  REAL(kind=__IOTK_REAL1), intent(in)  :: val (:,:)
  type(iotk_dummytype), optional :: dummy
  logical, optional, intent(in)  :: first
  integer, optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen
  integer :: vallen
  integer :: namlen
  integer :: iostat
  character :: delim
# 235 "iotk_attr.spp"
  character(iotk_vallenx) :: tmpval
  ierrl = 0
  iostat = 0
  if(present(first)) then
    if(first) attr(1:1) = iotk_eos
  end if
  if(.not.iotk_check_name(name)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Wrong tag name')
# 242 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",trim(name))
    goto 1
  end if
  attlen = iotk_strlen(attr)
  if(attlen==len(attr)) attlen = len_trim(attr)
  namlen = len_trim(name)
# 262 "iotk_attr.spp"
  delim = '"'
# 266 "iotk_attr.spp"
  call iotk_write(pack(val,mask=.true.),tmpval,ierrl)
# 268 "iotk_attr.spp"
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 269 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 273 "iotk_attr.spp"
  vallen = iotk_strlen(tmpval)
  if(attlen+vallen+namlen+5>len(attr)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute dummy argument is too short')
    goto 1
  end if
  attr(attlen+1:attlen+vallen+namlen+5) = " "//trim(name)//"="//delim//tmpval(1:vallen)//delim//iotk_eos
1 continue
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_attr_REAL1_2

# 288 "iotk_attr.spp"
subroutine iotk_scan_attr_REAL1_2(attr,name,val,dummy,found,default,eos,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_read
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*),             intent(in)  :: attr
  character(*),             intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL(kind=__IOTK_REAL1)                        :: val (:,:)
#else
  REAL(kind=__IOTK_REAL1), intent(out)           :: val (:,:)
#endif
  type(iotk_dummytype), optional :: dummy
  logical,        optional, intent(out) :: found
  REAL(kind=__IOTK_REAL1), optional, intent(in)  :: default (:,:)
  logical,        optional, intent(in)  :: eos
  integer,        optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen,pos,equal
  character :: delim
  logical :: foundl
  character(iotk_vallenx) :: valc
# 317 "iotk_attr.spp"
  integer :: index
  REAL(kind=__IOTK_REAL1), allocatable :: tmpval (:)
# 320 "iotk_attr.spp"
  ierrl = 0
  attlen=iotk_strlen(attr)
  foundl = .false.
  equal = 0
  do
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) exit
    equal = equal + pos
    pos = scan(attr(equal+1:attlen),"=")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,'')
# 330 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",attr(equal+1:attlen))
      goto 1
    end if
    equal = equal + pos
    if(trim(attr(equal-pos:equal-1))==trim(name)) foundl = .true.
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 337 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    equal = equal + pos
    delim = attr(equal:equal)
    if(delim/="'" .and. delim/='"') then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 343 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    pos = scan(attr(equal+1:attlen),delim)
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 348 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    if(foundl) exit
    equal = equal + pos
  end do
  if(foundl) then
    call iotk_strcpy(valc,attr(equal+1:equal+pos-1),ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 357 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
  else
    goto 1
  end if
# 380 "iotk_attr.spp"
  allocate(tmpval(size(val)))
  index = 0
  call iotk_read(tmpval,valc(1:iotk_strlen(valc)),index,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 384 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 390 "iotk_attr.spp"
  if(index/=size(val)) then
# 392 "iotk_attr.spp"
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute size does not match')
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",valc)
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"size",size(tmpval))
    goto 1
  end if
# 398 "iotk_attr.spp"
  val = reshape (source=tmpval,shape=shape(val))
# 400 "iotk_attr.spp"
  deallocate(tmpval)
# 402 "iotk_attr.spp"
1 continue
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute not found')
# 406 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if
  if(present(default) .and. .not. foundl) then
# 419 "iotk_attr.spp"
    val = default
# 421 "iotk_attr.spp"
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_attr_REAL1_2
# 429 "iotk_attr.spp"

#endif
#endif

subroutine iotk_attr_dummy_REAL1_2
  write(0,*)
end subroutine iotk_attr_dummy_REAL1_2

# 45 "iotk_attr.spp"

# 47 "iotk_attr.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_attr.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_attr.spp"

# 59 "iotk_attr.spp"

#ifdef __IOTK_REAL1
#if 3 <= __IOTK_MAXRANK

# 137 "iotk_attr.spp"

# 210 "iotk_attr.spp"

# 213 "iotk_attr.spp"
subroutine iotk_write_attr_REAL1_3(attr,name,val,dummy,first,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*), intent(inout) :: attr
  character(*), intent(in)    :: name
  REAL(kind=__IOTK_REAL1), intent(in)  :: val (:,:,:)
  type(iotk_dummytype), optional :: dummy
  logical, optional, intent(in)  :: first
  integer, optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen
  integer :: vallen
  integer :: namlen
  integer :: iostat
  character :: delim
# 235 "iotk_attr.spp"
  character(iotk_vallenx) :: tmpval
  ierrl = 0
  iostat = 0
  if(present(first)) then
    if(first) attr(1:1) = iotk_eos
  end if
  if(.not.iotk_check_name(name)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Wrong tag name')
# 242 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",trim(name))
    goto 1
  end if
  attlen = iotk_strlen(attr)
  if(attlen==len(attr)) attlen = len_trim(attr)
  namlen = len_trim(name)
# 262 "iotk_attr.spp"
  delim = '"'
# 266 "iotk_attr.spp"
  call iotk_write(pack(val,mask=.true.),tmpval,ierrl)
# 268 "iotk_attr.spp"
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 269 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 273 "iotk_attr.spp"
  vallen = iotk_strlen(tmpval)
  if(attlen+vallen+namlen+5>len(attr)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute dummy argument is too short')
    goto 1
  end if
  attr(attlen+1:attlen+vallen+namlen+5) = " "//trim(name)//"="//delim//tmpval(1:vallen)//delim//iotk_eos
1 continue
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_attr_REAL1_3

# 288 "iotk_attr.spp"
subroutine iotk_scan_attr_REAL1_3(attr,name,val,dummy,found,default,eos,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_read
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*),             intent(in)  :: attr
  character(*),             intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL(kind=__IOTK_REAL1)                        :: val (:,:,:)
#else
  REAL(kind=__IOTK_REAL1), intent(out)           :: val (:,:,:)
#endif
  type(iotk_dummytype), optional :: dummy
  logical,        optional, intent(out) :: found
  REAL(kind=__IOTK_REAL1), optional, intent(in)  :: default (:,:,:)
  logical,        optional, intent(in)  :: eos
  integer,        optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen,pos,equal
  character :: delim
  logical :: foundl
  character(iotk_vallenx) :: valc
# 317 "iotk_attr.spp"
  integer :: index
  REAL(kind=__IOTK_REAL1), allocatable :: tmpval (:)
# 320 "iotk_attr.spp"
  ierrl = 0
  attlen=iotk_strlen(attr)
  foundl = .false.
  equal = 0
  do
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) exit
    equal = equal + pos
    pos = scan(attr(equal+1:attlen),"=")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,'')
# 330 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",attr(equal+1:attlen))
      goto 1
    end if
    equal = equal + pos
    if(trim(attr(equal-pos:equal-1))==trim(name)) foundl = .true.
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 337 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    equal = equal + pos
    delim = attr(equal:equal)
    if(delim/="'" .and. delim/='"') then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 343 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    pos = scan(attr(equal+1:attlen),delim)
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 348 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    if(foundl) exit
    equal = equal + pos
  end do
  if(foundl) then
    call iotk_strcpy(valc,attr(equal+1:equal+pos-1),ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 357 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
  else
    goto 1
  end if
# 380 "iotk_attr.spp"
  allocate(tmpval(size(val)))
  index = 0
  call iotk_read(tmpval,valc(1:iotk_strlen(valc)),index,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 384 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 390 "iotk_attr.spp"
  if(index/=size(val)) then
# 392 "iotk_attr.spp"
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute size does not match')
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",valc)
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"size",size(tmpval))
    goto 1
  end if
# 398 "iotk_attr.spp"
  val = reshape (source=tmpval,shape=shape(val))
# 400 "iotk_attr.spp"
  deallocate(tmpval)
# 402 "iotk_attr.spp"
1 continue
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute not found')
# 406 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if
  if(present(default) .and. .not. foundl) then
# 419 "iotk_attr.spp"
    val = default
# 421 "iotk_attr.spp"
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_attr_REAL1_3
# 429 "iotk_attr.spp"

#endif
#endif

subroutine iotk_attr_dummy_REAL1_3
  write(0,*)
end subroutine iotk_attr_dummy_REAL1_3

# 45 "iotk_attr.spp"

# 47 "iotk_attr.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_attr.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_attr.spp"

# 59 "iotk_attr.spp"

#ifdef __IOTK_REAL1
#if 4 <= __IOTK_MAXRANK

# 137 "iotk_attr.spp"

# 210 "iotk_attr.spp"

# 213 "iotk_attr.spp"
subroutine iotk_write_attr_REAL1_4(attr,name,val,dummy,first,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*), intent(inout) :: attr
  character(*), intent(in)    :: name
  REAL(kind=__IOTK_REAL1), intent(in)  :: val (:,:,:,:)
  type(iotk_dummytype), optional :: dummy
  logical, optional, intent(in)  :: first
  integer, optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen
  integer :: vallen
  integer :: namlen
  integer :: iostat
  character :: delim
# 235 "iotk_attr.spp"
  character(iotk_vallenx) :: tmpval
  ierrl = 0
  iostat = 0
  if(present(first)) then
    if(first) attr(1:1) = iotk_eos
  end if
  if(.not.iotk_check_name(name)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Wrong tag name')
# 242 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",trim(name))
    goto 1
  end if
  attlen = iotk_strlen(attr)
  if(attlen==len(attr)) attlen = len_trim(attr)
  namlen = len_trim(name)
# 262 "iotk_attr.spp"
  delim = '"'
# 266 "iotk_attr.spp"
  call iotk_write(pack(val,mask=.true.),tmpval,ierrl)
# 268 "iotk_attr.spp"
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 269 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 273 "iotk_attr.spp"
  vallen = iotk_strlen(tmpval)
  if(attlen+vallen+namlen+5>len(attr)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute dummy argument is too short')
    goto 1
  end if
  attr(attlen+1:attlen+vallen+namlen+5) = " "//trim(name)//"="//delim//tmpval(1:vallen)//delim//iotk_eos
1 continue
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_attr_REAL1_4

# 288 "iotk_attr.spp"
subroutine iotk_scan_attr_REAL1_4(attr,name,val,dummy,found,default,eos,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_read
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*),             intent(in)  :: attr
  character(*),             intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL(kind=__IOTK_REAL1)                        :: val (:,:,:,:)
#else
  REAL(kind=__IOTK_REAL1), intent(out)           :: val (:,:,:,:)
#endif
  type(iotk_dummytype), optional :: dummy
  logical,        optional, intent(out) :: found
  REAL(kind=__IOTK_REAL1), optional, intent(in)  :: default (:,:,:,:)
  logical,        optional, intent(in)  :: eos
  integer,        optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen,pos,equal
  character :: delim
  logical :: foundl
  character(iotk_vallenx) :: valc
# 317 "iotk_attr.spp"
  integer :: index
  REAL(kind=__IOTK_REAL1), allocatable :: tmpval (:)
# 320 "iotk_attr.spp"
  ierrl = 0
  attlen=iotk_strlen(attr)
  foundl = .false.
  equal = 0
  do
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) exit
    equal = equal + pos
    pos = scan(attr(equal+1:attlen),"=")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,'')
# 330 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",attr(equal+1:attlen))
      goto 1
    end if
    equal = equal + pos
    if(trim(attr(equal-pos:equal-1))==trim(name)) foundl = .true.
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 337 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    equal = equal + pos
    delim = attr(equal:equal)
    if(delim/="'" .and. delim/='"') then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 343 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    pos = scan(attr(equal+1:attlen),delim)
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 348 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    if(foundl) exit
    equal = equal + pos
  end do
  if(foundl) then
    call iotk_strcpy(valc,attr(equal+1:equal+pos-1),ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 357 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
  else
    goto 1
  end if
# 380 "iotk_attr.spp"
  allocate(tmpval(size(val)))
  index = 0
  call iotk_read(tmpval,valc(1:iotk_strlen(valc)),index,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 384 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 390 "iotk_attr.spp"
  if(index/=size(val)) then
# 392 "iotk_attr.spp"
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute size does not match')
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",valc)
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"size",size(tmpval))
    goto 1
  end if
# 398 "iotk_attr.spp"
  val = reshape (source=tmpval,shape=shape(val))
# 400 "iotk_attr.spp"
  deallocate(tmpval)
# 402 "iotk_attr.spp"
1 continue
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute not found')
# 406 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if
  if(present(default) .and. .not. foundl) then
# 419 "iotk_attr.spp"
    val = default
# 421 "iotk_attr.spp"
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_attr_REAL1_4
# 429 "iotk_attr.spp"

#endif
#endif

subroutine iotk_attr_dummy_REAL1_4
  write(0,*)
end subroutine iotk_attr_dummy_REAL1_4

# 45 "iotk_attr.spp"

# 47 "iotk_attr.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_attr.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_attr.spp"

# 59 "iotk_attr.spp"

#ifdef __IOTK_REAL1
#if 5 <= __IOTK_MAXRANK

# 137 "iotk_attr.spp"

# 210 "iotk_attr.spp"

# 213 "iotk_attr.spp"
subroutine iotk_write_attr_REAL1_5(attr,name,val,dummy,first,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*), intent(inout) :: attr
  character(*), intent(in)    :: name
  REAL(kind=__IOTK_REAL1), intent(in)  :: val (:,:,:,:,:)
  type(iotk_dummytype), optional :: dummy
  logical, optional, intent(in)  :: first
  integer, optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen
  integer :: vallen
  integer :: namlen
  integer :: iostat
  character :: delim
# 235 "iotk_attr.spp"
  character(iotk_vallenx) :: tmpval
  ierrl = 0
  iostat = 0
  if(present(first)) then
    if(first) attr(1:1) = iotk_eos
  end if
  if(.not.iotk_check_name(name)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Wrong tag name')
# 242 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",trim(name))
    goto 1
  end if
  attlen = iotk_strlen(attr)
  if(attlen==len(attr)) attlen = len_trim(attr)
  namlen = len_trim(name)
# 262 "iotk_attr.spp"
  delim = '"'
# 266 "iotk_attr.spp"
  call iotk_write(pack(val,mask=.true.),tmpval,ierrl)
# 268 "iotk_attr.spp"
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 269 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 273 "iotk_attr.spp"
  vallen = iotk_strlen(tmpval)
  if(attlen+vallen+namlen+5>len(attr)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute dummy argument is too short')
    goto 1
  end if
  attr(attlen+1:attlen+vallen+namlen+5) = " "//trim(name)//"="//delim//tmpval(1:vallen)//delim//iotk_eos
1 continue
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_attr_REAL1_5

# 288 "iotk_attr.spp"
subroutine iotk_scan_attr_REAL1_5(attr,name,val,dummy,found,default,eos,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_read
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*),             intent(in)  :: attr
  character(*),             intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL(kind=__IOTK_REAL1)                        :: val (:,:,:,:,:)
#else
  REAL(kind=__IOTK_REAL1), intent(out)           :: val (:,:,:,:,:)
#endif
  type(iotk_dummytype), optional :: dummy
  logical,        optional, intent(out) :: found
  REAL(kind=__IOTK_REAL1), optional, intent(in)  :: default (:,:,:,:,:)
  logical,        optional, intent(in)  :: eos
  integer,        optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen,pos,equal
  character :: delim
  logical :: foundl
  character(iotk_vallenx) :: valc
# 317 "iotk_attr.spp"
  integer :: index
  REAL(kind=__IOTK_REAL1), allocatable :: tmpval (:)
# 320 "iotk_attr.spp"
  ierrl = 0
  attlen=iotk_strlen(attr)
  foundl = .false.
  equal = 0
  do
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) exit
    equal = equal + pos
    pos = scan(attr(equal+1:attlen),"=")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,'')
# 330 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",attr(equal+1:attlen))
      goto 1
    end if
    equal = equal + pos
    if(trim(attr(equal-pos:equal-1))==trim(name)) foundl = .true.
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 337 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    equal = equal + pos
    delim = attr(equal:equal)
    if(delim/="'" .and. delim/='"') then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 343 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    pos = scan(attr(equal+1:attlen),delim)
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 348 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    if(foundl) exit
    equal = equal + pos
  end do
  if(foundl) then
    call iotk_strcpy(valc,attr(equal+1:equal+pos-1),ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 357 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
  else
    goto 1
  end if
# 380 "iotk_attr.spp"
  allocate(tmpval(size(val)))
  index = 0
  call iotk_read(tmpval,valc(1:iotk_strlen(valc)),index,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 384 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 390 "iotk_attr.spp"
  if(index/=size(val)) then
# 392 "iotk_attr.spp"
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute size does not match')
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",valc)
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"size",size(tmpval))
    goto 1
  end if
# 398 "iotk_attr.spp"
  val = reshape (source=tmpval,shape=shape(val))
# 400 "iotk_attr.spp"
  deallocate(tmpval)
# 402 "iotk_attr.spp"
1 continue
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute not found')
# 406 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if
  if(present(default) .and. .not. foundl) then
# 419 "iotk_attr.spp"
    val = default
# 421 "iotk_attr.spp"
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_attr_REAL1_5
# 429 "iotk_attr.spp"

#endif
#endif

subroutine iotk_attr_dummy_REAL1_5
  write(0,*)
end subroutine iotk_attr_dummy_REAL1_5

# 45 "iotk_attr.spp"

# 47 "iotk_attr.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_attr.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_attr.spp"

# 59 "iotk_attr.spp"

#ifdef __IOTK_REAL1
#if 6 <= __IOTK_MAXRANK

# 137 "iotk_attr.spp"

# 210 "iotk_attr.spp"

# 213 "iotk_attr.spp"
subroutine iotk_write_attr_REAL1_6(attr,name,val,dummy,first,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*), intent(inout) :: attr
  character(*), intent(in)    :: name
  REAL(kind=__IOTK_REAL1), intent(in)  :: val (:,:,:,:,:,:)
  type(iotk_dummytype), optional :: dummy
  logical, optional, intent(in)  :: first
  integer, optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen
  integer :: vallen
  integer :: namlen
  integer :: iostat
  character :: delim
# 235 "iotk_attr.spp"
  character(iotk_vallenx) :: tmpval
  ierrl = 0
  iostat = 0
  if(present(first)) then
    if(first) attr(1:1) = iotk_eos
  end if
  if(.not.iotk_check_name(name)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Wrong tag name')
# 242 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",trim(name))
    goto 1
  end if
  attlen = iotk_strlen(attr)
  if(attlen==len(attr)) attlen = len_trim(attr)
  namlen = len_trim(name)
# 262 "iotk_attr.spp"
  delim = '"'
# 266 "iotk_attr.spp"
  call iotk_write(pack(val,mask=.true.),tmpval,ierrl)
# 268 "iotk_attr.spp"
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 269 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 273 "iotk_attr.spp"
  vallen = iotk_strlen(tmpval)
  if(attlen+vallen+namlen+5>len(attr)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute dummy argument is too short')
    goto 1
  end if
  attr(attlen+1:attlen+vallen+namlen+5) = " "//trim(name)//"="//delim//tmpval(1:vallen)//delim//iotk_eos
1 continue
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_attr_REAL1_6

# 288 "iotk_attr.spp"
subroutine iotk_scan_attr_REAL1_6(attr,name,val,dummy,found,default,eos,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_read
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*),             intent(in)  :: attr
  character(*),             intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL(kind=__IOTK_REAL1)                        :: val (:,:,:,:,:,:)
#else
  REAL(kind=__IOTK_REAL1), intent(out)           :: val (:,:,:,:,:,:)
#endif
  type(iotk_dummytype), optional :: dummy
  logical,        optional, intent(out) :: found
  REAL(kind=__IOTK_REAL1), optional, intent(in)  :: default (:,:,:,:,:,:)
  logical,        optional, intent(in)  :: eos
  integer,        optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen,pos,equal
  character :: delim
  logical :: foundl
  character(iotk_vallenx) :: valc
# 317 "iotk_attr.spp"
  integer :: index
  REAL(kind=__IOTK_REAL1), allocatable :: tmpval (:)
# 320 "iotk_attr.spp"
  ierrl = 0
  attlen=iotk_strlen(attr)
  foundl = .false.
  equal = 0
  do
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) exit
    equal = equal + pos
    pos = scan(attr(equal+1:attlen),"=")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,'')
# 330 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",attr(equal+1:attlen))
      goto 1
    end if
    equal = equal + pos
    if(trim(attr(equal-pos:equal-1))==trim(name)) foundl = .true.
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 337 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    equal = equal + pos
    delim = attr(equal:equal)
    if(delim/="'" .and. delim/='"') then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 343 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    pos = scan(attr(equal+1:attlen),delim)
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 348 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    if(foundl) exit
    equal = equal + pos
  end do
  if(foundl) then
    call iotk_strcpy(valc,attr(equal+1:equal+pos-1),ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 357 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
  else
    goto 1
  end if
# 380 "iotk_attr.spp"
  allocate(tmpval(size(val)))
  index = 0
  call iotk_read(tmpval,valc(1:iotk_strlen(valc)),index,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 384 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 390 "iotk_attr.spp"
  if(index/=size(val)) then
# 392 "iotk_attr.spp"
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute size does not match')
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",valc)
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"size",size(tmpval))
    goto 1
  end if
# 398 "iotk_attr.spp"
  val = reshape (source=tmpval,shape=shape(val))
# 400 "iotk_attr.spp"
  deallocate(tmpval)
# 402 "iotk_attr.spp"
1 continue
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute not found')
# 406 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if
  if(present(default) .and. .not. foundl) then
# 419 "iotk_attr.spp"
    val = default
# 421 "iotk_attr.spp"
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_attr_REAL1_6
# 429 "iotk_attr.spp"

#endif
#endif

subroutine iotk_attr_dummy_REAL1_6
  write(0,*)
end subroutine iotk_attr_dummy_REAL1_6

# 45 "iotk_attr.spp"

# 47 "iotk_attr.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_attr.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_attr.spp"

# 59 "iotk_attr.spp"

#ifdef __IOTK_REAL1
#if 7 <= __IOTK_MAXRANK

# 137 "iotk_attr.spp"

# 210 "iotk_attr.spp"

# 213 "iotk_attr.spp"
subroutine iotk_write_attr_REAL1_7(attr,name,val,dummy,first,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*), intent(inout) :: attr
  character(*), intent(in)    :: name
  REAL(kind=__IOTK_REAL1), intent(in)  :: val (:,:,:,:,:,:,:)
  type(iotk_dummytype), optional :: dummy
  logical, optional, intent(in)  :: first
  integer, optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen
  integer :: vallen
  integer :: namlen
  integer :: iostat
  character :: delim
# 235 "iotk_attr.spp"
  character(iotk_vallenx) :: tmpval
  ierrl = 0
  iostat = 0
  if(present(first)) then
    if(first) attr(1:1) = iotk_eos
  end if
  if(.not.iotk_check_name(name)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Wrong tag name')
# 242 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",trim(name))
    goto 1
  end if
  attlen = iotk_strlen(attr)
  if(attlen==len(attr)) attlen = len_trim(attr)
  namlen = len_trim(name)
# 262 "iotk_attr.spp"
  delim = '"'
# 266 "iotk_attr.spp"
  call iotk_write(pack(val,mask=.true.),tmpval,ierrl)
# 268 "iotk_attr.spp"
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 269 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 273 "iotk_attr.spp"
  vallen = iotk_strlen(tmpval)
  if(attlen+vallen+namlen+5>len(attr)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute dummy argument is too short')
    goto 1
  end if
  attr(attlen+1:attlen+vallen+namlen+5) = " "//trim(name)//"="//delim//tmpval(1:vallen)//delim//iotk_eos
1 continue
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_attr_REAL1_7

# 288 "iotk_attr.spp"
subroutine iotk_scan_attr_REAL1_7(attr,name,val,dummy,found,default,eos,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_read
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*),             intent(in)  :: attr
  character(*),             intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL(kind=__IOTK_REAL1)                        :: val (:,:,:,:,:,:,:)
#else
  REAL(kind=__IOTK_REAL1), intent(out)           :: val (:,:,:,:,:,:,:)
#endif
  type(iotk_dummytype), optional :: dummy
  logical,        optional, intent(out) :: found
  REAL(kind=__IOTK_REAL1), optional, intent(in)  :: default (:,:,:,:,:,:,:)
  logical,        optional, intent(in)  :: eos
  integer,        optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen,pos,equal
  character :: delim
  logical :: foundl
  character(iotk_vallenx) :: valc
# 317 "iotk_attr.spp"
  integer :: index
  REAL(kind=__IOTK_REAL1), allocatable :: tmpval (:)
# 320 "iotk_attr.spp"
  ierrl = 0
  attlen=iotk_strlen(attr)
  foundl = .false.
  equal = 0
  do
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) exit
    equal = equal + pos
    pos = scan(attr(equal+1:attlen),"=")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,'')
# 330 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",attr(equal+1:attlen))
      goto 1
    end if
    equal = equal + pos
    if(trim(attr(equal-pos:equal-1))==trim(name)) foundl = .true.
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 337 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    equal = equal + pos
    delim = attr(equal:equal)
    if(delim/="'" .and. delim/='"') then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 343 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    pos = scan(attr(equal+1:attlen),delim)
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 348 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    if(foundl) exit
    equal = equal + pos
  end do
  if(foundl) then
    call iotk_strcpy(valc,attr(equal+1:equal+pos-1),ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 357 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
  else
    goto 1
  end if
# 380 "iotk_attr.spp"
  allocate(tmpval(size(val)))
  index = 0
  call iotk_read(tmpval,valc(1:iotk_strlen(valc)),index,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 384 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 390 "iotk_attr.spp"
  if(index/=size(val)) then
# 392 "iotk_attr.spp"
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute size does not match')
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",valc)
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"size",size(tmpval))
    goto 1
  end if
# 398 "iotk_attr.spp"
  val = reshape (source=tmpval,shape=shape(val))
# 400 "iotk_attr.spp"
  deallocate(tmpval)
# 402 "iotk_attr.spp"
1 continue
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute not found')
# 406 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if
  if(present(default) .and. .not. foundl) then
# 419 "iotk_attr.spp"
    val = default
# 421 "iotk_attr.spp"
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_attr_REAL1_7
# 429 "iotk_attr.spp"

#endif
#endif

subroutine iotk_attr_dummy_REAL1_7
  write(0,*)
end subroutine iotk_attr_dummy_REAL1_7

# 45 "iotk_attr.spp"

# 47 "iotk_attr.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_attr.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_attr.spp"

# 59 "iotk_attr.spp"

#ifdef __IOTK_REAL2
#if 0 <= __IOTK_MAXRANK

# 64 "iotk_attr.spp"
! This is needed as a workaround for bugged pack 
subroutine iotk_private_pack_REAL2(out,in,n,l)
    use iotk_base
    implicit none
    integer,                                    intent(in)  :: n,l
# 73 "iotk_attr.spp"
    REAL (kind=__IOTK_REAL2), intent(out) :: out(n)
    REAL (kind=__IOTK_REAL2), intent(in)  :: in(n)
# 76 "iotk_attr.spp"
    out = in
end subroutine iotk_private_pack_REAL2

# 81 "iotk_attr.spp"
subroutine iotk_write_REAL2(val,string,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_xtox_interf
  use iotk_fmt_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  REAL(kind=__IOTK_REAL2), intent(in) :: val(:)
#ifdef __IOTK_WORKAROUND6
  character(len=*)              :: string
#else
  character(len=*), intent(out) :: string
#endif
  integer, intent(out) :: ierr
  character(len=100) :: tmpval
  integer :: index,iostat
  ierr = 0
  iostat = 0 
  string(1:1) = iotk_eos
  if(size(val)==0) return
  if(len(string)==0) then
    call iotk_error_issue(ierr,"iotk_write",__FILE__,__LINE__)
# 103 "iotk_attr.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.7 ")
    return
  end if
  do index=1,size(val)
# 120 "iotk_attr.spp"
    write(tmpval,trim(iotk_wfmt("REAL",kind(val),size(val),-1)),iostat=iostat) val(index)
    if(iostat/=0) then
      call iotk_error_issue(ierr,"iotk_write",__FILE__,__LINE__)
# 122 "iotk_attr.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.7 ")
# 122 "iotk_attr.spp"
call iotk_error_msg(ierr,' ')
# 122 "iotk_attr.spp"
call iotk_error_write(ierr,"iostat",iostat)
      return
    end if
    call iotk_strcat(string,trim(adjustl(tmpval))//" ",ierr)
    if(ierr/=0) then
      call iotk_error_issue(ierr,"iotk_write",__FILE__,__LINE__)
# 127 "iotk_attr.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.7 ")
      return
    end if
# 131 "iotk_attr.spp"
  end do
! taglio l'ultimo spazio
  string(iotk_strlen(string):iotk_strlen(string)) = iotk_eos
end subroutine iotk_write_REAL2
# 137 "iotk_attr.spp"

# 141 "iotk_attr.spp"
subroutine iotk_read_REAL2(val,string,index,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_xtox_interf
  use iotk_misc_interf
  implicit none
  REAL(kind=__IOTK_REAL2), intent(inout) :: val(:)
  character(len=*), intent(in) :: string
  integer, intent(inout) :: index
  integer, intent(out) :: ierr
  logical :: check
  integer :: pos,pos1,iostat
  integer :: maxindex
# 158 "iotk_attr.spp"
  pos = 0
  pos1= 0
  ierr = 0
  iostat = 0
# 165 "iotk_attr.spp"
    maxindex = size(val)
# 167 "iotk_attr.spp"
! PER ORA CONSIDERA LE VIRGOLE COME SPAZII
  do
    pos = verify(string(pos1+1:)," ,")+pos1
    if(pos==pos1) exit
    pos = pos - 1
    pos1 = scan(string(pos+1:)," ,")+pos
    if(pos1==pos) pos1 = len(string) + 1
!LEGGI string(pos+1:pos1-1)
    index = index+1
    if(index>maxindex) then
      call iotk_error_issue(ierr,"iotk_read",__FILE__,__LINE__)
# 177 "iotk_attr.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.7 ")
# 177 "iotk_attr.spp"
call iotk_error_msg(ierr,'Too many data')
    end if
# 184 "iotk_attr.spp"
    read(string(pos+1:pos1-1),"(G100.95)",iostat=iostat) val(index)
# 200 "iotk_attr.spp"
    if(iostat/=0) then
      call iotk_error_issue(ierr,"iotk_read",__FILE__,__LINE__)
# 201 "iotk_attr.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.7 ")
# 201 "iotk_attr.spp"
call iotk_error_msg(ierr,'Error reading from string')
# 201 "iotk_attr.spp"
call iotk_error_write(ierr,"string",string(pos+1:pos1-1))
# 201 "iotk_attr.spp"
call iotk_error_write(ierr,"iostat",iostat)
      return
    end if
# 205 "iotk_attr.spp"
    if(pos1>=len(string)) exit
  end do
end subroutine iotk_read_REAL2
# 210 "iotk_attr.spp"

# 213 "iotk_attr.spp"
subroutine iotk_write_attr_REAL2_0(attr,name,val,dummy,first,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*), intent(inout) :: attr
  character(*), intent(in)    :: name
  REAL(kind=__IOTK_REAL2), intent(in)  :: val 
  type(iotk_dummytype), optional :: dummy
  logical, optional, intent(in)  :: first
  integer, optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen
  integer :: vallen
  integer :: namlen
  integer :: iostat
  character :: delim
# 235 "iotk_attr.spp"
  character(iotk_vallenx) :: tmpval
  ierrl = 0
  iostat = 0
  if(present(first)) then
    if(first) attr(1:1) = iotk_eos
  end if
  if(.not.iotk_check_name(name)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Wrong tag name')
# 242 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",trim(name))
    goto 1
  end if
  attlen = iotk_strlen(attr)
  if(attlen==len(attr)) attlen = len_trim(attr)
  namlen = len_trim(name)
# 262 "iotk_attr.spp"
  delim = '"'
# 264 "iotk_attr.spp"
  call iotk_write((/val/),tmpval,ierrl)
# 268 "iotk_attr.spp"
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 269 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 273 "iotk_attr.spp"
  vallen = iotk_strlen(tmpval)
  if(attlen+vallen+namlen+5>len(attr)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute dummy argument is too short')
    goto 1
  end if
  attr(attlen+1:attlen+vallen+namlen+5) = " "//trim(name)//"="//delim//tmpval(1:vallen)//delim//iotk_eos
1 continue
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_attr_REAL2_0

# 288 "iotk_attr.spp"
subroutine iotk_scan_attr_REAL2_0(attr,name,val,dummy,found,default,eos,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_read
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*),             intent(in)  :: attr
  character(*),             intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL(kind=__IOTK_REAL2)                        :: val 
#else
  REAL(kind=__IOTK_REAL2), intent(out)           :: val 
#endif
  type(iotk_dummytype), optional :: dummy
  logical,        optional, intent(out) :: found
  REAL(kind=__IOTK_REAL2), optional, intent(in)  :: default 
  logical,        optional, intent(in)  :: eos
  integer,        optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen,pos,equal
  character :: delim
  logical :: foundl
  character(iotk_vallenx) :: valc
# 317 "iotk_attr.spp"
  integer :: index
  REAL(kind=__IOTK_REAL2), allocatable :: tmpval (:)
# 320 "iotk_attr.spp"
  ierrl = 0
  attlen=iotk_strlen(attr)
  foundl = .false.
  equal = 0
  do
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) exit
    equal = equal + pos
    pos = scan(attr(equal+1:attlen),"=")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,'')
# 330 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",attr(equal+1:attlen))
      goto 1
    end if
    equal = equal + pos
    if(trim(attr(equal-pos:equal-1))==trim(name)) foundl = .true.
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 337 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    equal = equal + pos
    delim = attr(equal:equal)
    if(delim/="'" .and. delim/='"') then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 343 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    pos = scan(attr(equal+1:attlen),delim)
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 348 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    if(foundl) exit
    equal = equal + pos
  end do
  if(foundl) then
    call iotk_strcpy(valc,attr(equal+1:equal+pos-1),ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 357 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
  else
    goto 1
  end if
# 380 "iotk_attr.spp"
  allocate(tmpval(1))
  index = 0
  call iotk_read(tmpval,valc(1:iotk_strlen(valc)),index,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 384 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 390 "iotk_attr.spp"
  if(index/=1) then
# 392 "iotk_attr.spp"
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute size does not match')
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",valc)
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"size",size(tmpval))
    goto 1
  end if
# 396 "iotk_attr.spp"
  val = tmpval(1)
# 400 "iotk_attr.spp"
  deallocate(tmpval)
# 402 "iotk_attr.spp"
1 continue
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute not found')
# 406 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if
  if(present(default) .and. .not. foundl) then
# 419 "iotk_attr.spp"
    val = default
# 421 "iotk_attr.spp"
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_attr_REAL2_0
# 429 "iotk_attr.spp"

#endif
#endif

subroutine iotk_attr_dummy_REAL2_0
  write(0,*)
end subroutine iotk_attr_dummy_REAL2_0

# 45 "iotk_attr.spp"

# 47 "iotk_attr.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_attr.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_attr.spp"

# 59 "iotk_attr.spp"

#ifdef __IOTK_REAL2
#if 1 <= __IOTK_MAXRANK

# 137 "iotk_attr.spp"

# 210 "iotk_attr.spp"

# 213 "iotk_attr.spp"
subroutine iotk_write_attr_REAL2_1(attr,name,val,dummy,first,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*), intent(inout) :: attr
  character(*), intent(in)    :: name
  REAL(kind=__IOTK_REAL2), intent(in)  :: val (:)
  type(iotk_dummytype), optional :: dummy
  logical, optional, intent(in)  :: first
  integer, optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen
  integer :: vallen
  integer :: namlen
  integer :: iostat
  character :: delim
# 235 "iotk_attr.spp"
  character(iotk_vallenx) :: tmpval
  ierrl = 0
  iostat = 0
  if(present(first)) then
    if(first) attr(1:1) = iotk_eos
  end if
  if(.not.iotk_check_name(name)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Wrong tag name')
# 242 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",trim(name))
    goto 1
  end if
  attlen = iotk_strlen(attr)
  if(attlen==len(attr)) attlen = len_trim(attr)
  namlen = len_trim(name)
# 262 "iotk_attr.spp"
  delim = '"'
# 266 "iotk_attr.spp"
  call iotk_write(pack(val,mask=.true.),tmpval,ierrl)
# 268 "iotk_attr.spp"
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 269 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 273 "iotk_attr.spp"
  vallen = iotk_strlen(tmpval)
  if(attlen+vallen+namlen+5>len(attr)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute dummy argument is too short')
    goto 1
  end if
  attr(attlen+1:attlen+vallen+namlen+5) = " "//trim(name)//"="//delim//tmpval(1:vallen)//delim//iotk_eos
1 continue
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_attr_REAL2_1

# 288 "iotk_attr.spp"
subroutine iotk_scan_attr_REAL2_1(attr,name,val,dummy,found,default,eos,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_read
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*),             intent(in)  :: attr
  character(*),             intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL(kind=__IOTK_REAL2)                        :: val (:)
#else
  REAL(kind=__IOTK_REAL2), intent(out)           :: val (:)
#endif
  type(iotk_dummytype), optional :: dummy
  logical,        optional, intent(out) :: found
  REAL(kind=__IOTK_REAL2), optional, intent(in)  :: default (:)
  logical,        optional, intent(in)  :: eos
  integer,        optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen,pos,equal
  character :: delim
  logical :: foundl
  character(iotk_vallenx) :: valc
# 317 "iotk_attr.spp"
  integer :: index
  REAL(kind=__IOTK_REAL2), allocatable :: tmpval (:)
# 320 "iotk_attr.spp"
  ierrl = 0
  attlen=iotk_strlen(attr)
  foundl = .false.
  equal = 0
  do
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) exit
    equal = equal + pos
    pos = scan(attr(equal+1:attlen),"=")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,'')
# 330 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",attr(equal+1:attlen))
      goto 1
    end if
    equal = equal + pos
    if(trim(attr(equal-pos:equal-1))==trim(name)) foundl = .true.
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 337 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    equal = equal + pos
    delim = attr(equal:equal)
    if(delim/="'" .and. delim/='"') then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 343 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    pos = scan(attr(equal+1:attlen),delim)
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 348 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    if(foundl) exit
    equal = equal + pos
  end do
  if(foundl) then
    call iotk_strcpy(valc,attr(equal+1:equal+pos-1),ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 357 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
  else
    goto 1
  end if
# 380 "iotk_attr.spp"
  allocate(tmpval(size(val)))
  index = 0
  call iotk_read(tmpval,valc(1:iotk_strlen(valc)),index,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 384 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 390 "iotk_attr.spp"
  if(index/=size(val)) then
# 392 "iotk_attr.spp"
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute size does not match')
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",valc)
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"size",size(tmpval))
    goto 1
  end if
# 398 "iotk_attr.spp"
  val = reshape (source=tmpval,shape=shape(val))
# 400 "iotk_attr.spp"
  deallocate(tmpval)
# 402 "iotk_attr.spp"
1 continue
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute not found')
# 406 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if
  if(present(default) .and. .not. foundl) then
# 419 "iotk_attr.spp"
    val = default
# 421 "iotk_attr.spp"
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_attr_REAL2_1
# 429 "iotk_attr.spp"

#endif
#endif

subroutine iotk_attr_dummy_REAL2_1
  write(0,*)
end subroutine iotk_attr_dummy_REAL2_1

# 45 "iotk_attr.spp"

# 47 "iotk_attr.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_attr.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_attr.spp"

# 59 "iotk_attr.spp"

#ifdef __IOTK_REAL2
#if 2 <= __IOTK_MAXRANK

# 137 "iotk_attr.spp"

# 210 "iotk_attr.spp"

# 213 "iotk_attr.spp"
subroutine iotk_write_attr_REAL2_2(attr,name,val,dummy,first,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*), intent(inout) :: attr
  character(*), intent(in)    :: name
  REAL(kind=__IOTK_REAL2), intent(in)  :: val (:,:)
  type(iotk_dummytype), optional :: dummy
  logical, optional, intent(in)  :: first
  integer, optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen
  integer :: vallen
  integer :: namlen
  integer :: iostat
  character :: delim
# 235 "iotk_attr.spp"
  character(iotk_vallenx) :: tmpval
  ierrl = 0
  iostat = 0
  if(present(first)) then
    if(first) attr(1:1) = iotk_eos
  end if
  if(.not.iotk_check_name(name)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Wrong tag name')
# 242 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",trim(name))
    goto 1
  end if
  attlen = iotk_strlen(attr)
  if(attlen==len(attr)) attlen = len_trim(attr)
  namlen = len_trim(name)
# 262 "iotk_attr.spp"
  delim = '"'
# 266 "iotk_attr.spp"
  call iotk_write(pack(val,mask=.true.),tmpval,ierrl)
# 268 "iotk_attr.spp"
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 269 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 273 "iotk_attr.spp"
  vallen = iotk_strlen(tmpval)
  if(attlen+vallen+namlen+5>len(attr)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute dummy argument is too short')
    goto 1
  end if
  attr(attlen+1:attlen+vallen+namlen+5) = " "//trim(name)//"="//delim//tmpval(1:vallen)//delim//iotk_eos
1 continue
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_attr_REAL2_2

# 288 "iotk_attr.spp"
subroutine iotk_scan_attr_REAL2_2(attr,name,val,dummy,found,default,eos,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_read
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*),             intent(in)  :: attr
  character(*),             intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL(kind=__IOTK_REAL2)                        :: val (:,:)
#else
  REAL(kind=__IOTK_REAL2), intent(out)           :: val (:,:)
#endif
  type(iotk_dummytype), optional :: dummy
  logical,        optional, intent(out) :: found
  REAL(kind=__IOTK_REAL2), optional, intent(in)  :: default (:,:)
  logical,        optional, intent(in)  :: eos
  integer,        optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen,pos,equal
  character :: delim
  logical :: foundl
  character(iotk_vallenx) :: valc
# 317 "iotk_attr.spp"
  integer :: index
  REAL(kind=__IOTK_REAL2), allocatable :: tmpval (:)
# 320 "iotk_attr.spp"
  ierrl = 0
  attlen=iotk_strlen(attr)
  foundl = .false.
  equal = 0
  do
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) exit
    equal = equal + pos
    pos = scan(attr(equal+1:attlen),"=")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,'')
# 330 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",attr(equal+1:attlen))
      goto 1
    end if
    equal = equal + pos
    if(trim(attr(equal-pos:equal-1))==trim(name)) foundl = .true.
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 337 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    equal = equal + pos
    delim = attr(equal:equal)
    if(delim/="'" .and. delim/='"') then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 343 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    pos = scan(attr(equal+1:attlen),delim)
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 348 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    if(foundl) exit
    equal = equal + pos
  end do
  if(foundl) then
    call iotk_strcpy(valc,attr(equal+1:equal+pos-1),ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 357 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
  else
    goto 1
  end if
# 380 "iotk_attr.spp"
  allocate(tmpval(size(val)))
  index = 0
  call iotk_read(tmpval,valc(1:iotk_strlen(valc)),index,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 384 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 390 "iotk_attr.spp"
  if(index/=size(val)) then
# 392 "iotk_attr.spp"
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute size does not match')
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",valc)
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"size",size(tmpval))
    goto 1
  end if
# 398 "iotk_attr.spp"
  val = reshape (source=tmpval,shape=shape(val))
# 400 "iotk_attr.spp"
  deallocate(tmpval)
# 402 "iotk_attr.spp"
1 continue
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute not found')
# 406 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if
  if(present(default) .and. .not. foundl) then
# 419 "iotk_attr.spp"
    val = default
# 421 "iotk_attr.spp"
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_attr_REAL2_2
# 429 "iotk_attr.spp"

#endif
#endif

subroutine iotk_attr_dummy_REAL2_2
  write(0,*)
end subroutine iotk_attr_dummy_REAL2_2

# 45 "iotk_attr.spp"

# 47 "iotk_attr.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_attr.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_attr.spp"

# 59 "iotk_attr.spp"

#ifdef __IOTK_REAL2
#if 3 <= __IOTK_MAXRANK

# 137 "iotk_attr.spp"

# 210 "iotk_attr.spp"

# 213 "iotk_attr.spp"
subroutine iotk_write_attr_REAL2_3(attr,name,val,dummy,first,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*), intent(inout) :: attr
  character(*), intent(in)    :: name
  REAL(kind=__IOTK_REAL2), intent(in)  :: val (:,:,:)
  type(iotk_dummytype), optional :: dummy
  logical, optional, intent(in)  :: first
  integer, optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen
  integer :: vallen
  integer :: namlen
  integer :: iostat
  character :: delim
# 235 "iotk_attr.spp"
  character(iotk_vallenx) :: tmpval
  ierrl = 0
  iostat = 0
  if(present(first)) then
    if(first) attr(1:1) = iotk_eos
  end if
  if(.not.iotk_check_name(name)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Wrong tag name')
# 242 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",trim(name))
    goto 1
  end if
  attlen = iotk_strlen(attr)
  if(attlen==len(attr)) attlen = len_trim(attr)
  namlen = len_trim(name)
# 262 "iotk_attr.spp"
  delim = '"'
# 266 "iotk_attr.spp"
  call iotk_write(pack(val,mask=.true.),tmpval,ierrl)
# 268 "iotk_attr.spp"
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 269 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 273 "iotk_attr.spp"
  vallen = iotk_strlen(tmpval)
  if(attlen+vallen+namlen+5>len(attr)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute dummy argument is too short')
    goto 1
  end if
  attr(attlen+1:attlen+vallen+namlen+5) = " "//trim(name)//"="//delim//tmpval(1:vallen)//delim//iotk_eos
1 continue
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_attr_REAL2_3

# 288 "iotk_attr.spp"
subroutine iotk_scan_attr_REAL2_3(attr,name,val,dummy,found,default,eos,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_read
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*),             intent(in)  :: attr
  character(*),             intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL(kind=__IOTK_REAL2)                        :: val (:,:,:)
#else
  REAL(kind=__IOTK_REAL2), intent(out)           :: val (:,:,:)
#endif
  type(iotk_dummytype), optional :: dummy
  logical,        optional, intent(out) :: found
  REAL(kind=__IOTK_REAL2), optional, intent(in)  :: default (:,:,:)
  logical,        optional, intent(in)  :: eos
  integer,        optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen,pos,equal
  character :: delim
  logical :: foundl
  character(iotk_vallenx) :: valc
# 317 "iotk_attr.spp"
  integer :: index
  REAL(kind=__IOTK_REAL2), allocatable :: tmpval (:)
# 320 "iotk_attr.spp"
  ierrl = 0
  attlen=iotk_strlen(attr)
  foundl = .false.
  equal = 0
  do
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) exit
    equal = equal + pos
    pos = scan(attr(equal+1:attlen),"=")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,'')
# 330 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",attr(equal+1:attlen))
      goto 1
    end if
    equal = equal + pos
    if(trim(attr(equal-pos:equal-1))==trim(name)) foundl = .true.
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 337 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    equal = equal + pos
    delim = attr(equal:equal)
    if(delim/="'" .and. delim/='"') then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 343 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    pos = scan(attr(equal+1:attlen),delim)
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 348 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    if(foundl) exit
    equal = equal + pos
  end do
  if(foundl) then
    call iotk_strcpy(valc,attr(equal+1:equal+pos-1),ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 357 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
  else
    goto 1
  end if
# 380 "iotk_attr.spp"
  allocate(tmpval(size(val)))
  index = 0
  call iotk_read(tmpval,valc(1:iotk_strlen(valc)),index,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 384 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 390 "iotk_attr.spp"
  if(index/=size(val)) then
# 392 "iotk_attr.spp"
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute size does not match')
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",valc)
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"size",size(tmpval))
    goto 1
  end if
# 398 "iotk_attr.spp"
  val = reshape (source=tmpval,shape=shape(val))
# 400 "iotk_attr.spp"
  deallocate(tmpval)
# 402 "iotk_attr.spp"
1 continue
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute not found')
# 406 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if
  if(present(default) .and. .not. foundl) then
# 419 "iotk_attr.spp"
    val = default
# 421 "iotk_attr.spp"
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_attr_REAL2_3
# 429 "iotk_attr.spp"

#endif
#endif

subroutine iotk_attr_dummy_REAL2_3
  write(0,*)
end subroutine iotk_attr_dummy_REAL2_3

# 45 "iotk_attr.spp"

# 47 "iotk_attr.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_attr.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_attr.spp"

# 59 "iotk_attr.spp"

#ifdef __IOTK_REAL2
#if 4 <= __IOTK_MAXRANK

# 137 "iotk_attr.spp"

# 210 "iotk_attr.spp"

# 213 "iotk_attr.spp"
subroutine iotk_write_attr_REAL2_4(attr,name,val,dummy,first,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*), intent(inout) :: attr
  character(*), intent(in)    :: name
  REAL(kind=__IOTK_REAL2), intent(in)  :: val (:,:,:,:)
  type(iotk_dummytype), optional :: dummy
  logical, optional, intent(in)  :: first
  integer, optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen
  integer :: vallen
  integer :: namlen
  integer :: iostat
  character :: delim
# 235 "iotk_attr.spp"
  character(iotk_vallenx) :: tmpval
  ierrl = 0
  iostat = 0
  if(present(first)) then
    if(first) attr(1:1) = iotk_eos
  end if
  if(.not.iotk_check_name(name)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Wrong tag name')
# 242 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",trim(name))
    goto 1
  end if
  attlen = iotk_strlen(attr)
  if(attlen==len(attr)) attlen = len_trim(attr)
  namlen = len_trim(name)
# 262 "iotk_attr.spp"
  delim = '"'
# 266 "iotk_attr.spp"
  call iotk_write(pack(val,mask=.true.),tmpval,ierrl)
# 268 "iotk_attr.spp"
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 269 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 273 "iotk_attr.spp"
  vallen = iotk_strlen(tmpval)
  if(attlen+vallen+namlen+5>len(attr)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute dummy argument is too short')
    goto 1
  end if
  attr(attlen+1:attlen+vallen+namlen+5) = " "//trim(name)//"="//delim//tmpval(1:vallen)//delim//iotk_eos
1 continue
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_attr_REAL2_4

# 288 "iotk_attr.spp"
subroutine iotk_scan_attr_REAL2_4(attr,name,val,dummy,found,default,eos,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_read
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*),             intent(in)  :: attr
  character(*),             intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL(kind=__IOTK_REAL2)                        :: val (:,:,:,:)
#else
  REAL(kind=__IOTK_REAL2), intent(out)           :: val (:,:,:,:)
#endif
  type(iotk_dummytype), optional :: dummy
  logical,        optional, intent(out) :: found
  REAL(kind=__IOTK_REAL2), optional, intent(in)  :: default (:,:,:,:)
  logical,        optional, intent(in)  :: eos
  integer,        optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen,pos,equal
  character :: delim
  logical :: foundl
  character(iotk_vallenx) :: valc
# 317 "iotk_attr.spp"
  integer :: index
  REAL(kind=__IOTK_REAL2), allocatable :: tmpval (:)
# 320 "iotk_attr.spp"
  ierrl = 0
  attlen=iotk_strlen(attr)
  foundl = .false.
  equal = 0
  do
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) exit
    equal = equal + pos
    pos = scan(attr(equal+1:attlen),"=")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,'')
# 330 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",attr(equal+1:attlen))
      goto 1
    end if
    equal = equal + pos
    if(trim(attr(equal-pos:equal-1))==trim(name)) foundl = .true.
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 337 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    equal = equal + pos
    delim = attr(equal:equal)
    if(delim/="'" .and. delim/='"') then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 343 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    pos = scan(attr(equal+1:attlen),delim)
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 348 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    if(foundl) exit
    equal = equal + pos
  end do
  if(foundl) then
    call iotk_strcpy(valc,attr(equal+1:equal+pos-1),ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 357 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
  else
    goto 1
  end if
# 380 "iotk_attr.spp"
  allocate(tmpval(size(val)))
  index = 0
  call iotk_read(tmpval,valc(1:iotk_strlen(valc)),index,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 384 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 390 "iotk_attr.spp"
  if(index/=size(val)) then
# 392 "iotk_attr.spp"
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute size does not match')
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",valc)
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"size",size(tmpval))
    goto 1
  end if
# 398 "iotk_attr.spp"
  val = reshape (source=tmpval,shape=shape(val))
# 400 "iotk_attr.spp"
  deallocate(tmpval)
# 402 "iotk_attr.spp"
1 continue
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute not found')
# 406 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if
  if(present(default) .and. .not. foundl) then
# 419 "iotk_attr.spp"
    val = default
# 421 "iotk_attr.spp"
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_attr_REAL2_4
# 429 "iotk_attr.spp"

#endif
#endif

subroutine iotk_attr_dummy_REAL2_4
  write(0,*)
end subroutine iotk_attr_dummy_REAL2_4

# 45 "iotk_attr.spp"

# 47 "iotk_attr.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_attr.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_attr.spp"

# 59 "iotk_attr.spp"

#ifdef __IOTK_REAL2
#if 5 <= __IOTK_MAXRANK

# 137 "iotk_attr.spp"

# 210 "iotk_attr.spp"

# 213 "iotk_attr.spp"
subroutine iotk_write_attr_REAL2_5(attr,name,val,dummy,first,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*), intent(inout) :: attr
  character(*), intent(in)    :: name
  REAL(kind=__IOTK_REAL2), intent(in)  :: val (:,:,:,:,:)
  type(iotk_dummytype), optional :: dummy
  logical, optional, intent(in)  :: first
  integer, optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen
  integer :: vallen
  integer :: namlen
  integer :: iostat
  character :: delim
# 235 "iotk_attr.spp"
  character(iotk_vallenx) :: tmpval
  ierrl = 0
  iostat = 0
  if(present(first)) then
    if(first) attr(1:1) = iotk_eos
  end if
  if(.not.iotk_check_name(name)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Wrong tag name')
# 242 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",trim(name))
    goto 1
  end if
  attlen = iotk_strlen(attr)
  if(attlen==len(attr)) attlen = len_trim(attr)
  namlen = len_trim(name)
# 262 "iotk_attr.spp"
  delim = '"'
# 266 "iotk_attr.spp"
  call iotk_write(pack(val,mask=.true.),tmpval,ierrl)
# 268 "iotk_attr.spp"
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 269 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 273 "iotk_attr.spp"
  vallen = iotk_strlen(tmpval)
  if(attlen+vallen+namlen+5>len(attr)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute dummy argument is too short')
    goto 1
  end if
  attr(attlen+1:attlen+vallen+namlen+5) = " "//trim(name)//"="//delim//tmpval(1:vallen)//delim//iotk_eos
1 continue
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_attr_REAL2_5

# 288 "iotk_attr.spp"
subroutine iotk_scan_attr_REAL2_5(attr,name,val,dummy,found,default,eos,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_read
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*),             intent(in)  :: attr
  character(*),             intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL(kind=__IOTK_REAL2)                        :: val (:,:,:,:,:)
#else
  REAL(kind=__IOTK_REAL2), intent(out)           :: val (:,:,:,:,:)
#endif
  type(iotk_dummytype), optional :: dummy
  logical,        optional, intent(out) :: found
  REAL(kind=__IOTK_REAL2), optional, intent(in)  :: default (:,:,:,:,:)
  logical,        optional, intent(in)  :: eos
  integer,        optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen,pos,equal
  character :: delim
  logical :: foundl
  character(iotk_vallenx) :: valc
# 317 "iotk_attr.spp"
  integer :: index
  REAL(kind=__IOTK_REAL2), allocatable :: tmpval (:)
# 320 "iotk_attr.spp"
  ierrl = 0
  attlen=iotk_strlen(attr)
  foundl = .false.
  equal = 0
  do
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) exit
    equal = equal + pos
    pos = scan(attr(equal+1:attlen),"=")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,'')
# 330 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",attr(equal+1:attlen))
      goto 1
    end if
    equal = equal + pos
    if(trim(attr(equal-pos:equal-1))==trim(name)) foundl = .true.
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 337 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    equal = equal + pos
    delim = attr(equal:equal)
    if(delim/="'" .and. delim/='"') then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 343 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    pos = scan(attr(equal+1:attlen),delim)
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 348 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    if(foundl) exit
    equal = equal + pos
  end do
  if(foundl) then
    call iotk_strcpy(valc,attr(equal+1:equal+pos-1),ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 357 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
  else
    goto 1
  end if
# 380 "iotk_attr.spp"
  allocate(tmpval(size(val)))
  index = 0
  call iotk_read(tmpval,valc(1:iotk_strlen(valc)),index,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 384 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 390 "iotk_attr.spp"
  if(index/=size(val)) then
# 392 "iotk_attr.spp"
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute size does not match')
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",valc)
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"size",size(tmpval))
    goto 1
  end if
# 398 "iotk_attr.spp"
  val = reshape (source=tmpval,shape=shape(val))
# 400 "iotk_attr.spp"
  deallocate(tmpval)
# 402 "iotk_attr.spp"
1 continue
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute not found')
# 406 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if
  if(present(default) .and. .not. foundl) then
# 419 "iotk_attr.spp"
    val = default
# 421 "iotk_attr.spp"
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_attr_REAL2_5
# 429 "iotk_attr.spp"

#endif
#endif

subroutine iotk_attr_dummy_REAL2_5
  write(0,*)
end subroutine iotk_attr_dummy_REAL2_5

# 45 "iotk_attr.spp"

# 47 "iotk_attr.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_attr.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_attr.spp"

# 59 "iotk_attr.spp"

#ifdef __IOTK_REAL2
#if 6 <= __IOTK_MAXRANK

# 137 "iotk_attr.spp"

# 210 "iotk_attr.spp"

# 213 "iotk_attr.spp"
subroutine iotk_write_attr_REAL2_6(attr,name,val,dummy,first,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*), intent(inout) :: attr
  character(*), intent(in)    :: name
  REAL(kind=__IOTK_REAL2), intent(in)  :: val (:,:,:,:,:,:)
  type(iotk_dummytype), optional :: dummy
  logical, optional, intent(in)  :: first
  integer, optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen
  integer :: vallen
  integer :: namlen
  integer :: iostat
  character :: delim
# 235 "iotk_attr.spp"
  character(iotk_vallenx) :: tmpval
  ierrl = 0
  iostat = 0
  if(present(first)) then
    if(first) attr(1:1) = iotk_eos
  end if
  if(.not.iotk_check_name(name)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Wrong tag name')
# 242 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",trim(name))
    goto 1
  end if
  attlen = iotk_strlen(attr)
  if(attlen==len(attr)) attlen = len_trim(attr)
  namlen = len_trim(name)
# 262 "iotk_attr.spp"
  delim = '"'
# 266 "iotk_attr.spp"
  call iotk_write(pack(val,mask=.true.),tmpval,ierrl)
# 268 "iotk_attr.spp"
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 269 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 273 "iotk_attr.spp"
  vallen = iotk_strlen(tmpval)
  if(attlen+vallen+namlen+5>len(attr)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute dummy argument is too short')
    goto 1
  end if
  attr(attlen+1:attlen+vallen+namlen+5) = " "//trim(name)//"="//delim//tmpval(1:vallen)//delim//iotk_eos
1 continue
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_attr_REAL2_6

# 288 "iotk_attr.spp"
subroutine iotk_scan_attr_REAL2_6(attr,name,val,dummy,found,default,eos,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_read
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*),             intent(in)  :: attr
  character(*),             intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL(kind=__IOTK_REAL2)                        :: val (:,:,:,:,:,:)
#else
  REAL(kind=__IOTK_REAL2), intent(out)           :: val (:,:,:,:,:,:)
#endif
  type(iotk_dummytype), optional :: dummy
  logical,        optional, intent(out) :: found
  REAL(kind=__IOTK_REAL2), optional, intent(in)  :: default (:,:,:,:,:,:)
  logical,        optional, intent(in)  :: eos
  integer,        optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen,pos,equal
  character :: delim
  logical :: foundl
  character(iotk_vallenx) :: valc
# 317 "iotk_attr.spp"
  integer :: index
  REAL(kind=__IOTK_REAL2), allocatable :: tmpval (:)
# 320 "iotk_attr.spp"
  ierrl = 0
  attlen=iotk_strlen(attr)
  foundl = .false.
  equal = 0
  do
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) exit
    equal = equal + pos
    pos = scan(attr(equal+1:attlen),"=")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,'')
# 330 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",attr(equal+1:attlen))
      goto 1
    end if
    equal = equal + pos
    if(trim(attr(equal-pos:equal-1))==trim(name)) foundl = .true.
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 337 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    equal = equal + pos
    delim = attr(equal:equal)
    if(delim/="'" .and. delim/='"') then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 343 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    pos = scan(attr(equal+1:attlen),delim)
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 348 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    if(foundl) exit
    equal = equal + pos
  end do
  if(foundl) then
    call iotk_strcpy(valc,attr(equal+1:equal+pos-1),ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 357 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
  else
    goto 1
  end if
# 380 "iotk_attr.spp"
  allocate(tmpval(size(val)))
  index = 0
  call iotk_read(tmpval,valc(1:iotk_strlen(valc)),index,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 384 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 390 "iotk_attr.spp"
  if(index/=size(val)) then
# 392 "iotk_attr.spp"
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute size does not match')
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",valc)
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"size",size(tmpval))
    goto 1
  end if
# 398 "iotk_attr.spp"
  val = reshape (source=tmpval,shape=shape(val))
# 400 "iotk_attr.spp"
  deallocate(tmpval)
# 402 "iotk_attr.spp"
1 continue
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute not found')
# 406 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if
  if(present(default) .and. .not. foundl) then
# 419 "iotk_attr.spp"
    val = default
# 421 "iotk_attr.spp"
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_attr_REAL2_6
# 429 "iotk_attr.spp"

#endif
#endif

subroutine iotk_attr_dummy_REAL2_6
  write(0,*)
end subroutine iotk_attr_dummy_REAL2_6

# 45 "iotk_attr.spp"

# 47 "iotk_attr.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_attr.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_attr.spp"

# 59 "iotk_attr.spp"

#ifdef __IOTK_REAL2
#if 7 <= __IOTK_MAXRANK

# 137 "iotk_attr.spp"

# 210 "iotk_attr.spp"

# 213 "iotk_attr.spp"
subroutine iotk_write_attr_REAL2_7(attr,name,val,dummy,first,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*), intent(inout) :: attr
  character(*), intent(in)    :: name
  REAL(kind=__IOTK_REAL2), intent(in)  :: val (:,:,:,:,:,:,:)
  type(iotk_dummytype), optional :: dummy
  logical, optional, intent(in)  :: first
  integer, optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen
  integer :: vallen
  integer :: namlen
  integer :: iostat
  character :: delim
# 235 "iotk_attr.spp"
  character(iotk_vallenx) :: tmpval
  ierrl = 0
  iostat = 0
  if(present(first)) then
    if(first) attr(1:1) = iotk_eos
  end if
  if(.not.iotk_check_name(name)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Wrong tag name')
# 242 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",trim(name))
    goto 1
  end if
  attlen = iotk_strlen(attr)
  if(attlen==len(attr)) attlen = len_trim(attr)
  namlen = len_trim(name)
# 262 "iotk_attr.spp"
  delim = '"'
# 266 "iotk_attr.spp"
  call iotk_write(pack(val,mask=.true.),tmpval,ierrl)
# 268 "iotk_attr.spp"
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 269 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 273 "iotk_attr.spp"
  vallen = iotk_strlen(tmpval)
  if(attlen+vallen+namlen+5>len(attr)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute dummy argument is too short')
    goto 1
  end if
  attr(attlen+1:attlen+vallen+namlen+5) = " "//trim(name)//"="//delim//tmpval(1:vallen)//delim//iotk_eos
1 continue
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_attr_REAL2_7

# 288 "iotk_attr.spp"
subroutine iotk_scan_attr_REAL2_7(attr,name,val,dummy,found,default,eos,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_read
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*),             intent(in)  :: attr
  character(*),             intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL(kind=__IOTK_REAL2)                        :: val (:,:,:,:,:,:,:)
#else
  REAL(kind=__IOTK_REAL2), intent(out)           :: val (:,:,:,:,:,:,:)
#endif
  type(iotk_dummytype), optional :: dummy
  logical,        optional, intent(out) :: found
  REAL(kind=__IOTK_REAL2), optional, intent(in)  :: default (:,:,:,:,:,:,:)
  logical,        optional, intent(in)  :: eos
  integer,        optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen,pos,equal
  character :: delim
  logical :: foundl
  character(iotk_vallenx) :: valc
# 317 "iotk_attr.spp"
  integer :: index
  REAL(kind=__IOTK_REAL2), allocatable :: tmpval (:)
# 320 "iotk_attr.spp"
  ierrl = 0
  attlen=iotk_strlen(attr)
  foundl = .false.
  equal = 0
  do
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) exit
    equal = equal + pos
    pos = scan(attr(equal+1:attlen),"=")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,'')
# 330 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",attr(equal+1:attlen))
      goto 1
    end if
    equal = equal + pos
    if(trim(attr(equal-pos:equal-1))==trim(name)) foundl = .true.
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 337 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    equal = equal + pos
    delim = attr(equal:equal)
    if(delim/="'" .and. delim/='"') then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 343 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    pos = scan(attr(equal+1:attlen),delim)
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 348 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    if(foundl) exit
    equal = equal + pos
  end do
  if(foundl) then
    call iotk_strcpy(valc,attr(equal+1:equal+pos-1),ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 357 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
  else
    goto 1
  end if
# 380 "iotk_attr.spp"
  allocate(tmpval(size(val)))
  index = 0
  call iotk_read(tmpval,valc(1:iotk_strlen(valc)),index,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 384 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 390 "iotk_attr.spp"
  if(index/=size(val)) then
# 392 "iotk_attr.spp"
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute size does not match')
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",valc)
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"size",size(tmpval))
    goto 1
  end if
# 398 "iotk_attr.spp"
  val = reshape (source=tmpval,shape=shape(val))
# 400 "iotk_attr.spp"
  deallocate(tmpval)
# 402 "iotk_attr.spp"
1 continue
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute not found')
# 406 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if
  if(present(default) .and. .not. foundl) then
# 419 "iotk_attr.spp"
    val = default
# 421 "iotk_attr.spp"
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_attr_REAL2_7
# 429 "iotk_attr.spp"

#endif
#endif

subroutine iotk_attr_dummy_REAL2_7
  write(0,*)
end subroutine iotk_attr_dummy_REAL2_7

# 45 "iotk_attr.spp"

# 47 "iotk_attr.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_attr.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_attr.spp"

# 59 "iotk_attr.spp"

#ifdef __IOTK_REAL3
#if 0 <= __IOTK_MAXRANK

# 64 "iotk_attr.spp"
! This is needed as a workaround for bugged pack 
subroutine iotk_private_pack_REAL3(out,in,n,l)
    use iotk_base
    implicit none
    integer,                                    intent(in)  :: n,l
# 73 "iotk_attr.spp"
    REAL (kind=__IOTK_REAL3), intent(out) :: out(n)
    REAL (kind=__IOTK_REAL3), intent(in)  :: in(n)
# 76 "iotk_attr.spp"
    out = in
end subroutine iotk_private_pack_REAL3

# 81 "iotk_attr.spp"
subroutine iotk_write_REAL3(val,string,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_xtox_interf
  use iotk_fmt_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  REAL(kind=__IOTK_REAL3), intent(in) :: val(:)
#ifdef __IOTK_WORKAROUND6
  character(len=*)              :: string
#else
  character(len=*), intent(out) :: string
#endif
  integer, intent(out) :: ierr
  character(len=100) :: tmpval
  integer :: index,iostat
  ierr = 0
  iostat = 0 
  string(1:1) = iotk_eos
  if(size(val)==0) return
  if(len(string)==0) then
    call iotk_error_issue(ierr,"iotk_write",__FILE__,__LINE__)
# 103 "iotk_attr.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.7 ")
    return
  end if
  do index=1,size(val)
# 120 "iotk_attr.spp"
    write(tmpval,trim(iotk_wfmt("REAL",kind(val),size(val),-1)),iostat=iostat) val(index)
    if(iostat/=0) then
      call iotk_error_issue(ierr,"iotk_write",__FILE__,__LINE__)
# 122 "iotk_attr.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.7 ")
# 122 "iotk_attr.spp"
call iotk_error_msg(ierr,' ')
# 122 "iotk_attr.spp"
call iotk_error_write(ierr,"iostat",iostat)
      return
    end if
    call iotk_strcat(string,trim(adjustl(tmpval))//" ",ierr)
    if(ierr/=0) then
      call iotk_error_issue(ierr,"iotk_write",__FILE__,__LINE__)
# 127 "iotk_attr.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.7 ")
      return
    end if
# 131 "iotk_attr.spp"
  end do
! taglio l'ultimo spazio
  string(iotk_strlen(string):iotk_strlen(string)) = iotk_eos
end subroutine iotk_write_REAL3
# 137 "iotk_attr.spp"

# 141 "iotk_attr.spp"
subroutine iotk_read_REAL3(val,string,index,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_xtox_interf
  use iotk_misc_interf
  implicit none
  REAL(kind=__IOTK_REAL3), intent(inout) :: val(:)
  character(len=*), intent(in) :: string
  integer, intent(inout) :: index
  integer, intent(out) :: ierr
  logical :: check
  integer :: pos,pos1,iostat
  integer :: maxindex
# 158 "iotk_attr.spp"
  pos = 0
  pos1= 0
  ierr = 0
  iostat = 0
# 165 "iotk_attr.spp"
    maxindex = size(val)
# 167 "iotk_attr.spp"
! PER ORA CONSIDERA LE VIRGOLE COME SPAZII
  do
    pos = verify(string(pos1+1:)," ,")+pos1
    if(pos==pos1) exit
    pos = pos - 1
    pos1 = scan(string(pos+1:)," ,")+pos
    if(pos1==pos) pos1 = len(string) + 1
!LEGGI string(pos+1:pos1-1)
    index = index+1
    if(index>maxindex) then
      call iotk_error_issue(ierr,"iotk_read",__FILE__,__LINE__)
# 177 "iotk_attr.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.7 ")
# 177 "iotk_attr.spp"
call iotk_error_msg(ierr,'Too many data')
    end if
# 184 "iotk_attr.spp"
    read(string(pos+1:pos1-1),"(G100.95)",iostat=iostat) val(index)
# 200 "iotk_attr.spp"
    if(iostat/=0) then
      call iotk_error_issue(ierr,"iotk_read",__FILE__,__LINE__)
# 201 "iotk_attr.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.7 ")
# 201 "iotk_attr.spp"
call iotk_error_msg(ierr,'Error reading from string')
# 201 "iotk_attr.spp"
call iotk_error_write(ierr,"string",string(pos+1:pos1-1))
# 201 "iotk_attr.spp"
call iotk_error_write(ierr,"iostat",iostat)
      return
    end if
# 205 "iotk_attr.spp"
    if(pos1>=len(string)) exit
  end do
end subroutine iotk_read_REAL3
# 210 "iotk_attr.spp"

# 213 "iotk_attr.spp"
subroutine iotk_write_attr_REAL3_0(attr,name,val,dummy,first,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*), intent(inout) :: attr
  character(*), intent(in)    :: name
  REAL(kind=__IOTK_REAL3), intent(in)  :: val 
  type(iotk_dummytype), optional :: dummy
  logical, optional, intent(in)  :: first
  integer, optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen
  integer :: vallen
  integer :: namlen
  integer :: iostat
  character :: delim
# 235 "iotk_attr.spp"
  character(iotk_vallenx) :: tmpval
  ierrl = 0
  iostat = 0
  if(present(first)) then
    if(first) attr(1:1) = iotk_eos
  end if
  if(.not.iotk_check_name(name)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Wrong tag name')
# 242 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",trim(name))
    goto 1
  end if
  attlen = iotk_strlen(attr)
  if(attlen==len(attr)) attlen = len_trim(attr)
  namlen = len_trim(name)
# 262 "iotk_attr.spp"
  delim = '"'
# 264 "iotk_attr.spp"
  call iotk_write((/val/),tmpval,ierrl)
# 268 "iotk_attr.spp"
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 269 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 273 "iotk_attr.spp"
  vallen = iotk_strlen(tmpval)
  if(attlen+vallen+namlen+5>len(attr)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute dummy argument is too short')
    goto 1
  end if
  attr(attlen+1:attlen+vallen+namlen+5) = " "//trim(name)//"="//delim//tmpval(1:vallen)//delim//iotk_eos
1 continue
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_attr_REAL3_0

# 288 "iotk_attr.spp"
subroutine iotk_scan_attr_REAL3_0(attr,name,val,dummy,found,default,eos,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_read
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*),             intent(in)  :: attr
  character(*),             intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL(kind=__IOTK_REAL3)                        :: val 
#else
  REAL(kind=__IOTK_REAL3), intent(out)           :: val 
#endif
  type(iotk_dummytype), optional :: dummy
  logical,        optional, intent(out) :: found
  REAL(kind=__IOTK_REAL3), optional, intent(in)  :: default 
  logical,        optional, intent(in)  :: eos
  integer,        optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen,pos,equal
  character :: delim
  logical :: foundl
  character(iotk_vallenx) :: valc
# 317 "iotk_attr.spp"
  integer :: index
  REAL(kind=__IOTK_REAL3), allocatable :: tmpval (:)
# 320 "iotk_attr.spp"
  ierrl = 0
  attlen=iotk_strlen(attr)
  foundl = .false.
  equal = 0
  do
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) exit
    equal = equal + pos
    pos = scan(attr(equal+1:attlen),"=")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,'')
# 330 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",attr(equal+1:attlen))
      goto 1
    end if
    equal = equal + pos
    if(trim(attr(equal-pos:equal-1))==trim(name)) foundl = .true.
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 337 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    equal = equal + pos
    delim = attr(equal:equal)
    if(delim/="'" .and. delim/='"') then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 343 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    pos = scan(attr(equal+1:attlen),delim)
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 348 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    if(foundl) exit
    equal = equal + pos
  end do
  if(foundl) then
    call iotk_strcpy(valc,attr(equal+1:equal+pos-1),ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 357 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
  else
    goto 1
  end if
# 380 "iotk_attr.spp"
  allocate(tmpval(1))
  index = 0
  call iotk_read(tmpval,valc(1:iotk_strlen(valc)),index,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 384 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 390 "iotk_attr.spp"
  if(index/=1) then
# 392 "iotk_attr.spp"
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute size does not match')
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",valc)
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"size",size(tmpval))
    goto 1
  end if
# 396 "iotk_attr.spp"
  val = tmpval(1)
# 400 "iotk_attr.spp"
  deallocate(tmpval)
# 402 "iotk_attr.spp"
1 continue
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute not found')
# 406 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if
  if(present(default) .and. .not. foundl) then
# 419 "iotk_attr.spp"
    val = default
# 421 "iotk_attr.spp"
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_attr_REAL3_0
# 429 "iotk_attr.spp"

#endif
#endif

subroutine iotk_attr_dummy_REAL3_0
  write(0,*)
end subroutine iotk_attr_dummy_REAL3_0

# 45 "iotk_attr.spp"

# 47 "iotk_attr.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_attr.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_attr.spp"

# 59 "iotk_attr.spp"

#ifdef __IOTK_REAL3
#if 1 <= __IOTK_MAXRANK

# 137 "iotk_attr.spp"

# 210 "iotk_attr.spp"

# 213 "iotk_attr.spp"
subroutine iotk_write_attr_REAL3_1(attr,name,val,dummy,first,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*), intent(inout) :: attr
  character(*), intent(in)    :: name
  REAL(kind=__IOTK_REAL3), intent(in)  :: val (:)
  type(iotk_dummytype), optional :: dummy
  logical, optional, intent(in)  :: first
  integer, optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen
  integer :: vallen
  integer :: namlen
  integer :: iostat
  character :: delim
# 235 "iotk_attr.spp"
  character(iotk_vallenx) :: tmpval
  ierrl = 0
  iostat = 0
  if(present(first)) then
    if(first) attr(1:1) = iotk_eos
  end if
  if(.not.iotk_check_name(name)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Wrong tag name')
# 242 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",trim(name))
    goto 1
  end if
  attlen = iotk_strlen(attr)
  if(attlen==len(attr)) attlen = len_trim(attr)
  namlen = len_trim(name)
# 262 "iotk_attr.spp"
  delim = '"'
# 266 "iotk_attr.spp"
  call iotk_write(pack(val,mask=.true.),tmpval,ierrl)
# 268 "iotk_attr.spp"
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 269 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 273 "iotk_attr.spp"
  vallen = iotk_strlen(tmpval)
  if(attlen+vallen+namlen+5>len(attr)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute dummy argument is too short')
    goto 1
  end if
  attr(attlen+1:attlen+vallen+namlen+5) = " "//trim(name)//"="//delim//tmpval(1:vallen)//delim//iotk_eos
1 continue
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_attr_REAL3_1

# 288 "iotk_attr.spp"
subroutine iotk_scan_attr_REAL3_1(attr,name,val,dummy,found,default,eos,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_read
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*),             intent(in)  :: attr
  character(*),             intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL(kind=__IOTK_REAL3)                        :: val (:)
#else
  REAL(kind=__IOTK_REAL3), intent(out)           :: val (:)
#endif
  type(iotk_dummytype), optional :: dummy
  logical,        optional, intent(out) :: found
  REAL(kind=__IOTK_REAL3), optional, intent(in)  :: default (:)
  logical,        optional, intent(in)  :: eos
  integer,        optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen,pos,equal
  character :: delim
  logical :: foundl
  character(iotk_vallenx) :: valc
# 317 "iotk_attr.spp"
  integer :: index
  REAL(kind=__IOTK_REAL3), allocatable :: tmpval (:)
# 320 "iotk_attr.spp"
  ierrl = 0
  attlen=iotk_strlen(attr)
  foundl = .false.
  equal = 0
  do
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) exit
    equal = equal + pos
    pos = scan(attr(equal+1:attlen),"=")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,'')
# 330 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",attr(equal+1:attlen))
      goto 1
    end if
    equal = equal + pos
    if(trim(attr(equal-pos:equal-1))==trim(name)) foundl = .true.
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 337 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    equal = equal + pos
    delim = attr(equal:equal)
    if(delim/="'" .and. delim/='"') then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 343 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    pos = scan(attr(equal+1:attlen),delim)
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 348 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    if(foundl) exit
    equal = equal + pos
  end do
  if(foundl) then
    call iotk_strcpy(valc,attr(equal+1:equal+pos-1),ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 357 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
  else
    goto 1
  end if
# 380 "iotk_attr.spp"
  allocate(tmpval(size(val)))
  index = 0
  call iotk_read(tmpval,valc(1:iotk_strlen(valc)),index,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 384 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 390 "iotk_attr.spp"
  if(index/=size(val)) then
# 392 "iotk_attr.spp"
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute size does not match')
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",valc)
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"size",size(tmpval))
    goto 1
  end if
# 398 "iotk_attr.spp"
  val = reshape (source=tmpval,shape=shape(val))
# 400 "iotk_attr.spp"
  deallocate(tmpval)
# 402 "iotk_attr.spp"
1 continue
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute not found')
# 406 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if
  if(present(default) .and. .not. foundl) then
# 419 "iotk_attr.spp"
    val = default
# 421 "iotk_attr.spp"
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_attr_REAL3_1
# 429 "iotk_attr.spp"

#endif
#endif

subroutine iotk_attr_dummy_REAL3_1
  write(0,*)
end subroutine iotk_attr_dummy_REAL3_1

# 45 "iotk_attr.spp"

# 47 "iotk_attr.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_attr.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_attr.spp"

# 59 "iotk_attr.spp"

#ifdef __IOTK_REAL3
#if 2 <= __IOTK_MAXRANK

# 137 "iotk_attr.spp"

# 210 "iotk_attr.spp"

# 213 "iotk_attr.spp"
subroutine iotk_write_attr_REAL3_2(attr,name,val,dummy,first,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*), intent(inout) :: attr
  character(*), intent(in)    :: name
  REAL(kind=__IOTK_REAL3), intent(in)  :: val (:,:)
  type(iotk_dummytype), optional :: dummy
  logical, optional, intent(in)  :: first
  integer, optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen
  integer :: vallen
  integer :: namlen
  integer :: iostat
  character :: delim
# 235 "iotk_attr.spp"
  character(iotk_vallenx) :: tmpval
  ierrl = 0
  iostat = 0
  if(present(first)) then
    if(first) attr(1:1) = iotk_eos
  end if
  if(.not.iotk_check_name(name)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Wrong tag name')
# 242 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",trim(name))
    goto 1
  end if
  attlen = iotk_strlen(attr)
  if(attlen==len(attr)) attlen = len_trim(attr)
  namlen = len_trim(name)
# 262 "iotk_attr.spp"
  delim = '"'
# 266 "iotk_attr.spp"
  call iotk_write(pack(val,mask=.true.),tmpval,ierrl)
# 268 "iotk_attr.spp"
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 269 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 273 "iotk_attr.spp"
  vallen = iotk_strlen(tmpval)
  if(attlen+vallen+namlen+5>len(attr)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute dummy argument is too short')
    goto 1
  end if
  attr(attlen+1:attlen+vallen+namlen+5) = " "//trim(name)//"="//delim//tmpval(1:vallen)//delim//iotk_eos
1 continue
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_attr_REAL3_2

# 288 "iotk_attr.spp"
subroutine iotk_scan_attr_REAL3_2(attr,name,val,dummy,found,default,eos,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_read
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*),             intent(in)  :: attr
  character(*),             intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL(kind=__IOTK_REAL3)                        :: val (:,:)
#else
  REAL(kind=__IOTK_REAL3), intent(out)           :: val (:,:)
#endif
  type(iotk_dummytype), optional :: dummy
  logical,        optional, intent(out) :: found
  REAL(kind=__IOTK_REAL3), optional, intent(in)  :: default (:,:)
  logical,        optional, intent(in)  :: eos
  integer,        optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen,pos,equal
  character :: delim
  logical :: foundl
  character(iotk_vallenx) :: valc
# 317 "iotk_attr.spp"
  integer :: index
  REAL(kind=__IOTK_REAL3), allocatable :: tmpval (:)
# 320 "iotk_attr.spp"
  ierrl = 0
  attlen=iotk_strlen(attr)
  foundl = .false.
  equal = 0
  do
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) exit
    equal = equal + pos
    pos = scan(attr(equal+1:attlen),"=")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,'')
# 330 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",attr(equal+1:attlen))
      goto 1
    end if
    equal = equal + pos
    if(trim(attr(equal-pos:equal-1))==trim(name)) foundl = .true.
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 337 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    equal = equal + pos
    delim = attr(equal:equal)
    if(delim/="'" .and. delim/='"') then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 343 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    pos = scan(attr(equal+1:attlen),delim)
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 348 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    if(foundl) exit
    equal = equal + pos
  end do
  if(foundl) then
    call iotk_strcpy(valc,attr(equal+1:equal+pos-1),ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 357 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
  else
    goto 1
  end if
# 380 "iotk_attr.spp"
  allocate(tmpval(size(val)))
  index = 0
  call iotk_read(tmpval,valc(1:iotk_strlen(valc)),index,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 384 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 390 "iotk_attr.spp"
  if(index/=size(val)) then
# 392 "iotk_attr.spp"
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute size does not match')
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",valc)
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"size",size(tmpval))
    goto 1
  end if
# 398 "iotk_attr.spp"
  val = reshape (source=tmpval,shape=shape(val))
# 400 "iotk_attr.spp"
  deallocate(tmpval)
# 402 "iotk_attr.spp"
1 continue
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute not found')
# 406 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if
  if(present(default) .and. .not. foundl) then
# 419 "iotk_attr.spp"
    val = default
# 421 "iotk_attr.spp"
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_attr_REAL3_2
# 429 "iotk_attr.spp"

#endif
#endif

subroutine iotk_attr_dummy_REAL3_2
  write(0,*)
end subroutine iotk_attr_dummy_REAL3_2

# 45 "iotk_attr.spp"

# 47 "iotk_attr.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_attr.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_attr.spp"

# 59 "iotk_attr.spp"

#ifdef __IOTK_REAL3
#if 3 <= __IOTK_MAXRANK

# 137 "iotk_attr.spp"

# 210 "iotk_attr.spp"

# 213 "iotk_attr.spp"
subroutine iotk_write_attr_REAL3_3(attr,name,val,dummy,first,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*), intent(inout) :: attr
  character(*), intent(in)    :: name
  REAL(kind=__IOTK_REAL3), intent(in)  :: val (:,:,:)
  type(iotk_dummytype), optional :: dummy
  logical, optional, intent(in)  :: first
  integer, optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen
  integer :: vallen
  integer :: namlen
  integer :: iostat
  character :: delim
# 235 "iotk_attr.spp"
  character(iotk_vallenx) :: tmpval
  ierrl = 0
  iostat = 0
  if(present(first)) then
    if(first) attr(1:1) = iotk_eos
  end if
  if(.not.iotk_check_name(name)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Wrong tag name')
# 242 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",trim(name))
    goto 1
  end if
  attlen = iotk_strlen(attr)
  if(attlen==len(attr)) attlen = len_trim(attr)
  namlen = len_trim(name)
# 262 "iotk_attr.spp"
  delim = '"'
# 266 "iotk_attr.spp"
  call iotk_write(pack(val,mask=.true.),tmpval,ierrl)
# 268 "iotk_attr.spp"
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 269 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 273 "iotk_attr.spp"
  vallen = iotk_strlen(tmpval)
  if(attlen+vallen+namlen+5>len(attr)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute dummy argument is too short')
    goto 1
  end if
  attr(attlen+1:attlen+vallen+namlen+5) = " "//trim(name)//"="//delim//tmpval(1:vallen)//delim//iotk_eos
1 continue
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_attr_REAL3_3

# 288 "iotk_attr.spp"
subroutine iotk_scan_attr_REAL3_3(attr,name,val,dummy,found,default,eos,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_read
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*),             intent(in)  :: attr
  character(*),             intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL(kind=__IOTK_REAL3)                        :: val (:,:,:)
#else
  REAL(kind=__IOTK_REAL3), intent(out)           :: val (:,:,:)
#endif
  type(iotk_dummytype), optional :: dummy
  logical,        optional, intent(out) :: found
  REAL(kind=__IOTK_REAL3), optional, intent(in)  :: default (:,:,:)
  logical,        optional, intent(in)  :: eos
  integer,        optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen,pos,equal
  character :: delim
  logical :: foundl
  character(iotk_vallenx) :: valc
# 317 "iotk_attr.spp"
  integer :: index
  REAL(kind=__IOTK_REAL3), allocatable :: tmpval (:)
# 320 "iotk_attr.spp"
  ierrl = 0
  attlen=iotk_strlen(attr)
  foundl = .false.
  equal = 0
  do
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) exit
    equal = equal + pos
    pos = scan(attr(equal+1:attlen),"=")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,'')
# 330 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",attr(equal+1:attlen))
      goto 1
    end if
    equal = equal + pos
    if(trim(attr(equal-pos:equal-1))==trim(name)) foundl = .true.
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 337 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    equal = equal + pos
    delim = attr(equal:equal)
    if(delim/="'" .and. delim/='"') then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 343 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    pos = scan(attr(equal+1:attlen),delim)
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 348 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    if(foundl) exit
    equal = equal + pos
  end do
  if(foundl) then
    call iotk_strcpy(valc,attr(equal+1:equal+pos-1),ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 357 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
  else
    goto 1
  end if
# 380 "iotk_attr.spp"
  allocate(tmpval(size(val)))
  index = 0
  call iotk_read(tmpval,valc(1:iotk_strlen(valc)),index,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 384 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 390 "iotk_attr.spp"
  if(index/=size(val)) then
# 392 "iotk_attr.spp"
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute size does not match')
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",valc)
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"size",size(tmpval))
    goto 1
  end if
# 398 "iotk_attr.spp"
  val = reshape (source=tmpval,shape=shape(val))
# 400 "iotk_attr.spp"
  deallocate(tmpval)
# 402 "iotk_attr.spp"
1 continue
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute not found')
# 406 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if
  if(present(default) .and. .not. foundl) then
# 419 "iotk_attr.spp"
    val = default
# 421 "iotk_attr.spp"
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_attr_REAL3_3
# 429 "iotk_attr.spp"

#endif
#endif

subroutine iotk_attr_dummy_REAL3_3
  write(0,*)
end subroutine iotk_attr_dummy_REAL3_3

# 45 "iotk_attr.spp"

# 47 "iotk_attr.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_attr.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_attr.spp"

# 59 "iotk_attr.spp"

#ifdef __IOTK_REAL3
#if 4 <= __IOTK_MAXRANK

# 137 "iotk_attr.spp"

# 210 "iotk_attr.spp"

# 213 "iotk_attr.spp"
subroutine iotk_write_attr_REAL3_4(attr,name,val,dummy,first,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*), intent(inout) :: attr
  character(*), intent(in)    :: name
  REAL(kind=__IOTK_REAL3), intent(in)  :: val (:,:,:,:)
  type(iotk_dummytype), optional :: dummy
  logical, optional, intent(in)  :: first
  integer, optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen
  integer :: vallen
  integer :: namlen
  integer :: iostat
  character :: delim
# 235 "iotk_attr.spp"
  character(iotk_vallenx) :: tmpval
  ierrl = 0
  iostat = 0
  if(present(first)) then
    if(first) attr(1:1) = iotk_eos
  end if
  if(.not.iotk_check_name(name)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Wrong tag name')
# 242 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",trim(name))
    goto 1
  end if
  attlen = iotk_strlen(attr)
  if(attlen==len(attr)) attlen = len_trim(attr)
  namlen = len_trim(name)
# 262 "iotk_attr.spp"
  delim = '"'
# 266 "iotk_attr.spp"
  call iotk_write(pack(val,mask=.true.),tmpval,ierrl)
# 268 "iotk_attr.spp"
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 269 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 273 "iotk_attr.spp"
  vallen = iotk_strlen(tmpval)
  if(attlen+vallen+namlen+5>len(attr)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute dummy argument is too short')
    goto 1
  end if
  attr(attlen+1:attlen+vallen+namlen+5) = " "//trim(name)//"="//delim//tmpval(1:vallen)//delim//iotk_eos
1 continue
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_attr_REAL3_4

# 288 "iotk_attr.spp"
subroutine iotk_scan_attr_REAL3_4(attr,name,val,dummy,found,default,eos,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_read
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*),             intent(in)  :: attr
  character(*),             intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL(kind=__IOTK_REAL3)                        :: val (:,:,:,:)
#else
  REAL(kind=__IOTK_REAL3), intent(out)           :: val (:,:,:,:)
#endif
  type(iotk_dummytype), optional :: dummy
  logical,        optional, intent(out) :: found
  REAL(kind=__IOTK_REAL3), optional, intent(in)  :: default (:,:,:,:)
  logical,        optional, intent(in)  :: eos
  integer,        optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen,pos,equal
  character :: delim
  logical :: foundl
  character(iotk_vallenx) :: valc
# 317 "iotk_attr.spp"
  integer :: index
  REAL(kind=__IOTK_REAL3), allocatable :: tmpval (:)
# 320 "iotk_attr.spp"
  ierrl = 0
  attlen=iotk_strlen(attr)
  foundl = .false.
  equal = 0
  do
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) exit
    equal = equal + pos
    pos = scan(attr(equal+1:attlen),"=")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,'')
# 330 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",attr(equal+1:attlen))
      goto 1
    end if
    equal = equal + pos
    if(trim(attr(equal-pos:equal-1))==trim(name)) foundl = .true.
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 337 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    equal = equal + pos
    delim = attr(equal:equal)
    if(delim/="'" .and. delim/='"') then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 343 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    pos = scan(attr(equal+1:attlen),delim)
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 348 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    if(foundl) exit
    equal = equal + pos
  end do
  if(foundl) then
    call iotk_strcpy(valc,attr(equal+1:equal+pos-1),ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 357 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
  else
    goto 1
  end if
# 380 "iotk_attr.spp"
  allocate(tmpval(size(val)))
  index = 0
  call iotk_read(tmpval,valc(1:iotk_strlen(valc)),index,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 384 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 390 "iotk_attr.spp"
  if(index/=size(val)) then
# 392 "iotk_attr.spp"
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute size does not match')
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",valc)
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"size",size(tmpval))
    goto 1
  end if
# 398 "iotk_attr.spp"
  val = reshape (source=tmpval,shape=shape(val))
# 400 "iotk_attr.spp"
  deallocate(tmpval)
# 402 "iotk_attr.spp"
1 continue
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute not found')
# 406 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if
  if(present(default) .and. .not. foundl) then
# 419 "iotk_attr.spp"
    val = default
# 421 "iotk_attr.spp"
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_attr_REAL3_4
# 429 "iotk_attr.spp"

#endif
#endif

subroutine iotk_attr_dummy_REAL3_4
  write(0,*)
end subroutine iotk_attr_dummy_REAL3_4

# 45 "iotk_attr.spp"

# 47 "iotk_attr.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_attr.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_attr.spp"

# 59 "iotk_attr.spp"

#ifdef __IOTK_REAL3
#if 5 <= __IOTK_MAXRANK

# 137 "iotk_attr.spp"

# 210 "iotk_attr.spp"

# 213 "iotk_attr.spp"
subroutine iotk_write_attr_REAL3_5(attr,name,val,dummy,first,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*), intent(inout) :: attr
  character(*), intent(in)    :: name
  REAL(kind=__IOTK_REAL3), intent(in)  :: val (:,:,:,:,:)
  type(iotk_dummytype), optional :: dummy
  logical, optional, intent(in)  :: first
  integer, optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen
  integer :: vallen
  integer :: namlen
  integer :: iostat
  character :: delim
# 235 "iotk_attr.spp"
  character(iotk_vallenx) :: tmpval
  ierrl = 0
  iostat = 0
  if(present(first)) then
    if(first) attr(1:1) = iotk_eos
  end if
  if(.not.iotk_check_name(name)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Wrong tag name')
# 242 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",trim(name))
    goto 1
  end if
  attlen = iotk_strlen(attr)
  if(attlen==len(attr)) attlen = len_trim(attr)
  namlen = len_trim(name)
# 262 "iotk_attr.spp"
  delim = '"'
# 266 "iotk_attr.spp"
  call iotk_write(pack(val,mask=.true.),tmpval,ierrl)
# 268 "iotk_attr.spp"
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 269 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 273 "iotk_attr.spp"
  vallen = iotk_strlen(tmpval)
  if(attlen+vallen+namlen+5>len(attr)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute dummy argument is too short')
    goto 1
  end if
  attr(attlen+1:attlen+vallen+namlen+5) = " "//trim(name)//"="//delim//tmpval(1:vallen)//delim//iotk_eos
1 continue
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_attr_REAL3_5

# 288 "iotk_attr.spp"
subroutine iotk_scan_attr_REAL3_5(attr,name,val,dummy,found,default,eos,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_read
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*),             intent(in)  :: attr
  character(*),             intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL(kind=__IOTK_REAL3)                        :: val (:,:,:,:,:)
#else
  REAL(kind=__IOTK_REAL3), intent(out)           :: val (:,:,:,:,:)
#endif
  type(iotk_dummytype), optional :: dummy
  logical,        optional, intent(out) :: found
  REAL(kind=__IOTK_REAL3), optional, intent(in)  :: default (:,:,:,:,:)
  logical,        optional, intent(in)  :: eos
  integer,        optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen,pos,equal
  character :: delim
  logical :: foundl
  character(iotk_vallenx) :: valc
# 317 "iotk_attr.spp"
  integer :: index
  REAL(kind=__IOTK_REAL3), allocatable :: tmpval (:)
# 320 "iotk_attr.spp"
  ierrl = 0
  attlen=iotk_strlen(attr)
  foundl = .false.
  equal = 0
  do
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) exit
    equal = equal + pos
    pos = scan(attr(equal+1:attlen),"=")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,'')
# 330 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",attr(equal+1:attlen))
      goto 1
    end if
    equal = equal + pos
    if(trim(attr(equal-pos:equal-1))==trim(name)) foundl = .true.
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 337 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    equal = equal + pos
    delim = attr(equal:equal)
    if(delim/="'" .and. delim/='"') then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 343 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    pos = scan(attr(equal+1:attlen),delim)
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 348 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    if(foundl) exit
    equal = equal + pos
  end do
  if(foundl) then
    call iotk_strcpy(valc,attr(equal+1:equal+pos-1),ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 357 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
  else
    goto 1
  end if
# 380 "iotk_attr.spp"
  allocate(tmpval(size(val)))
  index = 0
  call iotk_read(tmpval,valc(1:iotk_strlen(valc)),index,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 384 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 390 "iotk_attr.spp"
  if(index/=size(val)) then
# 392 "iotk_attr.spp"
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute size does not match')
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",valc)
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"size",size(tmpval))
    goto 1
  end if
# 398 "iotk_attr.spp"
  val = reshape (source=tmpval,shape=shape(val))
# 400 "iotk_attr.spp"
  deallocate(tmpval)
# 402 "iotk_attr.spp"
1 continue
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute not found')
# 406 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if
  if(present(default) .and. .not. foundl) then
# 419 "iotk_attr.spp"
    val = default
# 421 "iotk_attr.spp"
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_attr_REAL3_5
# 429 "iotk_attr.spp"

#endif
#endif

subroutine iotk_attr_dummy_REAL3_5
  write(0,*)
end subroutine iotk_attr_dummy_REAL3_5

# 45 "iotk_attr.spp"

# 47 "iotk_attr.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_attr.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_attr.spp"

# 59 "iotk_attr.spp"

#ifdef __IOTK_REAL3
#if 6 <= __IOTK_MAXRANK

# 137 "iotk_attr.spp"

# 210 "iotk_attr.spp"

# 213 "iotk_attr.spp"
subroutine iotk_write_attr_REAL3_6(attr,name,val,dummy,first,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*), intent(inout) :: attr
  character(*), intent(in)    :: name
  REAL(kind=__IOTK_REAL3), intent(in)  :: val (:,:,:,:,:,:)
  type(iotk_dummytype), optional :: dummy
  logical, optional, intent(in)  :: first
  integer, optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen
  integer :: vallen
  integer :: namlen
  integer :: iostat
  character :: delim
# 235 "iotk_attr.spp"
  character(iotk_vallenx) :: tmpval
  ierrl = 0
  iostat = 0
  if(present(first)) then
    if(first) attr(1:1) = iotk_eos
  end if
  if(.not.iotk_check_name(name)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Wrong tag name')
# 242 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",trim(name))
    goto 1
  end if
  attlen = iotk_strlen(attr)
  if(attlen==len(attr)) attlen = len_trim(attr)
  namlen = len_trim(name)
# 262 "iotk_attr.spp"
  delim = '"'
# 266 "iotk_attr.spp"
  call iotk_write(pack(val,mask=.true.),tmpval,ierrl)
# 268 "iotk_attr.spp"
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 269 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 273 "iotk_attr.spp"
  vallen = iotk_strlen(tmpval)
  if(attlen+vallen+namlen+5>len(attr)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute dummy argument is too short')
    goto 1
  end if
  attr(attlen+1:attlen+vallen+namlen+5) = " "//trim(name)//"="//delim//tmpval(1:vallen)//delim//iotk_eos
1 continue
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_attr_REAL3_6

# 288 "iotk_attr.spp"
subroutine iotk_scan_attr_REAL3_6(attr,name,val,dummy,found,default,eos,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_read
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*),             intent(in)  :: attr
  character(*),             intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL(kind=__IOTK_REAL3)                        :: val (:,:,:,:,:,:)
#else
  REAL(kind=__IOTK_REAL3), intent(out)           :: val (:,:,:,:,:,:)
#endif
  type(iotk_dummytype), optional :: dummy
  logical,        optional, intent(out) :: found
  REAL(kind=__IOTK_REAL3), optional, intent(in)  :: default (:,:,:,:,:,:)
  logical,        optional, intent(in)  :: eos
  integer,        optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen,pos,equal
  character :: delim
  logical :: foundl
  character(iotk_vallenx) :: valc
# 317 "iotk_attr.spp"
  integer :: index
  REAL(kind=__IOTK_REAL3), allocatable :: tmpval (:)
# 320 "iotk_attr.spp"
  ierrl = 0
  attlen=iotk_strlen(attr)
  foundl = .false.
  equal = 0
  do
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) exit
    equal = equal + pos
    pos = scan(attr(equal+1:attlen),"=")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,'')
# 330 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",attr(equal+1:attlen))
      goto 1
    end if
    equal = equal + pos
    if(trim(attr(equal-pos:equal-1))==trim(name)) foundl = .true.
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 337 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    equal = equal + pos
    delim = attr(equal:equal)
    if(delim/="'" .and. delim/='"') then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 343 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    pos = scan(attr(equal+1:attlen),delim)
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 348 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    if(foundl) exit
    equal = equal + pos
  end do
  if(foundl) then
    call iotk_strcpy(valc,attr(equal+1:equal+pos-1),ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 357 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
  else
    goto 1
  end if
# 380 "iotk_attr.spp"
  allocate(tmpval(size(val)))
  index = 0
  call iotk_read(tmpval,valc(1:iotk_strlen(valc)),index,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 384 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 390 "iotk_attr.spp"
  if(index/=size(val)) then
# 392 "iotk_attr.spp"
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute size does not match')
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",valc)
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"size",size(tmpval))
    goto 1
  end if
# 398 "iotk_attr.spp"
  val = reshape (source=tmpval,shape=shape(val))
# 400 "iotk_attr.spp"
  deallocate(tmpval)
# 402 "iotk_attr.spp"
1 continue
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute not found')
# 406 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if
  if(present(default) .and. .not. foundl) then
# 419 "iotk_attr.spp"
    val = default
# 421 "iotk_attr.spp"
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_attr_REAL3_6
# 429 "iotk_attr.spp"

#endif
#endif

subroutine iotk_attr_dummy_REAL3_6
  write(0,*)
end subroutine iotk_attr_dummy_REAL3_6

# 45 "iotk_attr.spp"

# 47 "iotk_attr.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_attr.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_attr.spp"

# 59 "iotk_attr.spp"

#ifdef __IOTK_REAL3
#if 7 <= __IOTK_MAXRANK

# 137 "iotk_attr.spp"

# 210 "iotk_attr.spp"

# 213 "iotk_attr.spp"
subroutine iotk_write_attr_REAL3_7(attr,name,val,dummy,first,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*), intent(inout) :: attr
  character(*), intent(in)    :: name
  REAL(kind=__IOTK_REAL3), intent(in)  :: val (:,:,:,:,:,:,:)
  type(iotk_dummytype), optional :: dummy
  logical, optional, intent(in)  :: first
  integer, optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen
  integer :: vallen
  integer :: namlen
  integer :: iostat
  character :: delim
# 235 "iotk_attr.spp"
  character(iotk_vallenx) :: tmpval
  ierrl = 0
  iostat = 0
  if(present(first)) then
    if(first) attr(1:1) = iotk_eos
  end if
  if(.not.iotk_check_name(name)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Wrong tag name')
# 242 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",trim(name))
    goto 1
  end if
  attlen = iotk_strlen(attr)
  if(attlen==len(attr)) attlen = len_trim(attr)
  namlen = len_trim(name)
# 262 "iotk_attr.spp"
  delim = '"'
# 266 "iotk_attr.spp"
  call iotk_write(pack(val,mask=.true.),tmpval,ierrl)
# 268 "iotk_attr.spp"
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 269 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 273 "iotk_attr.spp"
  vallen = iotk_strlen(tmpval)
  if(attlen+vallen+namlen+5>len(attr)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute dummy argument is too short')
    goto 1
  end if
  attr(attlen+1:attlen+vallen+namlen+5) = " "//trim(name)//"="//delim//tmpval(1:vallen)//delim//iotk_eos
1 continue
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_attr_REAL3_7

# 288 "iotk_attr.spp"
subroutine iotk_scan_attr_REAL3_7(attr,name,val,dummy,found,default,eos,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_read
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*),             intent(in)  :: attr
  character(*),             intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL(kind=__IOTK_REAL3)                        :: val (:,:,:,:,:,:,:)
#else
  REAL(kind=__IOTK_REAL3), intent(out)           :: val (:,:,:,:,:,:,:)
#endif
  type(iotk_dummytype), optional :: dummy
  logical,        optional, intent(out) :: found
  REAL(kind=__IOTK_REAL3), optional, intent(in)  :: default (:,:,:,:,:,:,:)
  logical,        optional, intent(in)  :: eos
  integer,        optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen,pos,equal
  character :: delim
  logical :: foundl
  character(iotk_vallenx) :: valc
# 317 "iotk_attr.spp"
  integer :: index
  REAL(kind=__IOTK_REAL3), allocatable :: tmpval (:)
# 320 "iotk_attr.spp"
  ierrl = 0
  attlen=iotk_strlen(attr)
  foundl = .false.
  equal = 0
  do
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) exit
    equal = equal + pos
    pos = scan(attr(equal+1:attlen),"=")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,'')
# 330 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",attr(equal+1:attlen))
      goto 1
    end if
    equal = equal + pos
    if(trim(attr(equal-pos:equal-1))==trim(name)) foundl = .true.
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 337 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    equal = equal + pos
    delim = attr(equal:equal)
    if(delim/="'" .and. delim/='"') then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 343 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    pos = scan(attr(equal+1:attlen),delim)
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 348 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    if(foundl) exit
    equal = equal + pos
  end do
  if(foundl) then
    call iotk_strcpy(valc,attr(equal+1:equal+pos-1),ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 357 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
  else
    goto 1
  end if
# 380 "iotk_attr.spp"
  allocate(tmpval(size(val)))
  index = 0
  call iotk_read(tmpval,valc(1:iotk_strlen(valc)),index,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 384 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 390 "iotk_attr.spp"
  if(index/=size(val)) then
# 392 "iotk_attr.spp"
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute size does not match')
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",valc)
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"size",size(tmpval))
    goto 1
  end if
# 398 "iotk_attr.spp"
  val = reshape (source=tmpval,shape=shape(val))
# 400 "iotk_attr.spp"
  deallocate(tmpval)
# 402 "iotk_attr.spp"
1 continue
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute not found')
# 406 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if
  if(present(default) .and. .not. foundl) then
# 419 "iotk_attr.spp"
    val = default
# 421 "iotk_attr.spp"
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_attr_REAL3_7
# 429 "iotk_attr.spp"

#endif
#endif

subroutine iotk_attr_dummy_REAL3_7
  write(0,*)
end subroutine iotk_attr_dummy_REAL3_7

# 45 "iotk_attr.spp"

# 47 "iotk_attr.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_attr.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_attr.spp"

# 59 "iotk_attr.spp"

#ifdef __IOTK_REAL4
#if 0 <= __IOTK_MAXRANK

# 64 "iotk_attr.spp"
! This is needed as a workaround for bugged pack 
subroutine iotk_private_pack_REAL4(out,in,n,l)
    use iotk_base
    implicit none
    integer,                                    intent(in)  :: n,l
# 73 "iotk_attr.spp"
    REAL (kind=__IOTK_REAL4), intent(out) :: out(n)
    REAL (kind=__IOTK_REAL4), intent(in)  :: in(n)
# 76 "iotk_attr.spp"
    out = in
end subroutine iotk_private_pack_REAL4

# 81 "iotk_attr.spp"
subroutine iotk_write_REAL4(val,string,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_xtox_interf
  use iotk_fmt_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  REAL(kind=__IOTK_REAL4), intent(in) :: val(:)
#ifdef __IOTK_WORKAROUND6
  character(len=*)              :: string
#else
  character(len=*), intent(out) :: string
#endif
  integer, intent(out) :: ierr
  character(len=100) :: tmpval
  integer :: index,iostat
  ierr = 0
  iostat = 0 
  string(1:1) = iotk_eos
  if(size(val)==0) return
  if(len(string)==0) then
    call iotk_error_issue(ierr,"iotk_write",__FILE__,__LINE__)
# 103 "iotk_attr.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.7 ")
    return
  end if
  do index=1,size(val)
# 120 "iotk_attr.spp"
    write(tmpval,trim(iotk_wfmt("REAL",kind(val),size(val),-1)),iostat=iostat) val(index)
    if(iostat/=0) then
      call iotk_error_issue(ierr,"iotk_write",__FILE__,__LINE__)
# 122 "iotk_attr.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.7 ")
# 122 "iotk_attr.spp"
call iotk_error_msg(ierr,' ')
# 122 "iotk_attr.spp"
call iotk_error_write(ierr,"iostat",iostat)
      return
    end if
    call iotk_strcat(string,trim(adjustl(tmpval))//" ",ierr)
    if(ierr/=0) then
      call iotk_error_issue(ierr,"iotk_write",__FILE__,__LINE__)
# 127 "iotk_attr.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.7 ")
      return
    end if
# 131 "iotk_attr.spp"
  end do
! taglio l'ultimo spazio
  string(iotk_strlen(string):iotk_strlen(string)) = iotk_eos
end subroutine iotk_write_REAL4
# 137 "iotk_attr.spp"

# 141 "iotk_attr.spp"
subroutine iotk_read_REAL4(val,string,index,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_xtox_interf
  use iotk_misc_interf
  implicit none
  REAL(kind=__IOTK_REAL4), intent(inout) :: val(:)
  character(len=*), intent(in) :: string
  integer, intent(inout) :: index
  integer, intent(out) :: ierr
  logical :: check
  integer :: pos,pos1,iostat
  integer :: maxindex
# 158 "iotk_attr.spp"
  pos = 0
  pos1= 0
  ierr = 0
  iostat = 0
# 165 "iotk_attr.spp"
    maxindex = size(val)
# 167 "iotk_attr.spp"
! PER ORA CONSIDERA LE VIRGOLE COME SPAZII
  do
    pos = verify(string(pos1+1:)," ,")+pos1
    if(pos==pos1) exit
    pos = pos - 1
    pos1 = scan(string(pos+1:)," ,")+pos
    if(pos1==pos) pos1 = len(string) + 1
!LEGGI string(pos+1:pos1-1)
    index = index+1
    if(index>maxindex) then
      call iotk_error_issue(ierr,"iotk_read",__FILE__,__LINE__)
# 177 "iotk_attr.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.7 ")
# 177 "iotk_attr.spp"
call iotk_error_msg(ierr,'Too many data')
    end if
# 184 "iotk_attr.spp"
    read(string(pos+1:pos1-1),"(G100.95)",iostat=iostat) val(index)
# 200 "iotk_attr.spp"
    if(iostat/=0) then
      call iotk_error_issue(ierr,"iotk_read",__FILE__,__LINE__)
# 201 "iotk_attr.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.7 ")
# 201 "iotk_attr.spp"
call iotk_error_msg(ierr,'Error reading from string')
# 201 "iotk_attr.spp"
call iotk_error_write(ierr,"string",string(pos+1:pos1-1))
# 201 "iotk_attr.spp"
call iotk_error_write(ierr,"iostat",iostat)
      return
    end if
# 205 "iotk_attr.spp"
    if(pos1>=len(string)) exit
  end do
end subroutine iotk_read_REAL4
# 210 "iotk_attr.spp"

# 213 "iotk_attr.spp"
subroutine iotk_write_attr_REAL4_0(attr,name,val,dummy,first,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*), intent(inout) :: attr
  character(*), intent(in)    :: name
  REAL(kind=__IOTK_REAL4), intent(in)  :: val 
  type(iotk_dummytype), optional :: dummy
  logical, optional, intent(in)  :: first
  integer, optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen
  integer :: vallen
  integer :: namlen
  integer :: iostat
  character :: delim
# 235 "iotk_attr.spp"
  character(iotk_vallenx) :: tmpval
  ierrl = 0
  iostat = 0
  if(present(first)) then
    if(first) attr(1:1) = iotk_eos
  end if
  if(.not.iotk_check_name(name)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Wrong tag name')
# 242 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",trim(name))
    goto 1
  end if
  attlen = iotk_strlen(attr)
  if(attlen==len(attr)) attlen = len_trim(attr)
  namlen = len_trim(name)
# 262 "iotk_attr.spp"
  delim = '"'
# 264 "iotk_attr.spp"
  call iotk_write((/val/),tmpval,ierrl)
# 268 "iotk_attr.spp"
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 269 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 273 "iotk_attr.spp"
  vallen = iotk_strlen(tmpval)
  if(attlen+vallen+namlen+5>len(attr)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute dummy argument is too short')
    goto 1
  end if
  attr(attlen+1:attlen+vallen+namlen+5) = " "//trim(name)//"="//delim//tmpval(1:vallen)//delim//iotk_eos
1 continue
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_attr_REAL4_0

# 288 "iotk_attr.spp"
subroutine iotk_scan_attr_REAL4_0(attr,name,val,dummy,found,default,eos,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_read
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*),             intent(in)  :: attr
  character(*),             intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL(kind=__IOTK_REAL4)                        :: val 
#else
  REAL(kind=__IOTK_REAL4), intent(out)           :: val 
#endif
  type(iotk_dummytype), optional :: dummy
  logical,        optional, intent(out) :: found
  REAL(kind=__IOTK_REAL4), optional, intent(in)  :: default 
  logical,        optional, intent(in)  :: eos
  integer,        optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen,pos,equal
  character :: delim
  logical :: foundl
  character(iotk_vallenx) :: valc
# 317 "iotk_attr.spp"
  integer :: index
  REAL(kind=__IOTK_REAL4), allocatable :: tmpval (:)
# 320 "iotk_attr.spp"
  ierrl = 0
  attlen=iotk_strlen(attr)
  foundl = .false.
  equal = 0
  do
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) exit
    equal = equal + pos
    pos = scan(attr(equal+1:attlen),"=")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,'')
# 330 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",attr(equal+1:attlen))
      goto 1
    end if
    equal = equal + pos
    if(trim(attr(equal-pos:equal-1))==trim(name)) foundl = .true.
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 337 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    equal = equal + pos
    delim = attr(equal:equal)
    if(delim/="'" .and. delim/='"') then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 343 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    pos = scan(attr(equal+1:attlen),delim)
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 348 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    if(foundl) exit
    equal = equal + pos
  end do
  if(foundl) then
    call iotk_strcpy(valc,attr(equal+1:equal+pos-1),ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 357 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
  else
    goto 1
  end if
# 380 "iotk_attr.spp"
  allocate(tmpval(1))
  index = 0
  call iotk_read(tmpval,valc(1:iotk_strlen(valc)),index,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 384 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 390 "iotk_attr.spp"
  if(index/=1) then
# 392 "iotk_attr.spp"
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute size does not match')
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",valc)
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"size",size(tmpval))
    goto 1
  end if
# 396 "iotk_attr.spp"
  val = tmpval(1)
# 400 "iotk_attr.spp"
  deallocate(tmpval)
# 402 "iotk_attr.spp"
1 continue
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute not found')
# 406 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if
  if(present(default) .and. .not. foundl) then
# 419 "iotk_attr.spp"
    val = default
# 421 "iotk_attr.spp"
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_attr_REAL4_0
# 429 "iotk_attr.spp"

#endif
#endif

subroutine iotk_attr_dummy_REAL4_0
  write(0,*)
end subroutine iotk_attr_dummy_REAL4_0

# 45 "iotk_attr.spp"

# 47 "iotk_attr.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_attr.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_attr.spp"

# 59 "iotk_attr.spp"

#ifdef __IOTK_REAL4
#if 1 <= __IOTK_MAXRANK

# 137 "iotk_attr.spp"

# 210 "iotk_attr.spp"

# 213 "iotk_attr.spp"
subroutine iotk_write_attr_REAL4_1(attr,name,val,dummy,first,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*), intent(inout) :: attr
  character(*), intent(in)    :: name
  REAL(kind=__IOTK_REAL4), intent(in)  :: val (:)
  type(iotk_dummytype), optional :: dummy
  logical, optional, intent(in)  :: first
  integer, optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen
  integer :: vallen
  integer :: namlen
  integer :: iostat
  character :: delim
# 235 "iotk_attr.spp"
  character(iotk_vallenx) :: tmpval
  ierrl = 0
  iostat = 0
  if(present(first)) then
    if(first) attr(1:1) = iotk_eos
  end if
  if(.not.iotk_check_name(name)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Wrong tag name')
# 242 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",trim(name))
    goto 1
  end if
  attlen = iotk_strlen(attr)
  if(attlen==len(attr)) attlen = len_trim(attr)
  namlen = len_trim(name)
# 262 "iotk_attr.spp"
  delim = '"'
# 266 "iotk_attr.spp"
  call iotk_write(pack(val,mask=.true.),tmpval,ierrl)
# 268 "iotk_attr.spp"
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 269 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 273 "iotk_attr.spp"
  vallen = iotk_strlen(tmpval)
  if(attlen+vallen+namlen+5>len(attr)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute dummy argument is too short')
    goto 1
  end if
  attr(attlen+1:attlen+vallen+namlen+5) = " "//trim(name)//"="//delim//tmpval(1:vallen)//delim//iotk_eos
1 continue
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_attr_REAL4_1

# 288 "iotk_attr.spp"
subroutine iotk_scan_attr_REAL4_1(attr,name,val,dummy,found,default,eos,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_read
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*),             intent(in)  :: attr
  character(*),             intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL(kind=__IOTK_REAL4)                        :: val (:)
#else
  REAL(kind=__IOTK_REAL4), intent(out)           :: val (:)
#endif
  type(iotk_dummytype), optional :: dummy
  logical,        optional, intent(out) :: found
  REAL(kind=__IOTK_REAL4), optional, intent(in)  :: default (:)
  logical,        optional, intent(in)  :: eos
  integer,        optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen,pos,equal
  character :: delim
  logical :: foundl
  character(iotk_vallenx) :: valc
# 317 "iotk_attr.spp"
  integer :: index
  REAL(kind=__IOTK_REAL4), allocatable :: tmpval (:)
# 320 "iotk_attr.spp"
  ierrl = 0
  attlen=iotk_strlen(attr)
  foundl = .false.
  equal = 0
  do
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) exit
    equal = equal + pos
    pos = scan(attr(equal+1:attlen),"=")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,'')
# 330 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",attr(equal+1:attlen))
      goto 1
    end if
    equal = equal + pos
    if(trim(attr(equal-pos:equal-1))==trim(name)) foundl = .true.
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 337 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    equal = equal + pos
    delim = attr(equal:equal)
    if(delim/="'" .and. delim/='"') then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 343 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    pos = scan(attr(equal+1:attlen),delim)
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 348 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    if(foundl) exit
    equal = equal + pos
  end do
  if(foundl) then
    call iotk_strcpy(valc,attr(equal+1:equal+pos-1),ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 357 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
  else
    goto 1
  end if
# 380 "iotk_attr.spp"
  allocate(tmpval(size(val)))
  index = 0
  call iotk_read(tmpval,valc(1:iotk_strlen(valc)),index,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 384 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 390 "iotk_attr.spp"
  if(index/=size(val)) then
# 392 "iotk_attr.spp"
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute size does not match')
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",valc)
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"size",size(tmpval))
    goto 1
  end if
# 398 "iotk_attr.spp"
  val = reshape (source=tmpval,shape=shape(val))
# 400 "iotk_attr.spp"
  deallocate(tmpval)
# 402 "iotk_attr.spp"
1 continue
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute not found')
# 406 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if
  if(present(default) .and. .not. foundl) then
# 419 "iotk_attr.spp"
    val = default
# 421 "iotk_attr.spp"
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_attr_REAL4_1
# 429 "iotk_attr.spp"

#endif
#endif

subroutine iotk_attr_dummy_REAL4_1
  write(0,*)
end subroutine iotk_attr_dummy_REAL4_1

# 45 "iotk_attr.spp"

# 47 "iotk_attr.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_attr.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_attr.spp"

# 59 "iotk_attr.spp"

#ifdef __IOTK_REAL4
#if 2 <= __IOTK_MAXRANK

# 137 "iotk_attr.spp"

# 210 "iotk_attr.spp"

# 213 "iotk_attr.spp"
subroutine iotk_write_attr_REAL4_2(attr,name,val,dummy,first,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*), intent(inout) :: attr
  character(*), intent(in)    :: name
  REAL(kind=__IOTK_REAL4), intent(in)  :: val (:,:)
  type(iotk_dummytype), optional :: dummy
  logical, optional, intent(in)  :: first
  integer, optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen
  integer :: vallen
  integer :: namlen
  integer :: iostat
  character :: delim
# 235 "iotk_attr.spp"
  character(iotk_vallenx) :: tmpval
  ierrl = 0
  iostat = 0
  if(present(first)) then
    if(first) attr(1:1) = iotk_eos
  end if
  if(.not.iotk_check_name(name)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Wrong tag name')
# 242 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",trim(name))
    goto 1
  end if
  attlen = iotk_strlen(attr)
  if(attlen==len(attr)) attlen = len_trim(attr)
  namlen = len_trim(name)
# 262 "iotk_attr.spp"
  delim = '"'
# 266 "iotk_attr.spp"
  call iotk_write(pack(val,mask=.true.),tmpval,ierrl)
# 268 "iotk_attr.spp"
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 269 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 273 "iotk_attr.spp"
  vallen = iotk_strlen(tmpval)
  if(attlen+vallen+namlen+5>len(attr)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute dummy argument is too short')
    goto 1
  end if
  attr(attlen+1:attlen+vallen+namlen+5) = " "//trim(name)//"="//delim//tmpval(1:vallen)//delim//iotk_eos
1 continue
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_attr_REAL4_2

# 288 "iotk_attr.spp"
subroutine iotk_scan_attr_REAL4_2(attr,name,val,dummy,found,default,eos,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_read
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*),             intent(in)  :: attr
  character(*),             intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL(kind=__IOTK_REAL4)                        :: val (:,:)
#else
  REAL(kind=__IOTK_REAL4), intent(out)           :: val (:,:)
#endif
  type(iotk_dummytype), optional :: dummy
  logical,        optional, intent(out) :: found
  REAL(kind=__IOTK_REAL4), optional, intent(in)  :: default (:,:)
  logical,        optional, intent(in)  :: eos
  integer,        optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen,pos,equal
  character :: delim
  logical :: foundl
  character(iotk_vallenx) :: valc
# 317 "iotk_attr.spp"
  integer :: index
  REAL(kind=__IOTK_REAL4), allocatable :: tmpval (:)
# 320 "iotk_attr.spp"
  ierrl = 0
  attlen=iotk_strlen(attr)
  foundl = .false.
  equal = 0
  do
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) exit
    equal = equal + pos
    pos = scan(attr(equal+1:attlen),"=")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,'')
# 330 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",attr(equal+1:attlen))
      goto 1
    end if
    equal = equal + pos
    if(trim(attr(equal-pos:equal-1))==trim(name)) foundl = .true.
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 337 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    equal = equal + pos
    delim = attr(equal:equal)
    if(delim/="'" .and. delim/='"') then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 343 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    pos = scan(attr(equal+1:attlen),delim)
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 348 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    if(foundl) exit
    equal = equal + pos
  end do
  if(foundl) then
    call iotk_strcpy(valc,attr(equal+1:equal+pos-1),ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 357 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
  else
    goto 1
  end if
# 380 "iotk_attr.spp"
  allocate(tmpval(size(val)))
  index = 0
  call iotk_read(tmpval,valc(1:iotk_strlen(valc)),index,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 384 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 390 "iotk_attr.spp"
  if(index/=size(val)) then
# 392 "iotk_attr.spp"
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute size does not match')
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",valc)
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"size",size(tmpval))
    goto 1
  end if
# 398 "iotk_attr.spp"
  val = reshape (source=tmpval,shape=shape(val))
# 400 "iotk_attr.spp"
  deallocate(tmpval)
# 402 "iotk_attr.spp"
1 continue
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute not found')
# 406 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if
  if(present(default) .and. .not. foundl) then
# 419 "iotk_attr.spp"
    val = default
# 421 "iotk_attr.spp"
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_attr_REAL4_2
# 429 "iotk_attr.spp"

#endif
#endif

subroutine iotk_attr_dummy_REAL4_2
  write(0,*)
end subroutine iotk_attr_dummy_REAL4_2

# 45 "iotk_attr.spp"

# 47 "iotk_attr.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_attr.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_attr.spp"

# 59 "iotk_attr.spp"

#ifdef __IOTK_REAL4
#if 3 <= __IOTK_MAXRANK

# 137 "iotk_attr.spp"

# 210 "iotk_attr.spp"

# 213 "iotk_attr.spp"
subroutine iotk_write_attr_REAL4_3(attr,name,val,dummy,first,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*), intent(inout) :: attr
  character(*), intent(in)    :: name
  REAL(kind=__IOTK_REAL4), intent(in)  :: val (:,:,:)
  type(iotk_dummytype), optional :: dummy
  logical, optional, intent(in)  :: first
  integer, optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen
  integer :: vallen
  integer :: namlen
  integer :: iostat
  character :: delim
# 235 "iotk_attr.spp"
  character(iotk_vallenx) :: tmpval
  ierrl = 0
  iostat = 0
  if(present(first)) then
    if(first) attr(1:1) = iotk_eos
  end if
  if(.not.iotk_check_name(name)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Wrong tag name')
# 242 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",trim(name))
    goto 1
  end if
  attlen = iotk_strlen(attr)
  if(attlen==len(attr)) attlen = len_trim(attr)
  namlen = len_trim(name)
# 262 "iotk_attr.spp"
  delim = '"'
# 266 "iotk_attr.spp"
  call iotk_write(pack(val,mask=.true.),tmpval,ierrl)
# 268 "iotk_attr.spp"
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 269 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 273 "iotk_attr.spp"
  vallen = iotk_strlen(tmpval)
  if(attlen+vallen+namlen+5>len(attr)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute dummy argument is too short')
    goto 1
  end if
  attr(attlen+1:attlen+vallen+namlen+5) = " "//trim(name)//"="//delim//tmpval(1:vallen)//delim//iotk_eos
1 continue
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_attr_REAL4_3

# 288 "iotk_attr.spp"
subroutine iotk_scan_attr_REAL4_3(attr,name,val,dummy,found,default,eos,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_read
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*),             intent(in)  :: attr
  character(*),             intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL(kind=__IOTK_REAL4)                        :: val (:,:,:)
#else
  REAL(kind=__IOTK_REAL4), intent(out)           :: val (:,:,:)
#endif
  type(iotk_dummytype), optional :: dummy
  logical,        optional, intent(out) :: found
  REAL(kind=__IOTK_REAL4), optional, intent(in)  :: default (:,:,:)
  logical,        optional, intent(in)  :: eos
  integer,        optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen,pos,equal
  character :: delim
  logical :: foundl
  character(iotk_vallenx) :: valc
# 317 "iotk_attr.spp"
  integer :: index
  REAL(kind=__IOTK_REAL4), allocatable :: tmpval (:)
# 320 "iotk_attr.spp"
  ierrl = 0
  attlen=iotk_strlen(attr)
  foundl = .false.
  equal = 0
  do
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) exit
    equal = equal + pos
    pos = scan(attr(equal+1:attlen),"=")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,'')
# 330 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",attr(equal+1:attlen))
      goto 1
    end if
    equal = equal + pos
    if(trim(attr(equal-pos:equal-1))==trim(name)) foundl = .true.
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 337 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    equal = equal + pos
    delim = attr(equal:equal)
    if(delim/="'" .and. delim/='"') then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 343 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    pos = scan(attr(equal+1:attlen),delim)
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 348 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    if(foundl) exit
    equal = equal + pos
  end do
  if(foundl) then
    call iotk_strcpy(valc,attr(equal+1:equal+pos-1),ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 357 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
  else
    goto 1
  end if
# 380 "iotk_attr.spp"
  allocate(tmpval(size(val)))
  index = 0
  call iotk_read(tmpval,valc(1:iotk_strlen(valc)),index,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 384 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 390 "iotk_attr.spp"
  if(index/=size(val)) then
# 392 "iotk_attr.spp"
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute size does not match')
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",valc)
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"size",size(tmpval))
    goto 1
  end if
# 398 "iotk_attr.spp"
  val = reshape (source=tmpval,shape=shape(val))
# 400 "iotk_attr.spp"
  deallocate(tmpval)
# 402 "iotk_attr.spp"
1 continue
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute not found')
# 406 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if
  if(present(default) .and. .not. foundl) then
# 419 "iotk_attr.spp"
    val = default
# 421 "iotk_attr.spp"
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_attr_REAL4_3
# 429 "iotk_attr.spp"

#endif
#endif

subroutine iotk_attr_dummy_REAL4_3
  write(0,*)
end subroutine iotk_attr_dummy_REAL4_3

# 45 "iotk_attr.spp"

# 47 "iotk_attr.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_attr.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_attr.spp"

# 59 "iotk_attr.spp"

#ifdef __IOTK_REAL4
#if 4 <= __IOTK_MAXRANK

# 137 "iotk_attr.spp"

# 210 "iotk_attr.spp"

# 213 "iotk_attr.spp"
subroutine iotk_write_attr_REAL4_4(attr,name,val,dummy,first,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*), intent(inout) :: attr
  character(*), intent(in)    :: name
  REAL(kind=__IOTK_REAL4), intent(in)  :: val (:,:,:,:)
  type(iotk_dummytype), optional :: dummy
  logical, optional, intent(in)  :: first
  integer, optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen
  integer :: vallen
  integer :: namlen
  integer :: iostat
  character :: delim
# 235 "iotk_attr.spp"
  character(iotk_vallenx) :: tmpval
  ierrl = 0
  iostat = 0
  if(present(first)) then
    if(first) attr(1:1) = iotk_eos
  end if
  if(.not.iotk_check_name(name)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Wrong tag name')
# 242 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",trim(name))
    goto 1
  end if
  attlen = iotk_strlen(attr)
  if(attlen==len(attr)) attlen = len_trim(attr)
  namlen = len_trim(name)
# 262 "iotk_attr.spp"
  delim = '"'
# 266 "iotk_attr.spp"
  call iotk_write(pack(val,mask=.true.),tmpval,ierrl)
# 268 "iotk_attr.spp"
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 269 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 273 "iotk_attr.spp"
  vallen = iotk_strlen(tmpval)
  if(attlen+vallen+namlen+5>len(attr)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute dummy argument is too short')
    goto 1
  end if
  attr(attlen+1:attlen+vallen+namlen+5) = " "//trim(name)//"="//delim//tmpval(1:vallen)//delim//iotk_eos
1 continue
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_attr_REAL4_4

# 288 "iotk_attr.spp"
subroutine iotk_scan_attr_REAL4_4(attr,name,val,dummy,found,default,eos,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_read
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*),             intent(in)  :: attr
  character(*),             intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL(kind=__IOTK_REAL4)                        :: val (:,:,:,:)
#else
  REAL(kind=__IOTK_REAL4), intent(out)           :: val (:,:,:,:)
#endif
  type(iotk_dummytype), optional :: dummy
  logical,        optional, intent(out) :: found
  REAL(kind=__IOTK_REAL4), optional, intent(in)  :: default (:,:,:,:)
  logical,        optional, intent(in)  :: eos
  integer,        optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen,pos,equal
  character :: delim
  logical :: foundl
  character(iotk_vallenx) :: valc
# 317 "iotk_attr.spp"
  integer :: index
  REAL(kind=__IOTK_REAL4), allocatable :: tmpval (:)
# 320 "iotk_attr.spp"
  ierrl = 0
  attlen=iotk_strlen(attr)
  foundl = .false.
  equal = 0
  do
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) exit
    equal = equal + pos
    pos = scan(attr(equal+1:attlen),"=")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,'')
# 330 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",attr(equal+1:attlen))
      goto 1
    end if
    equal = equal + pos
    if(trim(attr(equal-pos:equal-1))==trim(name)) foundl = .true.
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 337 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    equal = equal + pos
    delim = attr(equal:equal)
    if(delim/="'" .and. delim/='"') then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 343 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    pos = scan(attr(equal+1:attlen),delim)
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 348 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    if(foundl) exit
    equal = equal + pos
  end do
  if(foundl) then
    call iotk_strcpy(valc,attr(equal+1:equal+pos-1),ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 357 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
  else
    goto 1
  end if
# 380 "iotk_attr.spp"
  allocate(tmpval(size(val)))
  index = 0
  call iotk_read(tmpval,valc(1:iotk_strlen(valc)),index,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 384 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 390 "iotk_attr.spp"
  if(index/=size(val)) then
# 392 "iotk_attr.spp"
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute size does not match')
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",valc)
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"size",size(tmpval))
    goto 1
  end if
# 398 "iotk_attr.spp"
  val = reshape (source=tmpval,shape=shape(val))
# 400 "iotk_attr.spp"
  deallocate(tmpval)
# 402 "iotk_attr.spp"
1 continue
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute not found')
# 406 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if
  if(present(default) .and. .not. foundl) then
# 419 "iotk_attr.spp"
    val = default
# 421 "iotk_attr.spp"
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_attr_REAL4_4
# 429 "iotk_attr.spp"

#endif
#endif

subroutine iotk_attr_dummy_REAL4_4
  write(0,*)
end subroutine iotk_attr_dummy_REAL4_4

# 45 "iotk_attr.spp"

# 47 "iotk_attr.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_attr.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_attr.spp"

# 59 "iotk_attr.spp"

#ifdef __IOTK_REAL4
#if 5 <= __IOTK_MAXRANK

# 137 "iotk_attr.spp"

# 210 "iotk_attr.spp"

# 213 "iotk_attr.spp"
subroutine iotk_write_attr_REAL4_5(attr,name,val,dummy,first,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*), intent(inout) :: attr
  character(*), intent(in)    :: name
  REAL(kind=__IOTK_REAL4), intent(in)  :: val (:,:,:,:,:)
  type(iotk_dummytype), optional :: dummy
  logical, optional, intent(in)  :: first
  integer, optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen
  integer :: vallen
  integer :: namlen
  integer :: iostat
  character :: delim
# 235 "iotk_attr.spp"
  character(iotk_vallenx) :: tmpval
  ierrl = 0
  iostat = 0
  if(present(first)) then
    if(first) attr(1:1) = iotk_eos
  end if
  if(.not.iotk_check_name(name)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Wrong tag name')
# 242 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",trim(name))
    goto 1
  end if
  attlen = iotk_strlen(attr)
  if(attlen==len(attr)) attlen = len_trim(attr)
  namlen = len_trim(name)
# 262 "iotk_attr.spp"
  delim = '"'
# 266 "iotk_attr.spp"
  call iotk_write(pack(val,mask=.true.),tmpval,ierrl)
# 268 "iotk_attr.spp"
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 269 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 273 "iotk_attr.spp"
  vallen = iotk_strlen(tmpval)
  if(attlen+vallen+namlen+5>len(attr)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute dummy argument is too short')
    goto 1
  end if
  attr(attlen+1:attlen+vallen+namlen+5) = " "//trim(name)//"="//delim//tmpval(1:vallen)//delim//iotk_eos
1 continue
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_attr_REAL4_5

# 288 "iotk_attr.spp"
subroutine iotk_scan_attr_REAL4_5(attr,name,val,dummy,found,default,eos,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_read
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*),             intent(in)  :: attr
  character(*),             intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL(kind=__IOTK_REAL4)                        :: val (:,:,:,:,:)
#else
  REAL(kind=__IOTK_REAL4), intent(out)           :: val (:,:,:,:,:)
#endif
  type(iotk_dummytype), optional :: dummy
  logical,        optional, intent(out) :: found
  REAL(kind=__IOTK_REAL4), optional, intent(in)  :: default (:,:,:,:,:)
  logical,        optional, intent(in)  :: eos
  integer,        optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen,pos,equal
  character :: delim
  logical :: foundl
  character(iotk_vallenx) :: valc
# 317 "iotk_attr.spp"
  integer :: index
  REAL(kind=__IOTK_REAL4), allocatable :: tmpval (:)
# 320 "iotk_attr.spp"
  ierrl = 0
  attlen=iotk_strlen(attr)
  foundl = .false.
  equal = 0
  do
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) exit
    equal = equal + pos
    pos = scan(attr(equal+1:attlen),"=")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,'')
# 330 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",attr(equal+1:attlen))
      goto 1
    end if
    equal = equal + pos
    if(trim(attr(equal-pos:equal-1))==trim(name)) foundl = .true.
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 337 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    equal = equal + pos
    delim = attr(equal:equal)
    if(delim/="'" .and. delim/='"') then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 343 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    pos = scan(attr(equal+1:attlen),delim)
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 348 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    if(foundl) exit
    equal = equal + pos
  end do
  if(foundl) then
    call iotk_strcpy(valc,attr(equal+1:equal+pos-1),ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 357 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
  else
    goto 1
  end if
# 380 "iotk_attr.spp"
  allocate(tmpval(size(val)))
  index = 0
  call iotk_read(tmpval,valc(1:iotk_strlen(valc)),index,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 384 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 390 "iotk_attr.spp"
  if(index/=size(val)) then
# 392 "iotk_attr.spp"
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute size does not match')
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",valc)
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"size",size(tmpval))
    goto 1
  end if
# 398 "iotk_attr.spp"
  val = reshape (source=tmpval,shape=shape(val))
# 400 "iotk_attr.spp"
  deallocate(tmpval)
# 402 "iotk_attr.spp"
1 continue
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute not found')
# 406 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if
  if(present(default) .and. .not. foundl) then
# 419 "iotk_attr.spp"
    val = default
# 421 "iotk_attr.spp"
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_attr_REAL4_5
# 429 "iotk_attr.spp"

#endif
#endif

subroutine iotk_attr_dummy_REAL4_5
  write(0,*)
end subroutine iotk_attr_dummy_REAL4_5

# 45 "iotk_attr.spp"

# 47 "iotk_attr.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_attr.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_attr.spp"

# 59 "iotk_attr.spp"

#ifdef __IOTK_REAL4
#if 6 <= __IOTK_MAXRANK

# 137 "iotk_attr.spp"

# 210 "iotk_attr.spp"

# 213 "iotk_attr.spp"
subroutine iotk_write_attr_REAL4_6(attr,name,val,dummy,first,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*), intent(inout) :: attr
  character(*), intent(in)    :: name
  REAL(kind=__IOTK_REAL4), intent(in)  :: val (:,:,:,:,:,:)
  type(iotk_dummytype), optional :: dummy
  logical, optional, intent(in)  :: first
  integer, optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen
  integer :: vallen
  integer :: namlen
  integer :: iostat
  character :: delim
# 235 "iotk_attr.spp"
  character(iotk_vallenx) :: tmpval
  ierrl = 0
  iostat = 0
  if(present(first)) then
    if(first) attr(1:1) = iotk_eos
  end if
  if(.not.iotk_check_name(name)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Wrong tag name')
# 242 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",trim(name))
    goto 1
  end if
  attlen = iotk_strlen(attr)
  if(attlen==len(attr)) attlen = len_trim(attr)
  namlen = len_trim(name)
# 262 "iotk_attr.spp"
  delim = '"'
# 266 "iotk_attr.spp"
  call iotk_write(pack(val,mask=.true.),tmpval,ierrl)
# 268 "iotk_attr.spp"
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 269 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 273 "iotk_attr.spp"
  vallen = iotk_strlen(tmpval)
  if(attlen+vallen+namlen+5>len(attr)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute dummy argument is too short')
    goto 1
  end if
  attr(attlen+1:attlen+vallen+namlen+5) = " "//trim(name)//"="//delim//tmpval(1:vallen)//delim//iotk_eos
1 continue
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_attr_REAL4_6

# 288 "iotk_attr.spp"
subroutine iotk_scan_attr_REAL4_6(attr,name,val,dummy,found,default,eos,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_read
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*),             intent(in)  :: attr
  character(*),             intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL(kind=__IOTK_REAL4)                        :: val (:,:,:,:,:,:)
#else
  REAL(kind=__IOTK_REAL4), intent(out)           :: val (:,:,:,:,:,:)
#endif
  type(iotk_dummytype), optional :: dummy
  logical,        optional, intent(out) :: found
  REAL(kind=__IOTK_REAL4), optional, intent(in)  :: default (:,:,:,:,:,:)
  logical,        optional, intent(in)  :: eos
  integer,        optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen,pos,equal
  character :: delim
  logical :: foundl
  character(iotk_vallenx) :: valc
# 317 "iotk_attr.spp"
  integer :: index
  REAL(kind=__IOTK_REAL4), allocatable :: tmpval (:)
# 320 "iotk_attr.spp"
  ierrl = 0
  attlen=iotk_strlen(attr)
  foundl = .false.
  equal = 0
  do
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) exit
    equal = equal + pos
    pos = scan(attr(equal+1:attlen),"=")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,'')
# 330 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",attr(equal+1:attlen))
      goto 1
    end if
    equal = equal + pos
    if(trim(attr(equal-pos:equal-1))==trim(name)) foundl = .true.
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 337 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    equal = equal + pos
    delim = attr(equal:equal)
    if(delim/="'" .and. delim/='"') then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 343 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    pos = scan(attr(equal+1:attlen),delim)
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 348 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    if(foundl) exit
    equal = equal + pos
  end do
  if(foundl) then
    call iotk_strcpy(valc,attr(equal+1:equal+pos-1),ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 357 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
  else
    goto 1
  end if
# 380 "iotk_attr.spp"
  allocate(tmpval(size(val)))
  index = 0
  call iotk_read(tmpval,valc(1:iotk_strlen(valc)),index,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 384 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 390 "iotk_attr.spp"
  if(index/=size(val)) then
# 392 "iotk_attr.spp"
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute size does not match')
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",valc)
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"size",size(tmpval))
    goto 1
  end if
# 398 "iotk_attr.spp"
  val = reshape (source=tmpval,shape=shape(val))
# 400 "iotk_attr.spp"
  deallocate(tmpval)
# 402 "iotk_attr.spp"
1 continue
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute not found')
# 406 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if
  if(present(default) .and. .not. foundl) then
# 419 "iotk_attr.spp"
    val = default
# 421 "iotk_attr.spp"
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_attr_REAL4_6
# 429 "iotk_attr.spp"

#endif
#endif

subroutine iotk_attr_dummy_REAL4_6
  write(0,*)
end subroutine iotk_attr_dummy_REAL4_6

# 45 "iotk_attr.spp"

# 47 "iotk_attr.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_attr.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_attr.spp"

# 59 "iotk_attr.spp"

#ifdef __IOTK_REAL4
#if 7 <= __IOTK_MAXRANK

# 137 "iotk_attr.spp"

# 210 "iotk_attr.spp"

# 213 "iotk_attr.spp"
subroutine iotk_write_attr_REAL4_7(attr,name,val,dummy,first,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*), intent(inout) :: attr
  character(*), intent(in)    :: name
  REAL(kind=__IOTK_REAL4), intent(in)  :: val (:,:,:,:,:,:,:)
  type(iotk_dummytype), optional :: dummy
  logical, optional, intent(in)  :: first
  integer, optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen
  integer :: vallen
  integer :: namlen
  integer :: iostat
  character :: delim
# 235 "iotk_attr.spp"
  character(iotk_vallenx) :: tmpval
  ierrl = 0
  iostat = 0
  if(present(first)) then
    if(first) attr(1:1) = iotk_eos
  end if
  if(.not.iotk_check_name(name)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 242 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Wrong tag name')
# 242 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",trim(name))
    goto 1
  end if
  attlen = iotk_strlen(attr)
  if(attlen==len(attr)) attlen = len_trim(attr)
  namlen = len_trim(name)
# 262 "iotk_attr.spp"
  delim = '"'
# 266 "iotk_attr.spp"
  call iotk_write(pack(val,mask=.true.),tmpval,ierrl)
# 268 "iotk_attr.spp"
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 269 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 273 "iotk_attr.spp"
  vallen = iotk_strlen(tmpval)
  if(attlen+vallen+namlen+5>len(attr)) then
    call iotk_error_issue(ierrl,"iotk_write_attr",__FILE__,__LINE__)
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 275 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute dummy argument is too short')
    goto 1
  end if
  attr(attlen+1:attlen+vallen+namlen+5) = " "//trim(name)//"="//delim//tmpval(1:vallen)//delim//iotk_eos
1 continue
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_attr_REAL4_7

# 288 "iotk_attr.spp"
subroutine iotk_scan_attr_REAL4_7(attr,name,val,dummy,found,default,eos,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_read
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  character(*),             intent(in)  :: attr
  character(*),             intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL(kind=__IOTK_REAL4)                        :: val (:,:,:,:,:,:,:)
#else
  REAL(kind=__IOTK_REAL4), intent(out)           :: val (:,:,:,:,:,:,:)
#endif
  type(iotk_dummytype), optional :: dummy
  logical,        optional, intent(out) :: found
  REAL(kind=__IOTK_REAL4), optional, intent(in)  :: default (:,:,:,:,:,:,:)
  logical,        optional, intent(in)  :: eos
  integer,        optional, intent(out) :: ierr
  integer :: ierrl
  integer :: attlen,pos,equal
  character :: delim
  logical :: foundl
  character(iotk_vallenx) :: valc
# 317 "iotk_attr.spp"
  integer :: index
  REAL(kind=__IOTK_REAL4), allocatable :: tmpval (:)
# 320 "iotk_attr.spp"
  ierrl = 0
  attlen=iotk_strlen(attr)
  foundl = .false.
  equal = 0
  do
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) exit
    equal = equal + pos
    pos = scan(attr(equal+1:attlen),"=")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 330 "iotk_attr.spp"
call iotk_error_msg(ierrl,'')
# 330 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",attr(equal+1:attlen))
      goto 1
    end if
    equal = equal + pos
    if(trim(attr(equal-pos:equal-1))==trim(name)) foundl = .true.
    pos = verify(attr(equal+1:attlen)," ")
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 337 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    equal = equal + pos
    delim = attr(equal:equal)
    if(delim/="'" .and. delim/='"') then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 343 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    pos = scan(attr(equal+1:attlen),delim)
    if(pos<=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 348 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
    if(foundl) exit
    equal = equal + pos
  end do
  if(foundl) then
    call iotk_strcpy(valc,attr(equal+1:equal+pos-1),ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 357 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
      goto 1
    end if
  else
    goto 1
  end if
# 380 "iotk_attr.spp"
  allocate(tmpval(size(val)))
  index = 0
  call iotk_read(tmpval,valc(1:iotk_strlen(valc)),index,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 384 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
    goto 1
  end if
# 390 "iotk_attr.spp"
  if(index/=size(val)) then
# 392 "iotk_attr.spp"
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 392 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute size does not match')
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"attr",valc)
# 392 "iotk_attr.spp"
call iotk_error_write(ierrl,"size",size(tmpval))
    goto 1
  end if
# 398 "iotk_attr.spp"
  val = reshape (source=tmpval,shape=shape(val))
# 400 "iotk_attr.spp"
  deallocate(tmpval)
# 402 "iotk_attr.spp"
1 continue
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_attr",__FILE__,__LINE__)
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.7 ")
# 406 "iotk_attr.spp"
call iotk_error_msg(ierrl,'Attribute not found')
# 406 "iotk_attr.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if
  if(present(default) .and. .not. foundl) then
# 419 "iotk_attr.spp"
    val = default
# 421 "iotk_attr.spp"
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_attr_REAL4_7
# 429 "iotk_attr.spp"

#endif
#endif

subroutine iotk_attr_dummy_REAL4_7
  write(0,*)
end subroutine iotk_attr_dummy_REAL4_7

# 45 "iotk_attr.spp"

# 47 "iotk_dat.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_dat.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_dat.spp"

# 59 "iotk_dat.spp"

#ifdef __IOTK_REAL1
#if 0 <= __IOTK_MAXRANK
# 63 "iotk_dat.spp"
subroutine iotk_write_dat_REAL1_0(unit,name,dat,dummy,attr,fmt,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_write_attr
  use iotk_write_interf
  use iotk_fmt_interf
  use iotk_str_interf
  use iotk_unit_interf
  use iotk_misc_interf
  implicit none
  integer,                intent(in)  :: unit
  character(*),           intent(in)  :: name
  REAL (kind=__IOTK_REAL1), intent(in)  :: dat  
  type(iotk_dummytype), optional      :: dummy
  character(len=*), optional, intent(in)  :: attr
  character(len=*), optional, intent(in)  :: fmt
  integer,      optional, intent(out) :: ierr
  integer :: ierrl,lunit,iostat
  logical :: binary,raw
  integer(iotk_header_kind), parameter :: idummy=0
  character(300) :: usefmt,usefmt1
  character(iotk_attlenx) :: lattr
  character(iotk_attlenx) :: attr_tmp
  type (iotk_unit), pointer :: this
# 91 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL1),allocatable :: dattmp(:)
# 93 "iotk_dat.spp"
  integer :: itmp
  ierrl = 0
  iostat = 0
  lunit = iotk_phys_unit(unit)
  call iotk_unit_get(lunit,pointer=this)
  raw = .false.
  if(associated(this)) then
    raw = this%raw
  end if
  call iotk_inquire(lunit,binary=binary,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 104 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_strcpy(usefmt,"!",ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 109 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(fmt) .and. .not. raw) call iotk_strcpy(usefmt,iotk_strtrim(fmt),ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 114 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(iotk_strscan(usefmt,"<>&")/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Special characters (<>&) found in fmt string')
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"unit",unit)
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",trim(name))
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"fmt",trim(fmt))
    goto 1
  end if
  call iotk_write_attr(lattr,"type",iotk_tolower("REAL"),first=.true.,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 123 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_attr(lattr,"size",1,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 128 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
# 138 "iotk_dat.spp"
  if(binary) then
    call iotk_write_attr(lattr,"kind",kind(dat),ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 141 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
  end if
# 146 "iotk_dat.spp"
  if(.not.iotk_strcomp(usefmt,"!")) call iotk_write_attr(lattr,"fmt",iotk_strtrim(usefmt),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 148 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(attr)) then
    attr_tmp(1:1)=iotk_eos
    call iotk_strcpy(attr_tmp,attr,ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 155 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"type",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 160 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"kind",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 165 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"size",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 170 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"fmt",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 175 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"len",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 180 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    if(iotk_strlen_trim(attr_tmp)>0) call iotk_strcat(lattr,iotk_strtrim(attr_tmp),ierr=ierrl)
  end if
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 186 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_begin(unit,name,lattr,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 191 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if

  allocate(dattmp(1))
# 197 "iotk_dat.spp"
     dattmp(1) = dat
# 209 "iotk_dat.spp"

  if(binary) then
    if(raw) then
      write(lunit,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 214 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else
      write(lunit,iostat=iostat) idummy,(dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 220 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  else
    if(raw) then
# 229 "iotk_dat.spp"
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
# 231 "iotk_dat.spp"
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 232 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"*")) then
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 238 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"!")) then
# 252 "iotk_dat.spp"
     write(lunit,fmt=trim(iotk_wfmt("REAL",kind(dattmp),1,-1)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
     if(iostat/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 254 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
     end if
# 258 "iotk_dat.spp"
    else
      write(lunit,fmt=usefmt(1:iotk_strlen(usefmt)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 261 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  end if
  call iotk_write_end(unit,name,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 268 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
1 continue
  if(allocated(dattmp)) deallocate(dattmp)
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_dat_REAL1_0


# 545 "iotk_dat.spp"

# 547 "iotk_dat.spp"
subroutine iotk_scan_dat_REAL1_0(unit,name,dat,dummy,attr,found,default,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_dat_interf, only: iotk_scan_dat_aux
  use iotk_scan_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  integer,                   intent(in)  :: unit
  character(*),              intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL (kind=__IOTK_REAL1)                        :: dat 
#else
  REAL (kind=__IOTK_REAL1),           intent(out) :: dat 
#endif
  type(iotk_dummytype), optional         :: dummy
#ifdef __IOTK_WORKAROUND6
  character(len=*),optional              :: attr
#else
  character(len=*),optional, intent(out) :: attr
#endif
  logical,         optional, intent(out) :: found
  REAL (kind=__IOTK_REAL1), optional, intent(in)  :: default 
  integer,         optional, intent(out) :: ierr
# 574 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL1),              allocatable :: tmpdat(:)
# 576 "iotk_dat.spp"
  integer :: ierrl,ierrl2
  integer :: rkind,rsize,rlen
  character(iotk_vallenx) :: rtype
  character(iotk_vallenx) :: fmt
  character(iotk_attlenx) :: lattr
  logical :: inside,foundl
  inside = .false.
  ierrl = 0
  ierrl2 = 0
  foundl=.false.
  call iotk_scan_begin(unit,name,lattr,found=foundl,ierr=ierrl)
  if(.not. foundl) goto 1
  foundl = .true.
  inside = .true.
  if(present(attr)) call iotk_strcpy(attr,lattr,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 592 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_parse_dat(lattr,rtype,rkind,rsize,rlen,fmt,ierrl)
  if(ierrl/=0) goto 1
  if(.not. (iotk_strcomp(rtype,iotk_eos) .or. iotk_strcomp(rtype,"REAL") ) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,' ')
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"rtype",rtype(1:iotk_strlen(rtype)))
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"type","REAL")
    goto 1
  end if
  if(.not. (rsize==-1 .or. rsize==1) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 602 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(rkind==-1) rkind = kind(dat)
# 609 "iotk_dat.spp"

  allocate(tmpdat(1))
  call iotk_scan_dat_aux(unit,tmpdat,rkind,rlen,fmt(1:iotk_strlen(fmt)),ierrl)
# 613 "iotk_dat.spp"
        dat = tmpdat(1)
# 617 "iotk_dat.spp"
  deallocate(tmpdat)
1 continue
  if(inside) then
    call iotk_scan_end(unit,name,ierr=ierrl2)
    if(ierrl2/=0) then
      call iotk_error_clear(ierrl)
      ierrl=ierrl2
    end if
  end if
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Dat not found')
# 629 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if 
  if(present(default) .and. .not. foundl) then
    dat=default
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl>0 .or. (.not.present(found) .and. .not.present(default))) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_dat_REAL1_0


#endif
#endif

subroutine iotk_dat_dummy_REAL1_0
  write(0,*)
end subroutine iotk_dat_dummy_REAL1_0

# 45 "iotk_dat.spp"

# 47 "iotk_dat.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_dat.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_dat.spp"

# 59 "iotk_dat.spp"

#ifdef __IOTK_REAL1
#if 1 <= __IOTK_MAXRANK
# 63 "iotk_dat.spp"
subroutine iotk_write_dat_REAL1_1(unit,name,dat,dummy,attr,fmt,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_write_attr
  use iotk_write_interf
  use iotk_fmt_interf
  use iotk_str_interf
  use iotk_unit_interf
  use iotk_misc_interf
  implicit none
  integer,                intent(in)  :: unit
  character(*),           intent(in)  :: name
  REAL (kind=__IOTK_REAL1), intent(in)  :: dat (:) 
  type(iotk_dummytype), optional      :: dummy
  character(len=*), optional, intent(in)  :: attr
  character(len=*), optional, intent(in)  :: fmt
  integer,      optional, intent(out) :: ierr
  integer :: ierrl,lunit,iostat
  logical :: binary,raw
  integer(iotk_header_kind), parameter :: idummy=0
  character(300) :: usefmt,usefmt1
  character(iotk_attlenx) :: lattr
  character(iotk_attlenx) :: attr_tmp
  type (iotk_unit), pointer :: this
# 91 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL1),allocatable :: dattmp(:)
# 93 "iotk_dat.spp"
  integer :: itmp
  ierrl = 0
  iostat = 0
  lunit = iotk_phys_unit(unit)
  call iotk_unit_get(lunit,pointer=this)
  raw = .false.
  if(associated(this)) then
    raw = this%raw
  end if
  call iotk_inquire(lunit,binary=binary,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 104 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_strcpy(usefmt,"!",ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 109 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(fmt) .and. .not. raw) call iotk_strcpy(usefmt,iotk_strtrim(fmt),ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 114 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(iotk_strscan(usefmt,"<>&")/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Special characters (<>&) found in fmt string')
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"unit",unit)
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",trim(name))
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"fmt",trim(fmt))
    goto 1
  end if
  call iotk_write_attr(lattr,"type",iotk_tolower("REAL"),first=.true.,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 123 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_attr(lattr,"size",size(dat),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 128 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
# 138 "iotk_dat.spp"
  if(binary) then
    call iotk_write_attr(lattr,"kind",kind(dat),ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 141 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
  end if
# 146 "iotk_dat.spp"
  if(.not.iotk_strcomp(usefmt,"!")) call iotk_write_attr(lattr,"fmt",iotk_strtrim(usefmt),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 148 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(attr)) then
    attr_tmp(1:1)=iotk_eos
    call iotk_strcpy(attr_tmp,attr,ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 155 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"type",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 160 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"kind",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 165 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"size",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 170 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"fmt",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 175 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"len",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 180 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    if(iotk_strlen_trim(attr_tmp)>0) call iotk_strcat(lattr,iotk_strtrim(attr_tmp),ierr=ierrl)
  end if
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 186 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_begin(unit,name,lattr,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 191 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if

  allocate(dattmp(size(dat)))
# 199 "iotk_dat.spp"
#if defined(__IOTK_WORKAROUND3) || defined(__IOTK_WORKAROUND4)
# 203 "iotk_dat.spp"
     call iotk_private_pack_REAL1(dattmp,dat,size(dattmp),1)
# 205 "iotk_dat.spp"
#else
     dattmp = pack(dat,mask=.true.)
#endif
# 209 "iotk_dat.spp"

  if(binary) then
    if(raw) then
      write(lunit,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 214 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else
      write(lunit,iostat=iostat) idummy,(dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 220 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  else
    if(raw) then
# 229 "iotk_dat.spp"
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
# 231 "iotk_dat.spp"
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 232 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"*")) then
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 238 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"!")) then
# 252 "iotk_dat.spp"
     write(lunit,fmt=trim(iotk_wfmt("REAL",kind(dattmp),1,-1)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
     if(iostat/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 254 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
     end if
# 258 "iotk_dat.spp"
    else
      write(lunit,fmt=usefmt(1:iotk_strlen(usefmt)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 261 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  end if
  call iotk_write_end(unit,name,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 268 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
1 continue
  if(allocated(dattmp)) deallocate(dattmp)
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_dat_REAL1_1


# 283 "iotk_dat.spp"
recursive subroutine iotk_scan_dat_aux_REAL1(unit,dat,rkind,rlen,fmt,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only: iotk_read
  use iotk_scan_interf
  use iotk_str_interf
  use iotk_unit_interf
  use iotk_misc_interf
  implicit none
  integer,         intent(in)  :: unit
#ifdef __IOTK_WORKAROUND6
  REAL (kind=__IOTK_REAL1)                        :: dat (:)
#else
  REAL (kind=__IOTK_REAL1),           intent(out) :: dat (:)
#endif
  integer,         intent(in)  :: rkind
  integer,         intent(in)  :: rlen
  character(*),    intent(in)  :: fmt
  integer,         intent(out) :: ierr
  integer(iotk_header_kind) :: idummy
  logical :: raw,binary
  integer :: lunit
  integer :: index,length,nexttag,iostat,altlength
  type(iotk_unit), pointer :: this
  character(len=iotk_linlenx) :: line,altline
# 313 "iotk_dat.spp"
#ifdef __IOTK_REAL2
  REAL (__IOTK_REAL2), allocatable :: dat2 (:)
#endif
# 313 "iotk_dat.spp"
#ifdef __IOTK_REAL3
  REAL (__IOTK_REAL3), allocatable :: dat3 (:)
#endif
# 313 "iotk_dat.spp"
#ifdef __IOTK_REAL4
  REAL (__IOTK_REAL4), allocatable :: dat4 (:)
#endif
# 319 "iotk_dat.spp"
  lunit = iotk_phys_unit(unit)
  ierr = 0
  iostat = 0
  idummy = 0
  call iotk_unit_get(lunit,pointer=this)
  raw = .false.
  if(associated(this)) then
    raw = this%raw
  end if
  call iotk_inquire(unit=lunit,binary=binary,ierr=ierr)
  if(ierr/=0) then
    call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 330 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
    return
  end if
# 420 "iotk_dat.spp"
  if(binary) then
    select case(rkind)
    case(kind(dat))
      if(raw) then
        read(lunit,iostat=iostat) dat
        if(iostat/=0) then
          call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 426 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
# 426 "iotk_dat.spp"
call iotk_error_msg(ierr,' ')
# 426 "iotk_dat.spp"
call iotk_error_write(ierr,"iostat",iostat)
          return
        end if
      else
        read(lunit,iostat=iostat) idummy,dat
        if(iostat/=0) then
          call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 432 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
# 432 "iotk_dat.spp"
call iotk_error_msg(ierr,' ')
# 432 "iotk_dat.spp"
call iotk_error_write(ierr,"iostat",iostat)
          return
        end if
      end if
# 438 "iotk_dat.spp"
#ifdef __IOTK_REAL2
    case(kind(dat2))
      ! Giusto per scrupolo. Se e' raw non ci sono info sul kind, quindi questa linea e' irraggiungibile
      if(raw) then
        call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 442 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
        return
      end if
      allocate(dat2(ubound(dat,1)))
      read(lunit,iostat=iostat) idummy,dat2
      if(iostat/=0) then
        call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 448 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
# 448 "iotk_dat.spp"
call iotk_error_msg(ierr,' ')
# 448 "iotk_dat.spp"
call iotk_error_write(ierr,"iostat",iostat)
        return
      end if
# 458 "iotk_dat.spp"
      dat = dat2
# 460 "iotk_dat.spp"
      deallocate(dat2)
#endif
# 438 "iotk_dat.spp"
#ifdef __IOTK_REAL3
    case(kind(dat3))
      ! Giusto per scrupolo. Se e' raw non ci sono info sul kind, quindi questa linea e' irraggiungibile
      if(raw) then
        call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 442 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
        return
      end if
      allocate(dat3(ubound(dat,1)))
      read(lunit,iostat=iostat) idummy,dat3
      if(iostat/=0) then
        call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 448 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
# 448 "iotk_dat.spp"
call iotk_error_msg(ierr,' ')
# 448 "iotk_dat.spp"
call iotk_error_write(ierr,"iostat",iostat)
        return
      end if
# 458 "iotk_dat.spp"
      dat = dat3
# 460 "iotk_dat.spp"
      deallocate(dat3)
#endif
# 438 "iotk_dat.spp"
#ifdef __IOTK_REAL4
    case(kind(dat4))
      ! Giusto per scrupolo. Se e' raw non ci sono info sul kind, quindi questa linea e' irraggiungibile
      if(raw) then
        call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 442 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
        return
      end if
      allocate(dat4(ubound(dat,1)))
      read(lunit,iostat=iostat) idummy,dat4
      if(iostat/=0) then
        call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 448 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
# 448 "iotk_dat.spp"
call iotk_error_msg(ierr,' ')
# 448 "iotk_dat.spp"
call iotk_error_write(ierr,"iostat",iostat)
        return
      end if
# 458 "iotk_dat.spp"
      dat = dat4
# 460 "iotk_dat.spp"
      deallocate(dat4)
#endif
# 464 "iotk_dat.spp"
    case default
      call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 465 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
# 465 "iotk_dat.spp"
call iotk_error_msg(ierr,'Kind incompatibility')
# 465 "iotk_dat.spp"
call iotk_error_write(ierr,"kind",rkind)
    end select
  else
    if(raw) then
      read(lunit,fmt=*,iostat=iostat) dat
      if(iostat/=0) then
        call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 471 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
# 471 "iotk_dat.spp"
call iotk_error_msg(ierr,' ')
# 471 "iotk_dat.spp"
call iotk_error_write(ierr,"iostat",iostat)
        return
      end if
    else if(iotk_strcomp(fmt,"*")) then
      read(lunit,fmt=*,iostat=iostat) dat
      if(iostat/=0) then
        call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 477 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
# 477 "iotk_dat.spp"
call iotk_error_msg(ierr,' ')
# 477 "iotk_dat.spp"
call iotk_error_write(ierr,"iostat",iostat)
        return
      end if
    else if(iotk_strcomp(fmt,"!")) then
      index = 0
      do
        call iotk_getline(lunit,line,length,ierr)
        if(ierr/=0) then
          call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 485 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
          return
        end if
        nexttag = scan(line(1:length),"<")
        if(nexttag==0) then
          nexttag = length + 1
        else
! AGGIUSTA LA POSIZIONE SE C'E' UNA TAG SU QUESTA LINEA
! E' UN PO' CASERECCIO MA FUNZIONA
          backspace(lunit,iostat=iostat)
          if(iostat/=0) then
            call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 496 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
# 496 "iotk_dat.spp"
call iotk_error_msg(ierr,' ')
# 496 "iotk_dat.spp"
call iotk_error_write(ierr,"iostat",iostat)
            return
          end if
          call iotk_getline(lunit,altline,altlength,ierr)
          if(ierr/=0) then
            call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 501 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
            return
          end if
          backspace(lunit,iostat=iostat)
          if(iostat/=0) then
            call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 506 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
# 506 "iotk_dat.spp"
call iotk_error_msg(ierr,' ')
# 506 "iotk_dat.spp"
call iotk_error_write(ierr,"iostat",iostat)
            return
          end if
          read(lunit,"(a)",advance="no",iostat=iostat) altline(1:nexttag-1 + altlength - length)
          if(iostat/=0) then
            call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 511 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
# 511 "iotk_dat.spp"
call iotk_error_msg(ierr,' ')
# 511 "iotk_dat.spp"
call iotk_error_write(ierr,"iostat",iostat)
            return
          end if
        end if
        call iotk_read(dat,line(1:nexttag - 1),index,ierr)
        if(ierr/=0) then
          call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 517 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
          return
        end if
# 523 "iotk_dat.spp"
        if(index == size(dat)) exit
# 525 "iotk_dat.spp"
        if(nexttag/=length + 1) then
          call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 526 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
          return
        end if
      end do
    else
      read(lunit,fmt=fmt(1:iotk_strlen(fmt)),iostat=iostat) dat
      if(iostat/=0) then
        call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 533 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
# 533 "iotk_dat.spp"
call iotk_error_msg(ierr,' ')
# 533 "iotk_dat.spp"
call iotk_error_write(ierr,"iostat",iostat)
        return
      end if
    end if
  end if
# 539 "iotk_dat.spp"
  if(idummy/=0) then
    call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 540 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
    return
  end if
end subroutine iotk_scan_dat_aux_REAL1
# 545 "iotk_dat.spp"

# 547 "iotk_dat.spp"
subroutine iotk_scan_dat_REAL1_1(unit,name,dat,dummy,attr,found,default,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_dat_interf, only: iotk_scan_dat_aux
  use iotk_scan_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  integer,                   intent(in)  :: unit
  character(*),              intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL (kind=__IOTK_REAL1)                        :: dat (:)
#else
  REAL (kind=__IOTK_REAL1),           intent(out) :: dat (:)
#endif
  type(iotk_dummytype), optional         :: dummy
#ifdef __IOTK_WORKAROUND6
  character(len=*),optional              :: attr
#else
  character(len=*),optional, intent(out) :: attr
#endif
  logical,         optional, intent(out) :: found
  REAL (kind=__IOTK_REAL1), optional, intent(in)  :: default (:)
  integer,         optional, intent(out) :: ierr
# 574 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL1),              allocatable :: tmpdat(:)
# 576 "iotk_dat.spp"
  integer :: ierrl,ierrl2
  integer :: rkind,rsize,rlen
  character(iotk_vallenx) :: rtype
  character(iotk_vallenx) :: fmt
  character(iotk_attlenx) :: lattr
  logical :: inside,foundl
  inside = .false.
  ierrl = 0
  ierrl2 = 0
  foundl=.false.
  call iotk_scan_begin(unit,name,lattr,found=foundl,ierr=ierrl)
  if(.not. foundl) goto 1
  foundl = .true.
  inside = .true.
  if(present(attr)) call iotk_strcpy(attr,lattr,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 592 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_parse_dat(lattr,rtype,rkind,rsize,rlen,fmt,ierrl)
  if(ierrl/=0) goto 1
  if(.not. (iotk_strcomp(rtype,iotk_eos) .or. iotk_strcomp(rtype,"REAL") ) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,' ')
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"rtype",rtype(1:iotk_strlen(rtype)))
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"type","REAL")
    goto 1
  end if
  if(.not. (rsize==-1 .or. rsize==size(dat)) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 602 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(rkind==-1) rkind = kind(dat)
# 609 "iotk_dat.spp"

  allocate(tmpdat(size(dat)))
  call iotk_scan_dat_aux(unit,tmpdat,rkind,rlen,fmt(1:iotk_strlen(fmt)),ierrl)
# 615 "iotk_dat.spp"
        dat = reshape(tmpdat,shape(dat))
# 617 "iotk_dat.spp"
  deallocate(tmpdat)
1 continue
  if(inside) then
    call iotk_scan_end(unit,name,ierr=ierrl2)
    if(ierrl2/=0) then
      call iotk_error_clear(ierrl)
      ierrl=ierrl2
    end if
  end if
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Dat not found')
# 629 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if 
  if(present(default) .and. .not. foundl) then
    dat=default
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl>0 .or. (.not.present(found) .and. .not.present(default))) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_dat_REAL1_1


#endif
#endif

subroutine iotk_dat_dummy_REAL1_1
  write(0,*)
end subroutine iotk_dat_dummy_REAL1_1

# 45 "iotk_dat.spp"

# 47 "iotk_dat.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_dat.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_dat.spp"

# 59 "iotk_dat.spp"

#ifdef __IOTK_REAL1
#if 2 <= __IOTK_MAXRANK
# 63 "iotk_dat.spp"
subroutine iotk_write_dat_REAL1_2(unit,name,dat,dummy,attr,fmt,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_write_attr
  use iotk_write_interf
  use iotk_fmt_interf
  use iotk_str_interf
  use iotk_unit_interf
  use iotk_misc_interf
  implicit none
  integer,                intent(in)  :: unit
  character(*),           intent(in)  :: name
  REAL (kind=__IOTK_REAL1), intent(in)  :: dat (:,:) 
  type(iotk_dummytype), optional      :: dummy
  character(len=*), optional, intent(in)  :: attr
  character(len=*), optional, intent(in)  :: fmt
  integer,      optional, intent(out) :: ierr
  integer :: ierrl,lunit,iostat
  logical :: binary,raw
  integer(iotk_header_kind), parameter :: idummy=0
  character(300) :: usefmt,usefmt1
  character(iotk_attlenx) :: lattr
  character(iotk_attlenx) :: attr_tmp
  type (iotk_unit), pointer :: this
# 91 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL1),allocatable :: dattmp(:)
# 93 "iotk_dat.spp"
  integer :: itmp
  ierrl = 0
  iostat = 0
  lunit = iotk_phys_unit(unit)
  call iotk_unit_get(lunit,pointer=this)
  raw = .false.
  if(associated(this)) then
    raw = this%raw
  end if
  call iotk_inquire(lunit,binary=binary,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 104 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_strcpy(usefmt,"!",ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 109 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(fmt) .and. .not. raw) call iotk_strcpy(usefmt,iotk_strtrim(fmt),ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 114 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(iotk_strscan(usefmt,"<>&")/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Special characters (<>&) found in fmt string')
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"unit",unit)
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",trim(name))
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"fmt",trim(fmt))
    goto 1
  end if
  call iotk_write_attr(lattr,"type",iotk_tolower("REAL"),first=.true.,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 123 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_attr(lattr,"size",size(dat),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 128 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
# 138 "iotk_dat.spp"
  if(binary) then
    call iotk_write_attr(lattr,"kind",kind(dat),ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 141 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
  end if
# 146 "iotk_dat.spp"
  if(.not.iotk_strcomp(usefmt,"!")) call iotk_write_attr(lattr,"fmt",iotk_strtrim(usefmt),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 148 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(attr)) then
    attr_tmp(1:1)=iotk_eos
    call iotk_strcpy(attr_tmp,attr,ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 155 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"type",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 160 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"kind",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 165 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"size",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 170 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"fmt",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 175 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"len",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 180 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    if(iotk_strlen_trim(attr_tmp)>0) call iotk_strcat(lattr,iotk_strtrim(attr_tmp),ierr=ierrl)
  end if
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 186 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_begin(unit,name,lattr,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 191 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if

  allocate(dattmp(size(dat)))
# 199 "iotk_dat.spp"
#if defined(__IOTK_WORKAROUND3) || defined(__IOTK_WORKAROUND4)
# 203 "iotk_dat.spp"
     call iotk_private_pack_REAL1(dattmp,dat,size(dattmp),1)
# 205 "iotk_dat.spp"
#else
     dattmp = pack(dat,mask=.true.)
#endif
# 209 "iotk_dat.spp"

  if(binary) then
    if(raw) then
      write(lunit,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 214 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else
      write(lunit,iostat=iostat) idummy,(dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 220 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  else
    if(raw) then
# 229 "iotk_dat.spp"
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
# 231 "iotk_dat.spp"
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 232 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"*")) then
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 238 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"!")) then
# 252 "iotk_dat.spp"
     write(lunit,fmt=trim(iotk_wfmt("REAL",kind(dattmp),1,-1)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
     if(iostat/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 254 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
     end if
# 258 "iotk_dat.spp"
    else
      write(lunit,fmt=usefmt(1:iotk_strlen(usefmt)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 261 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  end if
  call iotk_write_end(unit,name,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 268 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
1 continue
  if(allocated(dattmp)) deallocate(dattmp)
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_dat_REAL1_2


# 545 "iotk_dat.spp"

# 547 "iotk_dat.spp"
subroutine iotk_scan_dat_REAL1_2(unit,name,dat,dummy,attr,found,default,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_dat_interf, only: iotk_scan_dat_aux
  use iotk_scan_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  integer,                   intent(in)  :: unit
  character(*),              intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL (kind=__IOTK_REAL1)                        :: dat (:,:)
#else
  REAL (kind=__IOTK_REAL1),           intent(out) :: dat (:,:)
#endif
  type(iotk_dummytype), optional         :: dummy
#ifdef __IOTK_WORKAROUND6
  character(len=*),optional              :: attr
#else
  character(len=*),optional, intent(out) :: attr
#endif
  logical,         optional, intent(out) :: found
  REAL (kind=__IOTK_REAL1), optional, intent(in)  :: default (:,:)
  integer,         optional, intent(out) :: ierr
# 574 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL1),              allocatable :: tmpdat(:)
# 576 "iotk_dat.spp"
  integer :: ierrl,ierrl2
  integer :: rkind,rsize,rlen
  character(iotk_vallenx) :: rtype
  character(iotk_vallenx) :: fmt
  character(iotk_attlenx) :: lattr
  logical :: inside,foundl
  inside = .false.
  ierrl = 0
  ierrl2 = 0
  foundl=.false.
  call iotk_scan_begin(unit,name,lattr,found=foundl,ierr=ierrl)
  if(.not. foundl) goto 1
  foundl = .true.
  inside = .true.
  if(present(attr)) call iotk_strcpy(attr,lattr,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 592 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_parse_dat(lattr,rtype,rkind,rsize,rlen,fmt,ierrl)
  if(ierrl/=0) goto 1
  if(.not. (iotk_strcomp(rtype,iotk_eos) .or. iotk_strcomp(rtype,"REAL") ) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,' ')
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"rtype",rtype(1:iotk_strlen(rtype)))
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"type","REAL")
    goto 1
  end if
  if(.not. (rsize==-1 .or. rsize==size(dat)) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 602 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(rkind==-1) rkind = kind(dat)
# 609 "iotk_dat.spp"

  allocate(tmpdat(size(dat)))
  call iotk_scan_dat_aux(unit,tmpdat,rkind,rlen,fmt(1:iotk_strlen(fmt)),ierrl)
# 615 "iotk_dat.spp"
        dat = reshape(tmpdat,shape(dat))
# 617 "iotk_dat.spp"
  deallocate(tmpdat)
1 continue
  if(inside) then
    call iotk_scan_end(unit,name,ierr=ierrl2)
    if(ierrl2/=0) then
      call iotk_error_clear(ierrl)
      ierrl=ierrl2
    end if
  end if
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Dat not found')
# 629 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if 
  if(present(default) .and. .not. foundl) then
    dat=default
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl>0 .or. (.not.present(found) .and. .not.present(default))) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_dat_REAL1_2


#endif
#endif

subroutine iotk_dat_dummy_REAL1_2
  write(0,*)
end subroutine iotk_dat_dummy_REAL1_2

# 45 "iotk_dat.spp"

# 47 "iotk_dat.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_dat.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_dat.spp"

# 59 "iotk_dat.spp"

#ifdef __IOTK_REAL1
#if 3 <= __IOTK_MAXRANK
# 63 "iotk_dat.spp"
subroutine iotk_write_dat_REAL1_3(unit,name,dat,dummy,attr,fmt,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_write_attr
  use iotk_write_interf
  use iotk_fmt_interf
  use iotk_str_interf
  use iotk_unit_interf
  use iotk_misc_interf
  implicit none
  integer,                intent(in)  :: unit
  character(*),           intent(in)  :: name
  REAL (kind=__IOTK_REAL1), intent(in)  :: dat (:,:,:) 
  type(iotk_dummytype), optional      :: dummy
  character(len=*), optional, intent(in)  :: attr
  character(len=*), optional, intent(in)  :: fmt
  integer,      optional, intent(out) :: ierr
  integer :: ierrl,lunit,iostat
  logical :: binary,raw
  integer(iotk_header_kind), parameter :: idummy=0
  character(300) :: usefmt,usefmt1
  character(iotk_attlenx) :: lattr
  character(iotk_attlenx) :: attr_tmp
  type (iotk_unit), pointer :: this
# 91 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL1),allocatable :: dattmp(:)
# 93 "iotk_dat.spp"
  integer :: itmp
  ierrl = 0
  iostat = 0
  lunit = iotk_phys_unit(unit)
  call iotk_unit_get(lunit,pointer=this)
  raw = .false.
  if(associated(this)) then
    raw = this%raw
  end if
  call iotk_inquire(lunit,binary=binary,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 104 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_strcpy(usefmt,"!",ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 109 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(fmt) .and. .not. raw) call iotk_strcpy(usefmt,iotk_strtrim(fmt),ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 114 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(iotk_strscan(usefmt,"<>&")/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Special characters (<>&) found in fmt string')
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"unit",unit)
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",trim(name))
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"fmt",trim(fmt))
    goto 1
  end if
  call iotk_write_attr(lattr,"type",iotk_tolower("REAL"),first=.true.,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 123 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_attr(lattr,"size",size(dat),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 128 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
# 138 "iotk_dat.spp"
  if(binary) then
    call iotk_write_attr(lattr,"kind",kind(dat),ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 141 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
  end if
# 146 "iotk_dat.spp"
  if(.not.iotk_strcomp(usefmt,"!")) call iotk_write_attr(lattr,"fmt",iotk_strtrim(usefmt),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 148 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(attr)) then
    attr_tmp(1:1)=iotk_eos
    call iotk_strcpy(attr_tmp,attr,ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 155 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"type",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 160 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"kind",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 165 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"size",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 170 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"fmt",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 175 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"len",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 180 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    if(iotk_strlen_trim(attr_tmp)>0) call iotk_strcat(lattr,iotk_strtrim(attr_tmp),ierr=ierrl)
  end if
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 186 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_begin(unit,name,lattr,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 191 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if

  allocate(dattmp(size(dat)))
# 199 "iotk_dat.spp"
#if defined(__IOTK_WORKAROUND3) || defined(__IOTK_WORKAROUND4)
# 203 "iotk_dat.spp"
     call iotk_private_pack_REAL1(dattmp,dat,size(dattmp),1)
# 205 "iotk_dat.spp"
#else
     dattmp = pack(dat,mask=.true.)
#endif
# 209 "iotk_dat.spp"

  if(binary) then
    if(raw) then
      write(lunit,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 214 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else
      write(lunit,iostat=iostat) idummy,(dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 220 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  else
    if(raw) then
# 229 "iotk_dat.spp"
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
# 231 "iotk_dat.spp"
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 232 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"*")) then
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 238 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"!")) then
# 252 "iotk_dat.spp"
     write(lunit,fmt=trim(iotk_wfmt("REAL",kind(dattmp),1,-1)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
     if(iostat/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 254 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
     end if
# 258 "iotk_dat.spp"
    else
      write(lunit,fmt=usefmt(1:iotk_strlen(usefmt)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 261 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  end if
  call iotk_write_end(unit,name,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 268 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
1 continue
  if(allocated(dattmp)) deallocate(dattmp)
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_dat_REAL1_3


# 545 "iotk_dat.spp"

# 547 "iotk_dat.spp"
subroutine iotk_scan_dat_REAL1_3(unit,name,dat,dummy,attr,found,default,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_dat_interf, only: iotk_scan_dat_aux
  use iotk_scan_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  integer,                   intent(in)  :: unit
  character(*),              intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL (kind=__IOTK_REAL1)                        :: dat (:,:,:)
#else
  REAL (kind=__IOTK_REAL1),           intent(out) :: dat (:,:,:)
#endif
  type(iotk_dummytype), optional         :: dummy
#ifdef __IOTK_WORKAROUND6
  character(len=*),optional              :: attr
#else
  character(len=*),optional, intent(out) :: attr
#endif
  logical,         optional, intent(out) :: found
  REAL (kind=__IOTK_REAL1), optional, intent(in)  :: default (:,:,:)
  integer,         optional, intent(out) :: ierr
# 574 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL1),              allocatable :: tmpdat(:)
# 576 "iotk_dat.spp"
  integer :: ierrl,ierrl2
  integer :: rkind,rsize,rlen
  character(iotk_vallenx) :: rtype
  character(iotk_vallenx) :: fmt
  character(iotk_attlenx) :: lattr
  logical :: inside,foundl
  inside = .false.
  ierrl = 0
  ierrl2 = 0
  foundl=.false.
  call iotk_scan_begin(unit,name,lattr,found=foundl,ierr=ierrl)
  if(.not. foundl) goto 1
  foundl = .true.
  inside = .true.
  if(present(attr)) call iotk_strcpy(attr,lattr,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 592 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_parse_dat(lattr,rtype,rkind,rsize,rlen,fmt,ierrl)
  if(ierrl/=0) goto 1
  if(.not. (iotk_strcomp(rtype,iotk_eos) .or. iotk_strcomp(rtype,"REAL") ) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,' ')
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"rtype",rtype(1:iotk_strlen(rtype)))
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"type","REAL")
    goto 1
  end if
  if(.not. (rsize==-1 .or. rsize==size(dat)) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 602 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(rkind==-1) rkind = kind(dat)
# 609 "iotk_dat.spp"

  allocate(tmpdat(size(dat)))
  call iotk_scan_dat_aux(unit,tmpdat,rkind,rlen,fmt(1:iotk_strlen(fmt)),ierrl)
# 615 "iotk_dat.spp"
        dat = reshape(tmpdat,shape(dat))
# 617 "iotk_dat.spp"
  deallocate(tmpdat)
1 continue
  if(inside) then
    call iotk_scan_end(unit,name,ierr=ierrl2)
    if(ierrl2/=0) then
      call iotk_error_clear(ierrl)
      ierrl=ierrl2
    end if
  end if
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Dat not found')
# 629 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if 
  if(present(default) .and. .not. foundl) then
    dat=default
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl>0 .or. (.not.present(found) .and. .not.present(default))) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_dat_REAL1_3


#endif
#endif

subroutine iotk_dat_dummy_REAL1_3
  write(0,*)
end subroutine iotk_dat_dummy_REAL1_3

# 45 "iotk_dat.spp"

# 47 "iotk_dat.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_dat.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_dat.spp"

# 59 "iotk_dat.spp"

#ifdef __IOTK_REAL1
#if 4 <= __IOTK_MAXRANK
# 63 "iotk_dat.spp"
subroutine iotk_write_dat_REAL1_4(unit,name,dat,dummy,attr,fmt,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_write_attr
  use iotk_write_interf
  use iotk_fmt_interf
  use iotk_str_interf
  use iotk_unit_interf
  use iotk_misc_interf
  implicit none
  integer,                intent(in)  :: unit
  character(*),           intent(in)  :: name
  REAL (kind=__IOTK_REAL1), intent(in)  :: dat (:,:,:,:) 
  type(iotk_dummytype), optional      :: dummy
  character(len=*), optional, intent(in)  :: attr
  character(len=*), optional, intent(in)  :: fmt
  integer,      optional, intent(out) :: ierr
  integer :: ierrl,lunit,iostat
  logical :: binary,raw
  integer(iotk_header_kind), parameter :: idummy=0
  character(300) :: usefmt,usefmt1
  character(iotk_attlenx) :: lattr
  character(iotk_attlenx) :: attr_tmp
  type (iotk_unit), pointer :: this
# 91 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL1),allocatable :: dattmp(:)
# 93 "iotk_dat.spp"
  integer :: itmp
  ierrl = 0
  iostat = 0
  lunit = iotk_phys_unit(unit)
  call iotk_unit_get(lunit,pointer=this)
  raw = .false.
  if(associated(this)) then
    raw = this%raw
  end if
  call iotk_inquire(lunit,binary=binary,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 104 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_strcpy(usefmt,"!",ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 109 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(fmt) .and. .not. raw) call iotk_strcpy(usefmt,iotk_strtrim(fmt),ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 114 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(iotk_strscan(usefmt,"<>&")/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Special characters (<>&) found in fmt string')
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"unit",unit)
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",trim(name))
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"fmt",trim(fmt))
    goto 1
  end if
  call iotk_write_attr(lattr,"type",iotk_tolower("REAL"),first=.true.,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 123 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_attr(lattr,"size",size(dat),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 128 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
# 138 "iotk_dat.spp"
  if(binary) then
    call iotk_write_attr(lattr,"kind",kind(dat),ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 141 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
  end if
# 146 "iotk_dat.spp"
  if(.not.iotk_strcomp(usefmt,"!")) call iotk_write_attr(lattr,"fmt",iotk_strtrim(usefmt),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 148 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(attr)) then
    attr_tmp(1:1)=iotk_eos
    call iotk_strcpy(attr_tmp,attr,ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 155 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"type",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 160 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"kind",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 165 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"size",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 170 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"fmt",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 175 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"len",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 180 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    if(iotk_strlen_trim(attr_tmp)>0) call iotk_strcat(lattr,iotk_strtrim(attr_tmp),ierr=ierrl)
  end if
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 186 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_begin(unit,name,lattr,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 191 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if

  allocate(dattmp(size(dat)))
# 199 "iotk_dat.spp"
#if defined(__IOTK_WORKAROUND3) || defined(__IOTK_WORKAROUND4)
# 203 "iotk_dat.spp"
     call iotk_private_pack_REAL1(dattmp,dat,size(dattmp),1)
# 205 "iotk_dat.spp"
#else
     dattmp = pack(dat,mask=.true.)
#endif
# 209 "iotk_dat.spp"

  if(binary) then
    if(raw) then
      write(lunit,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 214 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else
      write(lunit,iostat=iostat) idummy,(dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 220 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  else
    if(raw) then
# 229 "iotk_dat.spp"
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
# 231 "iotk_dat.spp"
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 232 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"*")) then
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 238 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"!")) then
# 252 "iotk_dat.spp"
     write(lunit,fmt=trim(iotk_wfmt("REAL",kind(dattmp),1,-1)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
     if(iostat/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 254 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
     end if
# 258 "iotk_dat.spp"
    else
      write(lunit,fmt=usefmt(1:iotk_strlen(usefmt)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 261 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  end if
  call iotk_write_end(unit,name,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 268 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
1 continue
  if(allocated(dattmp)) deallocate(dattmp)
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_dat_REAL1_4


# 545 "iotk_dat.spp"

# 547 "iotk_dat.spp"
subroutine iotk_scan_dat_REAL1_4(unit,name,dat,dummy,attr,found,default,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_dat_interf, only: iotk_scan_dat_aux
  use iotk_scan_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  integer,                   intent(in)  :: unit
  character(*),              intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL (kind=__IOTK_REAL1)                        :: dat (:,:,:,:)
#else
  REAL (kind=__IOTK_REAL1),           intent(out) :: dat (:,:,:,:)
#endif
  type(iotk_dummytype), optional         :: dummy
#ifdef __IOTK_WORKAROUND6
  character(len=*),optional              :: attr
#else
  character(len=*),optional, intent(out) :: attr
#endif
  logical,         optional, intent(out) :: found
  REAL (kind=__IOTK_REAL1), optional, intent(in)  :: default (:,:,:,:)
  integer,         optional, intent(out) :: ierr
# 574 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL1),              allocatable :: tmpdat(:)
# 576 "iotk_dat.spp"
  integer :: ierrl,ierrl2
  integer :: rkind,rsize,rlen
  character(iotk_vallenx) :: rtype
  character(iotk_vallenx) :: fmt
  character(iotk_attlenx) :: lattr
  logical :: inside,foundl
  inside = .false.
  ierrl = 0
  ierrl2 = 0
  foundl=.false.
  call iotk_scan_begin(unit,name,lattr,found=foundl,ierr=ierrl)
  if(.not. foundl) goto 1
  foundl = .true.
  inside = .true.
  if(present(attr)) call iotk_strcpy(attr,lattr,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 592 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_parse_dat(lattr,rtype,rkind,rsize,rlen,fmt,ierrl)
  if(ierrl/=0) goto 1
  if(.not. (iotk_strcomp(rtype,iotk_eos) .or. iotk_strcomp(rtype,"REAL") ) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,' ')
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"rtype",rtype(1:iotk_strlen(rtype)))
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"type","REAL")
    goto 1
  end if
  if(.not. (rsize==-1 .or. rsize==size(dat)) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 602 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(rkind==-1) rkind = kind(dat)
# 609 "iotk_dat.spp"

  allocate(tmpdat(size(dat)))
  call iotk_scan_dat_aux(unit,tmpdat,rkind,rlen,fmt(1:iotk_strlen(fmt)),ierrl)
# 615 "iotk_dat.spp"
        dat = reshape(tmpdat,shape(dat))
# 617 "iotk_dat.spp"
  deallocate(tmpdat)
1 continue
  if(inside) then
    call iotk_scan_end(unit,name,ierr=ierrl2)
    if(ierrl2/=0) then
      call iotk_error_clear(ierrl)
      ierrl=ierrl2
    end if
  end if
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Dat not found')
# 629 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if 
  if(present(default) .and. .not. foundl) then
    dat=default
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl>0 .or. (.not.present(found) .and. .not.present(default))) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_dat_REAL1_4


#endif
#endif

subroutine iotk_dat_dummy_REAL1_4
  write(0,*)
end subroutine iotk_dat_dummy_REAL1_4

# 45 "iotk_dat.spp"

# 47 "iotk_dat.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_dat.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_dat.spp"

# 59 "iotk_dat.spp"

#ifdef __IOTK_REAL1
#if 5 <= __IOTK_MAXRANK
# 63 "iotk_dat.spp"
subroutine iotk_write_dat_REAL1_5(unit,name,dat,dummy,attr,fmt,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_write_attr
  use iotk_write_interf
  use iotk_fmt_interf
  use iotk_str_interf
  use iotk_unit_interf
  use iotk_misc_interf
  implicit none
  integer,                intent(in)  :: unit
  character(*),           intent(in)  :: name
  REAL (kind=__IOTK_REAL1), intent(in)  :: dat (:,:,:,:,:) 
  type(iotk_dummytype), optional      :: dummy
  character(len=*), optional, intent(in)  :: attr
  character(len=*), optional, intent(in)  :: fmt
  integer,      optional, intent(out) :: ierr
  integer :: ierrl,lunit,iostat
  logical :: binary,raw
  integer(iotk_header_kind), parameter :: idummy=0
  character(300) :: usefmt,usefmt1
  character(iotk_attlenx) :: lattr
  character(iotk_attlenx) :: attr_tmp
  type (iotk_unit), pointer :: this
# 91 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL1),allocatable :: dattmp(:)
# 93 "iotk_dat.spp"
  integer :: itmp
  ierrl = 0
  iostat = 0
  lunit = iotk_phys_unit(unit)
  call iotk_unit_get(lunit,pointer=this)
  raw = .false.
  if(associated(this)) then
    raw = this%raw
  end if
  call iotk_inquire(lunit,binary=binary,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 104 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_strcpy(usefmt,"!",ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 109 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(fmt) .and. .not. raw) call iotk_strcpy(usefmt,iotk_strtrim(fmt),ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 114 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(iotk_strscan(usefmt,"<>&")/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Special characters (<>&) found in fmt string')
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"unit",unit)
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",trim(name))
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"fmt",trim(fmt))
    goto 1
  end if
  call iotk_write_attr(lattr,"type",iotk_tolower("REAL"),first=.true.,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 123 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_attr(lattr,"size",size(dat),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 128 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
# 138 "iotk_dat.spp"
  if(binary) then
    call iotk_write_attr(lattr,"kind",kind(dat),ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 141 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
  end if
# 146 "iotk_dat.spp"
  if(.not.iotk_strcomp(usefmt,"!")) call iotk_write_attr(lattr,"fmt",iotk_strtrim(usefmt),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 148 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(attr)) then
    attr_tmp(1:1)=iotk_eos
    call iotk_strcpy(attr_tmp,attr,ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 155 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"type",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 160 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"kind",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 165 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"size",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 170 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"fmt",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 175 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"len",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 180 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    if(iotk_strlen_trim(attr_tmp)>0) call iotk_strcat(lattr,iotk_strtrim(attr_tmp),ierr=ierrl)
  end if
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 186 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_begin(unit,name,lattr,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 191 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if

  allocate(dattmp(size(dat)))
# 199 "iotk_dat.spp"
#if defined(__IOTK_WORKAROUND3) || defined(__IOTK_WORKAROUND4)
# 203 "iotk_dat.spp"
     call iotk_private_pack_REAL1(dattmp,dat,size(dattmp),1)
# 205 "iotk_dat.spp"
#else
     dattmp = pack(dat,mask=.true.)
#endif
# 209 "iotk_dat.spp"

  if(binary) then
    if(raw) then
      write(lunit,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 214 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else
      write(lunit,iostat=iostat) idummy,(dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 220 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  else
    if(raw) then
# 229 "iotk_dat.spp"
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
# 231 "iotk_dat.spp"
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 232 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"*")) then
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 238 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"!")) then
# 252 "iotk_dat.spp"
     write(lunit,fmt=trim(iotk_wfmt("REAL",kind(dattmp),1,-1)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
     if(iostat/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 254 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
     end if
# 258 "iotk_dat.spp"
    else
      write(lunit,fmt=usefmt(1:iotk_strlen(usefmt)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 261 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  end if
  call iotk_write_end(unit,name,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 268 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
1 continue
  if(allocated(dattmp)) deallocate(dattmp)
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_dat_REAL1_5


# 545 "iotk_dat.spp"

# 547 "iotk_dat.spp"
subroutine iotk_scan_dat_REAL1_5(unit,name,dat,dummy,attr,found,default,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_dat_interf, only: iotk_scan_dat_aux
  use iotk_scan_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  integer,                   intent(in)  :: unit
  character(*),              intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL (kind=__IOTK_REAL1)                        :: dat (:,:,:,:,:)
#else
  REAL (kind=__IOTK_REAL1),           intent(out) :: dat (:,:,:,:,:)
#endif
  type(iotk_dummytype), optional         :: dummy
#ifdef __IOTK_WORKAROUND6
  character(len=*),optional              :: attr
#else
  character(len=*),optional, intent(out) :: attr
#endif
  logical,         optional, intent(out) :: found
  REAL (kind=__IOTK_REAL1), optional, intent(in)  :: default (:,:,:,:,:)
  integer,         optional, intent(out) :: ierr
# 574 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL1),              allocatable :: tmpdat(:)
# 576 "iotk_dat.spp"
  integer :: ierrl,ierrl2
  integer :: rkind,rsize,rlen
  character(iotk_vallenx) :: rtype
  character(iotk_vallenx) :: fmt
  character(iotk_attlenx) :: lattr
  logical :: inside,foundl
  inside = .false.
  ierrl = 0
  ierrl2 = 0
  foundl=.false.
  call iotk_scan_begin(unit,name,lattr,found=foundl,ierr=ierrl)
  if(.not. foundl) goto 1
  foundl = .true.
  inside = .true.
  if(present(attr)) call iotk_strcpy(attr,lattr,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 592 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_parse_dat(lattr,rtype,rkind,rsize,rlen,fmt,ierrl)
  if(ierrl/=0) goto 1
  if(.not. (iotk_strcomp(rtype,iotk_eos) .or. iotk_strcomp(rtype,"REAL") ) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,' ')
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"rtype",rtype(1:iotk_strlen(rtype)))
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"type","REAL")
    goto 1
  end if
  if(.not. (rsize==-1 .or. rsize==size(dat)) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 602 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(rkind==-1) rkind = kind(dat)
# 609 "iotk_dat.spp"

  allocate(tmpdat(size(dat)))
  call iotk_scan_dat_aux(unit,tmpdat,rkind,rlen,fmt(1:iotk_strlen(fmt)),ierrl)
# 615 "iotk_dat.spp"
        dat = reshape(tmpdat,shape(dat))
# 617 "iotk_dat.spp"
  deallocate(tmpdat)
1 continue
  if(inside) then
    call iotk_scan_end(unit,name,ierr=ierrl2)
    if(ierrl2/=0) then
      call iotk_error_clear(ierrl)
      ierrl=ierrl2
    end if
  end if
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Dat not found')
# 629 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if 
  if(present(default) .and. .not. foundl) then
    dat=default
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl>0 .or. (.not.present(found) .and. .not.present(default))) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_dat_REAL1_5


#endif
#endif

subroutine iotk_dat_dummy_REAL1_5
  write(0,*)
end subroutine iotk_dat_dummy_REAL1_5

# 45 "iotk_dat.spp"

# 47 "iotk_dat.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_dat.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_dat.spp"

# 59 "iotk_dat.spp"

#ifdef __IOTK_REAL1
#if 6 <= __IOTK_MAXRANK
# 63 "iotk_dat.spp"
subroutine iotk_write_dat_REAL1_6(unit,name,dat,dummy,attr,fmt,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_write_attr
  use iotk_write_interf
  use iotk_fmt_interf
  use iotk_str_interf
  use iotk_unit_interf
  use iotk_misc_interf
  implicit none
  integer,                intent(in)  :: unit
  character(*),           intent(in)  :: name
  REAL (kind=__IOTK_REAL1), intent(in)  :: dat (:,:,:,:,:,:) 
  type(iotk_dummytype), optional      :: dummy
  character(len=*), optional, intent(in)  :: attr
  character(len=*), optional, intent(in)  :: fmt
  integer,      optional, intent(out) :: ierr
  integer :: ierrl,lunit,iostat
  logical :: binary,raw
  integer(iotk_header_kind), parameter :: idummy=0
  character(300) :: usefmt,usefmt1
  character(iotk_attlenx) :: lattr
  character(iotk_attlenx) :: attr_tmp
  type (iotk_unit), pointer :: this
# 91 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL1),allocatable :: dattmp(:)
# 93 "iotk_dat.spp"
  integer :: itmp
  ierrl = 0
  iostat = 0
  lunit = iotk_phys_unit(unit)
  call iotk_unit_get(lunit,pointer=this)
  raw = .false.
  if(associated(this)) then
    raw = this%raw
  end if
  call iotk_inquire(lunit,binary=binary,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 104 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_strcpy(usefmt,"!",ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 109 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(fmt) .and. .not. raw) call iotk_strcpy(usefmt,iotk_strtrim(fmt),ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 114 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(iotk_strscan(usefmt,"<>&")/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Special characters (<>&) found in fmt string')
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"unit",unit)
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",trim(name))
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"fmt",trim(fmt))
    goto 1
  end if
  call iotk_write_attr(lattr,"type",iotk_tolower("REAL"),first=.true.,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 123 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_attr(lattr,"size",size(dat),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 128 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
# 138 "iotk_dat.spp"
  if(binary) then
    call iotk_write_attr(lattr,"kind",kind(dat),ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 141 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
  end if
# 146 "iotk_dat.spp"
  if(.not.iotk_strcomp(usefmt,"!")) call iotk_write_attr(lattr,"fmt",iotk_strtrim(usefmt),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 148 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(attr)) then
    attr_tmp(1:1)=iotk_eos
    call iotk_strcpy(attr_tmp,attr,ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 155 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"type",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 160 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"kind",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 165 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"size",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 170 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"fmt",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 175 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"len",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 180 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    if(iotk_strlen_trim(attr_tmp)>0) call iotk_strcat(lattr,iotk_strtrim(attr_tmp),ierr=ierrl)
  end if
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 186 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_begin(unit,name,lattr,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 191 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if

  allocate(dattmp(size(dat)))
# 199 "iotk_dat.spp"
#if defined(__IOTK_WORKAROUND3) || defined(__IOTK_WORKAROUND4)
# 203 "iotk_dat.spp"
     call iotk_private_pack_REAL1(dattmp,dat,size(dattmp),1)
# 205 "iotk_dat.spp"
#else
     dattmp = pack(dat,mask=.true.)
#endif
# 209 "iotk_dat.spp"

  if(binary) then
    if(raw) then
      write(lunit,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 214 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else
      write(lunit,iostat=iostat) idummy,(dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 220 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  else
    if(raw) then
# 229 "iotk_dat.spp"
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
# 231 "iotk_dat.spp"
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 232 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"*")) then
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 238 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"!")) then
# 252 "iotk_dat.spp"
     write(lunit,fmt=trim(iotk_wfmt("REAL",kind(dattmp),1,-1)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
     if(iostat/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 254 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
     end if
# 258 "iotk_dat.spp"
    else
      write(lunit,fmt=usefmt(1:iotk_strlen(usefmt)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 261 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  end if
  call iotk_write_end(unit,name,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 268 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
1 continue
  if(allocated(dattmp)) deallocate(dattmp)
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_dat_REAL1_6


# 545 "iotk_dat.spp"

# 547 "iotk_dat.spp"
subroutine iotk_scan_dat_REAL1_6(unit,name,dat,dummy,attr,found,default,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_dat_interf, only: iotk_scan_dat_aux
  use iotk_scan_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  integer,                   intent(in)  :: unit
  character(*),              intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL (kind=__IOTK_REAL1)                        :: dat (:,:,:,:,:,:)
#else
  REAL (kind=__IOTK_REAL1),           intent(out) :: dat (:,:,:,:,:,:)
#endif
  type(iotk_dummytype), optional         :: dummy
#ifdef __IOTK_WORKAROUND6
  character(len=*),optional              :: attr
#else
  character(len=*),optional, intent(out) :: attr
#endif
  logical,         optional, intent(out) :: found
  REAL (kind=__IOTK_REAL1), optional, intent(in)  :: default (:,:,:,:,:,:)
  integer,         optional, intent(out) :: ierr
# 574 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL1),              allocatable :: tmpdat(:)
# 576 "iotk_dat.spp"
  integer :: ierrl,ierrl2
  integer :: rkind,rsize,rlen
  character(iotk_vallenx) :: rtype
  character(iotk_vallenx) :: fmt
  character(iotk_attlenx) :: lattr
  logical :: inside,foundl
  inside = .false.
  ierrl = 0
  ierrl2 = 0
  foundl=.false.
  call iotk_scan_begin(unit,name,lattr,found=foundl,ierr=ierrl)
  if(.not. foundl) goto 1
  foundl = .true.
  inside = .true.
  if(present(attr)) call iotk_strcpy(attr,lattr,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 592 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_parse_dat(lattr,rtype,rkind,rsize,rlen,fmt,ierrl)
  if(ierrl/=0) goto 1
  if(.not. (iotk_strcomp(rtype,iotk_eos) .or. iotk_strcomp(rtype,"REAL") ) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,' ')
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"rtype",rtype(1:iotk_strlen(rtype)))
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"type","REAL")
    goto 1
  end if
  if(.not. (rsize==-1 .or. rsize==size(dat)) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 602 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(rkind==-1) rkind = kind(dat)
# 609 "iotk_dat.spp"

  allocate(tmpdat(size(dat)))
  call iotk_scan_dat_aux(unit,tmpdat,rkind,rlen,fmt(1:iotk_strlen(fmt)),ierrl)
# 615 "iotk_dat.spp"
        dat = reshape(tmpdat,shape(dat))
# 617 "iotk_dat.spp"
  deallocate(tmpdat)
1 continue
  if(inside) then
    call iotk_scan_end(unit,name,ierr=ierrl2)
    if(ierrl2/=0) then
      call iotk_error_clear(ierrl)
      ierrl=ierrl2
    end if
  end if
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Dat not found')
# 629 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if 
  if(present(default) .and. .not. foundl) then
    dat=default
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl>0 .or. (.not.present(found) .and. .not.present(default))) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_dat_REAL1_6


#endif
#endif

subroutine iotk_dat_dummy_REAL1_6
  write(0,*)
end subroutine iotk_dat_dummy_REAL1_6

# 45 "iotk_dat.spp"

# 47 "iotk_dat.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_dat.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_dat.spp"

# 59 "iotk_dat.spp"

#ifdef __IOTK_REAL1
#if 7 <= __IOTK_MAXRANK
# 63 "iotk_dat.spp"
subroutine iotk_write_dat_REAL1_7(unit,name,dat,dummy,attr,fmt,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_write_attr
  use iotk_write_interf
  use iotk_fmt_interf
  use iotk_str_interf
  use iotk_unit_interf
  use iotk_misc_interf
  implicit none
  integer,                intent(in)  :: unit
  character(*),           intent(in)  :: name
  REAL (kind=__IOTK_REAL1), intent(in)  :: dat (:,:,:,:,:,:,:) 
  type(iotk_dummytype), optional      :: dummy
  character(len=*), optional, intent(in)  :: attr
  character(len=*), optional, intent(in)  :: fmt
  integer,      optional, intent(out) :: ierr
  integer :: ierrl,lunit,iostat
  logical :: binary,raw
  integer(iotk_header_kind), parameter :: idummy=0
  character(300) :: usefmt,usefmt1
  character(iotk_attlenx) :: lattr
  character(iotk_attlenx) :: attr_tmp
  type (iotk_unit), pointer :: this
# 91 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL1),allocatable :: dattmp(:)
# 93 "iotk_dat.spp"
  integer :: itmp
  ierrl = 0
  iostat = 0
  lunit = iotk_phys_unit(unit)
  call iotk_unit_get(lunit,pointer=this)
  raw = .false.
  if(associated(this)) then
    raw = this%raw
  end if
  call iotk_inquire(lunit,binary=binary,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 104 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_strcpy(usefmt,"!",ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 109 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(fmt) .and. .not. raw) call iotk_strcpy(usefmt,iotk_strtrim(fmt),ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 114 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(iotk_strscan(usefmt,"<>&")/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Special characters (<>&) found in fmt string')
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"unit",unit)
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",trim(name))
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"fmt",trim(fmt))
    goto 1
  end if
  call iotk_write_attr(lattr,"type",iotk_tolower("REAL"),first=.true.,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 123 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_attr(lattr,"size",size(dat),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 128 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
# 138 "iotk_dat.spp"
  if(binary) then
    call iotk_write_attr(lattr,"kind",kind(dat),ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 141 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
  end if
# 146 "iotk_dat.spp"
  if(.not.iotk_strcomp(usefmt,"!")) call iotk_write_attr(lattr,"fmt",iotk_strtrim(usefmt),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 148 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(attr)) then
    attr_tmp(1:1)=iotk_eos
    call iotk_strcpy(attr_tmp,attr,ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 155 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"type",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 160 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"kind",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 165 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"size",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 170 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"fmt",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 175 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"len",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 180 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    if(iotk_strlen_trim(attr_tmp)>0) call iotk_strcat(lattr,iotk_strtrim(attr_tmp),ierr=ierrl)
  end if
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 186 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_begin(unit,name,lattr,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 191 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if

  allocate(dattmp(size(dat)))
# 199 "iotk_dat.spp"
#if defined(__IOTK_WORKAROUND3) || defined(__IOTK_WORKAROUND4)
# 203 "iotk_dat.spp"
     call iotk_private_pack_REAL1(dattmp,dat,size(dattmp),1)
# 205 "iotk_dat.spp"
#else
     dattmp = pack(dat,mask=.true.)
#endif
# 209 "iotk_dat.spp"

  if(binary) then
    if(raw) then
      write(lunit,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 214 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else
      write(lunit,iostat=iostat) idummy,(dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 220 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  else
    if(raw) then
# 229 "iotk_dat.spp"
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
# 231 "iotk_dat.spp"
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 232 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"*")) then
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 238 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"!")) then
# 252 "iotk_dat.spp"
     write(lunit,fmt=trim(iotk_wfmt("REAL",kind(dattmp),1,-1)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
     if(iostat/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 254 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
     end if
# 258 "iotk_dat.spp"
    else
      write(lunit,fmt=usefmt(1:iotk_strlen(usefmt)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 261 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  end if
  call iotk_write_end(unit,name,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 268 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
1 continue
  if(allocated(dattmp)) deallocate(dattmp)
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_dat_REAL1_7


# 545 "iotk_dat.spp"

# 547 "iotk_dat.spp"
subroutine iotk_scan_dat_REAL1_7(unit,name,dat,dummy,attr,found,default,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_dat_interf, only: iotk_scan_dat_aux
  use iotk_scan_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  integer,                   intent(in)  :: unit
  character(*),              intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL (kind=__IOTK_REAL1)                        :: dat (:,:,:,:,:,:,:)
#else
  REAL (kind=__IOTK_REAL1),           intent(out) :: dat (:,:,:,:,:,:,:)
#endif
  type(iotk_dummytype), optional         :: dummy
#ifdef __IOTK_WORKAROUND6
  character(len=*),optional              :: attr
#else
  character(len=*),optional, intent(out) :: attr
#endif
  logical,         optional, intent(out) :: found
  REAL (kind=__IOTK_REAL1), optional, intent(in)  :: default (:,:,:,:,:,:,:)
  integer,         optional, intent(out) :: ierr
# 574 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL1),              allocatable :: tmpdat(:)
# 576 "iotk_dat.spp"
  integer :: ierrl,ierrl2
  integer :: rkind,rsize,rlen
  character(iotk_vallenx) :: rtype
  character(iotk_vallenx) :: fmt
  character(iotk_attlenx) :: lattr
  logical :: inside,foundl
  inside = .false.
  ierrl = 0
  ierrl2 = 0
  foundl=.false.
  call iotk_scan_begin(unit,name,lattr,found=foundl,ierr=ierrl)
  if(.not. foundl) goto 1
  foundl = .true.
  inside = .true.
  if(present(attr)) call iotk_strcpy(attr,lattr,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 592 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_parse_dat(lattr,rtype,rkind,rsize,rlen,fmt,ierrl)
  if(ierrl/=0) goto 1
  if(.not. (iotk_strcomp(rtype,iotk_eos) .or. iotk_strcomp(rtype,"REAL") ) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,' ')
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"rtype",rtype(1:iotk_strlen(rtype)))
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"type","REAL")
    goto 1
  end if
  if(.not. (rsize==-1 .or. rsize==size(dat)) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 602 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(rkind==-1) rkind = kind(dat)
# 609 "iotk_dat.spp"

  allocate(tmpdat(size(dat)))
  call iotk_scan_dat_aux(unit,tmpdat,rkind,rlen,fmt(1:iotk_strlen(fmt)),ierrl)
# 615 "iotk_dat.spp"
        dat = reshape(tmpdat,shape(dat))
# 617 "iotk_dat.spp"
  deallocate(tmpdat)
1 continue
  if(inside) then
    call iotk_scan_end(unit,name,ierr=ierrl2)
    if(ierrl2/=0) then
      call iotk_error_clear(ierrl)
      ierrl=ierrl2
    end if
  end if
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Dat not found')
# 629 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if 
  if(present(default) .and. .not. foundl) then
    dat=default
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl>0 .or. (.not.present(found) .and. .not.present(default))) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_dat_REAL1_7


#endif
#endif

subroutine iotk_dat_dummy_REAL1_7
  write(0,*)
end subroutine iotk_dat_dummy_REAL1_7

# 45 "iotk_dat.spp"

# 47 "iotk_dat.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_dat.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_dat.spp"

# 59 "iotk_dat.spp"

#ifdef __IOTK_REAL2
#if 0 <= __IOTK_MAXRANK
# 63 "iotk_dat.spp"
subroutine iotk_write_dat_REAL2_0(unit,name,dat,dummy,attr,fmt,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_write_attr
  use iotk_write_interf
  use iotk_fmt_interf
  use iotk_str_interf
  use iotk_unit_interf
  use iotk_misc_interf
  implicit none
  integer,                intent(in)  :: unit
  character(*),           intent(in)  :: name
  REAL (kind=__IOTK_REAL2), intent(in)  :: dat  
  type(iotk_dummytype), optional      :: dummy
  character(len=*), optional, intent(in)  :: attr
  character(len=*), optional, intent(in)  :: fmt
  integer,      optional, intent(out) :: ierr
  integer :: ierrl,lunit,iostat
  logical :: binary,raw
  integer(iotk_header_kind), parameter :: idummy=0
  character(300) :: usefmt,usefmt1
  character(iotk_attlenx) :: lattr
  character(iotk_attlenx) :: attr_tmp
  type (iotk_unit), pointer :: this
# 91 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL2),allocatable :: dattmp(:)
# 93 "iotk_dat.spp"
  integer :: itmp
  ierrl = 0
  iostat = 0
  lunit = iotk_phys_unit(unit)
  call iotk_unit_get(lunit,pointer=this)
  raw = .false.
  if(associated(this)) then
    raw = this%raw
  end if
  call iotk_inquire(lunit,binary=binary,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 104 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_strcpy(usefmt,"!",ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 109 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(fmt) .and. .not. raw) call iotk_strcpy(usefmt,iotk_strtrim(fmt),ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 114 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(iotk_strscan(usefmt,"<>&")/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Special characters (<>&) found in fmt string')
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"unit",unit)
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",trim(name))
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"fmt",trim(fmt))
    goto 1
  end if
  call iotk_write_attr(lattr,"type",iotk_tolower("REAL"),first=.true.,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 123 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_attr(lattr,"size",1,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 128 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
# 138 "iotk_dat.spp"
  if(binary) then
    call iotk_write_attr(lattr,"kind",kind(dat),ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 141 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
  end if
# 146 "iotk_dat.spp"
  if(.not.iotk_strcomp(usefmt,"!")) call iotk_write_attr(lattr,"fmt",iotk_strtrim(usefmt),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 148 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(attr)) then
    attr_tmp(1:1)=iotk_eos
    call iotk_strcpy(attr_tmp,attr,ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 155 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"type",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 160 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"kind",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 165 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"size",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 170 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"fmt",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 175 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"len",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 180 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    if(iotk_strlen_trim(attr_tmp)>0) call iotk_strcat(lattr,iotk_strtrim(attr_tmp),ierr=ierrl)
  end if
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 186 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_begin(unit,name,lattr,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 191 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if

  allocate(dattmp(1))
# 197 "iotk_dat.spp"
     dattmp(1) = dat
# 209 "iotk_dat.spp"

  if(binary) then
    if(raw) then
      write(lunit,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 214 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else
      write(lunit,iostat=iostat) idummy,(dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 220 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  else
    if(raw) then
# 229 "iotk_dat.spp"
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
# 231 "iotk_dat.spp"
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 232 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"*")) then
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 238 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"!")) then
# 252 "iotk_dat.spp"
     write(lunit,fmt=trim(iotk_wfmt("REAL",kind(dattmp),1,-1)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
     if(iostat/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 254 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
     end if
# 258 "iotk_dat.spp"
    else
      write(lunit,fmt=usefmt(1:iotk_strlen(usefmt)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 261 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  end if
  call iotk_write_end(unit,name,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 268 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
1 continue
  if(allocated(dattmp)) deallocate(dattmp)
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_dat_REAL2_0


# 545 "iotk_dat.spp"

# 547 "iotk_dat.spp"
subroutine iotk_scan_dat_REAL2_0(unit,name,dat,dummy,attr,found,default,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_dat_interf, only: iotk_scan_dat_aux
  use iotk_scan_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  integer,                   intent(in)  :: unit
  character(*),              intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL (kind=__IOTK_REAL2)                        :: dat 
#else
  REAL (kind=__IOTK_REAL2),           intent(out) :: dat 
#endif
  type(iotk_dummytype), optional         :: dummy
#ifdef __IOTK_WORKAROUND6
  character(len=*),optional              :: attr
#else
  character(len=*),optional, intent(out) :: attr
#endif
  logical,         optional, intent(out) :: found
  REAL (kind=__IOTK_REAL2), optional, intent(in)  :: default 
  integer,         optional, intent(out) :: ierr
# 574 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL2),              allocatable :: tmpdat(:)
# 576 "iotk_dat.spp"
  integer :: ierrl,ierrl2
  integer :: rkind,rsize,rlen
  character(iotk_vallenx) :: rtype
  character(iotk_vallenx) :: fmt
  character(iotk_attlenx) :: lattr
  logical :: inside,foundl
  inside = .false.
  ierrl = 0
  ierrl2 = 0
  foundl=.false.
  call iotk_scan_begin(unit,name,lattr,found=foundl,ierr=ierrl)
  if(.not. foundl) goto 1
  foundl = .true.
  inside = .true.
  if(present(attr)) call iotk_strcpy(attr,lattr,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 592 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_parse_dat(lattr,rtype,rkind,rsize,rlen,fmt,ierrl)
  if(ierrl/=0) goto 1
  if(.not. (iotk_strcomp(rtype,iotk_eos) .or. iotk_strcomp(rtype,"REAL") ) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,' ')
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"rtype",rtype(1:iotk_strlen(rtype)))
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"type","REAL")
    goto 1
  end if
  if(.not. (rsize==-1 .or. rsize==1) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 602 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(rkind==-1) rkind = kind(dat)
# 609 "iotk_dat.spp"

  allocate(tmpdat(1))
  call iotk_scan_dat_aux(unit,tmpdat,rkind,rlen,fmt(1:iotk_strlen(fmt)),ierrl)
# 613 "iotk_dat.spp"
        dat = tmpdat(1)
# 617 "iotk_dat.spp"
  deallocate(tmpdat)
1 continue
  if(inside) then
    call iotk_scan_end(unit,name,ierr=ierrl2)
    if(ierrl2/=0) then
      call iotk_error_clear(ierrl)
      ierrl=ierrl2
    end if
  end if
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Dat not found')
# 629 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if 
  if(present(default) .and. .not. foundl) then
    dat=default
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl>0 .or. (.not.present(found) .and. .not.present(default))) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_dat_REAL2_0


#endif
#endif

subroutine iotk_dat_dummy_REAL2_0
  write(0,*)
end subroutine iotk_dat_dummy_REAL2_0

# 45 "iotk_dat.spp"

# 47 "iotk_dat.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_dat.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_dat.spp"

# 59 "iotk_dat.spp"

#ifdef __IOTK_REAL2
#if 1 <= __IOTK_MAXRANK
# 63 "iotk_dat.spp"
subroutine iotk_write_dat_REAL2_1(unit,name,dat,dummy,attr,fmt,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_write_attr
  use iotk_write_interf
  use iotk_fmt_interf
  use iotk_str_interf
  use iotk_unit_interf
  use iotk_misc_interf
  implicit none
  integer,                intent(in)  :: unit
  character(*),           intent(in)  :: name
  REAL (kind=__IOTK_REAL2), intent(in)  :: dat (:) 
  type(iotk_dummytype), optional      :: dummy
  character(len=*), optional, intent(in)  :: attr
  character(len=*), optional, intent(in)  :: fmt
  integer,      optional, intent(out) :: ierr
  integer :: ierrl,lunit,iostat
  logical :: binary,raw
  integer(iotk_header_kind), parameter :: idummy=0
  character(300) :: usefmt,usefmt1
  character(iotk_attlenx) :: lattr
  character(iotk_attlenx) :: attr_tmp
  type (iotk_unit), pointer :: this
# 91 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL2),allocatable :: dattmp(:)
# 93 "iotk_dat.spp"
  integer :: itmp
  ierrl = 0
  iostat = 0
  lunit = iotk_phys_unit(unit)
  call iotk_unit_get(lunit,pointer=this)
  raw = .false.
  if(associated(this)) then
    raw = this%raw
  end if
  call iotk_inquire(lunit,binary=binary,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 104 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_strcpy(usefmt,"!",ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 109 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(fmt) .and. .not. raw) call iotk_strcpy(usefmt,iotk_strtrim(fmt),ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 114 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(iotk_strscan(usefmt,"<>&")/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Special characters (<>&) found in fmt string')
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"unit",unit)
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",trim(name))
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"fmt",trim(fmt))
    goto 1
  end if
  call iotk_write_attr(lattr,"type",iotk_tolower("REAL"),first=.true.,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 123 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_attr(lattr,"size",size(dat),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 128 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
# 138 "iotk_dat.spp"
  if(binary) then
    call iotk_write_attr(lattr,"kind",kind(dat),ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 141 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
  end if
# 146 "iotk_dat.spp"
  if(.not.iotk_strcomp(usefmt,"!")) call iotk_write_attr(lattr,"fmt",iotk_strtrim(usefmt),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 148 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(attr)) then
    attr_tmp(1:1)=iotk_eos
    call iotk_strcpy(attr_tmp,attr,ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 155 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"type",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 160 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"kind",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 165 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"size",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 170 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"fmt",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 175 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"len",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 180 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    if(iotk_strlen_trim(attr_tmp)>0) call iotk_strcat(lattr,iotk_strtrim(attr_tmp),ierr=ierrl)
  end if
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 186 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_begin(unit,name,lattr,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 191 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if

  allocate(dattmp(size(dat)))
# 199 "iotk_dat.spp"
#if defined(__IOTK_WORKAROUND3) || defined(__IOTK_WORKAROUND4)
# 203 "iotk_dat.spp"
     call iotk_private_pack_REAL2(dattmp,dat,size(dattmp),1)
# 205 "iotk_dat.spp"
#else
     dattmp = pack(dat,mask=.true.)
#endif
# 209 "iotk_dat.spp"

  if(binary) then
    if(raw) then
      write(lunit,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 214 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else
      write(lunit,iostat=iostat) idummy,(dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 220 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  else
    if(raw) then
# 229 "iotk_dat.spp"
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
# 231 "iotk_dat.spp"
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 232 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"*")) then
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 238 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"!")) then
# 252 "iotk_dat.spp"
     write(lunit,fmt=trim(iotk_wfmt("REAL",kind(dattmp),1,-1)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
     if(iostat/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 254 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
     end if
# 258 "iotk_dat.spp"
    else
      write(lunit,fmt=usefmt(1:iotk_strlen(usefmt)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 261 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  end if
  call iotk_write_end(unit,name,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 268 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
1 continue
  if(allocated(dattmp)) deallocate(dattmp)
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_dat_REAL2_1


# 283 "iotk_dat.spp"
recursive subroutine iotk_scan_dat_aux_REAL2(unit,dat,rkind,rlen,fmt,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only: iotk_read
  use iotk_scan_interf
  use iotk_str_interf
  use iotk_unit_interf
  use iotk_misc_interf
  implicit none
  integer,         intent(in)  :: unit
#ifdef __IOTK_WORKAROUND6
  REAL (kind=__IOTK_REAL2)                        :: dat (:)
#else
  REAL (kind=__IOTK_REAL2),           intent(out) :: dat (:)
#endif
  integer,         intent(in)  :: rkind
  integer,         intent(in)  :: rlen
  character(*),    intent(in)  :: fmt
  integer,         intent(out) :: ierr
  integer(iotk_header_kind) :: idummy
  logical :: raw,binary
  integer :: lunit
  integer :: index,length,nexttag,iostat,altlength
  type(iotk_unit), pointer :: this
  character(len=iotk_linlenx) :: line,altline
# 313 "iotk_dat.spp"
#ifdef __IOTK_REAL1
  REAL (__IOTK_REAL1), allocatable :: dat1 (:)
#endif
# 313 "iotk_dat.spp"
#ifdef __IOTK_REAL3
  REAL (__IOTK_REAL3), allocatable :: dat3 (:)
#endif
# 313 "iotk_dat.spp"
#ifdef __IOTK_REAL4
  REAL (__IOTK_REAL4), allocatable :: dat4 (:)
#endif
# 319 "iotk_dat.spp"
  lunit = iotk_phys_unit(unit)
  ierr = 0
  iostat = 0
  idummy = 0
  call iotk_unit_get(lunit,pointer=this)
  raw = .false.
  if(associated(this)) then
    raw = this%raw
  end if
  call iotk_inquire(unit=lunit,binary=binary,ierr=ierr)
  if(ierr/=0) then
    call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 330 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
    return
  end if
# 420 "iotk_dat.spp"
  if(binary) then
    select case(rkind)
    case(kind(dat))
      if(raw) then
        read(lunit,iostat=iostat) dat
        if(iostat/=0) then
          call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 426 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
# 426 "iotk_dat.spp"
call iotk_error_msg(ierr,' ')
# 426 "iotk_dat.spp"
call iotk_error_write(ierr,"iostat",iostat)
          return
        end if
      else
        read(lunit,iostat=iostat) idummy,dat
        if(iostat/=0) then
          call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 432 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
# 432 "iotk_dat.spp"
call iotk_error_msg(ierr,' ')
# 432 "iotk_dat.spp"
call iotk_error_write(ierr,"iostat",iostat)
          return
        end if
      end if
# 438 "iotk_dat.spp"
#ifdef __IOTK_REAL1
    case(kind(dat1))
      ! Giusto per scrupolo. Se e' raw non ci sono info sul kind, quindi questa linea e' irraggiungibile
      if(raw) then
        call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 442 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
        return
      end if
      allocate(dat1(ubound(dat,1)))
      read(lunit,iostat=iostat) idummy,dat1
      if(iostat/=0) then
        call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 448 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
# 448 "iotk_dat.spp"
call iotk_error_msg(ierr,' ')
# 448 "iotk_dat.spp"
call iotk_error_write(ierr,"iostat",iostat)
        return
      end if
# 458 "iotk_dat.spp"
      dat = dat1
# 460 "iotk_dat.spp"
      deallocate(dat1)
#endif
# 438 "iotk_dat.spp"
#ifdef __IOTK_REAL3
    case(kind(dat3))
      ! Giusto per scrupolo. Se e' raw non ci sono info sul kind, quindi questa linea e' irraggiungibile
      if(raw) then
        call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 442 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
        return
      end if
      allocate(dat3(ubound(dat,1)))
      read(lunit,iostat=iostat) idummy,dat3
      if(iostat/=0) then
        call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 448 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
# 448 "iotk_dat.spp"
call iotk_error_msg(ierr,' ')
# 448 "iotk_dat.spp"
call iotk_error_write(ierr,"iostat",iostat)
        return
      end if
# 458 "iotk_dat.spp"
      dat = dat3
# 460 "iotk_dat.spp"
      deallocate(dat3)
#endif
# 438 "iotk_dat.spp"
#ifdef __IOTK_REAL4
    case(kind(dat4))
      ! Giusto per scrupolo. Se e' raw non ci sono info sul kind, quindi questa linea e' irraggiungibile
      if(raw) then
        call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 442 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
        return
      end if
      allocate(dat4(ubound(dat,1)))
      read(lunit,iostat=iostat) idummy,dat4
      if(iostat/=0) then
        call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 448 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
# 448 "iotk_dat.spp"
call iotk_error_msg(ierr,' ')
# 448 "iotk_dat.spp"
call iotk_error_write(ierr,"iostat",iostat)
        return
      end if
# 458 "iotk_dat.spp"
      dat = dat4
# 460 "iotk_dat.spp"
      deallocate(dat4)
#endif
# 464 "iotk_dat.spp"
    case default
      call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 465 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
# 465 "iotk_dat.spp"
call iotk_error_msg(ierr,'Kind incompatibility')
# 465 "iotk_dat.spp"
call iotk_error_write(ierr,"kind",rkind)
    end select
  else
    if(raw) then
      read(lunit,fmt=*,iostat=iostat) dat
      if(iostat/=0) then
        call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 471 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
# 471 "iotk_dat.spp"
call iotk_error_msg(ierr,' ')
# 471 "iotk_dat.spp"
call iotk_error_write(ierr,"iostat",iostat)
        return
      end if
    else if(iotk_strcomp(fmt,"*")) then
      read(lunit,fmt=*,iostat=iostat) dat
      if(iostat/=0) then
        call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 477 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
# 477 "iotk_dat.spp"
call iotk_error_msg(ierr,' ')
# 477 "iotk_dat.spp"
call iotk_error_write(ierr,"iostat",iostat)
        return
      end if
    else if(iotk_strcomp(fmt,"!")) then
      index = 0
      do
        call iotk_getline(lunit,line,length,ierr)
        if(ierr/=0) then
          call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 485 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
          return
        end if
        nexttag = scan(line(1:length),"<")
        if(nexttag==0) then
          nexttag = length + 1
        else
! AGGIUSTA LA POSIZIONE SE C'E' UNA TAG SU QUESTA LINEA
! E' UN PO' CASERECCIO MA FUNZIONA
          backspace(lunit,iostat=iostat)
          if(iostat/=0) then
            call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 496 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
# 496 "iotk_dat.spp"
call iotk_error_msg(ierr,' ')
# 496 "iotk_dat.spp"
call iotk_error_write(ierr,"iostat",iostat)
            return
          end if
          call iotk_getline(lunit,altline,altlength,ierr)
          if(ierr/=0) then
            call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 501 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
            return
          end if
          backspace(lunit,iostat=iostat)
          if(iostat/=0) then
            call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 506 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
# 506 "iotk_dat.spp"
call iotk_error_msg(ierr,' ')
# 506 "iotk_dat.spp"
call iotk_error_write(ierr,"iostat",iostat)
            return
          end if
          read(lunit,"(a)",advance="no",iostat=iostat) altline(1:nexttag-1 + altlength - length)
          if(iostat/=0) then
            call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 511 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
# 511 "iotk_dat.spp"
call iotk_error_msg(ierr,' ')
# 511 "iotk_dat.spp"
call iotk_error_write(ierr,"iostat",iostat)
            return
          end if
        end if
        call iotk_read(dat,line(1:nexttag - 1),index,ierr)
        if(ierr/=0) then
          call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 517 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
          return
        end if
# 523 "iotk_dat.spp"
        if(index == size(dat)) exit
# 525 "iotk_dat.spp"
        if(nexttag/=length + 1) then
          call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 526 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
          return
        end if
      end do
    else
      read(lunit,fmt=fmt(1:iotk_strlen(fmt)),iostat=iostat) dat
      if(iostat/=0) then
        call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 533 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
# 533 "iotk_dat.spp"
call iotk_error_msg(ierr,' ')
# 533 "iotk_dat.spp"
call iotk_error_write(ierr,"iostat",iostat)
        return
      end if
    end if
  end if
# 539 "iotk_dat.spp"
  if(idummy/=0) then
    call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 540 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
    return
  end if
end subroutine iotk_scan_dat_aux_REAL2
# 545 "iotk_dat.spp"

# 547 "iotk_dat.spp"
subroutine iotk_scan_dat_REAL2_1(unit,name,dat,dummy,attr,found,default,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_dat_interf, only: iotk_scan_dat_aux
  use iotk_scan_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  integer,                   intent(in)  :: unit
  character(*),              intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL (kind=__IOTK_REAL2)                        :: dat (:)
#else
  REAL (kind=__IOTK_REAL2),           intent(out) :: dat (:)
#endif
  type(iotk_dummytype), optional         :: dummy
#ifdef __IOTK_WORKAROUND6
  character(len=*),optional              :: attr
#else
  character(len=*),optional, intent(out) :: attr
#endif
  logical,         optional, intent(out) :: found
  REAL (kind=__IOTK_REAL2), optional, intent(in)  :: default (:)
  integer,         optional, intent(out) :: ierr
# 574 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL2),              allocatable :: tmpdat(:)
# 576 "iotk_dat.spp"
  integer :: ierrl,ierrl2
  integer :: rkind,rsize,rlen
  character(iotk_vallenx) :: rtype
  character(iotk_vallenx) :: fmt
  character(iotk_attlenx) :: lattr
  logical :: inside,foundl
  inside = .false.
  ierrl = 0
  ierrl2 = 0
  foundl=.false.
  call iotk_scan_begin(unit,name,lattr,found=foundl,ierr=ierrl)
  if(.not. foundl) goto 1
  foundl = .true.
  inside = .true.
  if(present(attr)) call iotk_strcpy(attr,lattr,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 592 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_parse_dat(lattr,rtype,rkind,rsize,rlen,fmt,ierrl)
  if(ierrl/=0) goto 1
  if(.not. (iotk_strcomp(rtype,iotk_eos) .or. iotk_strcomp(rtype,"REAL") ) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,' ')
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"rtype",rtype(1:iotk_strlen(rtype)))
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"type","REAL")
    goto 1
  end if
  if(.not. (rsize==-1 .or. rsize==size(dat)) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 602 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(rkind==-1) rkind = kind(dat)
# 609 "iotk_dat.spp"

  allocate(tmpdat(size(dat)))
  call iotk_scan_dat_aux(unit,tmpdat,rkind,rlen,fmt(1:iotk_strlen(fmt)),ierrl)
# 615 "iotk_dat.spp"
        dat = reshape(tmpdat,shape(dat))
# 617 "iotk_dat.spp"
  deallocate(tmpdat)
1 continue
  if(inside) then
    call iotk_scan_end(unit,name,ierr=ierrl2)
    if(ierrl2/=0) then
      call iotk_error_clear(ierrl)
      ierrl=ierrl2
    end if
  end if
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Dat not found')
# 629 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if 
  if(present(default) .and. .not. foundl) then
    dat=default
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl>0 .or. (.not.present(found) .and. .not.present(default))) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_dat_REAL2_1


#endif
#endif

subroutine iotk_dat_dummy_REAL2_1
  write(0,*)
end subroutine iotk_dat_dummy_REAL2_1

# 45 "iotk_dat.spp"

# 47 "iotk_dat.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_dat.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_dat.spp"

# 59 "iotk_dat.spp"

#ifdef __IOTK_REAL2
#if 2 <= __IOTK_MAXRANK
# 63 "iotk_dat.spp"
subroutine iotk_write_dat_REAL2_2(unit,name,dat,dummy,attr,fmt,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_write_attr
  use iotk_write_interf
  use iotk_fmt_interf
  use iotk_str_interf
  use iotk_unit_interf
  use iotk_misc_interf
  implicit none
  integer,                intent(in)  :: unit
  character(*),           intent(in)  :: name
  REAL (kind=__IOTK_REAL2), intent(in)  :: dat (:,:) 
  type(iotk_dummytype), optional      :: dummy
  character(len=*), optional, intent(in)  :: attr
  character(len=*), optional, intent(in)  :: fmt
  integer,      optional, intent(out) :: ierr
  integer :: ierrl,lunit,iostat
  logical :: binary,raw
  integer(iotk_header_kind), parameter :: idummy=0
  character(300) :: usefmt,usefmt1
  character(iotk_attlenx) :: lattr
  character(iotk_attlenx) :: attr_tmp
  type (iotk_unit), pointer :: this
# 91 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL2),allocatable :: dattmp(:)
# 93 "iotk_dat.spp"
  integer :: itmp
  ierrl = 0
  iostat = 0
  lunit = iotk_phys_unit(unit)
  call iotk_unit_get(lunit,pointer=this)
  raw = .false.
  if(associated(this)) then
    raw = this%raw
  end if
  call iotk_inquire(lunit,binary=binary,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 104 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_strcpy(usefmt,"!",ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 109 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(fmt) .and. .not. raw) call iotk_strcpy(usefmt,iotk_strtrim(fmt),ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 114 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(iotk_strscan(usefmt,"<>&")/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Special characters (<>&) found in fmt string')
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"unit",unit)
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",trim(name))
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"fmt",trim(fmt))
    goto 1
  end if
  call iotk_write_attr(lattr,"type",iotk_tolower("REAL"),first=.true.,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 123 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_attr(lattr,"size",size(dat),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 128 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
# 138 "iotk_dat.spp"
  if(binary) then
    call iotk_write_attr(lattr,"kind",kind(dat),ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 141 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
  end if
# 146 "iotk_dat.spp"
  if(.not.iotk_strcomp(usefmt,"!")) call iotk_write_attr(lattr,"fmt",iotk_strtrim(usefmt),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 148 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(attr)) then
    attr_tmp(1:1)=iotk_eos
    call iotk_strcpy(attr_tmp,attr,ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 155 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"type",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 160 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"kind",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 165 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"size",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 170 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"fmt",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 175 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"len",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 180 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    if(iotk_strlen_trim(attr_tmp)>0) call iotk_strcat(lattr,iotk_strtrim(attr_tmp),ierr=ierrl)
  end if
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 186 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_begin(unit,name,lattr,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 191 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if

  allocate(dattmp(size(dat)))
# 199 "iotk_dat.spp"
#if defined(__IOTK_WORKAROUND3) || defined(__IOTK_WORKAROUND4)
# 203 "iotk_dat.spp"
     call iotk_private_pack_REAL2(dattmp,dat,size(dattmp),1)
# 205 "iotk_dat.spp"
#else
     dattmp = pack(dat,mask=.true.)
#endif
# 209 "iotk_dat.spp"

  if(binary) then
    if(raw) then
      write(lunit,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 214 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else
      write(lunit,iostat=iostat) idummy,(dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 220 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  else
    if(raw) then
# 229 "iotk_dat.spp"
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
# 231 "iotk_dat.spp"
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 232 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"*")) then
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 238 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"!")) then
# 252 "iotk_dat.spp"
     write(lunit,fmt=trim(iotk_wfmt("REAL",kind(dattmp),1,-1)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
     if(iostat/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 254 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
     end if
# 258 "iotk_dat.spp"
    else
      write(lunit,fmt=usefmt(1:iotk_strlen(usefmt)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 261 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  end if
  call iotk_write_end(unit,name,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 268 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
1 continue
  if(allocated(dattmp)) deallocate(dattmp)
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_dat_REAL2_2


# 545 "iotk_dat.spp"

# 547 "iotk_dat.spp"
subroutine iotk_scan_dat_REAL2_2(unit,name,dat,dummy,attr,found,default,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_dat_interf, only: iotk_scan_dat_aux
  use iotk_scan_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  integer,                   intent(in)  :: unit
  character(*),              intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL (kind=__IOTK_REAL2)                        :: dat (:,:)
#else
  REAL (kind=__IOTK_REAL2),           intent(out) :: dat (:,:)
#endif
  type(iotk_dummytype), optional         :: dummy
#ifdef __IOTK_WORKAROUND6
  character(len=*),optional              :: attr
#else
  character(len=*),optional, intent(out) :: attr
#endif
  logical,         optional, intent(out) :: found
  REAL (kind=__IOTK_REAL2), optional, intent(in)  :: default (:,:)
  integer,         optional, intent(out) :: ierr
# 574 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL2),              allocatable :: tmpdat(:)
# 576 "iotk_dat.spp"
  integer :: ierrl,ierrl2
  integer :: rkind,rsize,rlen
  character(iotk_vallenx) :: rtype
  character(iotk_vallenx) :: fmt
  character(iotk_attlenx) :: lattr
  logical :: inside,foundl
  inside = .false.
  ierrl = 0
  ierrl2 = 0
  foundl=.false.
  call iotk_scan_begin(unit,name,lattr,found=foundl,ierr=ierrl)
  if(.not. foundl) goto 1
  foundl = .true.
  inside = .true.
  if(present(attr)) call iotk_strcpy(attr,lattr,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 592 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_parse_dat(lattr,rtype,rkind,rsize,rlen,fmt,ierrl)
  if(ierrl/=0) goto 1
  if(.not. (iotk_strcomp(rtype,iotk_eos) .or. iotk_strcomp(rtype,"REAL") ) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,' ')
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"rtype",rtype(1:iotk_strlen(rtype)))
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"type","REAL")
    goto 1
  end if
  if(.not. (rsize==-1 .or. rsize==size(dat)) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 602 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(rkind==-1) rkind = kind(dat)
# 609 "iotk_dat.spp"

  allocate(tmpdat(size(dat)))
  call iotk_scan_dat_aux(unit,tmpdat,rkind,rlen,fmt(1:iotk_strlen(fmt)),ierrl)
# 615 "iotk_dat.spp"
        dat = reshape(tmpdat,shape(dat))
# 617 "iotk_dat.spp"
  deallocate(tmpdat)
1 continue
  if(inside) then
    call iotk_scan_end(unit,name,ierr=ierrl2)
    if(ierrl2/=0) then
      call iotk_error_clear(ierrl)
      ierrl=ierrl2
    end if
  end if
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Dat not found')
# 629 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if 
  if(present(default) .and. .not. foundl) then
    dat=default
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl>0 .or. (.not.present(found) .and. .not.present(default))) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_dat_REAL2_2


#endif
#endif

subroutine iotk_dat_dummy_REAL2_2
  write(0,*)
end subroutine iotk_dat_dummy_REAL2_2

# 45 "iotk_dat.spp"

# 47 "iotk_dat.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_dat.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_dat.spp"

# 59 "iotk_dat.spp"

#ifdef __IOTK_REAL2
#if 3 <= __IOTK_MAXRANK
# 63 "iotk_dat.spp"
subroutine iotk_write_dat_REAL2_3(unit,name,dat,dummy,attr,fmt,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_write_attr
  use iotk_write_interf
  use iotk_fmt_interf
  use iotk_str_interf
  use iotk_unit_interf
  use iotk_misc_interf
  implicit none
  integer,                intent(in)  :: unit
  character(*),           intent(in)  :: name
  REAL (kind=__IOTK_REAL2), intent(in)  :: dat (:,:,:) 
  type(iotk_dummytype), optional      :: dummy
  character(len=*), optional, intent(in)  :: attr
  character(len=*), optional, intent(in)  :: fmt
  integer,      optional, intent(out) :: ierr
  integer :: ierrl,lunit,iostat
  logical :: binary,raw
  integer(iotk_header_kind), parameter :: idummy=0
  character(300) :: usefmt,usefmt1
  character(iotk_attlenx) :: lattr
  character(iotk_attlenx) :: attr_tmp
  type (iotk_unit), pointer :: this
# 91 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL2),allocatable :: dattmp(:)
# 93 "iotk_dat.spp"
  integer :: itmp
  ierrl = 0
  iostat = 0
  lunit = iotk_phys_unit(unit)
  call iotk_unit_get(lunit,pointer=this)
  raw = .false.
  if(associated(this)) then
    raw = this%raw
  end if
  call iotk_inquire(lunit,binary=binary,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 104 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_strcpy(usefmt,"!",ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 109 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(fmt) .and. .not. raw) call iotk_strcpy(usefmt,iotk_strtrim(fmt),ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 114 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(iotk_strscan(usefmt,"<>&")/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Special characters (<>&) found in fmt string')
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"unit",unit)
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",trim(name))
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"fmt",trim(fmt))
    goto 1
  end if
  call iotk_write_attr(lattr,"type",iotk_tolower("REAL"),first=.true.,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 123 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_attr(lattr,"size",size(dat),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 128 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
# 138 "iotk_dat.spp"
  if(binary) then
    call iotk_write_attr(lattr,"kind",kind(dat),ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 141 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
  end if
# 146 "iotk_dat.spp"
  if(.not.iotk_strcomp(usefmt,"!")) call iotk_write_attr(lattr,"fmt",iotk_strtrim(usefmt),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 148 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(attr)) then
    attr_tmp(1:1)=iotk_eos
    call iotk_strcpy(attr_tmp,attr,ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 155 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"type",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 160 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"kind",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 165 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"size",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 170 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"fmt",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 175 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"len",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 180 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    if(iotk_strlen_trim(attr_tmp)>0) call iotk_strcat(lattr,iotk_strtrim(attr_tmp),ierr=ierrl)
  end if
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 186 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_begin(unit,name,lattr,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 191 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if

  allocate(dattmp(size(dat)))
# 199 "iotk_dat.spp"
#if defined(__IOTK_WORKAROUND3) || defined(__IOTK_WORKAROUND4)
# 203 "iotk_dat.spp"
     call iotk_private_pack_REAL2(dattmp,dat,size(dattmp),1)
# 205 "iotk_dat.spp"
#else
     dattmp = pack(dat,mask=.true.)
#endif
# 209 "iotk_dat.spp"

  if(binary) then
    if(raw) then
      write(lunit,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 214 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else
      write(lunit,iostat=iostat) idummy,(dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 220 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  else
    if(raw) then
# 229 "iotk_dat.spp"
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
# 231 "iotk_dat.spp"
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 232 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"*")) then
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 238 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"!")) then
# 252 "iotk_dat.spp"
     write(lunit,fmt=trim(iotk_wfmt("REAL",kind(dattmp),1,-1)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
     if(iostat/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 254 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
     end if
# 258 "iotk_dat.spp"
    else
      write(lunit,fmt=usefmt(1:iotk_strlen(usefmt)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 261 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  end if
  call iotk_write_end(unit,name,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 268 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
1 continue
  if(allocated(dattmp)) deallocate(dattmp)
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_dat_REAL2_3


# 545 "iotk_dat.spp"

# 547 "iotk_dat.spp"
subroutine iotk_scan_dat_REAL2_3(unit,name,dat,dummy,attr,found,default,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_dat_interf, only: iotk_scan_dat_aux
  use iotk_scan_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  integer,                   intent(in)  :: unit
  character(*),              intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL (kind=__IOTK_REAL2)                        :: dat (:,:,:)
#else
  REAL (kind=__IOTK_REAL2),           intent(out) :: dat (:,:,:)
#endif
  type(iotk_dummytype), optional         :: dummy
#ifdef __IOTK_WORKAROUND6
  character(len=*),optional              :: attr
#else
  character(len=*),optional, intent(out) :: attr
#endif
  logical,         optional, intent(out) :: found
  REAL (kind=__IOTK_REAL2), optional, intent(in)  :: default (:,:,:)
  integer,         optional, intent(out) :: ierr
# 574 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL2),              allocatable :: tmpdat(:)
# 576 "iotk_dat.spp"
  integer :: ierrl,ierrl2
  integer :: rkind,rsize,rlen
  character(iotk_vallenx) :: rtype
  character(iotk_vallenx) :: fmt
  character(iotk_attlenx) :: lattr
  logical :: inside,foundl
  inside = .false.
  ierrl = 0
  ierrl2 = 0
  foundl=.false.
  call iotk_scan_begin(unit,name,lattr,found=foundl,ierr=ierrl)
  if(.not. foundl) goto 1
  foundl = .true.
  inside = .true.
  if(present(attr)) call iotk_strcpy(attr,lattr,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 592 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_parse_dat(lattr,rtype,rkind,rsize,rlen,fmt,ierrl)
  if(ierrl/=0) goto 1
  if(.not. (iotk_strcomp(rtype,iotk_eos) .or. iotk_strcomp(rtype,"REAL") ) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,' ')
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"rtype",rtype(1:iotk_strlen(rtype)))
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"type","REAL")
    goto 1
  end if
  if(.not. (rsize==-1 .or. rsize==size(dat)) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 602 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(rkind==-1) rkind = kind(dat)
# 609 "iotk_dat.spp"

  allocate(tmpdat(size(dat)))
  call iotk_scan_dat_aux(unit,tmpdat,rkind,rlen,fmt(1:iotk_strlen(fmt)),ierrl)
# 615 "iotk_dat.spp"
        dat = reshape(tmpdat,shape(dat))
# 617 "iotk_dat.spp"
  deallocate(tmpdat)
1 continue
  if(inside) then
    call iotk_scan_end(unit,name,ierr=ierrl2)
    if(ierrl2/=0) then
      call iotk_error_clear(ierrl)
      ierrl=ierrl2
    end if
  end if
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Dat not found')
# 629 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if 
  if(present(default) .and. .not. foundl) then
    dat=default
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl>0 .or. (.not.present(found) .and. .not.present(default))) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_dat_REAL2_3


#endif
#endif

subroutine iotk_dat_dummy_REAL2_3
  write(0,*)
end subroutine iotk_dat_dummy_REAL2_3

# 45 "iotk_dat.spp"

# 47 "iotk_dat.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_dat.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_dat.spp"

# 59 "iotk_dat.spp"

#ifdef __IOTK_REAL2
#if 4 <= __IOTK_MAXRANK
# 63 "iotk_dat.spp"
subroutine iotk_write_dat_REAL2_4(unit,name,dat,dummy,attr,fmt,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_write_attr
  use iotk_write_interf
  use iotk_fmt_interf
  use iotk_str_interf
  use iotk_unit_interf
  use iotk_misc_interf
  implicit none
  integer,                intent(in)  :: unit
  character(*),           intent(in)  :: name
  REAL (kind=__IOTK_REAL2), intent(in)  :: dat (:,:,:,:) 
  type(iotk_dummytype), optional      :: dummy
  character(len=*), optional, intent(in)  :: attr
  character(len=*), optional, intent(in)  :: fmt
  integer,      optional, intent(out) :: ierr
  integer :: ierrl,lunit,iostat
  logical :: binary,raw
  integer(iotk_header_kind), parameter :: idummy=0
  character(300) :: usefmt,usefmt1
  character(iotk_attlenx) :: lattr
  character(iotk_attlenx) :: attr_tmp
  type (iotk_unit), pointer :: this
# 91 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL2),allocatable :: dattmp(:)
# 93 "iotk_dat.spp"
  integer :: itmp
  ierrl = 0
  iostat = 0
  lunit = iotk_phys_unit(unit)
  call iotk_unit_get(lunit,pointer=this)
  raw = .false.
  if(associated(this)) then
    raw = this%raw
  end if
  call iotk_inquire(lunit,binary=binary,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 104 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_strcpy(usefmt,"!",ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 109 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(fmt) .and. .not. raw) call iotk_strcpy(usefmt,iotk_strtrim(fmt),ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 114 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(iotk_strscan(usefmt,"<>&")/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Special characters (<>&) found in fmt string')
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"unit",unit)
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",trim(name))
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"fmt",trim(fmt))
    goto 1
  end if
  call iotk_write_attr(lattr,"type",iotk_tolower("REAL"),first=.true.,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 123 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_attr(lattr,"size",size(dat),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 128 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
# 138 "iotk_dat.spp"
  if(binary) then
    call iotk_write_attr(lattr,"kind",kind(dat),ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 141 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
  end if
# 146 "iotk_dat.spp"
  if(.not.iotk_strcomp(usefmt,"!")) call iotk_write_attr(lattr,"fmt",iotk_strtrim(usefmt),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 148 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(attr)) then
    attr_tmp(1:1)=iotk_eos
    call iotk_strcpy(attr_tmp,attr,ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 155 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"type",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 160 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"kind",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 165 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"size",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 170 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"fmt",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 175 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"len",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 180 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    if(iotk_strlen_trim(attr_tmp)>0) call iotk_strcat(lattr,iotk_strtrim(attr_tmp),ierr=ierrl)
  end if
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 186 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_begin(unit,name,lattr,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 191 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if

  allocate(dattmp(size(dat)))
# 199 "iotk_dat.spp"
#if defined(__IOTK_WORKAROUND3) || defined(__IOTK_WORKAROUND4)
# 203 "iotk_dat.spp"
     call iotk_private_pack_REAL2(dattmp,dat,size(dattmp),1)
# 205 "iotk_dat.spp"
#else
     dattmp = pack(dat,mask=.true.)
#endif
# 209 "iotk_dat.spp"

  if(binary) then
    if(raw) then
      write(lunit,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 214 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else
      write(lunit,iostat=iostat) idummy,(dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 220 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  else
    if(raw) then
# 229 "iotk_dat.spp"
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
# 231 "iotk_dat.spp"
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 232 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"*")) then
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 238 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"!")) then
# 252 "iotk_dat.spp"
     write(lunit,fmt=trim(iotk_wfmt("REAL",kind(dattmp),1,-1)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
     if(iostat/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 254 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
     end if
# 258 "iotk_dat.spp"
    else
      write(lunit,fmt=usefmt(1:iotk_strlen(usefmt)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 261 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  end if
  call iotk_write_end(unit,name,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 268 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
1 continue
  if(allocated(dattmp)) deallocate(dattmp)
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_dat_REAL2_4


# 545 "iotk_dat.spp"

# 547 "iotk_dat.spp"
subroutine iotk_scan_dat_REAL2_4(unit,name,dat,dummy,attr,found,default,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_dat_interf, only: iotk_scan_dat_aux
  use iotk_scan_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  integer,                   intent(in)  :: unit
  character(*),              intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL (kind=__IOTK_REAL2)                        :: dat (:,:,:,:)
#else
  REAL (kind=__IOTK_REAL2),           intent(out) :: dat (:,:,:,:)
#endif
  type(iotk_dummytype), optional         :: dummy
#ifdef __IOTK_WORKAROUND6
  character(len=*),optional              :: attr
#else
  character(len=*),optional, intent(out) :: attr
#endif
  logical,         optional, intent(out) :: found
  REAL (kind=__IOTK_REAL2), optional, intent(in)  :: default (:,:,:,:)
  integer,         optional, intent(out) :: ierr
# 574 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL2),              allocatable :: tmpdat(:)
# 576 "iotk_dat.spp"
  integer :: ierrl,ierrl2
  integer :: rkind,rsize,rlen
  character(iotk_vallenx) :: rtype
  character(iotk_vallenx) :: fmt
  character(iotk_attlenx) :: lattr
  logical :: inside,foundl
  inside = .false.
  ierrl = 0
  ierrl2 = 0
  foundl=.false.
  call iotk_scan_begin(unit,name,lattr,found=foundl,ierr=ierrl)
  if(.not. foundl) goto 1
  foundl = .true.
  inside = .true.
  if(present(attr)) call iotk_strcpy(attr,lattr,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 592 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_parse_dat(lattr,rtype,rkind,rsize,rlen,fmt,ierrl)
  if(ierrl/=0) goto 1
  if(.not. (iotk_strcomp(rtype,iotk_eos) .or. iotk_strcomp(rtype,"REAL") ) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,' ')
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"rtype",rtype(1:iotk_strlen(rtype)))
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"type","REAL")
    goto 1
  end if
  if(.not. (rsize==-1 .or. rsize==size(dat)) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 602 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(rkind==-1) rkind = kind(dat)
# 609 "iotk_dat.spp"

  allocate(tmpdat(size(dat)))
  call iotk_scan_dat_aux(unit,tmpdat,rkind,rlen,fmt(1:iotk_strlen(fmt)),ierrl)
# 615 "iotk_dat.spp"
        dat = reshape(tmpdat,shape(dat))
# 617 "iotk_dat.spp"
  deallocate(tmpdat)
1 continue
  if(inside) then
    call iotk_scan_end(unit,name,ierr=ierrl2)
    if(ierrl2/=0) then
      call iotk_error_clear(ierrl)
      ierrl=ierrl2
    end if
  end if
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Dat not found')
# 629 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if 
  if(present(default) .and. .not. foundl) then
    dat=default
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl>0 .or. (.not.present(found) .and. .not.present(default))) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_dat_REAL2_4


#endif
#endif

subroutine iotk_dat_dummy_REAL2_4
  write(0,*)
end subroutine iotk_dat_dummy_REAL2_4

# 45 "iotk_dat.spp"

# 47 "iotk_dat.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_dat.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_dat.spp"

# 59 "iotk_dat.spp"

#ifdef __IOTK_REAL2
#if 5 <= __IOTK_MAXRANK
# 63 "iotk_dat.spp"
subroutine iotk_write_dat_REAL2_5(unit,name,dat,dummy,attr,fmt,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_write_attr
  use iotk_write_interf
  use iotk_fmt_interf
  use iotk_str_interf
  use iotk_unit_interf
  use iotk_misc_interf
  implicit none
  integer,                intent(in)  :: unit
  character(*),           intent(in)  :: name
  REAL (kind=__IOTK_REAL2), intent(in)  :: dat (:,:,:,:,:) 
  type(iotk_dummytype), optional      :: dummy
  character(len=*), optional, intent(in)  :: attr
  character(len=*), optional, intent(in)  :: fmt
  integer,      optional, intent(out) :: ierr
  integer :: ierrl,lunit,iostat
  logical :: binary,raw
  integer(iotk_header_kind), parameter :: idummy=0
  character(300) :: usefmt,usefmt1
  character(iotk_attlenx) :: lattr
  character(iotk_attlenx) :: attr_tmp
  type (iotk_unit), pointer :: this
# 91 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL2),allocatable :: dattmp(:)
# 93 "iotk_dat.spp"
  integer :: itmp
  ierrl = 0
  iostat = 0
  lunit = iotk_phys_unit(unit)
  call iotk_unit_get(lunit,pointer=this)
  raw = .false.
  if(associated(this)) then
    raw = this%raw
  end if
  call iotk_inquire(lunit,binary=binary,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 104 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_strcpy(usefmt,"!",ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 109 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(fmt) .and. .not. raw) call iotk_strcpy(usefmt,iotk_strtrim(fmt),ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 114 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(iotk_strscan(usefmt,"<>&")/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Special characters (<>&) found in fmt string')
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"unit",unit)
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",trim(name))
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"fmt",trim(fmt))
    goto 1
  end if
  call iotk_write_attr(lattr,"type",iotk_tolower("REAL"),first=.true.,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 123 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_attr(lattr,"size",size(dat),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 128 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
# 138 "iotk_dat.spp"
  if(binary) then
    call iotk_write_attr(lattr,"kind",kind(dat),ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 141 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
  end if
# 146 "iotk_dat.spp"
  if(.not.iotk_strcomp(usefmt,"!")) call iotk_write_attr(lattr,"fmt",iotk_strtrim(usefmt),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 148 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(attr)) then
    attr_tmp(1:1)=iotk_eos
    call iotk_strcpy(attr_tmp,attr,ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 155 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"type",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 160 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"kind",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 165 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"size",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 170 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"fmt",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 175 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"len",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 180 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    if(iotk_strlen_trim(attr_tmp)>0) call iotk_strcat(lattr,iotk_strtrim(attr_tmp),ierr=ierrl)
  end if
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 186 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_begin(unit,name,lattr,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 191 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if

  allocate(dattmp(size(dat)))
# 199 "iotk_dat.spp"
#if defined(__IOTK_WORKAROUND3) || defined(__IOTK_WORKAROUND4)
# 203 "iotk_dat.spp"
     call iotk_private_pack_REAL2(dattmp,dat,size(dattmp),1)
# 205 "iotk_dat.spp"
#else
     dattmp = pack(dat,mask=.true.)
#endif
# 209 "iotk_dat.spp"

  if(binary) then
    if(raw) then
      write(lunit,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 214 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else
      write(lunit,iostat=iostat) idummy,(dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 220 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  else
    if(raw) then
# 229 "iotk_dat.spp"
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
# 231 "iotk_dat.spp"
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 232 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"*")) then
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 238 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"!")) then
# 252 "iotk_dat.spp"
     write(lunit,fmt=trim(iotk_wfmt("REAL",kind(dattmp),1,-1)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
     if(iostat/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 254 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
     end if
# 258 "iotk_dat.spp"
    else
      write(lunit,fmt=usefmt(1:iotk_strlen(usefmt)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 261 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  end if
  call iotk_write_end(unit,name,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 268 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
1 continue
  if(allocated(dattmp)) deallocate(dattmp)
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_dat_REAL2_5


# 545 "iotk_dat.spp"

# 547 "iotk_dat.spp"
subroutine iotk_scan_dat_REAL2_5(unit,name,dat,dummy,attr,found,default,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_dat_interf, only: iotk_scan_dat_aux
  use iotk_scan_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  integer,                   intent(in)  :: unit
  character(*),              intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL (kind=__IOTK_REAL2)                        :: dat (:,:,:,:,:)
#else
  REAL (kind=__IOTK_REAL2),           intent(out) :: dat (:,:,:,:,:)
#endif
  type(iotk_dummytype), optional         :: dummy
#ifdef __IOTK_WORKAROUND6
  character(len=*),optional              :: attr
#else
  character(len=*),optional, intent(out) :: attr
#endif
  logical,         optional, intent(out) :: found
  REAL (kind=__IOTK_REAL2), optional, intent(in)  :: default (:,:,:,:,:)
  integer,         optional, intent(out) :: ierr
# 574 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL2),              allocatable :: tmpdat(:)
# 576 "iotk_dat.spp"
  integer :: ierrl,ierrl2
  integer :: rkind,rsize,rlen
  character(iotk_vallenx) :: rtype
  character(iotk_vallenx) :: fmt
  character(iotk_attlenx) :: lattr
  logical :: inside,foundl
  inside = .false.
  ierrl = 0
  ierrl2 = 0
  foundl=.false.
  call iotk_scan_begin(unit,name,lattr,found=foundl,ierr=ierrl)
  if(.not. foundl) goto 1
  foundl = .true.
  inside = .true.
  if(present(attr)) call iotk_strcpy(attr,lattr,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 592 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_parse_dat(lattr,rtype,rkind,rsize,rlen,fmt,ierrl)
  if(ierrl/=0) goto 1
  if(.not. (iotk_strcomp(rtype,iotk_eos) .or. iotk_strcomp(rtype,"REAL") ) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,' ')
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"rtype",rtype(1:iotk_strlen(rtype)))
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"type","REAL")
    goto 1
  end if
  if(.not. (rsize==-1 .or. rsize==size(dat)) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 602 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(rkind==-1) rkind = kind(dat)
# 609 "iotk_dat.spp"

  allocate(tmpdat(size(dat)))
  call iotk_scan_dat_aux(unit,tmpdat,rkind,rlen,fmt(1:iotk_strlen(fmt)),ierrl)
# 615 "iotk_dat.spp"
        dat = reshape(tmpdat,shape(dat))
# 617 "iotk_dat.spp"
  deallocate(tmpdat)
1 continue
  if(inside) then
    call iotk_scan_end(unit,name,ierr=ierrl2)
    if(ierrl2/=0) then
      call iotk_error_clear(ierrl)
      ierrl=ierrl2
    end if
  end if
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Dat not found')
# 629 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if 
  if(present(default) .and. .not. foundl) then
    dat=default
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl>0 .or. (.not.present(found) .and. .not.present(default))) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_dat_REAL2_5


#endif
#endif

subroutine iotk_dat_dummy_REAL2_5
  write(0,*)
end subroutine iotk_dat_dummy_REAL2_5

# 45 "iotk_dat.spp"

# 47 "iotk_dat.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_dat.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_dat.spp"

# 59 "iotk_dat.spp"

#ifdef __IOTK_REAL2
#if 6 <= __IOTK_MAXRANK
# 63 "iotk_dat.spp"
subroutine iotk_write_dat_REAL2_6(unit,name,dat,dummy,attr,fmt,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_write_attr
  use iotk_write_interf
  use iotk_fmt_interf
  use iotk_str_interf
  use iotk_unit_interf
  use iotk_misc_interf
  implicit none
  integer,                intent(in)  :: unit
  character(*),           intent(in)  :: name
  REAL (kind=__IOTK_REAL2), intent(in)  :: dat (:,:,:,:,:,:) 
  type(iotk_dummytype), optional      :: dummy
  character(len=*), optional, intent(in)  :: attr
  character(len=*), optional, intent(in)  :: fmt
  integer,      optional, intent(out) :: ierr
  integer :: ierrl,lunit,iostat
  logical :: binary,raw
  integer(iotk_header_kind), parameter :: idummy=0
  character(300) :: usefmt,usefmt1
  character(iotk_attlenx) :: lattr
  character(iotk_attlenx) :: attr_tmp
  type (iotk_unit), pointer :: this
# 91 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL2),allocatable :: dattmp(:)
# 93 "iotk_dat.spp"
  integer :: itmp
  ierrl = 0
  iostat = 0
  lunit = iotk_phys_unit(unit)
  call iotk_unit_get(lunit,pointer=this)
  raw = .false.
  if(associated(this)) then
    raw = this%raw
  end if
  call iotk_inquire(lunit,binary=binary,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 104 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_strcpy(usefmt,"!",ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 109 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(fmt) .and. .not. raw) call iotk_strcpy(usefmt,iotk_strtrim(fmt),ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 114 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(iotk_strscan(usefmt,"<>&")/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Special characters (<>&) found in fmt string')
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"unit",unit)
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",trim(name))
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"fmt",trim(fmt))
    goto 1
  end if
  call iotk_write_attr(lattr,"type",iotk_tolower("REAL"),first=.true.,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 123 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_attr(lattr,"size",size(dat),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 128 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
# 138 "iotk_dat.spp"
  if(binary) then
    call iotk_write_attr(lattr,"kind",kind(dat),ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 141 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
  end if
# 146 "iotk_dat.spp"
  if(.not.iotk_strcomp(usefmt,"!")) call iotk_write_attr(lattr,"fmt",iotk_strtrim(usefmt),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 148 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(attr)) then
    attr_tmp(1:1)=iotk_eos
    call iotk_strcpy(attr_tmp,attr,ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 155 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"type",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 160 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"kind",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 165 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"size",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 170 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"fmt",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 175 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"len",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 180 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    if(iotk_strlen_trim(attr_tmp)>0) call iotk_strcat(lattr,iotk_strtrim(attr_tmp),ierr=ierrl)
  end if
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 186 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_begin(unit,name,lattr,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 191 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if

  allocate(dattmp(size(dat)))
# 199 "iotk_dat.spp"
#if defined(__IOTK_WORKAROUND3) || defined(__IOTK_WORKAROUND4)
# 203 "iotk_dat.spp"
     call iotk_private_pack_REAL2(dattmp,dat,size(dattmp),1)
# 205 "iotk_dat.spp"
#else
     dattmp = pack(dat,mask=.true.)
#endif
# 209 "iotk_dat.spp"

  if(binary) then
    if(raw) then
      write(lunit,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 214 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else
      write(lunit,iostat=iostat) idummy,(dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 220 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  else
    if(raw) then
# 229 "iotk_dat.spp"
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
# 231 "iotk_dat.spp"
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 232 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"*")) then
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 238 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"!")) then
# 252 "iotk_dat.spp"
     write(lunit,fmt=trim(iotk_wfmt("REAL",kind(dattmp),1,-1)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
     if(iostat/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 254 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
     end if
# 258 "iotk_dat.spp"
    else
      write(lunit,fmt=usefmt(1:iotk_strlen(usefmt)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 261 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  end if
  call iotk_write_end(unit,name,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 268 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
1 continue
  if(allocated(dattmp)) deallocate(dattmp)
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_dat_REAL2_6


# 545 "iotk_dat.spp"

# 547 "iotk_dat.spp"
subroutine iotk_scan_dat_REAL2_6(unit,name,dat,dummy,attr,found,default,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_dat_interf, only: iotk_scan_dat_aux
  use iotk_scan_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  integer,                   intent(in)  :: unit
  character(*),              intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL (kind=__IOTK_REAL2)                        :: dat (:,:,:,:,:,:)
#else
  REAL (kind=__IOTK_REAL2),           intent(out) :: dat (:,:,:,:,:,:)
#endif
  type(iotk_dummytype), optional         :: dummy
#ifdef __IOTK_WORKAROUND6
  character(len=*),optional              :: attr
#else
  character(len=*),optional, intent(out) :: attr
#endif
  logical,         optional, intent(out) :: found
  REAL (kind=__IOTK_REAL2), optional, intent(in)  :: default (:,:,:,:,:,:)
  integer,         optional, intent(out) :: ierr
# 574 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL2),              allocatable :: tmpdat(:)
# 576 "iotk_dat.spp"
  integer :: ierrl,ierrl2
  integer :: rkind,rsize,rlen
  character(iotk_vallenx) :: rtype
  character(iotk_vallenx) :: fmt
  character(iotk_attlenx) :: lattr
  logical :: inside,foundl
  inside = .false.
  ierrl = 0
  ierrl2 = 0
  foundl=.false.
  call iotk_scan_begin(unit,name,lattr,found=foundl,ierr=ierrl)
  if(.not. foundl) goto 1
  foundl = .true.
  inside = .true.
  if(present(attr)) call iotk_strcpy(attr,lattr,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 592 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_parse_dat(lattr,rtype,rkind,rsize,rlen,fmt,ierrl)
  if(ierrl/=0) goto 1
  if(.not. (iotk_strcomp(rtype,iotk_eos) .or. iotk_strcomp(rtype,"REAL") ) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,' ')
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"rtype",rtype(1:iotk_strlen(rtype)))
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"type","REAL")
    goto 1
  end if
  if(.not. (rsize==-1 .or. rsize==size(dat)) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 602 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(rkind==-1) rkind = kind(dat)
# 609 "iotk_dat.spp"

  allocate(tmpdat(size(dat)))
  call iotk_scan_dat_aux(unit,tmpdat,rkind,rlen,fmt(1:iotk_strlen(fmt)),ierrl)
# 615 "iotk_dat.spp"
        dat = reshape(tmpdat,shape(dat))
# 617 "iotk_dat.spp"
  deallocate(tmpdat)
1 continue
  if(inside) then
    call iotk_scan_end(unit,name,ierr=ierrl2)
    if(ierrl2/=0) then
      call iotk_error_clear(ierrl)
      ierrl=ierrl2
    end if
  end if
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Dat not found')
# 629 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if 
  if(present(default) .and. .not. foundl) then
    dat=default
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl>0 .or. (.not.present(found) .and. .not.present(default))) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_dat_REAL2_6


#endif
#endif

subroutine iotk_dat_dummy_REAL2_6
  write(0,*)
end subroutine iotk_dat_dummy_REAL2_6

# 45 "iotk_dat.spp"

# 47 "iotk_dat.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_dat.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_dat.spp"

# 59 "iotk_dat.spp"

#ifdef __IOTK_REAL2
#if 7 <= __IOTK_MAXRANK
# 63 "iotk_dat.spp"
subroutine iotk_write_dat_REAL2_7(unit,name,dat,dummy,attr,fmt,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_write_attr
  use iotk_write_interf
  use iotk_fmt_interf
  use iotk_str_interf
  use iotk_unit_interf
  use iotk_misc_interf
  implicit none
  integer,                intent(in)  :: unit
  character(*),           intent(in)  :: name
  REAL (kind=__IOTK_REAL2), intent(in)  :: dat (:,:,:,:,:,:,:) 
  type(iotk_dummytype), optional      :: dummy
  character(len=*), optional, intent(in)  :: attr
  character(len=*), optional, intent(in)  :: fmt
  integer,      optional, intent(out) :: ierr
  integer :: ierrl,lunit,iostat
  logical :: binary,raw
  integer(iotk_header_kind), parameter :: idummy=0
  character(300) :: usefmt,usefmt1
  character(iotk_attlenx) :: lattr
  character(iotk_attlenx) :: attr_tmp
  type (iotk_unit), pointer :: this
# 91 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL2),allocatable :: dattmp(:)
# 93 "iotk_dat.spp"
  integer :: itmp
  ierrl = 0
  iostat = 0
  lunit = iotk_phys_unit(unit)
  call iotk_unit_get(lunit,pointer=this)
  raw = .false.
  if(associated(this)) then
    raw = this%raw
  end if
  call iotk_inquire(lunit,binary=binary,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 104 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_strcpy(usefmt,"!",ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 109 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(fmt) .and. .not. raw) call iotk_strcpy(usefmt,iotk_strtrim(fmt),ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 114 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(iotk_strscan(usefmt,"<>&")/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Special characters (<>&) found in fmt string')
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"unit",unit)
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",trim(name))
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"fmt",trim(fmt))
    goto 1
  end if
  call iotk_write_attr(lattr,"type",iotk_tolower("REAL"),first=.true.,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 123 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_attr(lattr,"size",size(dat),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 128 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
# 138 "iotk_dat.spp"
  if(binary) then
    call iotk_write_attr(lattr,"kind",kind(dat),ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 141 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
  end if
# 146 "iotk_dat.spp"
  if(.not.iotk_strcomp(usefmt,"!")) call iotk_write_attr(lattr,"fmt",iotk_strtrim(usefmt),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 148 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(attr)) then
    attr_tmp(1:1)=iotk_eos
    call iotk_strcpy(attr_tmp,attr,ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 155 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"type",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 160 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"kind",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 165 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"size",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 170 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"fmt",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 175 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"len",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 180 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    if(iotk_strlen_trim(attr_tmp)>0) call iotk_strcat(lattr,iotk_strtrim(attr_tmp),ierr=ierrl)
  end if
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 186 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_begin(unit,name,lattr,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 191 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if

  allocate(dattmp(size(dat)))
# 199 "iotk_dat.spp"
#if defined(__IOTK_WORKAROUND3) || defined(__IOTK_WORKAROUND4)
# 203 "iotk_dat.spp"
     call iotk_private_pack_REAL2(dattmp,dat,size(dattmp),1)
# 205 "iotk_dat.spp"
#else
     dattmp = pack(dat,mask=.true.)
#endif
# 209 "iotk_dat.spp"

  if(binary) then
    if(raw) then
      write(lunit,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 214 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else
      write(lunit,iostat=iostat) idummy,(dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 220 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  else
    if(raw) then
# 229 "iotk_dat.spp"
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
# 231 "iotk_dat.spp"
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 232 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"*")) then
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 238 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"!")) then
# 252 "iotk_dat.spp"
     write(lunit,fmt=trim(iotk_wfmt("REAL",kind(dattmp),1,-1)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
     if(iostat/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 254 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
     end if
# 258 "iotk_dat.spp"
    else
      write(lunit,fmt=usefmt(1:iotk_strlen(usefmt)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 261 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  end if
  call iotk_write_end(unit,name,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 268 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
1 continue
  if(allocated(dattmp)) deallocate(dattmp)
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_dat_REAL2_7


# 545 "iotk_dat.spp"

# 547 "iotk_dat.spp"
subroutine iotk_scan_dat_REAL2_7(unit,name,dat,dummy,attr,found,default,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_dat_interf, only: iotk_scan_dat_aux
  use iotk_scan_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  integer,                   intent(in)  :: unit
  character(*),              intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL (kind=__IOTK_REAL2)                        :: dat (:,:,:,:,:,:,:)
#else
  REAL (kind=__IOTK_REAL2),           intent(out) :: dat (:,:,:,:,:,:,:)
#endif
  type(iotk_dummytype), optional         :: dummy
#ifdef __IOTK_WORKAROUND6
  character(len=*),optional              :: attr
#else
  character(len=*),optional, intent(out) :: attr
#endif
  logical,         optional, intent(out) :: found
  REAL (kind=__IOTK_REAL2), optional, intent(in)  :: default (:,:,:,:,:,:,:)
  integer,         optional, intent(out) :: ierr
# 574 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL2),              allocatable :: tmpdat(:)
# 576 "iotk_dat.spp"
  integer :: ierrl,ierrl2
  integer :: rkind,rsize,rlen
  character(iotk_vallenx) :: rtype
  character(iotk_vallenx) :: fmt
  character(iotk_attlenx) :: lattr
  logical :: inside,foundl
  inside = .false.
  ierrl = 0
  ierrl2 = 0
  foundl=.false.
  call iotk_scan_begin(unit,name,lattr,found=foundl,ierr=ierrl)
  if(.not. foundl) goto 1
  foundl = .true.
  inside = .true.
  if(present(attr)) call iotk_strcpy(attr,lattr,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 592 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_parse_dat(lattr,rtype,rkind,rsize,rlen,fmt,ierrl)
  if(ierrl/=0) goto 1
  if(.not. (iotk_strcomp(rtype,iotk_eos) .or. iotk_strcomp(rtype,"REAL") ) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,' ')
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"rtype",rtype(1:iotk_strlen(rtype)))
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"type","REAL")
    goto 1
  end if
  if(.not. (rsize==-1 .or. rsize==size(dat)) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 602 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(rkind==-1) rkind = kind(dat)
# 609 "iotk_dat.spp"

  allocate(tmpdat(size(dat)))
  call iotk_scan_dat_aux(unit,tmpdat,rkind,rlen,fmt(1:iotk_strlen(fmt)),ierrl)
# 615 "iotk_dat.spp"
        dat = reshape(tmpdat,shape(dat))
# 617 "iotk_dat.spp"
  deallocate(tmpdat)
1 continue
  if(inside) then
    call iotk_scan_end(unit,name,ierr=ierrl2)
    if(ierrl2/=0) then
      call iotk_error_clear(ierrl)
      ierrl=ierrl2
    end if
  end if
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Dat not found')
# 629 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if 
  if(present(default) .and. .not. foundl) then
    dat=default
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl>0 .or. (.not.present(found) .and. .not.present(default))) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_dat_REAL2_7


#endif
#endif

subroutine iotk_dat_dummy_REAL2_7
  write(0,*)
end subroutine iotk_dat_dummy_REAL2_7

# 45 "iotk_dat.spp"

# 47 "iotk_dat.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_dat.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_dat.spp"

# 59 "iotk_dat.spp"

#ifdef __IOTK_REAL3
#if 0 <= __IOTK_MAXRANK
# 63 "iotk_dat.spp"
subroutine iotk_write_dat_REAL3_0(unit,name,dat,dummy,attr,fmt,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_write_attr
  use iotk_write_interf
  use iotk_fmt_interf
  use iotk_str_interf
  use iotk_unit_interf
  use iotk_misc_interf
  implicit none
  integer,                intent(in)  :: unit
  character(*),           intent(in)  :: name
  REAL (kind=__IOTK_REAL3), intent(in)  :: dat  
  type(iotk_dummytype), optional      :: dummy
  character(len=*), optional, intent(in)  :: attr
  character(len=*), optional, intent(in)  :: fmt
  integer,      optional, intent(out) :: ierr
  integer :: ierrl,lunit,iostat
  logical :: binary,raw
  integer(iotk_header_kind), parameter :: idummy=0
  character(300) :: usefmt,usefmt1
  character(iotk_attlenx) :: lattr
  character(iotk_attlenx) :: attr_tmp
  type (iotk_unit), pointer :: this
# 91 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL3),allocatable :: dattmp(:)
# 93 "iotk_dat.spp"
  integer :: itmp
  ierrl = 0
  iostat = 0
  lunit = iotk_phys_unit(unit)
  call iotk_unit_get(lunit,pointer=this)
  raw = .false.
  if(associated(this)) then
    raw = this%raw
  end if
  call iotk_inquire(lunit,binary=binary,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 104 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_strcpy(usefmt,"!",ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 109 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(fmt) .and. .not. raw) call iotk_strcpy(usefmt,iotk_strtrim(fmt),ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 114 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(iotk_strscan(usefmt,"<>&")/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Special characters (<>&) found in fmt string')
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"unit",unit)
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",trim(name))
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"fmt",trim(fmt))
    goto 1
  end if
  call iotk_write_attr(lattr,"type",iotk_tolower("REAL"),first=.true.,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 123 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_attr(lattr,"size",1,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 128 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
# 138 "iotk_dat.spp"
  if(binary) then
    call iotk_write_attr(lattr,"kind",kind(dat),ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 141 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
  end if
# 146 "iotk_dat.spp"
  if(.not.iotk_strcomp(usefmt,"!")) call iotk_write_attr(lattr,"fmt",iotk_strtrim(usefmt),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 148 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(attr)) then
    attr_tmp(1:1)=iotk_eos
    call iotk_strcpy(attr_tmp,attr,ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 155 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"type",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 160 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"kind",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 165 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"size",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 170 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"fmt",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 175 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"len",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 180 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    if(iotk_strlen_trim(attr_tmp)>0) call iotk_strcat(lattr,iotk_strtrim(attr_tmp),ierr=ierrl)
  end if
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 186 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_begin(unit,name,lattr,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 191 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if

  allocate(dattmp(1))
# 197 "iotk_dat.spp"
     dattmp(1) = dat
# 209 "iotk_dat.spp"

  if(binary) then
    if(raw) then
      write(lunit,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 214 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else
      write(lunit,iostat=iostat) idummy,(dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 220 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  else
    if(raw) then
# 229 "iotk_dat.spp"
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
# 231 "iotk_dat.spp"
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 232 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"*")) then
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 238 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"!")) then
# 252 "iotk_dat.spp"
     write(lunit,fmt=trim(iotk_wfmt("REAL",kind(dattmp),1,-1)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
     if(iostat/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 254 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
     end if
# 258 "iotk_dat.spp"
    else
      write(lunit,fmt=usefmt(1:iotk_strlen(usefmt)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 261 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  end if
  call iotk_write_end(unit,name,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 268 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
1 continue
  if(allocated(dattmp)) deallocate(dattmp)
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_dat_REAL3_0


# 545 "iotk_dat.spp"

# 547 "iotk_dat.spp"
subroutine iotk_scan_dat_REAL3_0(unit,name,dat,dummy,attr,found,default,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_dat_interf, only: iotk_scan_dat_aux
  use iotk_scan_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  integer,                   intent(in)  :: unit
  character(*),              intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL (kind=__IOTK_REAL3)                        :: dat 
#else
  REAL (kind=__IOTK_REAL3),           intent(out) :: dat 
#endif
  type(iotk_dummytype), optional         :: dummy
#ifdef __IOTK_WORKAROUND6
  character(len=*),optional              :: attr
#else
  character(len=*),optional, intent(out) :: attr
#endif
  logical,         optional, intent(out) :: found
  REAL (kind=__IOTK_REAL3), optional, intent(in)  :: default 
  integer,         optional, intent(out) :: ierr
# 574 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL3),              allocatable :: tmpdat(:)
# 576 "iotk_dat.spp"
  integer :: ierrl,ierrl2
  integer :: rkind,rsize,rlen
  character(iotk_vallenx) :: rtype
  character(iotk_vallenx) :: fmt
  character(iotk_attlenx) :: lattr
  logical :: inside,foundl
  inside = .false.
  ierrl = 0
  ierrl2 = 0
  foundl=.false.
  call iotk_scan_begin(unit,name,lattr,found=foundl,ierr=ierrl)
  if(.not. foundl) goto 1
  foundl = .true.
  inside = .true.
  if(present(attr)) call iotk_strcpy(attr,lattr,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 592 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_parse_dat(lattr,rtype,rkind,rsize,rlen,fmt,ierrl)
  if(ierrl/=0) goto 1
  if(.not. (iotk_strcomp(rtype,iotk_eos) .or. iotk_strcomp(rtype,"REAL") ) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,' ')
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"rtype",rtype(1:iotk_strlen(rtype)))
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"type","REAL")
    goto 1
  end if
  if(.not. (rsize==-1 .or. rsize==1) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 602 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(rkind==-1) rkind = kind(dat)
# 609 "iotk_dat.spp"

  allocate(tmpdat(1))
  call iotk_scan_dat_aux(unit,tmpdat,rkind,rlen,fmt(1:iotk_strlen(fmt)),ierrl)
# 613 "iotk_dat.spp"
        dat = tmpdat(1)
# 617 "iotk_dat.spp"
  deallocate(tmpdat)
1 continue
  if(inside) then
    call iotk_scan_end(unit,name,ierr=ierrl2)
    if(ierrl2/=0) then
      call iotk_error_clear(ierrl)
      ierrl=ierrl2
    end if
  end if
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Dat not found')
# 629 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if 
  if(present(default) .and. .not. foundl) then
    dat=default
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl>0 .or. (.not.present(found) .and. .not.present(default))) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_dat_REAL3_0


#endif
#endif

subroutine iotk_dat_dummy_REAL3_0
  write(0,*)
end subroutine iotk_dat_dummy_REAL3_0

# 45 "iotk_dat.spp"

# 47 "iotk_dat.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_dat.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_dat.spp"

# 59 "iotk_dat.spp"

#ifdef __IOTK_REAL3
#if 1 <= __IOTK_MAXRANK
# 63 "iotk_dat.spp"
subroutine iotk_write_dat_REAL3_1(unit,name,dat,dummy,attr,fmt,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_write_attr
  use iotk_write_interf
  use iotk_fmt_interf
  use iotk_str_interf
  use iotk_unit_interf
  use iotk_misc_interf
  implicit none
  integer,                intent(in)  :: unit
  character(*),           intent(in)  :: name
  REAL (kind=__IOTK_REAL3), intent(in)  :: dat (:) 
  type(iotk_dummytype), optional      :: dummy
  character(len=*), optional, intent(in)  :: attr
  character(len=*), optional, intent(in)  :: fmt
  integer,      optional, intent(out) :: ierr
  integer :: ierrl,lunit,iostat
  logical :: binary,raw
  integer(iotk_header_kind), parameter :: idummy=0
  character(300) :: usefmt,usefmt1
  character(iotk_attlenx) :: lattr
  character(iotk_attlenx) :: attr_tmp
  type (iotk_unit), pointer :: this
# 91 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL3),allocatable :: dattmp(:)
# 93 "iotk_dat.spp"
  integer :: itmp
  ierrl = 0
  iostat = 0
  lunit = iotk_phys_unit(unit)
  call iotk_unit_get(lunit,pointer=this)
  raw = .false.
  if(associated(this)) then
    raw = this%raw
  end if
  call iotk_inquire(lunit,binary=binary,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 104 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_strcpy(usefmt,"!",ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 109 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(fmt) .and. .not. raw) call iotk_strcpy(usefmt,iotk_strtrim(fmt),ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 114 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(iotk_strscan(usefmt,"<>&")/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Special characters (<>&) found in fmt string')
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"unit",unit)
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",trim(name))
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"fmt",trim(fmt))
    goto 1
  end if
  call iotk_write_attr(lattr,"type",iotk_tolower("REAL"),first=.true.,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 123 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_attr(lattr,"size",size(dat),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 128 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
# 138 "iotk_dat.spp"
  if(binary) then
    call iotk_write_attr(lattr,"kind",kind(dat),ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 141 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
  end if
# 146 "iotk_dat.spp"
  if(.not.iotk_strcomp(usefmt,"!")) call iotk_write_attr(lattr,"fmt",iotk_strtrim(usefmt),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 148 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(attr)) then
    attr_tmp(1:1)=iotk_eos
    call iotk_strcpy(attr_tmp,attr,ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 155 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"type",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 160 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"kind",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 165 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"size",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 170 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"fmt",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 175 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"len",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 180 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    if(iotk_strlen_trim(attr_tmp)>0) call iotk_strcat(lattr,iotk_strtrim(attr_tmp),ierr=ierrl)
  end if
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 186 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_begin(unit,name,lattr,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 191 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if

  allocate(dattmp(size(dat)))
# 199 "iotk_dat.spp"
#if defined(__IOTK_WORKAROUND3) || defined(__IOTK_WORKAROUND4)
# 203 "iotk_dat.spp"
     call iotk_private_pack_REAL3(dattmp,dat,size(dattmp),1)
# 205 "iotk_dat.spp"
#else
     dattmp = pack(dat,mask=.true.)
#endif
# 209 "iotk_dat.spp"

  if(binary) then
    if(raw) then
      write(lunit,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 214 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else
      write(lunit,iostat=iostat) idummy,(dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 220 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  else
    if(raw) then
# 229 "iotk_dat.spp"
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
# 231 "iotk_dat.spp"
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 232 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"*")) then
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 238 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"!")) then
# 252 "iotk_dat.spp"
     write(lunit,fmt=trim(iotk_wfmt("REAL",kind(dattmp),1,-1)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
     if(iostat/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 254 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
     end if
# 258 "iotk_dat.spp"
    else
      write(lunit,fmt=usefmt(1:iotk_strlen(usefmt)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 261 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  end if
  call iotk_write_end(unit,name,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 268 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
1 continue
  if(allocated(dattmp)) deallocate(dattmp)
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_dat_REAL3_1


# 283 "iotk_dat.spp"
recursive subroutine iotk_scan_dat_aux_REAL3(unit,dat,rkind,rlen,fmt,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only: iotk_read
  use iotk_scan_interf
  use iotk_str_interf
  use iotk_unit_interf
  use iotk_misc_interf
  implicit none
  integer,         intent(in)  :: unit
#ifdef __IOTK_WORKAROUND6
  REAL (kind=__IOTK_REAL3)                        :: dat (:)
#else
  REAL (kind=__IOTK_REAL3),           intent(out) :: dat (:)
#endif
  integer,         intent(in)  :: rkind
  integer,         intent(in)  :: rlen
  character(*),    intent(in)  :: fmt
  integer,         intent(out) :: ierr
  integer(iotk_header_kind) :: idummy
  logical :: raw,binary
  integer :: lunit
  integer :: index,length,nexttag,iostat,altlength
  type(iotk_unit), pointer :: this
  character(len=iotk_linlenx) :: line,altline
# 313 "iotk_dat.spp"
#ifdef __IOTK_REAL1
  REAL (__IOTK_REAL1), allocatable :: dat1 (:)
#endif
# 313 "iotk_dat.spp"
#ifdef __IOTK_REAL2
  REAL (__IOTK_REAL2), allocatable :: dat2 (:)
#endif
# 313 "iotk_dat.spp"
#ifdef __IOTK_REAL4
  REAL (__IOTK_REAL4), allocatable :: dat4 (:)
#endif
# 319 "iotk_dat.spp"
  lunit = iotk_phys_unit(unit)
  ierr = 0
  iostat = 0
  idummy = 0
  call iotk_unit_get(lunit,pointer=this)
  raw = .false.
  if(associated(this)) then
    raw = this%raw
  end if
  call iotk_inquire(unit=lunit,binary=binary,ierr=ierr)
  if(ierr/=0) then
    call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 330 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
    return
  end if
# 420 "iotk_dat.spp"
  if(binary) then
    select case(rkind)
    case(kind(dat))
      if(raw) then
        read(lunit,iostat=iostat) dat
        if(iostat/=0) then
          call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 426 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
# 426 "iotk_dat.spp"
call iotk_error_msg(ierr,' ')
# 426 "iotk_dat.spp"
call iotk_error_write(ierr,"iostat",iostat)
          return
        end if
      else
        read(lunit,iostat=iostat) idummy,dat
        if(iostat/=0) then
          call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 432 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
# 432 "iotk_dat.spp"
call iotk_error_msg(ierr,' ')
# 432 "iotk_dat.spp"
call iotk_error_write(ierr,"iostat",iostat)
          return
        end if
      end if
# 438 "iotk_dat.spp"
#ifdef __IOTK_REAL1
    case(kind(dat1))
      ! Giusto per scrupolo. Se e' raw non ci sono info sul kind, quindi questa linea e' irraggiungibile
      if(raw) then
        call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 442 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
        return
      end if
      allocate(dat1(ubound(dat,1)))
      read(lunit,iostat=iostat) idummy,dat1
      if(iostat/=0) then
        call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 448 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
# 448 "iotk_dat.spp"
call iotk_error_msg(ierr,' ')
# 448 "iotk_dat.spp"
call iotk_error_write(ierr,"iostat",iostat)
        return
      end if
# 458 "iotk_dat.spp"
      dat = dat1
# 460 "iotk_dat.spp"
      deallocate(dat1)
#endif
# 438 "iotk_dat.spp"
#ifdef __IOTK_REAL2
    case(kind(dat2))
      ! Giusto per scrupolo. Se e' raw non ci sono info sul kind, quindi questa linea e' irraggiungibile
      if(raw) then
        call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 442 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
        return
      end if
      allocate(dat2(ubound(dat,1)))
      read(lunit,iostat=iostat) idummy,dat2
      if(iostat/=0) then
        call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 448 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
# 448 "iotk_dat.spp"
call iotk_error_msg(ierr,' ')
# 448 "iotk_dat.spp"
call iotk_error_write(ierr,"iostat",iostat)
        return
      end if
# 458 "iotk_dat.spp"
      dat = dat2
# 460 "iotk_dat.spp"
      deallocate(dat2)
#endif
# 438 "iotk_dat.spp"
#ifdef __IOTK_REAL4
    case(kind(dat4))
      ! Giusto per scrupolo. Se e' raw non ci sono info sul kind, quindi questa linea e' irraggiungibile
      if(raw) then
        call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 442 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
        return
      end if
      allocate(dat4(ubound(dat,1)))
      read(lunit,iostat=iostat) idummy,dat4
      if(iostat/=0) then
        call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 448 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
# 448 "iotk_dat.spp"
call iotk_error_msg(ierr,' ')
# 448 "iotk_dat.spp"
call iotk_error_write(ierr,"iostat",iostat)
        return
      end if
# 458 "iotk_dat.spp"
      dat = dat4
# 460 "iotk_dat.spp"
      deallocate(dat4)
#endif
# 464 "iotk_dat.spp"
    case default
      call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 465 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
# 465 "iotk_dat.spp"
call iotk_error_msg(ierr,'Kind incompatibility')
# 465 "iotk_dat.spp"
call iotk_error_write(ierr,"kind",rkind)
    end select
  else
    if(raw) then
      read(lunit,fmt=*,iostat=iostat) dat
      if(iostat/=0) then
        call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 471 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
# 471 "iotk_dat.spp"
call iotk_error_msg(ierr,' ')
# 471 "iotk_dat.spp"
call iotk_error_write(ierr,"iostat",iostat)
        return
      end if
    else if(iotk_strcomp(fmt,"*")) then
      read(lunit,fmt=*,iostat=iostat) dat
      if(iostat/=0) then
        call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 477 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
# 477 "iotk_dat.spp"
call iotk_error_msg(ierr,' ')
# 477 "iotk_dat.spp"
call iotk_error_write(ierr,"iostat",iostat)
        return
      end if
    else if(iotk_strcomp(fmt,"!")) then
      index = 0
      do
        call iotk_getline(lunit,line,length,ierr)
        if(ierr/=0) then
          call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 485 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
          return
        end if
        nexttag = scan(line(1:length),"<")
        if(nexttag==0) then
          nexttag = length + 1
        else
! AGGIUSTA LA POSIZIONE SE C'E' UNA TAG SU QUESTA LINEA
! E' UN PO' CASERECCIO MA FUNZIONA
          backspace(lunit,iostat=iostat)
          if(iostat/=0) then
            call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 496 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
# 496 "iotk_dat.spp"
call iotk_error_msg(ierr,' ')
# 496 "iotk_dat.spp"
call iotk_error_write(ierr,"iostat",iostat)
            return
          end if
          call iotk_getline(lunit,altline,altlength,ierr)
          if(ierr/=0) then
            call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 501 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
            return
          end if
          backspace(lunit,iostat=iostat)
          if(iostat/=0) then
            call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 506 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
# 506 "iotk_dat.spp"
call iotk_error_msg(ierr,' ')
# 506 "iotk_dat.spp"
call iotk_error_write(ierr,"iostat",iostat)
            return
          end if
          read(lunit,"(a)",advance="no",iostat=iostat) altline(1:nexttag-1 + altlength - length)
          if(iostat/=0) then
            call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 511 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
# 511 "iotk_dat.spp"
call iotk_error_msg(ierr,' ')
# 511 "iotk_dat.spp"
call iotk_error_write(ierr,"iostat",iostat)
            return
          end if
        end if
        call iotk_read(dat,line(1:nexttag - 1),index,ierr)
        if(ierr/=0) then
          call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 517 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
          return
        end if
# 523 "iotk_dat.spp"
        if(index == size(dat)) exit
# 525 "iotk_dat.spp"
        if(nexttag/=length + 1) then
          call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 526 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
          return
        end if
      end do
    else
      read(lunit,fmt=fmt(1:iotk_strlen(fmt)),iostat=iostat) dat
      if(iostat/=0) then
        call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 533 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
# 533 "iotk_dat.spp"
call iotk_error_msg(ierr,' ')
# 533 "iotk_dat.spp"
call iotk_error_write(ierr,"iostat",iostat)
        return
      end if
    end if
  end if
# 539 "iotk_dat.spp"
  if(idummy/=0) then
    call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 540 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
    return
  end if
end subroutine iotk_scan_dat_aux_REAL3
# 545 "iotk_dat.spp"

# 547 "iotk_dat.spp"
subroutine iotk_scan_dat_REAL3_1(unit,name,dat,dummy,attr,found,default,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_dat_interf, only: iotk_scan_dat_aux
  use iotk_scan_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  integer,                   intent(in)  :: unit
  character(*),              intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL (kind=__IOTK_REAL3)                        :: dat (:)
#else
  REAL (kind=__IOTK_REAL3),           intent(out) :: dat (:)
#endif
  type(iotk_dummytype), optional         :: dummy
#ifdef __IOTK_WORKAROUND6
  character(len=*),optional              :: attr
#else
  character(len=*),optional, intent(out) :: attr
#endif
  logical,         optional, intent(out) :: found
  REAL (kind=__IOTK_REAL3), optional, intent(in)  :: default (:)
  integer,         optional, intent(out) :: ierr
# 574 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL3),              allocatable :: tmpdat(:)
# 576 "iotk_dat.spp"
  integer :: ierrl,ierrl2
  integer :: rkind,rsize,rlen
  character(iotk_vallenx) :: rtype
  character(iotk_vallenx) :: fmt
  character(iotk_attlenx) :: lattr
  logical :: inside,foundl
  inside = .false.
  ierrl = 0
  ierrl2 = 0
  foundl=.false.
  call iotk_scan_begin(unit,name,lattr,found=foundl,ierr=ierrl)
  if(.not. foundl) goto 1
  foundl = .true.
  inside = .true.
  if(present(attr)) call iotk_strcpy(attr,lattr,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 592 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_parse_dat(lattr,rtype,rkind,rsize,rlen,fmt,ierrl)
  if(ierrl/=0) goto 1
  if(.not. (iotk_strcomp(rtype,iotk_eos) .or. iotk_strcomp(rtype,"REAL") ) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,' ')
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"rtype",rtype(1:iotk_strlen(rtype)))
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"type","REAL")
    goto 1
  end if
  if(.not. (rsize==-1 .or. rsize==size(dat)) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 602 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(rkind==-1) rkind = kind(dat)
# 609 "iotk_dat.spp"

  allocate(tmpdat(size(dat)))
  call iotk_scan_dat_aux(unit,tmpdat,rkind,rlen,fmt(1:iotk_strlen(fmt)),ierrl)
# 615 "iotk_dat.spp"
        dat = reshape(tmpdat,shape(dat))
# 617 "iotk_dat.spp"
  deallocate(tmpdat)
1 continue
  if(inside) then
    call iotk_scan_end(unit,name,ierr=ierrl2)
    if(ierrl2/=0) then
      call iotk_error_clear(ierrl)
      ierrl=ierrl2
    end if
  end if
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Dat not found')
# 629 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if 
  if(present(default) .and. .not. foundl) then
    dat=default
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl>0 .or. (.not.present(found) .and. .not.present(default))) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_dat_REAL3_1


#endif
#endif

subroutine iotk_dat_dummy_REAL3_1
  write(0,*)
end subroutine iotk_dat_dummy_REAL3_1

# 45 "iotk_dat.spp"

# 47 "iotk_dat.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_dat.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_dat.spp"

# 59 "iotk_dat.spp"

#ifdef __IOTK_REAL3
#if 2 <= __IOTK_MAXRANK
# 63 "iotk_dat.spp"
subroutine iotk_write_dat_REAL3_2(unit,name,dat,dummy,attr,fmt,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_write_attr
  use iotk_write_interf
  use iotk_fmt_interf
  use iotk_str_interf
  use iotk_unit_interf
  use iotk_misc_interf
  implicit none
  integer,                intent(in)  :: unit
  character(*),           intent(in)  :: name
  REAL (kind=__IOTK_REAL3), intent(in)  :: dat (:,:) 
  type(iotk_dummytype), optional      :: dummy
  character(len=*), optional, intent(in)  :: attr
  character(len=*), optional, intent(in)  :: fmt
  integer,      optional, intent(out) :: ierr
  integer :: ierrl,lunit,iostat
  logical :: binary,raw
  integer(iotk_header_kind), parameter :: idummy=0
  character(300) :: usefmt,usefmt1
  character(iotk_attlenx) :: lattr
  character(iotk_attlenx) :: attr_tmp
  type (iotk_unit), pointer :: this
# 91 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL3),allocatable :: dattmp(:)
# 93 "iotk_dat.spp"
  integer :: itmp
  ierrl = 0
  iostat = 0
  lunit = iotk_phys_unit(unit)
  call iotk_unit_get(lunit,pointer=this)
  raw = .false.
  if(associated(this)) then
    raw = this%raw
  end if
  call iotk_inquire(lunit,binary=binary,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 104 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_strcpy(usefmt,"!",ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 109 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(fmt) .and. .not. raw) call iotk_strcpy(usefmt,iotk_strtrim(fmt),ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 114 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(iotk_strscan(usefmt,"<>&")/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Special characters (<>&) found in fmt string')
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"unit",unit)
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",trim(name))
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"fmt",trim(fmt))
    goto 1
  end if
  call iotk_write_attr(lattr,"type",iotk_tolower("REAL"),first=.true.,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 123 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_attr(lattr,"size",size(dat),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 128 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
# 138 "iotk_dat.spp"
  if(binary) then
    call iotk_write_attr(lattr,"kind",kind(dat),ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 141 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
  end if
# 146 "iotk_dat.spp"
  if(.not.iotk_strcomp(usefmt,"!")) call iotk_write_attr(lattr,"fmt",iotk_strtrim(usefmt),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 148 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(attr)) then
    attr_tmp(1:1)=iotk_eos
    call iotk_strcpy(attr_tmp,attr,ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 155 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"type",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 160 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"kind",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 165 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"size",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 170 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"fmt",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 175 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"len",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 180 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    if(iotk_strlen_trim(attr_tmp)>0) call iotk_strcat(lattr,iotk_strtrim(attr_tmp),ierr=ierrl)
  end if
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 186 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_begin(unit,name,lattr,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 191 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if

  allocate(dattmp(size(dat)))
# 199 "iotk_dat.spp"
#if defined(__IOTK_WORKAROUND3) || defined(__IOTK_WORKAROUND4)
# 203 "iotk_dat.spp"
     call iotk_private_pack_REAL3(dattmp,dat,size(dattmp),1)
# 205 "iotk_dat.spp"
#else
     dattmp = pack(dat,mask=.true.)
#endif
# 209 "iotk_dat.spp"

  if(binary) then
    if(raw) then
      write(lunit,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 214 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else
      write(lunit,iostat=iostat) idummy,(dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 220 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  else
    if(raw) then
# 229 "iotk_dat.spp"
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
# 231 "iotk_dat.spp"
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 232 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"*")) then
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 238 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"!")) then
# 252 "iotk_dat.spp"
     write(lunit,fmt=trim(iotk_wfmt("REAL",kind(dattmp),1,-1)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
     if(iostat/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 254 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
     end if
# 258 "iotk_dat.spp"
    else
      write(lunit,fmt=usefmt(1:iotk_strlen(usefmt)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 261 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  end if
  call iotk_write_end(unit,name,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 268 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
1 continue
  if(allocated(dattmp)) deallocate(dattmp)
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_dat_REAL3_2


# 545 "iotk_dat.spp"

# 547 "iotk_dat.spp"
subroutine iotk_scan_dat_REAL3_2(unit,name,dat,dummy,attr,found,default,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_dat_interf, only: iotk_scan_dat_aux
  use iotk_scan_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  integer,                   intent(in)  :: unit
  character(*),              intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL (kind=__IOTK_REAL3)                        :: dat (:,:)
#else
  REAL (kind=__IOTK_REAL3),           intent(out) :: dat (:,:)
#endif
  type(iotk_dummytype), optional         :: dummy
#ifdef __IOTK_WORKAROUND6
  character(len=*),optional              :: attr
#else
  character(len=*),optional, intent(out) :: attr
#endif
  logical,         optional, intent(out) :: found
  REAL (kind=__IOTK_REAL3), optional, intent(in)  :: default (:,:)
  integer,         optional, intent(out) :: ierr
# 574 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL3),              allocatable :: tmpdat(:)
# 576 "iotk_dat.spp"
  integer :: ierrl,ierrl2
  integer :: rkind,rsize,rlen
  character(iotk_vallenx) :: rtype
  character(iotk_vallenx) :: fmt
  character(iotk_attlenx) :: lattr
  logical :: inside,foundl
  inside = .false.
  ierrl = 0
  ierrl2 = 0
  foundl=.false.
  call iotk_scan_begin(unit,name,lattr,found=foundl,ierr=ierrl)
  if(.not. foundl) goto 1
  foundl = .true.
  inside = .true.
  if(present(attr)) call iotk_strcpy(attr,lattr,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 592 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_parse_dat(lattr,rtype,rkind,rsize,rlen,fmt,ierrl)
  if(ierrl/=0) goto 1
  if(.not. (iotk_strcomp(rtype,iotk_eos) .or. iotk_strcomp(rtype,"REAL") ) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,' ')
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"rtype",rtype(1:iotk_strlen(rtype)))
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"type","REAL")
    goto 1
  end if
  if(.not. (rsize==-1 .or. rsize==size(dat)) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 602 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(rkind==-1) rkind = kind(dat)
# 609 "iotk_dat.spp"

  allocate(tmpdat(size(dat)))
  call iotk_scan_dat_aux(unit,tmpdat,rkind,rlen,fmt(1:iotk_strlen(fmt)),ierrl)
# 615 "iotk_dat.spp"
        dat = reshape(tmpdat,shape(dat))
# 617 "iotk_dat.spp"
  deallocate(tmpdat)
1 continue
  if(inside) then
    call iotk_scan_end(unit,name,ierr=ierrl2)
    if(ierrl2/=0) then
      call iotk_error_clear(ierrl)
      ierrl=ierrl2
    end if
  end if
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Dat not found')
# 629 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if 
  if(present(default) .and. .not. foundl) then
    dat=default
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl>0 .or. (.not.present(found) .and. .not.present(default))) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_dat_REAL3_2


#endif
#endif

subroutine iotk_dat_dummy_REAL3_2
  write(0,*)
end subroutine iotk_dat_dummy_REAL3_2

# 45 "iotk_dat.spp"

# 47 "iotk_dat.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_dat.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_dat.spp"

# 59 "iotk_dat.spp"

#ifdef __IOTK_REAL3
#if 3 <= __IOTK_MAXRANK
# 63 "iotk_dat.spp"
subroutine iotk_write_dat_REAL3_3(unit,name,dat,dummy,attr,fmt,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_write_attr
  use iotk_write_interf
  use iotk_fmt_interf
  use iotk_str_interf
  use iotk_unit_interf
  use iotk_misc_interf
  implicit none
  integer,                intent(in)  :: unit
  character(*),           intent(in)  :: name
  REAL (kind=__IOTK_REAL3), intent(in)  :: dat (:,:,:) 
  type(iotk_dummytype), optional      :: dummy
  character(len=*), optional, intent(in)  :: attr
  character(len=*), optional, intent(in)  :: fmt
  integer,      optional, intent(out) :: ierr
  integer :: ierrl,lunit,iostat
  logical :: binary,raw
  integer(iotk_header_kind), parameter :: idummy=0
  character(300) :: usefmt,usefmt1
  character(iotk_attlenx) :: lattr
  character(iotk_attlenx) :: attr_tmp
  type (iotk_unit), pointer :: this
# 91 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL3),allocatable :: dattmp(:)
# 93 "iotk_dat.spp"
  integer :: itmp
  ierrl = 0
  iostat = 0
  lunit = iotk_phys_unit(unit)
  call iotk_unit_get(lunit,pointer=this)
  raw = .false.
  if(associated(this)) then
    raw = this%raw
  end if
  call iotk_inquire(lunit,binary=binary,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 104 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_strcpy(usefmt,"!",ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 109 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(fmt) .and. .not. raw) call iotk_strcpy(usefmt,iotk_strtrim(fmt),ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 114 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(iotk_strscan(usefmt,"<>&")/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Special characters (<>&) found in fmt string')
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"unit",unit)
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",trim(name))
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"fmt",trim(fmt))
    goto 1
  end if
  call iotk_write_attr(lattr,"type",iotk_tolower("REAL"),first=.true.,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 123 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_attr(lattr,"size",size(dat),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 128 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
# 138 "iotk_dat.spp"
  if(binary) then
    call iotk_write_attr(lattr,"kind",kind(dat),ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 141 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
  end if
# 146 "iotk_dat.spp"
  if(.not.iotk_strcomp(usefmt,"!")) call iotk_write_attr(lattr,"fmt",iotk_strtrim(usefmt),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 148 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(attr)) then
    attr_tmp(1:1)=iotk_eos
    call iotk_strcpy(attr_tmp,attr,ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 155 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"type",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 160 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"kind",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 165 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"size",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 170 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"fmt",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 175 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"len",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 180 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    if(iotk_strlen_trim(attr_tmp)>0) call iotk_strcat(lattr,iotk_strtrim(attr_tmp),ierr=ierrl)
  end if
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 186 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_begin(unit,name,lattr,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 191 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if

  allocate(dattmp(size(dat)))
# 199 "iotk_dat.spp"
#if defined(__IOTK_WORKAROUND3) || defined(__IOTK_WORKAROUND4)
# 203 "iotk_dat.spp"
     call iotk_private_pack_REAL3(dattmp,dat,size(dattmp),1)
# 205 "iotk_dat.spp"
#else
     dattmp = pack(dat,mask=.true.)
#endif
# 209 "iotk_dat.spp"

  if(binary) then
    if(raw) then
      write(lunit,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 214 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else
      write(lunit,iostat=iostat) idummy,(dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 220 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  else
    if(raw) then
# 229 "iotk_dat.spp"
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
# 231 "iotk_dat.spp"
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 232 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"*")) then
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 238 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"!")) then
# 252 "iotk_dat.spp"
     write(lunit,fmt=trim(iotk_wfmt("REAL",kind(dattmp),1,-1)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
     if(iostat/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 254 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
     end if
# 258 "iotk_dat.spp"
    else
      write(lunit,fmt=usefmt(1:iotk_strlen(usefmt)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 261 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  end if
  call iotk_write_end(unit,name,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 268 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
1 continue
  if(allocated(dattmp)) deallocate(dattmp)
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_dat_REAL3_3


# 545 "iotk_dat.spp"

# 547 "iotk_dat.spp"
subroutine iotk_scan_dat_REAL3_3(unit,name,dat,dummy,attr,found,default,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_dat_interf, only: iotk_scan_dat_aux
  use iotk_scan_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  integer,                   intent(in)  :: unit
  character(*),              intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL (kind=__IOTK_REAL3)                        :: dat (:,:,:)
#else
  REAL (kind=__IOTK_REAL3),           intent(out) :: dat (:,:,:)
#endif
  type(iotk_dummytype), optional         :: dummy
#ifdef __IOTK_WORKAROUND6
  character(len=*),optional              :: attr
#else
  character(len=*),optional, intent(out) :: attr
#endif
  logical,         optional, intent(out) :: found
  REAL (kind=__IOTK_REAL3), optional, intent(in)  :: default (:,:,:)
  integer,         optional, intent(out) :: ierr
# 574 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL3),              allocatable :: tmpdat(:)
# 576 "iotk_dat.spp"
  integer :: ierrl,ierrl2
  integer :: rkind,rsize,rlen
  character(iotk_vallenx) :: rtype
  character(iotk_vallenx) :: fmt
  character(iotk_attlenx) :: lattr
  logical :: inside,foundl
  inside = .false.
  ierrl = 0
  ierrl2 = 0
  foundl=.false.
  call iotk_scan_begin(unit,name,lattr,found=foundl,ierr=ierrl)
  if(.not. foundl) goto 1
  foundl = .true.
  inside = .true.
  if(present(attr)) call iotk_strcpy(attr,lattr,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 592 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_parse_dat(lattr,rtype,rkind,rsize,rlen,fmt,ierrl)
  if(ierrl/=0) goto 1
  if(.not. (iotk_strcomp(rtype,iotk_eos) .or. iotk_strcomp(rtype,"REAL") ) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,' ')
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"rtype",rtype(1:iotk_strlen(rtype)))
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"type","REAL")
    goto 1
  end if
  if(.not. (rsize==-1 .or. rsize==size(dat)) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 602 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(rkind==-1) rkind = kind(dat)
# 609 "iotk_dat.spp"

  allocate(tmpdat(size(dat)))
  call iotk_scan_dat_aux(unit,tmpdat,rkind,rlen,fmt(1:iotk_strlen(fmt)),ierrl)
# 615 "iotk_dat.spp"
        dat = reshape(tmpdat,shape(dat))
# 617 "iotk_dat.spp"
  deallocate(tmpdat)
1 continue
  if(inside) then
    call iotk_scan_end(unit,name,ierr=ierrl2)
    if(ierrl2/=0) then
      call iotk_error_clear(ierrl)
      ierrl=ierrl2
    end if
  end if
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Dat not found')
# 629 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if 
  if(present(default) .and. .not. foundl) then
    dat=default
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl>0 .or. (.not.present(found) .and. .not.present(default))) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_dat_REAL3_3


#endif
#endif

subroutine iotk_dat_dummy_REAL3_3
  write(0,*)
end subroutine iotk_dat_dummy_REAL3_3

# 45 "iotk_dat.spp"

# 47 "iotk_dat.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_dat.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_dat.spp"

# 59 "iotk_dat.spp"

#ifdef __IOTK_REAL3
#if 4 <= __IOTK_MAXRANK
# 63 "iotk_dat.spp"
subroutine iotk_write_dat_REAL3_4(unit,name,dat,dummy,attr,fmt,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_write_attr
  use iotk_write_interf
  use iotk_fmt_interf
  use iotk_str_interf
  use iotk_unit_interf
  use iotk_misc_interf
  implicit none
  integer,                intent(in)  :: unit
  character(*),           intent(in)  :: name
  REAL (kind=__IOTK_REAL3), intent(in)  :: dat (:,:,:,:) 
  type(iotk_dummytype), optional      :: dummy
  character(len=*), optional, intent(in)  :: attr
  character(len=*), optional, intent(in)  :: fmt
  integer,      optional, intent(out) :: ierr
  integer :: ierrl,lunit,iostat
  logical :: binary,raw
  integer(iotk_header_kind), parameter :: idummy=0
  character(300) :: usefmt,usefmt1
  character(iotk_attlenx) :: lattr
  character(iotk_attlenx) :: attr_tmp
  type (iotk_unit), pointer :: this
# 91 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL3),allocatable :: dattmp(:)
# 93 "iotk_dat.spp"
  integer :: itmp
  ierrl = 0
  iostat = 0
  lunit = iotk_phys_unit(unit)
  call iotk_unit_get(lunit,pointer=this)
  raw = .false.
  if(associated(this)) then
    raw = this%raw
  end if
  call iotk_inquire(lunit,binary=binary,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 104 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_strcpy(usefmt,"!",ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 109 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(fmt) .and. .not. raw) call iotk_strcpy(usefmt,iotk_strtrim(fmt),ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 114 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(iotk_strscan(usefmt,"<>&")/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Special characters (<>&) found in fmt string')
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"unit",unit)
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",trim(name))
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"fmt",trim(fmt))
    goto 1
  end if
  call iotk_write_attr(lattr,"type",iotk_tolower("REAL"),first=.true.,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 123 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_attr(lattr,"size",size(dat),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 128 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
# 138 "iotk_dat.spp"
  if(binary) then
    call iotk_write_attr(lattr,"kind",kind(dat),ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 141 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
  end if
# 146 "iotk_dat.spp"
  if(.not.iotk_strcomp(usefmt,"!")) call iotk_write_attr(lattr,"fmt",iotk_strtrim(usefmt),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 148 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(attr)) then
    attr_tmp(1:1)=iotk_eos
    call iotk_strcpy(attr_tmp,attr,ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 155 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"type",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 160 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"kind",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 165 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"size",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 170 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"fmt",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 175 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"len",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 180 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    if(iotk_strlen_trim(attr_tmp)>0) call iotk_strcat(lattr,iotk_strtrim(attr_tmp),ierr=ierrl)
  end if
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 186 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_begin(unit,name,lattr,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 191 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if

  allocate(dattmp(size(dat)))
# 199 "iotk_dat.spp"
#if defined(__IOTK_WORKAROUND3) || defined(__IOTK_WORKAROUND4)
# 203 "iotk_dat.spp"
     call iotk_private_pack_REAL3(dattmp,dat,size(dattmp),1)
# 205 "iotk_dat.spp"
#else
     dattmp = pack(dat,mask=.true.)
#endif
# 209 "iotk_dat.spp"

  if(binary) then
    if(raw) then
      write(lunit,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 214 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else
      write(lunit,iostat=iostat) idummy,(dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 220 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  else
    if(raw) then
# 229 "iotk_dat.spp"
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
# 231 "iotk_dat.spp"
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 232 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"*")) then
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 238 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"!")) then
# 252 "iotk_dat.spp"
     write(lunit,fmt=trim(iotk_wfmt("REAL",kind(dattmp),1,-1)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
     if(iostat/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 254 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
     end if
# 258 "iotk_dat.spp"
    else
      write(lunit,fmt=usefmt(1:iotk_strlen(usefmt)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 261 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  end if
  call iotk_write_end(unit,name,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 268 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
1 continue
  if(allocated(dattmp)) deallocate(dattmp)
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_dat_REAL3_4


# 545 "iotk_dat.spp"

# 547 "iotk_dat.spp"
subroutine iotk_scan_dat_REAL3_4(unit,name,dat,dummy,attr,found,default,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_dat_interf, only: iotk_scan_dat_aux
  use iotk_scan_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  integer,                   intent(in)  :: unit
  character(*),              intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL (kind=__IOTK_REAL3)                        :: dat (:,:,:,:)
#else
  REAL (kind=__IOTK_REAL3),           intent(out) :: dat (:,:,:,:)
#endif
  type(iotk_dummytype), optional         :: dummy
#ifdef __IOTK_WORKAROUND6
  character(len=*),optional              :: attr
#else
  character(len=*),optional, intent(out) :: attr
#endif
  logical,         optional, intent(out) :: found
  REAL (kind=__IOTK_REAL3), optional, intent(in)  :: default (:,:,:,:)
  integer,         optional, intent(out) :: ierr
# 574 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL3),              allocatable :: tmpdat(:)
# 576 "iotk_dat.spp"
  integer :: ierrl,ierrl2
  integer :: rkind,rsize,rlen
  character(iotk_vallenx) :: rtype
  character(iotk_vallenx) :: fmt
  character(iotk_attlenx) :: lattr
  logical :: inside,foundl
  inside = .false.
  ierrl = 0
  ierrl2 = 0
  foundl=.false.
  call iotk_scan_begin(unit,name,lattr,found=foundl,ierr=ierrl)
  if(.not. foundl) goto 1
  foundl = .true.
  inside = .true.
  if(present(attr)) call iotk_strcpy(attr,lattr,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 592 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_parse_dat(lattr,rtype,rkind,rsize,rlen,fmt,ierrl)
  if(ierrl/=0) goto 1
  if(.not. (iotk_strcomp(rtype,iotk_eos) .or. iotk_strcomp(rtype,"REAL") ) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,' ')
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"rtype",rtype(1:iotk_strlen(rtype)))
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"type","REAL")
    goto 1
  end if
  if(.not. (rsize==-1 .or. rsize==size(dat)) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 602 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(rkind==-1) rkind = kind(dat)
# 609 "iotk_dat.spp"

  allocate(tmpdat(size(dat)))
  call iotk_scan_dat_aux(unit,tmpdat,rkind,rlen,fmt(1:iotk_strlen(fmt)),ierrl)
# 615 "iotk_dat.spp"
        dat = reshape(tmpdat,shape(dat))
# 617 "iotk_dat.spp"
  deallocate(tmpdat)
1 continue
  if(inside) then
    call iotk_scan_end(unit,name,ierr=ierrl2)
    if(ierrl2/=0) then
      call iotk_error_clear(ierrl)
      ierrl=ierrl2
    end if
  end if
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Dat not found')
# 629 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if 
  if(present(default) .and. .not. foundl) then
    dat=default
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl>0 .or. (.not.present(found) .and. .not.present(default))) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_dat_REAL3_4


#endif
#endif

subroutine iotk_dat_dummy_REAL3_4
  write(0,*)
end subroutine iotk_dat_dummy_REAL3_4

# 45 "iotk_dat.spp"

# 47 "iotk_dat.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_dat.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_dat.spp"

# 59 "iotk_dat.spp"

#ifdef __IOTK_REAL3
#if 5 <= __IOTK_MAXRANK
# 63 "iotk_dat.spp"
subroutine iotk_write_dat_REAL3_5(unit,name,dat,dummy,attr,fmt,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_write_attr
  use iotk_write_interf
  use iotk_fmt_interf
  use iotk_str_interf
  use iotk_unit_interf
  use iotk_misc_interf
  implicit none
  integer,                intent(in)  :: unit
  character(*),           intent(in)  :: name
  REAL (kind=__IOTK_REAL3), intent(in)  :: dat (:,:,:,:,:) 
  type(iotk_dummytype), optional      :: dummy
  character(len=*), optional, intent(in)  :: attr
  character(len=*), optional, intent(in)  :: fmt
  integer,      optional, intent(out) :: ierr
  integer :: ierrl,lunit,iostat
  logical :: binary,raw
  integer(iotk_header_kind), parameter :: idummy=0
  character(300) :: usefmt,usefmt1
  character(iotk_attlenx) :: lattr
  character(iotk_attlenx) :: attr_tmp
  type (iotk_unit), pointer :: this
# 91 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL3),allocatable :: dattmp(:)
# 93 "iotk_dat.spp"
  integer :: itmp
  ierrl = 0
  iostat = 0
  lunit = iotk_phys_unit(unit)
  call iotk_unit_get(lunit,pointer=this)
  raw = .false.
  if(associated(this)) then
    raw = this%raw
  end if
  call iotk_inquire(lunit,binary=binary,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 104 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_strcpy(usefmt,"!",ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 109 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(fmt) .and. .not. raw) call iotk_strcpy(usefmt,iotk_strtrim(fmt),ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 114 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(iotk_strscan(usefmt,"<>&")/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Special characters (<>&) found in fmt string')
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"unit",unit)
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",trim(name))
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"fmt",trim(fmt))
    goto 1
  end if
  call iotk_write_attr(lattr,"type",iotk_tolower("REAL"),first=.true.,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 123 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_attr(lattr,"size",size(dat),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 128 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
# 138 "iotk_dat.spp"
  if(binary) then
    call iotk_write_attr(lattr,"kind",kind(dat),ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 141 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
  end if
# 146 "iotk_dat.spp"
  if(.not.iotk_strcomp(usefmt,"!")) call iotk_write_attr(lattr,"fmt",iotk_strtrim(usefmt),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 148 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(attr)) then
    attr_tmp(1:1)=iotk_eos
    call iotk_strcpy(attr_tmp,attr,ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 155 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"type",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 160 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"kind",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 165 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"size",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 170 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"fmt",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 175 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"len",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 180 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    if(iotk_strlen_trim(attr_tmp)>0) call iotk_strcat(lattr,iotk_strtrim(attr_tmp),ierr=ierrl)
  end if
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 186 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_begin(unit,name,lattr,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 191 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if

  allocate(dattmp(size(dat)))
# 199 "iotk_dat.spp"
#if defined(__IOTK_WORKAROUND3) || defined(__IOTK_WORKAROUND4)
# 203 "iotk_dat.spp"
     call iotk_private_pack_REAL3(dattmp,dat,size(dattmp),1)
# 205 "iotk_dat.spp"
#else
     dattmp = pack(dat,mask=.true.)
#endif
# 209 "iotk_dat.spp"

  if(binary) then
    if(raw) then
      write(lunit,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 214 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else
      write(lunit,iostat=iostat) idummy,(dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 220 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  else
    if(raw) then
# 229 "iotk_dat.spp"
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
# 231 "iotk_dat.spp"
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 232 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"*")) then
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 238 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"!")) then
# 252 "iotk_dat.spp"
     write(lunit,fmt=trim(iotk_wfmt("REAL",kind(dattmp),1,-1)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
     if(iostat/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 254 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
     end if
# 258 "iotk_dat.spp"
    else
      write(lunit,fmt=usefmt(1:iotk_strlen(usefmt)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 261 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  end if
  call iotk_write_end(unit,name,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 268 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
1 continue
  if(allocated(dattmp)) deallocate(dattmp)
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_dat_REAL3_5


# 545 "iotk_dat.spp"

# 547 "iotk_dat.spp"
subroutine iotk_scan_dat_REAL3_5(unit,name,dat,dummy,attr,found,default,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_dat_interf, only: iotk_scan_dat_aux
  use iotk_scan_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  integer,                   intent(in)  :: unit
  character(*),              intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL (kind=__IOTK_REAL3)                        :: dat (:,:,:,:,:)
#else
  REAL (kind=__IOTK_REAL3),           intent(out) :: dat (:,:,:,:,:)
#endif
  type(iotk_dummytype), optional         :: dummy
#ifdef __IOTK_WORKAROUND6
  character(len=*),optional              :: attr
#else
  character(len=*),optional, intent(out) :: attr
#endif
  logical,         optional, intent(out) :: found
  REAL (kind=__IOTK_REAL3), optional, intent(in)  :: default (:,:,:,:,:)
  integer,         optional, intent(out) :: ierr
# 574 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL3),              allocatable :: tmpdat(:)
# 576 "iotk_dat.spp"
  integer :: ierrl,ierrl2
  integer :: rkind,rsize,rlen
  character(iotk_vallenx) :: rtype
  character(iotk_vallenx) :: fmt
  character(iotk_attlenx) :: lattr
  logical :: inside,foundl
  inside = .false.
  ierrl = 0
  ierrl2 = 0
  foundl=.false.
  call iotk_scan_begin(unit,name,lattr,found=foundl,ierr=ierrl)
  if(.not. foundl) goto 1
  foundl = .true.
  inside = .true.
  if(present(attr)) call iotk_strcpy(attr,lattr,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 592 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_parse_dat(lattr,rtype,rkind,rsize,rlen,fmt,ierrl)
  if(ierrl/=0) goto 1
  if(.not. (iotk_strcomp(rtype,iotk_eos) .or. iotk_strcomp(rtype,"REAL") ) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,' ')
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"rtype",rtype(1:iotk_strlen(rtype)))
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"type","REAL")
    goto 1
  end if
  if(.not. (rsize==-1 .or. rsize==size(dat)) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 602 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(rkind==-1) rkind = kind(dat)
# 609 "iotk_dat.spp"

  allocate(tmpdat(size(dat)))
  call iotk_scan_dat_aux(unit,tmpdat,rkind,rlen,fmt(1:iotk_strlen(fmt)),ierrl)
# 615 "iotk_dat.spp"
        dat = reshape(tmpdat,shape(dat))
# 617 "iotk_dat.spp"
  deallocate(tmpdat)
1 continue
  if(inside) then
    call iotk_scan_end(unit,name,ierr=ierrl2)
    if(ierrl2/=0) then
      call iotk_error_clear(ierrl)
      ierrl=ierrl2
    end if
  end if
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Dat not found')
# 629 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if 
  if(present(default) .and. .not. foundl) then
    dat=default
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl>0 .or. (.not.present(found) .and. .not.present(default))) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_dat_REAL3_5


#endif
#endif

subroutine iotk_dat_dummy_REAL3_5
  write(0,*)
end subroutine iotk_dat_dummy_REAL3_5

# 45 "iotk_dat.spp"

# 47 "iotk_dat.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_dat.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_dat.spp"

# 59 "iotk_dat.spp"

#ifdef __IOTK_REAL3
#if 6 <= __IOTK_MAXRANK
# 63 "iotk_dat.spp"
subroutine iotk_write_dat_REAL3_6(unit,name,dat,dummy,attr,fmt,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_write_attr
  use iotk_write_interf
  use iotk_fmt_interf
  use iotk_str_interf
  use iotk_unit_interf
  use iotk_misc_interf
  implicit none
  integer,                intent(in)  :: unit
  character(*),           intent(in)  :: name
  REAL (kind=__IOTK_REAL3), intent(in)  :: dat (:,:,:,:,:,:) 
  type(iotk_dummytype), optional      :: dummy
  character(len=*), optional, intent(in)  :: attr
  character(len=*), optional, intent(in)  :: fmt
  integer,      optional, intent(out) :: ierr
  integer :: ierrl,lunit,iostat
  logical :: binary,raw
  integer(iotk_header_kind), parameter :: idummy=0
  character(300) :: usefmt,usefmt1
  character(iotk_attlenx) :: lattr
  character(iotk_attlenx) :: attr_tmp
  type (iotk_unit), pointer :: this
# 91 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL3),allocatable :: dattmp(:)
# 93 "iotk_dat.spp"
  integer :: itmp
  ierrl = 0
  iostat = 0
  lunit = iotk_phys_unit(unit)
  call iotk_unit_get(lunit,pointer=this)
  raw = .false.
  if(associated(this)) then
    raw = this%raw
  end if
  call iotk_inquire(lunit,binary=binary,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 104 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_strcpy(usefmt,"!",ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 109 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(fmt) .and. .not. raw) call iotk_strcpy(usefmt,iotk_strtrim(fmt),ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 114 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(iotk_strscan(usefmt,"<>&")/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Special characters (<>&) found in fmt string')
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"unit",unit)
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",trim(name))
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"fmt",trim(fmt))
    goto 1
  end if
  call iotk_write_attr(lattr,"type",iotk_tolower("REAL"),first=.true.,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 123 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_attr(lattr,"size",size(dat),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 128 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
# 138 "iotk_dat.spp"
  if(binary) then
    call iotk_write_attr(lattr,"kind",kind(dat),ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 141 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
  end if
# 146 "iotk_dat.spp"
  if(.not.iotk_strcomp(usefmt,"!")) call iotk_write_attr(lattr,"fmt",iotk_strtrim(usefmt),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 148 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(attr)) then
    attr_tmp(1:1)=iotk_eos
    call iotk_strcpy(attr_tmp,attr,ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 155 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"type",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 160 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"kind",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 165 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"size",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 170 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"fmt",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 175 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"len",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 180 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    if(iotk_strlen_trim(attr_tmp)>0) call iotk_strcat(lattr,iotk_strtrim(attr_tmp),ierr=ierrl)
  end if
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 186 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_begin(unit,name,lattr,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 191 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if

  allocate(dattmp(size(dat)))
# 199 "iotk_dat.spp"
#if defined(__IOTK_WORKAROUND3) || defined(__IOTK_WORKAROUND4)
# 203 "iotk_dat.spp"
     call iotk_private_pack_REAL3(dattmp,dat,size(dattmp),1)
# 205 "iotk_dat.spp"
#else
     dattmp = pack(dat,mask=.true.)
#endif
# 209 "iotk_dat.spp"

  if(binary) then
    if(raw) then
      write(lunit,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 214 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else
      write(lunit,iostat=iostat) idummy,(dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 220 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  else
    if(raw) then
# 229 "iotk_dat.spp"
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
# 231 "iotk_dat.spp"
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 232 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"*")) then
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 238 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"!")) then
# 252 "iotk_dat.spp"
     write(lunit,fmt=trim(iotk_wfmt("REAL",kind(dattmp),1,-1)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
     if(iostat/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 254 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
     end if
# 258 "iotk_dat.spp"
    else
      write(lunit,fmt=usefmt(1:iotk_strlen(usefmt)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 261 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  end if
  call iotk_write_end(unit,name,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 268 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
1 continue
  if(allocated(dattmp)) deallocate(dattmp)
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_dat_REAL3_6


# 545 "iotk_dat.spp"

# 547 "iotk_dat.spp"
subroutine iotk_scan_dat_REAL3_6(unit,name,dat,dummy,attr,found,default,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_dat_interf, only: iotk_scan_dat_aux
  use iotk_scan_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  integer,                   intent(in)  :: unit
  character(*),              intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL (kind=__IOTK_REAL3)                        :: dat (:,:,:,:,:,:)
#else
  REAL (kind=__IOTK_REAL3),           intent(out) :: dat (:,:,:,:,:,:)
#endif
  type(iotk_dummytype), optional         :: dummy
#ifdef __IOTK_WORKAROUND6
  character(len=*),optional              :: attr
#else
  character(len=*),optional, intent(out) :: attr
#endif
  logical,         optional, intent(out) :: found
  REAL (kind=__IOTK_REAL3), optional, intent(in)  :: default (:,:,:,:,:,:)
  integer,         optional, intent(out) :: ierr
# 574 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL3),              allocatable :: tmpdat(:)
# 576 "iotk_dat.spp"
  integer :: ierrl,ierrl2
  integer :: rkind,rsize,rlen
  character(iotk_vallenx) :: rtype
  character(iotk_vallenx) :: fmt
  character(iotk_attlenx) :: lattr
  logical :: inside,foundl
  inside = .false.
  ierrl = 0
  ierrl2 = 0
  foundl=.false.
  call iotk_scan_begin(unit,name,lattr,found=foundl,ierr=ierrl)
  if(.not. foundl) goto 1
  foundl = .true.
  inside = .true.
  if(present(attr)) call iotk_strcpy(attr,lattr,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 592 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_parse_dat(lattr,rtype,rkind,rsize,rlen,fmt,ierrl)
  if(ierrl/=0) goto 1
  if(.not. (iotk_strcomp(rtype,iotk_eos) .or. iotk_strcomp(rtype,"REAL") ) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,' ')
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"rtype",rtype(1:iotk_strlen(rtype)))
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"type","REAL")
    goto 1
  end if
  if(.not. (rsize==-1 .or. rsize==size(dat)) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 602 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(rkind==-1) rkind = kind(dat)
# 609 "iotk_dat.spp"

  allocate(tmpdat(size(dat)))
  call iotk_scan_dat_aux(unit,tmpdat,rkind,rlen,fmt(1:iotk_strlen(fmt)),ierrl)
# 615 "iotk_dat.spp"
        dat = reshape(tmpdat,shape(dat))
# 617 "iotk_dat.spp"
  deallocate(tmpdat)
1 continue
  if(inside) then
    call iotk_scan_end(unit,name,ierr=ierrl2)
    if(ierrl2/=0) then
      call iotk_error_clear(ierrl)
      ierrl=ierrl2
    end if
  end if
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Dat not found')
# 629 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if 
  if(present(default) .and. .not. foundl) then
    dat=default
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl>0 .or. (.not.present(found) .and. .not.present(default))) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_dat_REAL3_6


#endif
#endif

subroutine iotk_dat_dummy_REAL3_6
  write(0,*)
end subroutine iotk_dat_dummy_REAL3_6

# 45 "iotk_dat.spp"

# 47 "iotk_dat.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_dat.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_dat.spp"

# 59 "iotk_dat.spp"

#ifdef __IOTK_REAL3
#if 7 <= __IOTK_MAXRANK
# 63 "iotk_dat.spp"
subroutine iotk_write_dat_REAL3_7(unit,name,dat,dummy,attr,fmt,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_write_attr
  use iotk_write_interf
  use iotk_fmt_interf
  use iotk_str_interf
  use iotk_unit_interf
  use iotk_misc_interf
  implicit none
  integer,                intent(in)  :: unit
  character(*),           intent(in)  :: name
  REAL (kind=__IOTK_REAL3), intent(in)  :: dat (:,:,:,:,:,:,:) 
  type(iotk_dummytype), optional      :: dummy
  character(len=*), optional, intent(in)  :: attr
  character(len=*), optional, intent(in)  :: fmt
  integer,      optional, intent(out) :: ierr
  integer :: ierrl,lunit,iostat
  logical :: binary,raw
  integer(iotk_header_kind), parameter :: idummy=0
  character(300) :: usefmt,usefmt1
  character(iotk_attlenx) :: lattr
  character(iotk_attlenx) :: attr_tmp
  type (iotk_unit), pointer :: this
# 91 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL3),allocatable :: dattmp(:)
# 93 "iotk_dat.spp"
  integer :: itmp
  ierrl = 0
  iostat = 0
  lunit = iotk_phys_unit(unit)
  call iotk_unit_get(lunit,pointer=this)
  raw = .false.
  if(associated(this)) then
    raw = this%raw
  end if
  call iotk_inquire(lunit,binary=binary,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 104 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_strcpy(usefmt,"!",ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 109 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(fmt) .and. .not. raw) call iotk_strcpy(usefmt,iotk_strtrim(fmt),ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 114 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(iotk_strscan(usefmt,"<>&")/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Special characters (<>&) found in fmt string')
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"unit",unit)
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",trim(name))
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"fmt",trim(fmt))
    goto 1
  end if
  call iotk_write_attr(lattr,"type",iotk_tolower("REAL"),first=.true.,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 123 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_attr(lattr,"size",size(dat),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 128 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
# 138 "iotk_dat.spp"
  if(binary) then
    call iotk_write_attr(lattr,"kind",kind(dat),ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 141 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
  end if
# 146 "iotk_dat.spp"
  if(.not.iotk_strcomp(usefmt,"!")) call iotk_write_attr(lattr,"fmt",iotk_strtrim(usefmt),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 148 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(attr)) then
    attr_tmp(1:1)=iotk_eos
    call iotk_strcpy(attr_tmp,attr,ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 155 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"type",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 160 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"kind",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 165 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"size",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 170 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"fmt",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 175 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"len",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 180 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    if(iotk_strlen_trim(attr_tmp)>0) call iotk_strcat(lattr,iotk_strtrim(attr_tmp),ierr=ierrl)
  end if
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 186 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_begin(unit,name,lattr,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 191 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if

  allocate(dattmp(size(dat)))
# 199 "iotk_dat.spp"
#if defined(__IOTK_WORKAROUND3) || defined(__IOTK_WORKAROUND4)
# 203 "iotk_dat.spp"
     call iotk_private_pack_REAL3(dattmp,dat,size(dattmp),1)
# 205 "iotk_dat.spp"
#else
     dattmp = pack(dat,mask=.true.)
#endif
# 209 "iotk_dat.spp"

  if(binary) then
    if(raw) then
      write(lunit,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 214 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else
      write(lunit,iostat=iostat) idummy,(dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 220 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  else
    if(raw) then
# 229 "iotk_dat.spp"
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
# 231 "iotk_dat.spp"
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 232 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"*")) then
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 238 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"!")) then
# 252 "iotk_dat.spp"
     write(lunit,fmt=trim(iotk_wfmt("REAL",kind(dattmp),1,-1)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
     if(iostat/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 254 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
     end if
# 258 "iotk_dat.spp"
    else
      write(lunit,fmt=usefmt(1:iotk_strlen(usefmt)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 261 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  end if
  call iotk_write_end(unit,name,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 268 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
1 continue
  if(allocated(dattmp)) deallocate(dattmp)
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_dat_REAL3_7


# 545 "iotk_dat.spp"

# 547 "iotk_dat.spp"
subroutine iotk_scan_dat_REAL3_7(unit,name,dat,dummy,attr,found,default,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_dat_interf, only: iotk_scan_dat_aux
  use iotk_scan_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  integer,                   intent(in)  :: unit
  character(*),              intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL (kind=__IOTK_REAL3)                        :: dat (:,:,:,:,:,:,:)
#else
  REAL (kind=__IOTK_REAL3),           intent(out) :: dat (:,:,:,:,:,:,:)
#endif
  type(iotk_dummytype), optional         :: dummy
#ifdef __IOTK_WORKAROUND6
  character(len=*),optional              :: attr
#else
  character(len=*),optional, intent(out) :: attr
#endif
  logical,         optional, intent(out) :: found
  REAL (kind=__IOTK_REAL3), optional, intent(in)  :: default (:,:,:,:,:,:,:)
  integer,         optional, intent(out) :: ierr
# 574 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL3),              allocatable :: tmpdat(:)
# 576 "iotk_dat.spp"
  integer :: ierrl,ierrl2
  integer :: rkind,rsize,rlen
  character(iotk_vallenx) :: rtype
  character(iotk_vallenx) :: fmt
  character(iotk_attlenx) :: lattr
  logical :: inside,foundl
  inside = .false.
  ierrl = 0
  ierrl2 = 0
  foundl=.false.
  call iotk_scan_begin(unit,name,lattr,found=foundl,ierr=ierrl)
  if(.not. foundl) goto 1
  foundl = .true.
  inside = .true.
  if(present(attr)) call iotk_strcpy(attr,lattr,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 592 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_parse_dat(lattr,rtype,rkind,rsize,rlen,fmt,ierrl)
  if(ierrl/=0) goto 1
  if(.not. (iotk_strcomp(rtype,iotk_eos) .or. iotk_strcomp(rtype,"REAL") ) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,' ')
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"rtype",rtype(1:iotk_strlen(rtype)))
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"type","REAL")
    goto 1
  end if
  if(.not. (rsize==-1 .or. rsize==size(dat)) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 602 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(rkind==-1) rkind = kind(dat)
# 609 "iotk_dat.spp"

  allocate(tmpdat(size(dat)))
  call iotk_scan_dat_aux(unit,tmpdat,rkind,rlen,fmt(1:iotk_strlen(fmt)),ierrl)
# 615 "iotk_dat.spp"
        dat = reshape(tmpdat,shape(dat))
# 617 "iotk_dat.spp"
  deallocate(tmpdat)
1 continue
  if(inside) then
    call iotk_scan_end(unit,name,ierr=ierrl2)
    if(ierrl2/=0) then
      call iotk_error_clear(ierrl)
      ierrl=ierrl2
    end if
  end if
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Dat not found')
# 629 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if 
  if(present(default) .and. .not. foundl) then
    dat=default
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl>0 .or. (.not.present(found) .and. .not.present(default))) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_dat_REAL3_7


#endif
#endif

subroutine iotk_dat_dummy_REAL3_7
  write(0,*)
end subroutine iotk_dat_dummy_REAL3_7

# 45 "iotk_dat.spp"

# 47 "iotk_dat.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_dat.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_dat.spp"

# 59 "iotk_dat.spp"

#ifdef __IOTK_REAL4
#if 0 <= __IOTK_MAXRANK
# 63 "iotk_dat.spp"
subroutine iotk_write_dat_REAL4_0(unit,name,dat,dummy,attr,fmt,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_write_attr
  use iotk_write_interf
  use iotk_fmt_interf
  use iotk_str_interf
  use iotk_unit_interf
  use iotk_misc_interf
  implicit none
  integer,                intent(in)  :: unit
  character(*),           intent(in)  :: name
  REAL (kind=__IOTK_REAL4), intent(in)  :: dat  
  type(iotk_dummytype), optional      :: dummy
  character(len=*), optional, intent(in)  :: attr
  character(len=*), optional, intent(in)  :: fmt
  integer,      optional, intent(out) :: ierr
  integer :: ierrl,lunit,iostat
  logical :: binary,raw
  integer(iotk_header_kind), parameter :: idummy=0
  character(300) :: usefmt,usefmt1
  character(iotk_attlenx) :: lattr
  character(iotk_attlenx) :: attr_tmp
  type (iotk_unit), pointer :: this
# 91 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL4),allocatable :: dattmp(:)
# 93 "iotk_dat.spp"
  integer :: itmp
  ierrl = 0
  iostat = 0
  lunit = iotk_phys_unit(unit)
  call iotk_unit_get(lunit,pointer=this)
  raw = .false.
  if(associated(this)) then
    raw = this%raw
  end if
  call iotk_inquire(lunit,binary=binary,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 104 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_strcpy(usefmt,"!",ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 109 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(fmt) .and. .not. raw) call iotk_strcpy(usefmt,iotk_strtrim(fmt),ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 114 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(iotk_strscan(usefmt,"<>&")/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Special characters (<>&) found in fmt string')
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"unit",unit)
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",trim(name))
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"fmt",trim(fmt))
    goto 1
  end if
  call iotk_write_attr(lattr,"type",iotk_tolower("REAL"),first=.true.,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 123 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_attr(lattr,"size",1,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 128 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
# 138 "iotk_dat.spp"
  if(binary) then
    call iotk_write_attr(lattr,"kind",kind(dat),ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 141 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
  end if
# 146 "iotk_dat.spp"
  if(.not.iotk_strcomp(usefmt,"!")) call iotk_write_attr(lattr,"fmt",iotk_strtrim(usefmt),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 148 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(attr)) then
    attr_tmp(1:1)=iotk_eos
    call iotk_strcpy(attr_tmp,attr,ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 155 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"type",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 160 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"kind",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 165 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"size",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 170 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"fmt",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 175 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"len",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 180 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    if(iotk_strlen_trim(attr_tmp)>0) call iotk_strcat(lattr,iotk_strtrim(attr_tmp),ierr=ierrl)
  end if
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 186 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_begin(unit,name,lattr,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 191 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if

  allocate(dattmp(1))
# 197 "iotk_dat.spp"
     dattmp(1) = dat
# 209 "iotk_dat.spp"

  if(binary) then
    if(raw) then
      write(lunit,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 214 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else
      write(lunit,iostat=iostat) idummy,(dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 220 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  else
    if(raw) then
# 229 "iotk_dat.spp"
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
# 231 "iotk_dat.spp"
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 232 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"*")) then
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 238 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"!")) then
# 252 "iotk_dat.spp"
     write(lunit,fmt=trim(iotk_wfmt("REAL",kind(dattmp),1,-1)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
     if(iostat/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 254 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
     end if
# 258 "iotk_dat.spp"
    else
      write(lunit,fmt=usefmt(1:iotk_strlen(usefmt)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 261 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  end if
  call iotk_write_end(unit,name,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 268 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
1 continue
  if(allocated(dattmp)) deallocate(dattmp)
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_dat_REAL4_0


# 545 "iotk_dat.spp"

# 547 "iotk_dat.spp"
subroutine iotk_scan_dat_REAL4_0(unit,name,dat,dummy,attr,found,default,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_dat_interf, only: iotk_scan_dat_aux
  use iotk_scan_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  integer,                   intent(in)  :: unit
  character(*),              intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL (kind=__IOTK_REAL4)                        :: dat 
#else
  REAL (kind=__IOTK_REAL4),           intent(out) :: dat 
#endif
  type(iotk_dummytype), optional         :: dummy
#ifdef __IOTK_WORKAROUND6
  character(len=*),optional              :: attr
#else
  character(len=*),optional, intent(out) :: attr
#endif
  logical,         optional, intent(out) :: found
  REAL (kind=__IOTK_REAL4), optional, intent(in)  :: default 
  integer,         optional, intent(out) :: ierr
# 574 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL4),              allocatable :: tmpdat(:)
# 576 "iotk_dat.spp"
  integer :: ierrl,ierrl2
  integer :: rkind,rsize,rlen
  character(iotk_vallenx) :: rtype
  character(iotk_vallenx) :: fmt
  character(iotk_attlenx) :: lattr
  logical :: inside,foundl
  inside = .false.
  ierrl = 0
  ierrl2 = 0
  foundl=.false.
  call iotk_scan_begin(unit,name,lattr,found=foundl,ierr=ierrl)
  if(.not. foundl) goto 1
  foundl = .true.
  inside = .true.
  if(present(attr)) call iotk_strcpy(attr,lattr,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 592 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_parse_dat(lattr,rtype,rkind,rsize,rlen,fmt,ierrl)
  if(ierrl/=0) goto 1
  if(.not. (iotk_strcomp(rtype,iotk_eos) .or. iotk_strcomp(rtype,"REAL") ) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,' ')
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"rtype",rtype(1:iotk_strlen(rtype)))
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"type","REAL")
    goto 1
  end if
  if(.not. (rsize==-1 .or. rsize==1) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 602 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(rkind==-1) rkind = kind(dat)
# 609 "iotk_dat.spp"

  allocate(tmpdat(1))
  call iotk_scan_dat_aux(unit,tmpdat,rkind,rlen,fmt(1:iotk_strlen(fmt)),ierrl)
# 613 "iotk_dat.spp"
        dat = tmpdat(1)
# 617 "iotk_dat.spp"
  deallocate(tmpdat)
1 continue
  if(inside) then
    call iotk_scan_end(unit,name,ierr=ierrl2)
    if(ierrl2/=0) then
      call iotk_error_clear(ierrl)
      ierrl=ierrl2
    end if
  end if
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Dat not found')
# 629 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if 
  if(present(default) .and. .not. foundl) then
    dat=default
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl>0 .or. (.not.present(found) .and. .not.present(default))) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_dat_REAL4_0


#endif
#endif

subroutine iotk_dat_dummy_REAL4_0
  write(0,*)
end subroutine iotk_dat_dummy_REAL4_0

# 45 "iotk_dat.spp"

# 47 "iotk_dat.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_dat.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_dat.spp"

# 59 "iotk_dat.spp"

#ifdef __IOTK_REAL4
#if 1 <= __IOTK_MAXRANK
# 63 "iotk_dat.spp"
subroutine iotk_write_dat_REAL4_1(unit,name,dat,dummy,attr,fmt,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_write_attr
  use iotk_write_interf
  use iotk_fmt_interf
  use iotk_str_interf
  use iotk_unit_interf
  use iotk_misc_interf
  implicit none
  integer,                intent(in)  :: unit
  character(*),           intent(in)  :: name
  REAL (kind=__IOTK_REAL4), intent(in)  :: dat (:) 
  type(iotk_dummytype), optional      :: dummy
  character(len=*), optional, intent(in)  :: attr
  character(len=*), optional, intent(in)  :: fmt
  integer,      optional, intent(out) :: ierr
  integer :: ierrl,lunit,iostat
  logical :: binary,raw
  integer(iotk_header_kind), parameter :: idummy=0
  character(300) :: usefmt,usefmt1
  character(iotk_attlenx) :: lattr
  character(iotk_attlenx) :: attr_tmp
  type (iotk_unit), pointer :: this
# 91 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL4),allocatable :: dattmp(:)
# 93 "iotk_dat.spp"
  integer :: itmp
  ierrl = 0
  iostat = 0
  lunit = iotk_phys_unit(unit)
  call iotk_unit_get(lunit,pointer=this)
  raw = .false.
  if(associated(this)) then
    raw = this%raw
  end if
  call iotk_inquire(lunit,binary=binary,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 104 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_strcpy(usefmt,"!",ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 109 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(fmt) .and. .not. raw) call iotk_strcpy(usefmt,iotk_strtrim(fmt),ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 114 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(iotk_strscan(usefmt,"<>&")/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Special characters (<>&) found in fmt string')
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"unit",unit)
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",trim(name))
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"fmt",trim(fmt))
    goto 1
  end if
  call iotk_write_attr(lattr,"type",iotk_tolower("REAL"),first=.true.,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 123 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_attr(lattr,"size",size(dat),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 128 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
# 138 "iotk_dat.spp"
  if(binary) then
    call iotk_write_attr(lattr,"kind",kind(dat),ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 141 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
  end if
# 146 "iotk_dat.spp"
  if(.not.iotk_strcomp(usefmt,"!")) call iotk_write_attr(lattr,"fmt",iotk_strtrim(usefmt),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 148 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(attr)) then
    attr_tmp(1:1)=iotk_eos
    call iotk_strcpy(attr_tmp,attr,ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 155 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"type",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 160 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"kind",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 165 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"size",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 170 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"fmt",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 175 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"len",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 180 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    if(iotk_strlen_trim(attr_tmp)>0) call iotk_strcat(lattr,iotk_strtrim(attr_tmp),ierr=ierrl)
  end if
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 186 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_begin(unit,name,lattr,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 191 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if

  allocate(dattmp(size(dat)))
# 199 "iotk_dat.spp"
#if defined(__IOTK_WORKAROUND3) || defined(__IOTK_WORKAROUND4)
# 203 "iotk_dat.spp"
     call iotk_private_pack_REAL4(dattmp,dat,size(dattmp),1)
# 205 "iotk_dat.spp"
#else
     dattmp = pack(dat,mask=.true.)
#endif
# 209 "iotk_dat.spp"

  if(binary) then
    if(raw) then
      write(lunit,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 214 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else
      write(lunit,iostat=iostat) idummy,(dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 220 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  else
    if(raw) then
# 229 "iotk_dat.spp"
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
# 231 "iotk_dat.spp"
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 232 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"*")) then
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 238 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"!")) then
# 252 "iotk_dat.spp"
     write(lunit,fmt=trim(iotk_wfmt("REAL",kind(dattmp),1,-1)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
     if(iostat/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 254 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
     end if
# 258 "iotk_dat.spp"
    else
      write(lunit,fmt=usefmt(1:iotk_strlen(usefmt)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 261 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  end if
  call iotk_write_end(unit,name,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 268 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
1 continue
  if(allocated(dattmp)) deallocate(dattmp)
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_dat_REAL4_1


# 283 "iotk_dat.spp"
recursive subroutine iotk_scan_dat_aux_REAL4(unit,dat,rkind,rlen,fmt,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only: iotk_read
  use iotk_scan_interf
  use iotk_str_interf
  use iotk_unit_interf
  use iotk_misc_interf
  implicit none
  integer,         intent(in)  :: unit
#ifdef __IOTK_WORKAROUND6
  REAL (kind=__IOTK_REAL4)                        :: dat (:)
#else
  REAL (kind=__IOTK_REAL4),           intent(out) :: dat (:)
#endif
  integer,         intent(in)  :: rkind
  integer,         intent(in)  :: rlen
  character(*),    intent(in)  :: fmt
  integer,         intent(out) :: ierr
  integer(iotk_header_kind) :: idummy
  logical :: raw,binary
  integer :: lunit
  integer :: index,length,nexttag,iostat,altlength
  type(iotk_unit), pointer :: this
  character(len=iotk_linlenx) :: line,altline
# 313 "iotk_dat.spp"
#ifdef __IOTK_REAL1
  REAL (__IOTK_REAL1), allocatable :: dat1 (:)
#endif
# 313 "iotk_dat.spp"
#ifdef __IOTK_REAL2
  REAL (__IOTK_REAL2), allocatable :: dat2 (:)
#endif
# 313 "iotk_dat.spp"
#ifdef __IOTK_REAL3
  REAL (__IOTK_REAL3), allocatable :: dat3 (:)
#endif
# 319 "iotk_dat.spp"
  lunit = iotk_phys_unit(unit)
  ierr = 0
  iostat = 0
  idummy = 0
  call iotk_unit_get(lunit,pointer=this)
  raw = .false.
  if(associated(this)) then
    raw = this%raw
  end if
  call iotk_inquire(unit=lunit,binary=binary,ierr=ierr)
  if(ierr/=0) then
    call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 330 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
    return
  end if
# 420 "iotk_dat.spp"
  if(binary) then
    select case(rkind)
    case(kind(dat))
      if(raw) then
        read(lunit,iostat=iostat) dat
        if(iostat/=0) then
          call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 426 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
# 426 "iotk_dat.spp"
call iotk_error_msg(ierr,' ')
# 426 "iotk_dat.spp"
call iotk_error_write(ierr,"iostat",iostat)
          return
        end if
      else
        read(lunit,iostat=iostat) idummy,dat
        if(iostat/=0) then
          call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 432 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
# 432 "iotk_dat.spp"
call iotk_error_msg(ierr,' ')
# 432 "iotk_dat.spp"
call iotk_error_write(ierr,"iostat",iostat)
          return
        end if
      end if
# 438 "iotk_dat.spp"
#ifdef __IOTK_REAL1
    case(kind(dat1))
      ! Giusto per scrupolo. Se e' raw non ci sono info sul kind, quindi questa linea e' irraggiungibile
      if(raw) then
        call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 442 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
        return
      end if
      allocate(dat1(ubound(dat,1)))
      read(lunit,iostat=iostat) idummy,dat1
      if(iostat/=0) then
        call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 448 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
# 448 "iotk_dat.spp"
call iotk_error_msg(ierr,' ')
# 448 "iotk_dat.spp"
call iotk_error_write(ierr,"iostat",iostat)
        return
      end if
# 458 "iotk_dat.spp"
      dat = dat1
# 460 "iotk_dat.spp"
      deallocate(dat1)
#endif
# 438 "iotk_dat.spp"
#ifdef __IOTK_REAL2
    case(kind(dat2))
      ! Giusto per scrupolo. Se e' raw non ci sono info sul kind, quindi questa linea e' irraggiungibile
      if(raw) then
        call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 442 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
        return
      end if
      allocate(dat2(ubound(dat,1)))
      read(lunit,iostat=iostat) idummy,dat2
      if(iostat/=0) then
        call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 448 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
# 448 "iotk_dat.spp"
call iotk_error_msg(ierr,' ')
# 448 "iotk_dat.spp"
call iotk_error_write(ierr,"iostat",iostat)
        return
      end if
# 458 "iotk_dat.spp"
      dat = dat2
# 460 "iotk_dat.spp"
      deallocate(dat2)
#endif
# 438 "iotk_dat.spp"
#ifdef __IOTK_REAL3
    case(kind(dat3))
      ! Giusto per scrupolo. Se e' raw non ci sono info sul kind, quindi questa linea e' irraggiungibile
      if(raw) then
        call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 442 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
        return
      end if
      allocate(dat3(ubound(dat,1)))
      read(lunit,iostat=iostat) idummy,dat3
      if(iostat/=0) then
        call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 448 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
# 448 "iotk_dat.spp"
call iotk_error_msg(ierr,' ')
# 448 "iotk_dat.spp"
call iotk_error_write(ierr,"iostat",iostat)
        return
      end if
# 458 "iotk_dat.spp"
      dat = dat3
# 460 "iotk_dat.spp"
      deallocate(dat3)
#endif
# 464 "iotk_dat.spp"
    case default
      call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 465 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
# 465 "iotk_dat.spp"
call iotk_error_msg(ierr,'Kind incompatibility')
# 465 "iotk_dat.spp"
call iotk_error_write(ierr,"kind",rkind)
    end select
  else
    if(raw) then
      read(lunit,fmt=*,iostat=iostat) dat
      if(iostat/=0) then
        call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 471 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
# 471 "iotk_dat.spp"
call iotk_error_msg(ierr,' ')
# 471 "iotk_dat.spp"
call iotk_error_write(ierr,"iostat",iostat)
        return
      end if
    else if(iotk_strcomp(fmt,"*")) then
      read(lunit,fmt=*,iostat=iostat) dat
      if(iostat/=0) then
        call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 477 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
# 477 "iotk_dat.spp"
call iotk_error_msg(ierr,' ')
# 477 "iotk_dat.spp"
call iotk_error_write(ierr,"iostat",iostat)
        return
      end if
    else if(iotk_strcomp(fmt,"!")) then
      index = 0
      do
        call iotk_getline(lunit,line,length,ierr)
        if(ierr/=0) then
          call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 485 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
          return
        end if
        nexttag = scan(line(1:length),"<")
        if(nexttag==0) then
          nexttag = length + 1
        else
! AGGIUSTA LA POSIZIONE SE C'E' UNA TAG SU QUESTA LINEA
! E' UN PO' CASERECCIO MA FUNZIONA
          backspace(lunit,iostat=iostat)
          if(iostat/=0) then
            call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 496 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
# 496 "iotk_dat.spp"
call iotk_error_msg(ierr,' ')
# 496 "iotk_dat.spp"
call iotk_error_write(ierr,"iostat",iostat)
            return
          end if
          call iotk_getline(lunit,altline,altlength,ierr)
          if(ierr/=0) then
            call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 501 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
            return
          end if
          backspace(lunit,iostat=iostat)
          if(iostat/=0) then
            call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 506 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
# 506 "iotk_dat.spp"
call iotk_error_msg(ierr,' ')
# 506 "iotk_dat.spp"
call iotk_error_write(ierr,"iostat",iostat)
            return
          end if
          read(lunit,"(a)",advance="no",iostat=iostat) altline(1:nexttag-1 + altlength - length)
          if(iostat/=0) then
            call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 511 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
# 511 "iotk_dat.spp"
call iotk_error_msg(ierr,' ')
# 511 "iotk_dat.spp"
call iotk_error_write(ierr,"iostat",iostat)
            return
          end if
        end if
        call iotk_read(dat,line(1:nexttag - 1),index,ierr)
        if(ierr/=0) then
          call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 517 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
          return
        end if
# 523 "iotk_dat.spp"
        if(index == size(dat)) exit
# 525 "iotk_dat.spp"
        if(nexttag/=length + 1) then
          call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 526 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
          return
        end if
      end do
    else
      read(lunit,fmt=fmt(1:iotk_strlen(fmt)),iostat=iostat) dat
      if(iostat/=0) then
        call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 533 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
# 533 "iotk_dat.spp"
call iotk_error_msg(ierr,' ')
# 533 "iotk_dat.spp"
call iotk_error_write(ierr,"iostat",iostat)
        return
      end if
    end if
  end if
# 539 "iotk_dat.spp"
  if(idummy/=0) then
    call iotk_error_issue(ierr,"iotk_scan_dat_aux",__FILE__,__LINE__)
# 540 "iotk_dat.spp"
call iotk_error_msg(ierr,"CVS Revision: 1.12 ")
    return
  end if
end subroutine iotk_scan_dat_aux_REAL4
# 545 "iotk_dat.spp"

# 547 "iotk_dat.spp"
subroutine iotk_scan_dat_REAL4_1(unit,name,dat,dummy,attr,found,default,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_dat_interf, only: iotk_scan_dat_aux
  use iotk_scan_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  integer,                   intent(in)  :: unit
  character(*),              intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL (kind=__IOTK_REAL4)                        :: dat (:)
#else
  REAL (kind=__IOTK_REAL4),           intent(out) :: dat (:)
#endif
  type(iotk_dummytype), optional         :: dummy
#ifdef __IOTK_WORKAROUND6
  character(len=*),optional              :: attr
#else
  character(len=*),optional, intent(out) :: attr
#endif
  logical,         optional, intent(out) :: found
  REAL (kind=__IOTK_REAL4), optional, intent(in)  :: default (:)
  integer,         optional, intent(out) :: ierr
# 574 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL4),              allocatable :: tmpdat(:)
# 576 "iotk_dat.spp"
  integer :: ierrl,ierrl2
  integer :: rkind,rsize,rlen
  character(iotk_vallenx) :: rtype
  character(iotk_vallenx) :: fmt
  character(iotk_attlenx) :: lattr
  logical :: inside,foundl
  inside = .false.
  ierrl = 0
  ierrl2 = 0
  foundl=.false.
  call iotk_scan_begin(unit,name,lattr,found=foundl,ierr=ierrl)
  if(.not. foundl) goto 1
  foundl = .true.
  inside = .true.
  if(present(attr)) call iotk_strcpy(attr,lattr,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 592 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_parse_dat(lattr,rtype,rkind,rsize,rlen,fmt,ierrl)
  if(ierrl/=0) goto 1
  if(.not. (iotk_strcomp(rtype,iotk_eos) .or. iotk_strcomp(rtype,"REAL") ) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,' ')
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"rtype",rtype(1:iotk_strlen(rtype)))
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"type","REAL")
    goto 1
  end if
  if(.not. (rsize==-1 .or. rsize==size(dat)) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 602 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(rkind==-1) rkind = kind(dat)
# 609 "iotk_dat.spp"

  allocate(tmpdat(size(dat)))
  call iotk_scan_dat_aux(unit,tmpdat,rkind,rlen,fmt(1:iotk_strlen(fmt)),ierrl)
# 615 "iotk_dat.spp"
        dat = reshape(tmpdat,shape(dat))
# 617 "iotk_dat.spp"
  deallocate(tmpdat)
1 continue
  if(inside) then
    call iotk_scan_end(unit,name,ierr=ierrl2)
    if(ierrl2/=0) then
      call iotk_error_clear(ierrl)
      ierrl=ierrl2
    end if
  end if
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Dat not found')
# 629 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if 
  if(present(default) .and. .not. foundl) then
    dat=default
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl>0 .or. (.not.present(found) .and. .not.present(default))) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_dat_REAL4_1


#endif
#endif

subroutine iotk_dat_dummy_REAL4_1
  write(0,*)
end subroutine iotk_dat_dummy_REAL4_1

# 45 "iotk_dat.spp"

# 47 "iotk_dat.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_dat.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_dat.spp"

# 59 "iotk_dat.spp"

#ifdef __IOTK_REAL4
#if 2 <= __IOTK_MAXRANK
# 63 "iotk_dat.spp"
subroutine iotk_write_dat_REAL4_2(unit,name,dat,dummy,attr,fmt,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_write_attr
  use iotk_write_interf
  use iotk_fmt_interf
  use iotk_str_interf
  use iotk_unit_interf
  use iotk_misc_interf
  implicit none
  integer,                intent(in)  :: unit
  character(*),           intent(in)  :: name
  REAL (kind=__IOTK_REAL4), intent(in)  :: dat (:,:) 
  type(iotk_dummytype), optional      :: dummy
  character(len=*), optional, intent(in)  :: attr
  character(len=*), optional, intent(in)  :: fmt
  integer,      optional, intent(out) :: ierr
  integer :: ierrl,lunit,iostat
  logical :: binary,raw
  integer(iotk_header_kind), parameter :: idummy=0
  character(300) :: usefmt,usefmt1
  character(iotk_attlenx) :: lattr
  character(iotk_attlenx) :: attr_tmp
  type (iotk_unit), pointer :: this
# 91 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL4),allocatable :: dattmp(:)
# 93 "iotk_dat.spp"
  integer :: itmp
  ierrl = 0
  iostat = 0
  lunit = iotk_phys_unit(unit)
  call iotk_unit_get(lunit,pointer=this)
  raw = .false.
  if(associated(this)) then
    raw = this%raw
  end if
  call iotk_inquire(lunit,binary=binary,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 104 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_strcpy(usefmt,"!",ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 109 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(fmt) .and. .not. raw) call iotk_strcpy(usefmt,iotk_strtrim(fmt),ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 114 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(iotk_strscan(usefmt,"<>&")/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Special characters (<>&) found in fmt string')
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"unit",unit)
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",trim(name))
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"fmt",trim(fmt))
    goto 1
  end if
  call iotk_write_attr(lattr,"type",iotk_tolower("REAL"),first=.true.,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 123 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_attr(lattr,"size",size(dat),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 128 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
# 138 "iotk_dat.spp"
  if(binary) then
    call iotk_write_attr(lattr,"kind",kind(dat),ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 141 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
  end if
# 146 "iotk_dat.spp"
  if(.not.iotk_strcomp(usefmt,"!")) call iotk_write_attr(lattr,"fmt",iotk_strtrim(usefmt),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 148 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(attr)) then
    attr_tmp(1:1)=iotk_eos
    call iotk_strcpy(attr_tmp,attr,ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 155 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"type",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 160 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"kind",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 165 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"size",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 170 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"fmt",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 175 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"len",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 180 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    if(iotk_strlen_trim(attr_tmp)>0) call iotk_strcat(lattr,iotk_strtrim(attr_tmp),ierr=ierrl)
  end if
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 186 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_begin(unit,name,lattr,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 191 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if

  allocate(dattmp(size(dat)))
# 199 "iotk_dat.spp"
#if defined(__IOTK_WORKAROUND3) || defined(__IOTK_WORKAROUND4)
# 203 "iotk_dat.spp"
     call iotk_private_pack_REAL4(dattmp,dat,size(dattmp),1)
# 205 "iotk_dat.spp"
#else
     dattmp = pack(dat,mask=.true.)
#endif
# 209 "iotk_dat.spp"

  if(binary) then
    if(raw) then
      write(lunit,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 214 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else
      write(lunit,iostat=iostat) idummy,(dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 220 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  else
    if(raw) then
# 229 "iotk_dat.spp"
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
# 231 "iotk_dat.spp"
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 232 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"*")) then
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 238 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"!")) then
# 252 "iotk_dat.spp"
     write(lunit,fmt=trim(iotk_wfmt("REAL",kind(dattmp),1,-1)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
     if(iostat/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 254 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
     end if
# 258 "iotk_dat.spp"
    else
      write(lunit,fmt=usefmt(1:iotk_strlen(usefmt)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 261 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  end if
  call iotk_write_end(unit,name,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 268 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
1 continue
  if(allocated(dattmp)) deallocate(dattmp)
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_dat_REAL4_2


# 545 "iotk_dat.spp"

# 547 "iotk_dat.spp"
subroutine iotk_scan_dat_REAL4_2(unit,name,dat,dummy,attr,found,default,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_dat_interf, only: iotk_scan_dat_aux
  use iotk_scan_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  integer,                   intent(in)  :: unit
  character(*),              intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL (kind=__IOTK_REAL4)                        :: dat (:,:)
#else
  REAL (kind=__IOTK_REAL4),           intent(out) :: dat (:,:)
#endif
  type(iotk_dummytype), optional         :: dummy
#ifdef __IOTK_WORKAROUND6
  character(len=*),optional              :: attr
#else
  character(len=*),optional, intent(out) :: attr
#endif
  logical,         optional, intent(out) :: found
  REAL (kind=__IOTK_REAL4), optional, intent(in)  :: default (:,:)
  integer,         optional, intent(out) :: ierr
# 574 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL4),              allocatable :: tmpdat(:)
# 576 "iotk_dat.spp"
  integer :: ierrl,ierrl2
  integer :: rkind,rsize,rlen
  character(iotk_vallenx) :: rtype
  character(iotk_vallenx) :: fmt
  character(iotk_attlenx) :: lattr
  logical :: inside,foundl
  inside = .false.
  ierrl = 0
  ierrl2 = 0
  foundl=.false.
  call iotk_scan_begin(unit,name,lattr,found=foundl,ierr=ierrl)
  if(.not. foundl) goto 1
  foundl = .true.
  inside = .true.
  if(present(attr)) call iotk_strcpy(attr,lattr,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 592 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_parse_dat(lattr,rtype,rkind,rsize,rlen,fmt,ierrl)
  if(ierrl/=0) goto 1
  if(.not. (iotk_strcomp(rtype,iotk_eos) .or. iotk_strcomp(rtype,"REAL") ) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,' ')
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"rtype",rtype(1:iotk_strlen(rtype)))
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"type","REAL")
    goto 1
  end if
  if(.not. (rsize==-1 .or. rsize==size(dat)) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 602 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(rkind==-1) rkind = kind(dat)
# 609 "iotk_dat.spp"

  allocate(tmpdat(size(dat)))
  call iotk_scan_dat_aux(unit,tmpdat,rkind,rlen,fmt(1:iotk_strlen(fmt)),ierrl)
# 615 "iotk_dat.spp"
        dat = reshape(tmpdat,shape(dat))
# 617 "iotk_dat.spp"
  deallocate(tmpdat)
1 continue
  if(inside) then
    call iotk_scan_end(unit,name,ierr=ierrl2)
    if(ierrl2/=0) then
      call iotk_error_clear(ierrl)
      ierrl=ierrl2
    end if
  end if
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Dat not found')
# 629 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if 
  if(present(default) .and. .not. foundl) then
    dat=default
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl>0 .or. (.not.present(found) .and. .not.present(default))) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_dat_REAL4_2


#endif
#endif

subroutine iotk_dat_dummy_REAL4_2
  write(0,*)
end subroutine iotk_dat_dummy_REAL4_2

# 45 "iotk_dat.spp"

# 47 "iotk_dat.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_dat.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_dat.spp"

# 59 "iotk_dat.spp"

#ifdef __IOTK_REAL4
#if 3 <= __IOTK_MAXRANK
# 63 "iotk_dat.spp"
subroutine iotk_write_dat_REAL4_3(unit,name,dat,dummy,attr,fmt,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_write_attr
  use iotk_write_interf
  use iotk_fmt_interf
  use iotk_str_interf
  use iotk_unit_interf
  use iotk_misc_interf
  implicit none
  integer,                intent(in)  :: unit
  character(*),           intent(in)  :: name
  REAL (kind=__IOTK_REAL4), intent(in)  :: dat (:,:,:) 
  type(iotk_dummytype), optional      :: dummy
  character(len=*), optional, intent(in)  :: attr
  character(len=*), optional, intent(in)  :: fmt
  integer,      optional, intent(out) :: ierr
  integer :: ierrl,lunit,iostat
  logical :: binary,raw
  integer(iotk_header_kind), parameter :: idummy=0
  character(300) :: usefmt,usefmt1
  character(iotk_attlenx) :: lattr
  character(iotk_attlenx) :: attr_tmp
  type (iotk_unit), pointer :: this
# 91 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL4),allocatable :: dattmp(:)
# 93 "iotk_dat.spp"
  integer :: itmp
  ierrl = 0
  iostat = 0
  lunit = iotk_phys_unit(unit)
  call iotk_unit_get(lunit,pointer=this)
  raw = .false.
  if(associated(this)) then
    raw = this%raw
  end if
  call iotk_inquire(lunit,binary=binary,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 104 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_strcpy(usefmt,"!",ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 109 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(fmt) .and. .not. raw) call iotk_strcpy(usefmt,iotk_strtrim(fmt),ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 114 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(iotk_strscan(usefmt,"<>&")/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Special characters (<>&) found in fmt string')
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"unit",unit)
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",trim(name))
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"fmt",trim(fmt))
    goto 1
  end if
  call iotk_write_attr(lattr,"type",iotk_tolower("REAL"),first=.true.,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 123 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_attr(lattr,"size",size(dat),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 128 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
# 138 "iotk_dat.spp"
  if(binary) then
    call iotk_write_attr(lattr,"kind",kind(dat),ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 141 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
  end if
# 146 "iotk_dat.spp"
  if(.not.iotk_strcomp(usefmt,"!")) call iotk_write_attr(lattr,"fmt",iotk_strtrim(usefmt),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 148 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(attr)) then
    attr_tmp(1:1)=iotk_eos
    call iotk_strcpy(attr_tmp,attr,ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 155 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"type",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 160 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"kind",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 165 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"size",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 170 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"fmt",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 175 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"len",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 180 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    if(iotk_strlen_trim(attr_tmp)>0) call iotk_strcat(lattr,iotk_strtrim(attr_tmp),ierr=ierrl)
  end if
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 186 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_begin(unit,name,lattr,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 191 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if

  allocate(dattmp(size(dat)))
# 199 "iotk_dat.spp"
#if defined(__IOTK_WORKAROUND3) || defined(__IOTK_WORKAROUND4)
# 203 "iotk_dat.spp"
     call iotk_private_pack_REAL4(dattmp,dat,size(dattmp),1)
# 205 "iotk_dat.spp"
#else
     dattmp = pack(dat,mask=.true.)
#endif
# 209 "iotk_dat.spp"

  if(binary) then
    if(raw) then
      write(lunit,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 214 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else
      write(lunit,iostat=iostat) idummy,(dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 220 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  else
    if(raw) then
# 229 "iotk_dat.spp"
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
# 231 "iotk_dat.spp"
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 232 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"*")) then
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 238 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"!")) then
# 252 "iotk_dat.spp"
     write(lunit,fmt=trim(iotk_wfmt("REAL",kind(dattmp),1,-1)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
     if(iostat/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 254 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
     end if
# 258 "iotk_dat.spp"
    else
      write(lunit,fmt=usefmt(1:iotk_strlen(usefmt)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 261 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  end if
  call iotk_write_end(unit,name,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 268 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
1 continue
  if(allocated(dattmp)) deallocate(dattmp)
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_dat_REAL4_3


# 545 "iotk_dat.spp"

# 547 "iotk_dat.spp"
subroutine iotk_scan_dat_REAL4_3(unit,name,dat,dummy,attr,found,default,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_dat_interf, only: iotk_scan_dat_aux
  use iotk_scan_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  integer,                   intent(in)  :: unit
  character(*),              intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL (kind=__IOTK_REAL4)                        :: dat (:,:,:)
#else
  REAL (kind=__IOTK_REAL4),           intent(out) :: dat (:,:,:)
#endif
  type(iotk_dummytype), optional         :: dummy
#ifdef __IOTK_WORKAROUND6
  character(len=*),optional              :: attr
#else
  character(len=*),optional, intent(out) :: attr
#endif
  logical,         optional, intent(out) :: found
  REAL (kind=__IOTK_REAL4), optional, intent(in)  :: default (:,:,:)
  integer,         optional, intent(out) :: ierr
# 574 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL4),              allocatable :: tmpdat(:)
# 576 "iotk_dat.spp"
  integer :: ierrl,ierrl2
  integer :: rkind,rsize,rlen
  character(iotk_vallenx) :: rtype
  character(iotk_vallenx) :: fmt
  character(iotk_attlenx) :: lattr
  logical :: inside,foundl
  inside = .false.
  ierrl = 0
  ierrl2 = 0
  foundl=.false.
  call iotk_scan_begin(unit,name,lattr,found=foundl,ierr=ierrl)
  if(.not. foundl) goto 1
  foundl = .true.
  inside = .true.
  if(present(attr)) call iotk_strcpy(attr,lattr,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 592 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_parse_dat(lattr,rtype,rkind,rsize,rlen,fmt,ierrl)
  if(ierrl/=0) goto 1
  if(.not. (iotk_strcomp(rtype,iotk_eos) .or. iotk_strcomp(rtype,"REAL") ) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,' ')
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"rtype",rtype(1:iotk_strlen(rtype)))
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"type","REAL")
    goto 1
  end if
  if(.not. (rsize==-1 .or. rsize==size(dat)) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 602 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(rkind==-1) rkind = kind(dat)
# 609 "iotk_dat.spp"

  allocate(tmpdat(size(dat)))
  call iotk_scan_dat_aux(unit,tmpdat,rkind,rlen,fmt(1:iotk_strlen(fmt)),ierrl)
# 615 "iotk_dat.spp"
        dat = reshape(tmpdat,shape(dat))
# 617 "iotk_dat.spp"
  deallocate(tmpdat)
1 continue
  if(inside) then
    call iotk_scan_end(unit,name,ierr=ierrl2)
    if(ierrl2/=0) then
      call iotk_error_clear(ierrl)
      ierrl=ierrl2
    end if
  end if
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Dat not found')
# 629 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if 
  if(present(default) .and. .not. foundl) then
    dat=default
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl>0 .or. (.not.present(found) .and. .not.present(default))) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_dat_REAL4_3


#endif
#endif

subroutine iotk_dat_dummy_REAL4_3
  write(0,*)
end subroutine iotk_dat_dummy_REAL4_3

# 45 "iotk_dat.spp"

# 47 "iotk_dat.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_dat.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_dat.spp"

# 59 "iotk_dat.spp"

#ifdef __IOTK_REAL4
#if 4 <= __IOTK_MAXRANK
# 63 "iotk_dat.spp"
subroutine iotk_write_dat_REAL4_4(unit,name,dat,dummy,attr,fmt,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_write_attr
  use iotk_write_interf
  use iotk_fmt_interf
  use iotk_str_interf
  use iotk_unit_interf
  use iotk_misc_interf
  implicit none
  integer,                intent(in)  :: unit
  character(*),           intent(in)  :: name
  REAL (kind=__IOTK_REAL4), intent(in)  :: dat (:,:,:,:) 
  type(iotk_dummytype), optional      :: dummy
  character(len=*), optional, intent(in)  :: attr
  character(len=*), optional, intent(in)  :: fmt
  integer,      optional, intent(out) :: ierr
  integer :: ierrl,lunit,iostat
  logical :: binary,raw
  integer(iotk_header_kind), parameter :: idummy=0
  character(300) :: usefmt,usefmt1
  character(iotk_attlenx) :: lattr
  character(iotk_attlenx) :: attr_tmp
  type (iotk_unit), pointer :: this
# 91 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL4),allocatable :: dattmp(:)
# 93 "iotk_dat.spp"
  integer :: itmp
  ierrl = 0
  iostat = 0
  lunit = iotk_phys_unit(unit)
  call iotk_unit_get(lunit,pointer=this)
  raw = .false.
  if(associated(this)) then
    raw = this%raw
  end if
  call iotk_inquire(lunit,binary=binary,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 104 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_strcpy(usefmt,"!",ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 109 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(fmt) .and. .not. raw) call iotk_strcpy(usefmt,iotk_strtrim(fmt),ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 114 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(iotk_strscan(usefmt,"<>&")/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Special characters (<>&) found in fmt string')
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"unit",unit)
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",trim(name))
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"fmt",trim(fmt))
    goto 1
  end if
  call iotk_write_attr(lattr,"type",iotk_tolower("REAL"),first=.true.,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 123 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_attr(lattr,"size",size(dat),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 128 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
# 138 "iotk_dat.spp"
  if(binary) then
    call iotk_write_attr(lattr,"kind",kind(dat),ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 141 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
  end if
# 146 "iotk_dat.spp"
  if(.not.iotk_strcomp(usefmt,"!")) call iotk_write_attr(lattr,"fmt",iotk_strtrim(usefmt),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 148 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(attr)) then
    attr_tmp(1:1)=iotk_eos
    call iotk_strcpy(attr_tmp,attr,ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 155 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"type",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 160 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"kind",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 165 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"size",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 170 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"fmt",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 175 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"len",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 180 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    if(iotk_strlen_trim(attr_tmp)>0) call iotk_strcat(lattr,iotk_strtrim(attr_tmp),ierr=ierrl)
  end if
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 186 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_begin(unit,name,lattr,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 191 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if

  allocate(dattmp(size(dat)))
# 199 "iotk_dat.spp"
#if defined(__IOTK_WORKAROUND3) || defined(__IOTK_WORKAROUND4)
# 203 "iotk_dat.spp"
     call iotk_private_pack_REAL4(dattmp,dat,size(dattmp),1)
# 205 "iotk_dat.spp"
#else
     dattmp = pack(dat,mask=.true.)
#endif
# 209 "iotk_dat.spp"

  if(binary) then
    if(raw) then
      write(lunit,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 214 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else
      write(lunit,iostat=iostat) idummy,(dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 220 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  else
    if(raw) then
# 229 "iotk_dat.spp"
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
# 231 "iotk_dat.spp"
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 232 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"*")) then
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 238 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"!")) then
# 252 "iotk_dat.spp"
     write(lunit,fmt=trim(iotk_wfmt("REAL",kind(dattmp),1,-1)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
     if(iostat/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 254 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
     end if
# 258 "iotk_dat.spp"
    else
      write(lunit,fmt=usefmt(1:iotk_strlen(usefmt)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 261 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  end if
  call iotk_write_end(unit,name,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 268 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
1 continue
  if(allocated(dattmp)) deallocate(dattmp)
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_dat_REAL4_4


# 545 "iotk_dat.spp"

# 547 "iotk_dat.spp"
subroutine iotk_scan_dat_REAL4_4(unit,name,dat,dummy,attr,found,default,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_dat_interf, only: iotk_scan_dat_aux
  use iotk_scan_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  integer,                   intent(in)  :: unit
  character(*),              intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL (kind=__IOTK_REAL4)                        :: dat (:,:,:,:)
#else
  REAL (kind=__IOTK_REAL4),           intent(out) :: dat (:,:,:,:)
#endif
  type(iotk_dummytype), optional         :: dummy
#ifdef __IOTK_WORKAROUND6
  character(len=*),optional              :: attr
#else
  character(len=*),optional, intent(out) :: attr
#endif
  logical,         optional, intent(out) :: found
  REAL (kind=__IOTK_REAL4), optional, intent(in)  :: default (:,:,:,:)
  integer,         optional, intent(out) :: ierr
# 574 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL4),              allocatable :: tmpdat(:)
# 576 "iotk_dat.spp"
  integer :: ierrl,ierrl2
  integer :: rkind,rsize,rlen
  character(iotk_vallenx) :: rtype
  character(iotk_vallenx) :: fmt
  character(iotk_attlenx) :: lattr
  logical :: inside,foundl
  inside = .false.
  ierrl = 0
  ierrl2 = 0
  foundl=.false.
  call iotk_scan_begin(unit,name,lattr,found=foundl,ierr=ierrl)
  if(.not. foundl) goto 1
  foundl = .true.
  inside = .true.
  if(present(attr)) call iotk_strcpy(attr,lattr,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 592 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_parse_dat(lattr,rtype,rkind,rsize,rlen,fmt,ierrl)
  if(ierrl/=0) goto 1
  if(.not. (iotk_strcomp(rtype,iotk_eos) .or. iotk_strcomp(rtype,"REAL") ) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,' ')
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"rtype",rtype(1:iotk_strlen(rtype)))
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"type","REAL")
    goto 1
  end if
  if(.not. (rsize==-1 .or. rsize==size(dat)) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 602 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(rkind==-1) rkind = kind(dat)
# 609 "iotk_dat.spp"

  allocate(tmpdat(size(dat)))
  call iotk_scan_dat_aux(unit,tmpdat,rkind,rlen,fmt(1:iotk_strlen(fmt)),ierrl)
# 615 "iotk_dat.spp"
        dat = reshape(tmpdat,shape(dat))
# 617 "iotk_dat.spp"
  deallocate(tmpdat)
1 continue
  if(inside) then
    call iotk_scan_end(unit,name,ierr=ierrl2)
    if(ierrl2/=0) then
      call iotk_error_clear(ierrl)
      ierrl=ierrl2
    end if
  end if
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Dat not found')
# 629 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if 
  if(present(default) .and. .not. foundl) then
    dat=default
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl>0 .or. (.not.present(found) .and. .not.present(default))) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_dat_REAL4_4


#endif
#endif

subroutine iotk_dat_dummy_REAL4_4
  write(0,*)
end subroutine iotk_dat_dummy_REAL4_4

# 45 "iotk_dat.spp"

# 47 "iotk_dat.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_dat.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_dat.spp"

# 59 "iotk_dat.spp"

#ifdef __IOTK_REAL4
#if 5 <= __IOTK_MAXRANK
# 63 "iotk_dat.spp"
subroutine iotk_write_dat_REAL4_5(unit,name,dat,dummy,attr,fmt,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_write_attr
  use iotk_write_interf
  use iotk_fmt_interf
  use iotk_str_interf
  use iotk_unit_interf
  use iotk_misc_interf
  implicit none
  integer,                intent(in)  :: unit
  character(*),           intent(in)  :: name
  REAL (kind=__IOTK_REAL4), intent(in)  :: dat (:,:,:,:,:) 
  type(iotk_dummytype), optional      :: dummy
  character(len=*), optional, intent(in)  :: attr
  character(len=*), optional, intent(in)  :: fmt
  integer,      optional, intent(out) :: ierr
  integer :: ierrl,lunit,iostat
  logical :: binary,raw
  integer(iotk_header_kind), parameter :: idummy=0
  character(300) :: usefmt,usefmt1
  character(iotk_attlenx) :: lattr
  character(iotk_attlenx) :: attr_tmp
  type (iotk_unit), pointer :: this
# 91 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL4),allocatable :: dattmp(:)
# 93 "iotk_dat.spp"
  integer :: itmp
  ierrl = 0
  iostat = 0
  lunit = iotk_phys_unit(unit)
  call iotk_unit_get(lunit,pointer=this)
  raw = .false.
  if(associated(this)) then
    raw = this%raw
  end if
  call iotk_inquire(lunit,binary=binary,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 104 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_strcpy(usefmt,"!",ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 109 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(fmt) .and. .not. raw) call iotk_strcpy(usefmt,iotk_strtrim(fmt),ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 114 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(iotk_strscan(usefmt,"<>&")/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Special characters (<>&) found in fmt string')
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"unit",unit)
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",trim(name))
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"fmt",trim(fmt))
    goto 1
  end if
  call iotk_write_attr(lattr,"type",iotk_tolower("REAL"),first=.true.,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 123 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_attr(lattr,"size",size(dat),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 128 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
# 138 "iotk_dat.spp"
  if(binary) then
    call iotk_write_attr(lattr,"kind",kind(dat),ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 141 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
  end if
# 146 "iotk_dat.spp"
  if(.not.iotk_strcomp(usefmt,"!")) call iotk_write_attr(lattr,"fmt",iotk_strtrim(usefmt),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 148 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(attr)) then
    attr_tmp(1:1)=iotk_eos
    call iotk_strcpy(attr_tmp,attr,ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 155 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"type",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 160 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"kind",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 165 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"size",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 170 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"fmt",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 175 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"len",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 180 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    if(iotk_strlen_trim(attr_tmp)>0) call iotk_strcat(lattr,iotk_strtrim(attr_tmp),ierr=ierrl)
  end if
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 186 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_begin(unit,name,lattr,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 191 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if

  allocate(dattmp(size(dat)))
# 199 "iotk_dat.spp"
#if defined(__IOTK_WORKAROUND3) || defined(__IOTK_WORKAROUND4)
# 203 "iotk_dat.spp"
     call iotk_private_pack_REAL4(dattmp,dat,size(dattmp),1)
# 205 "iotk_dat.spp"
#else
     dattmp = pack(dat,mask=.true.)
#endif
# 209 "iotk_dat.spp"

  if(binary) then
    if(raw) then
      write(lunit,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 214 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else
      write(lunit,iostat=iostat) idummy,(dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 220 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  else
    if(raw) then
# 229 "iotk_dat.spp"
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
# 231 "iotk_dat.spp"
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 232 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"*")) then
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 238 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"!")) then
# 252 "iotk_dat.spp"
     write(lunit,fmt=trim(iotk_wfmt("REAL",kind(dattmp),1,-1)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
     if(iostat/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 254 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
     end if
# 258 "iotk_dat.spp"
    else
      write(lunit,fmt=usefmt(1:iotk_strlen(usefmt)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 261 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  end if
  call iotk_write_end(unit,name,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 268 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
1 continue
  if(allocated(dattmp)) deallocate(dattmp)
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_dat_REAL4_5


# 545 "iotk_dat.spp"

# 547 "iotk_dat.spp"
subroutine iotk_scan_dat_REAL4_5(unit,name,dat,dummy,attr,found,default,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_dat_interf, only: iotk_scan_dat_aux
  use iotk_scan_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  integer,                   intent(in)  :: unit
  character(*),              intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL (kind=__IOTK_REAL4)                        :: dat (:,:,:,:,:)
#else
  REAL (kind=__IOTK_REAL4),           intent(out) :: dat (:,:,:,:,:)
#endif
  type(iotk_dummytype), optional         :: dummy
#ifdef __IOTK_WORKAROUND6
  character(len=*),optional              :: attr
#else
  character(len=*),optional, intent(out) :: attr
#endif
  logical,         optional, intent(out) :: found
  REAL (kind=__IOTK_REAL4), optional, intent(in)  :: default (:,:,:,:,:)
  integer,         optional, intent(out) :: ierr
# 574 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL4),              allocatable :: tmpdat(:)
# 576 "iotk_dat.spp"
  integer :: ierrl,ierrl2
  integer :: rkind,rsize,rlen
  character(iotk_vallenx) :: rtype
  character(iotk_vallenx) :: fmt
  character(iotk_attlenx) :: lattr
  logical :: inside,foundl
  inside = .false.
  ierrl = 0
  ierrl2 = 0
  foundl=.false.
  call iotk_scan_begin(unit,name,lattr,found=foundl,ierr=ierrl)
  if(.not. foundl) goto 1
  foundl = .true.
  inside = .true.
  if(present(attr)) call iotk_strcpy(attr,lattr,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 592 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_parse_dat(lattr,rtype,rkind,rsize,rlen,fmt,ierrl)
  if(ierrl/=0) goto 1
  if(.not. (iotk_strcomp(rtype,iotk_eos) .or. iotk_strcomp(rtype,"REAL") ) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,' ')
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"rtype",rtype(1:iotk_strlen(rtype)))
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"type","REAL")
    goto 1
  end if
  if(.not. (rsize==-1 .or. rsize==size(dat)) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 602 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(rkind==-1) rkind = kind(dat)
# 609 "iotk_dat.spp"

  allocate(tmpdat(size(dat)))
  call iotk_scan_dat_aux(unit,tmpdat,rkind,rlen,fmt(1:iotk_strlen(fmt)),ierrl)
# 615 "iotk_dat.spp"
        dat = reshape(tmpdat,shape(dat))
# 617 "iotk_dat.spp"
  deallocate(tmpdat)
1 continue
  if(inside) then
    call iotk_scan_end(unit,name,ierr=ierrl2)
    if(ierrl2/=0) then
      call iotk_error_clear(ierrl)
      ierrl=ierrl2
    end if
  end if
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Dat not found')
# 629 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if 
  if(present(default) .and. .not. foundl) then
    dat=default
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl>0 .or. (.not.present(found) .and. .not.present(default))) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_dat_REAL4_5


#endif
#endif

subroutine iotk_dat_dummy_REAL4_5
  write(0,*)
end subroutine iotk_dat_dummy_REAL4_5

# 45 "iotk_dat.spp"

# 47 "iotk_dat.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_dat.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_dat.spp"

# 59 "iotk_dat.spp"

#ifdef __IOTK_REAL4
#if 6 <= __IOTK_MAXRANK
# 63 "iotk_dat.spp"
subroutine iotk_write_dat_REAL4_6(unit,name,dat,dummy,attr,fmt,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_write_attr
  use iotk_write_interf
  use iotk_fmt_interf
  use iotk_str_interf
  use iotk_unit_interf
  use iotk_misc_interf
  implicit none
  integer,                intent(in)  :: unit
  character(*),           intent(in)  :: name
  REAL (kind=__IOTK_REAL4), intent(in)  :: dat (:,:,:,:,:,:) 
  type(iotk_dummytype), optional      :: dummy
  character(len=*), optional, intent(in)  :: attr
  character(len=*), optional, intent(in)  :: fmt
  integer,      optional, intent(out) :: ierr
  integer :: ierrl,lunit,iostat
  logical :: binary,raw
  integer(iotk_header_kind), parameter :: idummy=0
  character(300) :: usefmt,usefmt1
  character(iotk_attlenx) :: lattr
  character(iotk_attlenx) :: attr_tmp
  type (iotk_unit), pointer :: this
# 91 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL4),allocatable :: dattmp(:)
# 93 "iotk_dat.spp"
  integer :: itmp
  ierrl = 0
  iostat = 0
  lunit = iotk_phys_unit(unit)
  call iotk_unit_get(lunit,pointer=this)
  raw = .false.
  if(associated(this)) then
    raw = this%raw
  end if
  call iotk_inquire(lunit,binary=binary,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 104 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_strcpy(usefmt,"!",ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 109 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(fmt) .and. .not. raw) call iotk_strcpy(usefmt,iotk_strtrim(fmt),ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 114 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(iotk_strscan(usefmt,"<>&")/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Special characters (<>&) found in fmt string')
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"unit",unit)
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",trim(name))
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"fmt",trim(fmt))
    goto 1
  end if
  call iotk_write_attr(lattr,"type",iotk_tolower("REAL"),first=.true.,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 123 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_attr(lattr,"size",size(dat),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 128 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
# 138 "iotk_dat.spp"
  if(binary) then
    call iotk_write_attr(lattr,"kind",kind(dat),ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 141 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
  end if
# 146 "iotk_dat.spp"
  if(.not.iotk_strcomp(usefmt,"!")) call iotk_write_attr(lattr,"fmt",iotk_strtrim(usefmt),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 148 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(attr)) then
    attr_tmp(1:1)=iotk_eos
    call iotk_strcpy(attr_tmp,attr,ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 155 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"type",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 160 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"kind",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 165 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"size",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 170 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"fmt",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 175 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"len",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 180 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    if(iotk_strlen_trim(attr_tmp)>0) call iotk_strcat(lattr,iotk_strtrim(attr_tmp),ierr=ierrl)
  end if
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 186 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_begin(unit,name,lattr,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 191 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if

  allocate(dattmp(size(dat)))
# 199 "iotk_dat.spp"
#if defined(__IOTK_WORKAROUND3) || defined(__IOTK_WORKAROUND4)
# 203 "iotk_dat.spp"
     call iotk_private_pack_REAL4(dattmp,dat,size(dattmp),1)
# 205 "iotk_dat.spp"
#else
     dattmp = pack(dat,mask=.true.)
#endif
# 209 "iotk_dat.spp"

  if(binary) then
    if(raw) then
      write(lunit,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 214 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else
      write(lunit,iostat=iostat) idummy,(dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 220 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  else
    if(raw) then
# 229 "iotk_dat.spp"
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
# 231 "iotk_dat.spp"
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 232 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"*")) then
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 238 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"!")) then
# 252 "iotk_dat.spp"
     write(lunit,fmt=trim(iotk_wfmt("REAL",kind(dattmp),1,-1)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
     if(iostat/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 254 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
     end if
# 258 "iotk_dat.spp"
    else
      write(lunit,fmt=usefmt(1:iotk_strlen(usefmt)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 261 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  end if
  call iotk_write_end(unit,name,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 268 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
1 continue
  if(allocated(dattmp)) deallocate(dattmp)
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_dat_REAL4_6


# 545 "iotk_dat.spp"

# 547 "iotk_dat.spp"
subroutine iotk_scan_dat_REAL4_6(unit,name,dat,dummy,attr,found,default,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_dat_interf, only: iotk_scan_dat_aux
  use iotk_scan_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  integer,                   intent(in)  :: unit
  character(*),              intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL (kind=__IOTK_REAL4)                        :: dat (:,:,:,:,:,:)
#else
  REAL (kind=__IOTK_REAL4),           intent(out) :: dat (:,:,:,:,:,:)
#endif
  type(iotk_dummytype), optional         :: dummy
#ifdef __IOTK_WORKAROUND6
  character(len=*),optional              :: attr
#else
  character(len=*),optional, intent(out) :: attr
#endif
  logical,         optional, intent(out) :: found
  REAL (kind=__IOTK_REAL4), optional, intent(in)  :: default (:,:,:,:,:,:)
  integer,         optional, intent(out) :: ierr
# 574 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL4),              allocatable :: tmpdat(:)
# 576 "iotk_dat.spp"
  integer :: ierrl,ierrl2
  integer :: rkind,rsize,rlen
  character(iotk_vallenx) :: rtype
  character(iotk_vallenx) :: fmt
  character(iotk_attlenx) :: lattr
  logical :: inside,foundl
  inside = .false.
  ierrl = 0
  ierrl2 = 0
  foundl=.false.
  call iotk_scan_begin(unit,name,lattr,found=foundl,ierr=ierrl)
  if(.not. foundl) goto 1
  foundl = .true.
  inside = .true.
  if(present(attr)) call iotk_strcpy(attr,lattr,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 592 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_parse_dat(lattr,rtype,rkind,rsize,rlen,fmt,ierrl)
  if(ierrl/=0) goto 1
  if(.not. (iotk_strcomp(rtype,iotk_eos) .or. iotk_strcomp(rtype,"REAL") ) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,' ')
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"rtype",rtype(1:iotk_strlen(rtype)))
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"type","REAL")
    goto 1
  end if
  if(.not. (rsize==-1 .or. rsize==size(dat)) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 602 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(rkind==-1) rkind = kind(dat)
# 609 "iotk_dat.spp"

  allocate(tmpdat(size(dat)))
  call iotk_scan_dat_aux(unit,tmpdat,rkind,rlen,fmt(1:iotk_strlen(fmt)),ierrl)
# 615 "iotk_dat.spp"
        dat = reshape(tmpdat,shape(dat))
# 617 "iotk_dat.spp"
  deallocate(tmpdat)
1 continue
  if(inside) then
    call iotk_scan_end(unit,name,ierr=ierrl2)
    if(ierrl2/=0) then
      call iotk_error_clear(ierrl)
      ierrl=ierrl2
    end if
  end if
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Dat not found')
# 629 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if 
  if(present(default) .and. .not. foundl) then
    dat=default
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl>0 .or. (.not.present(found) .and. .not.present(default))) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_dat_REAL4_6


#endif
#endif

subroutine iotk_dat_dummy_REAL4_6
  write(0,*)
end subroutine iotk_dat_dummy_REAL4_6

# 45 "iotk_dat.spp"

# 47 "iotk_dat.spp"

!------------------------------------------------------------------------------!
! Inclusion of configuration file
#include "iotk_config.h"
!------------------------------------------------------------------------------!

# 55 "iotk_dat.spp"
#include "iotk_auxmacros.h"
# 57 "iotk_dat.spp"

# 59 "iotk_dat.spp"

#ifdef __IOTK_REAL4
#if 7 <= __IOTK_MAXRANK
# 63 "iotk_dat.spp"
subroutine iotk_write_dat_REAL4_7(unit,name,dat,dummy,attr,fmt,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_attr_interf, only : iotk_write_attr
  use iotk_write_interf
  use iotk_fmt_interf
  use iotk_str_interf
  use iotk_unit_interf
  use iotk_misc_interf
  implicit none
  integer,                intent(in)  :: unit
  character(*),           intent(in)  :: name
  REAL (kind=__IOTK_REAL4), intent(in)  :: dat (:,:,:,:,:,:,:) 
  type(iotk_dummytype), optional      :: dummy
  character(len=*), optional, intent(in)  :: attr
  character(len=*), optional, intent(in)  :: fmt
  integer,      optional, intent(out) :: ierr
  integer :: ierrl,lunit,iostat
  logical :: binary,raw
  integer(iotk_header_kind), parameter :: idummy=0
  character(300) :: usefmt,usefmt1
  character(iotk_attlenx) :: lattr
  character(iotk_attlenx) :: attr_tmp
  type (iotk_unit), pointer :: this
# 91 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL4),allocatable :: dattmp(:)
# 93 "iotk_dat.spp"
  integer :: itmp
  ierrl = 0
  iostat = 0
  lunit = iotk_phys_unit(unit)
  call iotk_unit_get(lunit,pointer=this)
  raw = .false.
  if(associated(this)) then
    raw = this%raw
  end if
  call iotk_inquire(lunit,binary=binary,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 104 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_strcpy(usefmt,"!",ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 109 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(fmt) .and. .not. raw) call iotk_strcpy(usefmt,iotk_strtrim(fmt),ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 114 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(iotk_strscan(usefmt,"<>&")/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 118 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Special characters (<>&) found in fmt string')
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"unit",unit)
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",trim(name))
# 118 "iotk_dat.spp"
call iotk_error_write(ierrl,"fmt",trim(fmt))
    goto 1
  end if
  call iotk_write_attr(lattr,"type",iotk_tolower("REAL"),first=.true.,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 123 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_attr(lattr,"size",size(dat),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 128 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
# 138 "iotk_dat.spp"
  if(binary) then
    call iotk_write_attr(lattr,"kind",kind(dat),ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 141 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
  end if
# 146 "iotk_dat.spp"
  if(.not.iotk_strcomp(usefmt,"!")) call iotk_write_attr(lattr,"fmt",iotk_strtrim(usefmt),ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 148 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(present(attr)) then
    attr_tmp(1:1)=iotk_eos
    call iotk_strcpy(attr_tmp,attr,ierr=ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 155 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"type",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 160 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"kind",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 165 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"size",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 170 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"fmt",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 175 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    call iotk_delete_attr(attr_tmp,"len",ierrl)
    if(ierrl/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 180 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
    end if
    if(iotk_strlen_trim(attr_tmp)>0) call iotk_strcat(lattr,iotk_strtrim(attr_tmp),ierr=ierrl)
  end if
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 186 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_write_begin(unit,name,lattr,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 191 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if

  allocate(dattmp(size(dat)))
# 199 "iotk_dat.spp"
#if defined(__IOTK_WORKAROUND3) || defined(__IOTK_WORKAROUND4)
# 203 "iotk_dat.spp"
     call iotk_private_pack_REAL4(dattmp,dat,size(dattmp),1)
# 205 "iotk_dat.spp"
#else
     dattmp = pack(dat,mask=.true.)
#endif
# 209 "iotk_dat.spp"

  if(binary) then
    if(raw) then
      write(lunit,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 214 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else
      write(lunit,iostat=iostat) idummy,(dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 220 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  else
    if(raw) then
# 229 "iotk_dat.spp"
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
# 231 "iotk_dat.spp"
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 232 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"*")) then
      write(lunit,*,iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 238 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    else if(iotk_strcomp(usefmt,"!")) then
# 252 "iotk_dat.spp"
     write(lunit,fmt=trim(iotk_wfmt("REAL",kind(dattmp),1,-1)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
     if(iostat/=0) then
      call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 254 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
      goto 1
     end if
# 258 "iotk_dat.spp"
    else
      write(lunit,fmt=usefmt(1:iotk_strlen(usefmt)),iostat=iostat) (dattmp(itmp),itmp=1,size(dattmp))
      if(iostat/=0) then
        call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 261 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
        goto 1
      end if
    end if
  end if
  call iotk_write_end(unit,name,ierr=ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_write_dat",__FILE__,__LINE__)
# 268 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
1 continue
  if(allocated(dattmp)) deallocate(dattmp)
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl/=0) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_write_dat_REAL4_7


# 545 "iotk_dat.spp"

# 547 "iotk_dat.spp"
subroutine iotk_scan_dat_REAL4_7(unit,name,dat,dummy,attr,found,default,ierr)
  use iotk_base
  use iotk_error_interf
  use iotk_dat_interf, only: iotk_scan_dat_aux
  use iotk_scan_interf
  use iotk_str_interf
  use iotk_misc_interf
  implicit none
  integer,                   intent(in)  :: unit
  character(*),              intent(in)  :: name
#ifdef __IOTK_WORKAROUND6
  REAL (kind=__IOTK_REAL4)                        :: dat (:,:,:,:,:,:,:)
#else
  REAL (kind=__IOTK_REAL4),           intent(out) :: dat (:,:,:,:,:,:,:)
#endif
  type(iotk_dummytype), optional         :: dummy
#ifdef __IOTK_WORKAROUND6
  character(len=*),optional              :: attr
#else
  character(len=*),optional, intent(out) :: attr
#endif
  logical,         optional, intent(out) :: found
  REAL (kind=__IOTK_REAL4), optional, intent(in)  :: default (:,:,:,:,:,:,:)
  integer,         optional, intent(out) :: ierr
# 574 "iotk_dat.spp"
  REAL (kind=__IOTK_REAL4),              allocatable :: tmpdat(:)
# 576 "iotk_dat.spp"
  integer :: ierrl,ierrl2
  integer :: rkind,rsize,rlen
  character(iotk_vallenx) :: rtype
  character(iotk_vallenx) :: fmt
  character(iotk_attlenx) :: lattr
  logical :: inside,foundl
  inside = .false.
  ierrl = 0
  ierrl2 = 0
  foundl=.false.
  call iotk_scan_begin(unit,name,lattr,found=foundl,ierr=ierrl)
  if(.not. foundl) goto 1
  foundl = .true.
  inside = .true.
  if(present(attr)) call iotk_strcpy(attr,lattr,ierrl)
  if(ierrl/=0) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 592 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  call iotk_parse_dat(lattr,rtype,rkind,rsize,rlen,fmt,ierrl)
  if(ierrl/=0) goto 1
  if(.not. (iotk_strcomp(rtype,iotk_eos) .or. iotk_strcomp(rtype,"REAL") ) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 598 "iotk_dat.spp"
call iotk_error_msg(ierrl,' ')
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"rtype",rtype(1:iotk_strlen(rtype)))
# 598 "iotk_dat.spp"
call iotk_error_write(ierrl,"type","REAL")
    goto 1
  end if
  if(.not. (rsize==-1 .or. rsize==size(dat)) ) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 602 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
    goto 1
  end if
  if(rkind==-1) rkind = kind(dat)
# 609 "iotk_dat.spp"

  allocate(tmpdat(size(dat)))
  call iotk_scan_dat_aux(unit,tmpdat,rkind,rlen,fmt(1:iotk_strlen(fmt)),ierrl)
# 615 "iotk_dat.spp"
        dat = reshape(tmpdat,shape(dat))
# 617 "iotk_dat.spp"
  deallocate(tmpdat)
1 continue
  if(inside) then
    call iotk_scan_end(unit,name,ierr=ierrl2)
    if(ierrl2/=0) then
      call iotk_error_clear(ierrl)
      ierrl=ierrl2
    end if
  end if
  if(ierrl/=0) foundl=.false.
  if(present(found)) found = foundl
  if(ierrl==0 .and. .not. present(found) .and. .not. present(default) .and. .not. foundl) then
    call iotk_error_issue(ierrl,"iotk_scan_dat",__FILE__,__LINE__)
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,"CVS Revision: 1.12 ")
# 629 "iotk_dat.spp"
call iotk_error_msg(ierrl,'Dat not found')
# 629 "iotk_dat.spp"
call iotk_error_write(ierrl,"name",name)
    ierrl = - ierrl
  end if 
  if(present(default) .and. .not. foundl) then
    dat=default
  end if
  if(present(ierr)) then
    ierr = ierrl
  else
    if(ierrl>0 .or. (.not.present(found) .and. .not.present(default))) call iotk_error_handler(ierrl)
  end if
end subroutine iotk_scan_dat_REAL4_7


#endif
#endif

subroutine iotk_dat_dummy_REAL4_7
  write(0,*)
end subroutine iotk_dat_dummy_REAL4_7

# 45 "iotk_dat.spp"

