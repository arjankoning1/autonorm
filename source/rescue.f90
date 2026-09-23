subroutine rescue(mf,mt,isom)
!
!-----------------------------------------------------------------------------------------------------------------------------------
! Purpose: Rescue factors
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
  logical      :: first
  integer      :: mf
  integer      :: mt
  integer      :: isom
  integer      :: nenfirst
  integer      :: nenlast
  integer      :: nen
  integer      :: nen2
  real         :: E1
  real         :: E2
  real         :: E3
  real         :: E4
  real         :: E
  real         :: xs
  real         :: ea
  real         :: eb
  real         :: xsa
  real         :: xsb
  real         :: ealog
  real         :: eblog
  real         :: eelog
  real         :: xsalog
  real         :: xsblog
  real         :: Efac
!
! Determine rescue factors on TALYS energy grid
!
  E1=emin(mf,mt,isom)
  E2=ebeg(mf,mt,isom)
  E3=eend(mf,mt,isom)
  E4=emax(mf,mt,isom)
  if (mf == 3) then
    if (E4.eq.-1..and.emaxlib.gt.0.) then
      E4=emaxlib
    else
      E4=20.
    endif
    if (E3.eq.-1.) E3=E4
    first=.false.
    nenfirst=0
    nenlast=10000000
    do nen=1,nental
      E=etal(nen)
      Crescue(nen)=1.
      xs=0.
      if (E.ge.E2.and.E.le.E3) then
        do nen2=1,nenlib-1
          ea=elib(nen2)
          eb=elib(nen2+1)
          if (E.ge.ea.and.E.le.eb) then
            xsa=xslib(nen2)
            xsb=xslib(nen2+1)
            if (ea.gt.0..and.eb.gt.0..and.xsa.gt.0..and.xsb.gt.0..and.ea.ne.eb.and.xsa.ne.xsb) then
              ealog=log(ea)
              eblog=log(eb)
              eelog=log(E)
              xsalog=log(xsa)
              xsblog=log(xsb)
              Efac=(eelog-ealog)/(eblog-ealog)
              xs=exp(xsalog+Efac*(xsblog-xsalog))
            else
              Efac=(E-ea)/(eb-ea)
              xs=xsa+Efac*(xsb-xsa)
            endif
            exit
          endif
        enddo
        if (xs.ge.eps.and.xstal(nen).ge.eps) Crescue(nen)=xstal(nen)/xs
        if (.not.first) then
          nenfirst=nen
          first=.true.
        endif
        nenlast=nen
      endif
    enddo
    if (E1.lt.E2) then
      do nen=1,nenfirst-1
        E=etal(nen)
        if (E.gt.E1.and.E.lt.E2) then
          Efac=(E-E1)/(E2-E1)
          Crescue(nen)=1.+Efac*(Crescue(nenfirst)-1.)
        endif
      enddo
    endif
    if (E4.gt.E3) then
      do nen=nenlast+1,nental
        E=etal(nen)
        if (E.ge.E3.and.E.le.E4) then
          Efac=(E-E3)/(E4-E3)
          Crescue(nen)=Crescue(nenlast)+Efac*(1.-Crescue(nenlast))
        endif
      enddo
    else
!     do nen=nenlast+1,nental
!       Crescue(nen)=Crescue(nenlast)
!     enddo
    endif
  endif
  return
end subroutine rescue
