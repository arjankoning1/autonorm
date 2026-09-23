subroutine checkkeyword
!
!-----------------------------------------------------------------------------------------------------------------------------------
! Purpose: Check keywords
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
  character*80       :: word(40)
  character*80       :: key
  integer, parameter :: numkey=10
  character*80       :: keyword(numkey)
  integer            :: i
  integer            :: j
!
! Keywords
!
  data (keyword(i),i=1,numkey) / ' ', 'element', 'hfnorm', 'isomer', 'iterate', 'library', 'mass', 'nonorm', 'norm', 'projectile'/
!
! Check
!
  A: do i=1,Nlines
    call getkeywords(inline(i),word)
    key=word(1)
    if (key(1:1).eq.'#') cycle
    do j=1,numkey
      if (keyword(j).eq.key) cycle A
    enddo
    write(*,'(/" AUTONORM-error: Wrong keyword: ",a20)') key
    stop
  enddo A
  return
end subroutine checkkeyword
