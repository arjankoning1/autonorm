subroutine getflags(line,flag,val,Nflag)
!
!-----------------------------------------------------------------------------------------------------------------------------------
! Purpose: Get flags from input line
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
  character*80       :: line
  character*80       :: flag(numflag)
  character*80       :: val(numflag)
  integer            :: lline
  integer            :: k
  integer            :: i
  integer            :: j
  integer            :: l
  integer            :: Nflag
  integer            :: equal(numflag)
  integer            :: abeg
  integer            :: aend
  integer            :: bbeg
  integer            :: bend
!
! Count number of = signs and determine position
!
  lline = 80
  k = 0
  do i = 1, lline
    if (line(i:i) == '=') then
      k=k+1
      equal(k) = i
    endif
  enddo
  Nflag = k
  do k = 1, Nflag
    abeg = 0
    aend = 80
    loopA: do j = equal(k)-1, 1, -1
      if (line(j:j) /= ' ') then
        aend = j
        do l = j-1, 1, -1
          if (line(l:l) == ' ') then
            abeg=l+1
            exit loopA
          endif
        enddo
        exit
      endif
    enddo loopA
    flag(k) = line(abeg:aend)
    bbeg = 0
    bend = 80
    loopB: do j = equal(k)+1, lline
      if (line(j:j) /= ' ') then
        bbeg = j
        do l = j+1, lline
          if (line(l:l) == ' ') then
            bend=l-1
            exit loopB
          endif
        enddo
        exit
      endif
    enddo loopB
    val(k) = line(bbeg:bend)
  enddo
  return
end subroutine getflags
