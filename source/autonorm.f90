program autonorm
!
!-----------------------------------------------------------------------------------------------------------------------------------
! Purpose   : Adopt external data into TALYS and normalize
!
! Author    : Arjan Koning
!
! 2025-12-18: Current revision
!-----------------------------------------------------------------------------------------------------------------------------------
!
!   |-------------------------------------------------------|
!   |                 AUTONORM-2.2                          |
!   |                 Arjan Koning                          |
!   |                                                       |
!   | Email: A.Koning@iaea.org                              |
!   |-------------------------------------------------------|
!
! MIT License
!
! Copyright (c) 2025 Arjan Koning
!
! Permission is hereby granted, free of charge, to any person obtaining a copy
! of this software and associated documentation files (the "Software"), to deal
! in the Software without restriction, including without limitation the rights
! to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
! copies of the Software, and to permit persons to whom the Software is
! furnished to do so, subject to the following conditions:
!
! The above copyright notice and this permission notice shall be included in all
! copies or substantial portions of the Software.
!
! THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
! IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
! FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
! AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
! LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
! OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
! SOFTWARE.
!
  use autonorm_mod
!
! *** Declaration of local data
!
  implicit none
  integer            :: mf                                   !
  integer            :: mt                                   !
  integer            :: isom                                 !
!
! Initialization
!
  call machine
  call constants
!
! Input 
!
  call autonorminput
!
! Initialization
!
  call initial
!
! Read data from TALYS output files and data libraries and normalize
!
  open (unit=2,status='unknown',file='rescue.add')
  if (flaghfnorm) open (unit=3,status='unknown',file='hfnorm.add')
  do mf = 1, nummf
    do mt = 1, nummt
      do isom = -1, numisom
        if (mfmtexist(mf,mt,isom)) then
          call readtalys(mf,mt,isom)
          call readlib(mf,mt,isom)
          call rescue(mf,mt,isom)
          call outrescue(mf,mt,isom)
        endif
      enddo
    enddo
  enddo
  close(2)
  if (flaghfnorm) close(3)
end program autonorm
! Copyright A.J. Koning 2025
