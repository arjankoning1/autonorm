subroutine normflags(inorm,flag,val,Nflag)
!
!-----------------------------------------------------------------------------------------------------------------------------------
! Purpose: Identify normalization flags from input line
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
  integer            :: inorm
  integer            :: Nflag
  integer            :: i
!
! Identify keywords and their values
!
  do i = 1, Nflag
    if (trim(flag(i)) == 'mf') read(val(i),*) mf_read(inorm)
    if (trim(flag(i)) == 'mt') read(val(i),*) mt_read(inorm)
    if (trim(flag(i)) == 'isom') read(val(i),*) isom_read(inorm)
    if (trim(flag(i)) == 'z') read(val(i),*) Z_read(inorm)
    if (trim(flag(i)) == 'a') read(val(i),*) A_read(inorm)
    if (trim(flag(i)) == 'emin') read(val(i),*) emin_read(inorm)
    if (trim(flag(i)) == 'emax') read(val(i),*) emax_read(inorm)
    if (trim(flag(i)) == 'ebeg') read(val(i),*) ebeg_read(inorm)
    if (trim(flag(i)) == 'eend') read(val(i),*) eend_read(inorm)
    if (trim(flag(i)) == 'norm') read(val(i),*) norm_read(inorm)
    if (trim(flag(i)) == 'width') read(val(i),*) width_read(inorm)
    if (trim(flag(i)) == 'lib') lib_read(inorm) = trim(val(i))
  enddo
  return
end subroutine normflags
