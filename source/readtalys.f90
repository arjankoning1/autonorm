subroutine readtalys(mf,mt,isom)
!
!-----------------------------------------------------------------------------------------------------------------------------------
! Purpose: Read TALYS cross sections
!
! Revision    Date      Author           Description
! ====================================================
!    1     2023-07-17   A.J. Koning      Original code
!-----------------------------------------------------------------------------------------------------------------------------------
!
! *** Use data from other modules
!
  use autonorm_mod
!
! *** Declaration of local data
!
  implicit none
  logical      :: lexist
  character*20 :: talysfile
  character(len=132) :: line        !
  character(len=132) :: key        !
  integer      :: keyix
  integer      :: istat
  integer      :: mf
  integer      :: mt
  integer      :: isom
  integer      :: nen
!
! Determine TALYS output file
!
  if (mf == 3) then
    talysfile=xsfile(mt,isom)
    etal=0.
    xstal=0.
    nental=0
!
! Read data from TALYS output file
!
    inquire (file=talysfile,exist=lexist)
    if (lexist) then
      etal(0)=0.
      open (unit=1,status='unknown',file=talysfile)
      do
        read(1,'(a)',iostat = istat) line
        if (istat == -1) exit
        key='entries'
        keyix=index(line,trim(key))
        if (keyix > 0) then
          read(line(keyix+len_trim(key)+2:80),*, iostat = istat) nental
          if (istat /= 0) exit
          read(1,'(/)')
          do nen = 1, nental
            read(1, * , iostat = istat) etal(nen),xstal(nen)
            if (istat == -1) exit
          enddo
          exit
        endif
      enddo
      close(1)
    endif
  endif
  return
end subroutine readtalys
