subroutine initial
!
!-----------------------------------------------------------------------------------------------------------------------------------
! Purpose: Initialize data
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
  logical      :: lexist
  character*20 :: xshead(nummt)
  integer      :: i
  integer      :: type
  integer      :: i0
  integer      :: imt
  integer      :: imtcon
  integer      :: offset
!
! Each MT-number corresponds to a certain number of particles in the
! outgoing channel.
!
! Partial cross sections
!
  eps=1.e-10
  xsfile=' '
  xshead=' '
  xshead(4)='xs100000'
  xshead(11)='xs201000'
  xshead(16)='xs200000'
  xshead(17)='xs300000'
  xshead(18)='fission'
  xshead(19)='xs000000'
  xshead(20)='xs100000'
  xshead(21)='xs200000'
  xshead(22)='xs100001'
  xshead(23)='xs100003'
  xshead(24)='xs200001'
  xshead(25)='xs300001'
  xshead(28)='xs110000'
  xshead(29)='xs100002'
  xshead(30)='xs200002'
  xshead(32)='xs101000'
  xshead(33)='xs100100'
  xshead(34)='xs100010'
  xshead(35)='xs101002'
  xshead(36)='xs100102'
  xshead(37)='xs400000'
  xshead(38)='xs300000'
  xshead(41)='xs210000'
  xshead(42)='xs310000'
  xshead(44)='xs120000'
  xshead(45)='xs110001'
  xshead(102)='xs000000'
  xshead(103)='xs010000'
  xshead(104)='xs001000'
  xshead(105)='xs000100'
  xshead(106)='xs000010'
  xshead(107)='xs000001'
  xshead(108)='xs000002'
  xshead(109)='xs000003'
  xshead(111)='xs020000'
  xshead(112)='xs010001'
  xshead(113)='xs000102'
  xshead(114)='xs001002'
  xshead(115)='xs011000'
  xshead(116)='xs010100'
  xshead(117)='xs001001'
!
! Total cross sections
!
  xsfile(1,-1)='endftot.tot'
  inquire (file=xsfile(1,-1),exist=lexist)
  if (.not.lexist) xsfile(1,-1)='totalxs.tot'
  xsfile(2,-1)='endfel.tot'
  inquire (file=xsfile(2,-1),exist=lexist)
  if (.not.lexist) xsfile(2,-1)='elastic.tot'
  xsfile(3,-1)='endfnon.tot'
  inquire (file=xsfile(3,-1),exist=lexist)
  if (.not.lexist) xsfile(3,-1)='nonelastic.tot'
  do i = 4, nummt
    if (xshead(i) /= ' ' ) then
      xsfile(i,-1) = trim(xshead(i))//'.tot'
      xsfile(i,0) = trim(xshead(i))//'.L00'
      xsfile(i,1) = trim(xshead(i))//'.L01'
    endif
  enddo
  xsfile(19,-1) = trim(xshead(19))//'.fis'
  xsfile(20,-1) = trim(xshead(20))//'.fis'
  xsfile(21,-1) = trim(xshead(21))//'.fis'
  xsfile(38,-1) = trim(xshead(38))//'.fis'
!
! Discrete level cross sections
!
  do type=1,6
    if (type.eq.1) then
      i0=1
      offset=50
      imtcon=91
    else
      i0=0
      offset=500+50*type
      imtcon=offset+49
    endif
    do i=i0,40
      imt=offset+i
      xsfile(imt,-1)='nn.L00'
      write(xsfile(imt,-1)(2:2),'(a1)') parsym(type)
      write(xsfile(imt,-1)(5:6),'(i2.2)') i
    enddo    
    xsfile(imtcon,-1)='nn.con'
    write(xsfile(imtcon,-1)(2:2),'(a1)') parsym(type)
  enddo    
  return
end subroutine initial
