subroutine checkvalues
!
!-----------------------------------------------------------------------------------------------------------------------------------
! Purpose: Check values of keywords
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
  integer            :: type
  integer            :: i
!
! ******************* Check for wrong input variables ******************
!
! 1. Check of values for four main keywords.
!
  do type = 0, 6
    if (proj == parsym(type)) then
      k0 = type
      goto 20
    endif
  enddo
  write(*, '(" AUTONORM-error: Wrong symbol for projectile: ", a1)') proj
  stop
20 do i = 3, numA
    if (element == nuc(i)) then
      Ztarget=i
      goto 40
    endif
   enddo
  write(*, '(" AUTONORM-error: Wrong symbol for element: ", a2)') element
  stop
40 if (Atarget <= 5 .or. Atarget > numA) then
     write(*, '(" AUTONORM-error: 5 < Target mass < = ", i3)') numA
     stop
  endif
   if (isomtar /= ' ' .and. isomtar /= 'g' .and. isomtar /= 'm' .and. isomtar /= 'n') then
      write(*, '(" AUTONORM-error: isomer should be blnk, g, m or n ")')
      stop
  endif
  return
end subroutine checkvalues
