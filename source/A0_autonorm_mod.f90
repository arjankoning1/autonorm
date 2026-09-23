module autonorm_mod
!
!-----------------------------------------------------------------------------------------------------------------------------------
! Purpose: All global variables
!
! Revision    Date      Author           Description
! ====================================================
!    1     2025-12-18   A.J. Koning      Original code
!-----------------------------------------------------------------------------------------------------------------------------------
!
  implicit none
  integer, parameter :: sgl = selected_real_kind(6,37)       ! single precision kind
  integer, parameter :: dbl = selected_real_kind(15,307)     ! double precision kind
  integer, parameter :: numlines=1000                      !
  integer, parameter :: numlib=7                              !
  integer, parameter :: numen=1000000                         !
  integer, parameter :: nummf=40                             !
  integer, parameter :: nummt=1000                           !
  integer, parameter :: numnorm=100                           !
  integer, parameter :: numpar=6                              !
  integer, parameter :: numisom=2                              !
  integer, parameter :: numZ=124                          !
  integer, parameter :: numA=414                          !
  integer, parameter :: numflag=20
!
! machine 
!
  character*80       :: libs
!
! readinput 
!
  character*80       :: inline(numlines)
  integer            :: Nlines                           !
!
! input
!
  logical            :: mfmtexist(nummf,nummt,-1:numisom)
  logical            :: flaghfnorm
  logical            :: flagiterate
  character*1        :: proj
  character*1        :: isomtar
  character*2        :: element
  character*20       :: library
  character*20       :: lib_read(numnorm)
  character*20       :: lib(nummf,nummt,-1:numisom)
  integer            :: Ztarget
  integer            :: Atarget
  integer            :: k0
  integer            :: Nnorm
  integer            :: mf_read(numnorm)
  integer            :: mt_read(numnorm)
  integer            :: isom_read(numnorm)
  integer            :: Z_read(numnorm)
  integer            :: A_read(numnorm)
  integer            :: Zlib(nummf,nummt,-1:numisom)
  integer            :: Alib(nummf,nummt,-1:numisom)
  real               :: emin_read(numnorm)
  real               :: emax_read(numnorm)
  real               :: ebeg_read(numnorm)
  real               :: eend_read(numnorm)
  real               :: norm_read(numnorm)
  real               :: width_read(numnorm)
  real               :: emin(nummf,nummt,-1:numisom)
  real               :: emax(nummf,nummt,-1:numisom)
  real               :: ebeg(nummf,nummt,-1:numisom)
  real               :: eend(nummf,nummt,-1:numisom)
  real               :: norm(nummf,nummt,-1:numisom)
  real               :: width(nummf,nummt,-1:numisom)
!
! constants
!
  character*1        :: parsym(-1:numpar)
  character*1        :: isochar(-1:numisom)
  character*2        :: nuc(numZ)
  character*20       :: worldlib(numlib)
  integer            :: parZ(0:numpar)
  integer            :: parN(0:numpar)
!
! initial
!
  real               :: eps
  character*20       :: xsfile(nummt,-1:numisom)
!
! readtalys
!
  integer            :: nental
  real               :: etal(0:numen)
  real               :: xstal(0:numen)
!
! readlib
!
  integer            :: nenlib
  real               :: elib(0:numen)
  real               :: xslib(0:numen)
  real               :: emaxlib
!
! rescue
!
  real               :: Crescue(numen)
end module
