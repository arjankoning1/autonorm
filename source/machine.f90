subroutine machine
!
!-----------------------------------------------------------------------------------------------------------------------------------
! Purpose: Machine dependent statements
!
! Revision    Date      Author           Description
! ====================================================
!    1     2023-10-27   A.J. Koning      Original code
!    2     2026-08-28   A.J. Koning      Runtime definition of AUTONORM directory
!-----------------------------------------------------------------------------------------------------------------------------------
!
! *** Use data from other modules
!
  use autonorm_mod
!
! *** Declaration of local data
!
  implicit none
  character(len=1024) :: code_dir
  character(len=1024) :: base_dir
  character(len=1024) :: autonorm_dir
  integer             :: envstat
  integer             :: i
  integer             :: n
!
! ************************ Set directories *****************************
!
! The preferred option is to set the environment variable AUTONORM_DIR,
! for example in ~/.profile or ~/.zshrc:
!
! export AUTONORM_DIR=/path/to/autonorm
!
  call get_environment_variable('AUTONORM_DIR', autonorm_dir, length=n, status=envstat)
  if (envstat == 0 .and. n > 0) then
    code_dir = trim(autonorm_dir)
  else
!
! If the environment variable cannot be used, the code directory can be
! changed here manually.
!
    code_dir = '/path/to/autonorm/'
  endif
!
! Remove a trailing slash, if present, and determine the parent directory.
!
  i = len_trim(code_dir)
  if (i > 1) then
    if (code_dir(i:i) == '/') code_dir = code_dir(:i - 1)
  endif
  i = scan(trim(code_dir), '/', back=.true.)
  if (i > 0) then
    base_dir = code_dir(:i)
  else
    base_dir = './'
  endif
!
! The nuclear-data libraries are expected as a sibling directory of
! AUTONORM.
!
  libs = trim(base_dir)//'libraries/'
  return
end subroutine machine
