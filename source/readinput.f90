subroutine readinput
!
!-----------------------------------------------------------------------------------------------------------------------------------
! Purpose: Read input file with options
!
! Revision    Date      Author           Description
! ====================================================
!    1     2016-03-04   A.J. Koning      Original code
!-----------------------------------------------------------------------------------------------------------------------------------
!
! *** Use data from other modules
!
  use autonorm_mod
!
! *** Declaration of local data
!
  implicit none
  integer            :: i
  integer            :: k
!
! Read input
!
  Nlines=0
  inline=' '
  i=1
10 read(*,'(a80)',end=100) inline(i)
  i=i+1
  if (i.gt.numlines) then
    write(*,'(" AUTONORM-error: Number of input lines exceeds ",i5)') numlines
    write(*,'(" numlines in A0_autonorm_mod should be increased")')
    stop
  endif
  goto 10
100 Nlines=i-1
!
! ************** Convert uppercase to lowercase characters *************
!
  do i=1,Nlines
    do k=1,80
      if (inline(i)(k:k).ge.'A'.and.inline(i)(k:k).le.'Z') inline(i)(k:k)=char(ichar(inline(i)(k:k))+32)
    enddo 
  enddo 
  return
end subroutine readinput
