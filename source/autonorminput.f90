subroutine autonorminput
!
!-----------------------------------------------------------------------------------------------------------------------------------
! Purpose: Read and process input
!
! Revision    Date      Author           Description
! ====================================================
!    1     2016-10-12   A.J. Koning      Original code
!-----------------------------------------------------------------------------------------------------------------------------------
!
!
! Input 
!
  call readinput
  call input
  call checkkeyword
  call checkvalues
  call processinput
end
