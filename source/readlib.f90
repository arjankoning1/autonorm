subroutine readlib(mf,mt,isom)
!
!-----------------------------------------------------------------------------------------------------------------------------------
! Purpose: Read library cross sections
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
  logical       :: lexist
  character*4   :: massstring
  character*6   :: nuclide
  character*8   :: MTstring
  character*40  :: MTfile
  character*132 :: libfile
  character(len=132) :: line        !
  character(len=132) :: key        !
  integer      :: keyix
  integer      :: istat
  integer       :: mf
  integer       :: mt
  integer       :: isom
  integer       :: Z
  integer       :: A
  integer       :: nen
!
! Determine cross section file from data library
!
  if (mf == 3) then
    Z=Zlib(mf,mt,isom)
    A=Alib(mf,mt,isom)
    massstring='    '
    write(massstring(1:3),'(i3.3)') A
    if (isomtar /= ' ') massstring=trim(massstring)//isomtar
    MTstring='MT      '
    write(MTstring(3:5),'(i3.3)') mt
    if (isom >= 0) MTstring=trim(MTstring)//isochar(isom)
    MTstring=trim(MTstring)//'.'
    nuclide=trim(nuc(Z))//trim(massstring)
    MTfile=proj//'-'//trim(nuclide)//'-'//trim(MTstring)//trim(lib(mf,mt,isom))
    libfile=trim(libs)//proj//'/'//trim(nuclide)//'/'//trim(lib(mf,mt,isom))//'/tables/xs/'//trim(MTfile)
!
! Read data from cross section file from data library
!
    emaxlib=0.
    inquire (file=libfile,exist=lexist)
    if (lexist) then
      open (unit=1,status='unknown',file=libfile)
      do
        read(1,'(a)',iostat = istat) line
        if (istat == -1) exit
        key='entries'
        keyix=index(line,trim(key))
        if (keyix > 0) then
          read(line(keyix+len_trim(key)+2:80),*, iostat = istat) nenlib
          if (istat /= 0) exit
          read(1,'(/)')
          do nen = 1, nenlib
            read(1, * , iostat = istat) elib(nen),xslib(nen)
            if (istat == -1) exit
            if (xslib(nen).gt.0.) emaxlib=max(emaxlib,elib(nen))
          enddo
          exit
        endif
      enddo
      close(1)
    else
      write(*,*) "AUTONORM Warning: file does not exist:",libfile
    endif
  endif
  return
end subroutine readlib
