subroutine outrescue(mf,mt,isom)
!
!-----------------------------------------------------------------------------------------------------------------------------------
! Purpose: Output of rescue factors
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
  character*1  :: ejec
  character*9  :: hffile
  character*11 :: rescuefile
  integer      :: mf
  integer      :: mt
  integer      :: isom
  integer      :: nen
  integer      :: Zinit
  integer      :: Ainit
  integer      :: Zcomp
  integer      :: Acomp
  real         :: factor(numen)
  real         :: ee
!
! Create and write to rescue file
!
  if (mf == 3) then
    rescuefile='rescue.000 '
    write(rescuefile(8:10),'(i3.3)') mt
    if (isom >= 0) rescuefile=trim(rescuefile)//isochar(isom)
    open (unit=1,status='unknown',file=rescuefile)
    do nen=1,nental
      if (etal(nen).gt.etal(nen-1)) write(1,*) etal(nen),Crescue(nen)
    enddo
    close(1)
    write(2,'("rescuefile ",i3," ",a12,2f10.5)') mt,rescuefile,norm(mf,mt,isom),width(mf,mt,isom)
    if (flaghfnorm) then
      if (mt == 4 .or. mt == 16 .or. mt == 17 .or. mt == 18 .or. mt == 19 .or. mt == 20 .or. mt == 102 .or. mt == 103) then
        hffile='T000000.x'
        Zinit = Ztarget + parZ(k0)
        Ainit = Atarget + parZ(k0) + parN(k0)
        if (mt == 4)  then
          Zcomp = Zinit
          Acomp = Ainit
          ejec = 'n'
        endif
        if (mt == 16)  then
          Zcomp = Zinit
          Acomp = Ainit - 1
          ejec = 'n'
        endif
        if (mt == 17)  then
          Zcomp = Zinit
          Acomp = Ainit - 2
          ejec = 'n'
        endif
        if (mt == 18)  then
          Zcomp = Zinit
          Acomp = Ainit
          ejec = 'f'
        endif
        if (mt == 19)  then
          Zcomp = Zinit
          Acomp = Ainit
          ejec = 'f'
        endif
        if (mt == 20)  then
          Zcomp = Zinit
          Acomp = Ainit
          ejec = 'f'
        endif
        if (mt == 102)  then
          Zcomp = Zinit
          Acomp = Ainit
          ejec = 'g'
        endif
        if (mt == 103)  then
          Zcomp = Zinit
          Acomp = Ainit
          ejec = 'p'
        endif
        write(hffile(2:9),'(2i3.3,".",a1)') Zcomp,Acomp,ejec
        factor = 1.
        if (flagiterate) then
          open (unit=1,status='unknown',file=hffile)
          do nen=1,nental
            read(1,*) ee,factor(nen)
          enddo
          close(1)
        endif
        open (unit=1,status='unknown',file=hffile)
        do nen=1,nental
          if (etal(nen).gt.etal(nen-1).and.Crescue(nen).gt.0.) write(1,*) etal(nen),1./Crescue(nen)*factor(nen)
        enddo
        close(1)
        write(3,'("Tjadjust ",2i4," ",a1," 1. ",a12)') Zcomp,Acomp,ejec,hffile
      endif
    endif
  endif
  return
end subroutine outrescue
