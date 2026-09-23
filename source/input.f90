subroutine input
!
!-----------------------------------------------------------------------------------------------------------------------------------
! Purpose: Read keywords
!
! Revision    Date      Author           Description
! ====================================================
!    1     2016-10-04   A.J. Koning      Original code
!-----------------------------------------------------------------------------------------------------------------------------------
!
! *** Use data from other modules
!
  use autonorm_mod
!
! *** Declaration of local data
!
  implicit none
  character*80       :: flag(numflag)
  character*80       :: val(numflag)
  character*1        :: ch
  character*80       :: word(40),value
  character*80       :: key
  character*80       :: line
  integer            :: i
  integer            :: Nflag
  integer            :: inorm
!
! Default values for options
!
  library='irdff2.0'
  isomtar=' '
  mf_read=-1
  mt_read=-1
  isom_read=-1
  emin_read=-1.
  emax_read=-1.
  ebeg_read=-1.
  eend_read=-1.
  norm_read=-1.
  width_read=-1.
  lib_read=' '
  Z_read=-1
  A_read=-1
  mfmtexist=.false.
  flaghfnorm=.false.
  flagiterate=.false.
  emin=0.
  emax=20.
  ebeg=0.
  eend=20.
  norm=1.
  width=0.05
  flag=' '
  val=' '
!
! Read input
!
  inorm = 0
  do i=1,Nlines
    line=inline(i)
    call getkeywords(line,word)
    key=word(1)
    value=word(2)
    ch=word(2)(1:1)
    if (key.eq.'projectile') then
      proj=ch
      cycle
    endif
    if (key.eq.'element') then
      element=trim(value)
      element(1:1)=char(ichar(element(1:1))-32)
      cycle
    endif
    if (key.eq.'mass') then
      read(value,*,end=100,err=100) Atarget
      cycle
    endif
    if (key.eq.'isomer') then
      isomtar=ch
      cycle
    endif
    if (key.eq.'library') then
      library=trim(value)
      cycle
    endif
    if (key.eq.'norm') then
      inorm = inorm + 1
      call getflags(line,flag,val,Nflag)
      call normflags(inorm,flag,val,Nflag)
      cycle
    endif
    if (key.eq.'nonorm') then
    endif
    if (key == 'hfnorm') then
      if (ch == 'n') flaghfnorm = .false.
      if (ch == 'y') flaghfnorm = .true.
      cycle
    endif
    if (key == 'iterate') then
      if (ch == 'n') flagiterate = .false.
      if (ch == 'y') flagiterate = .true.
      cycle
    endif
  enddo
  Nnorm = inorm
  return
100 write(*,'(" AUTONORM-error: Wrong input: ",a80)') line
  stop
end subroutine input
