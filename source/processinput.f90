subroutine processinput
!
!-----------------------------------------------------------------------------------------------------------------------------------
! Purpose: Process input keywords and flags
!
! Revision    Date      Author           Description
! ====================================================
!    1     2021-11-24   A.J. Koning      Original code
!-----------------------------------------------------------------------------------------------------------------------------------
!
! *** Use data from other modules
!
  use autonorm_mod
!
! *** Declaration of local data
!
  implicit none
  integer            :: i
  integer            :: imt
  integer            :: k
  integer            :: isom
  integer            :: mf
  integer            :: mt
  integer            :: mtb
  integer            :: mte
!
! Identify keywords and their values
!
  Zlib=Ztarget
  Alib=Atarget
  do k = 1, Nnorm
    isom=isom_read(k)
    if (mf_read(k) == -1) then
      mf=3
    else
      mf=mf_read(k)
    endif
    if (mt_read(k) == -1) then
      mtb=1
      mte=1000
    else
      mtb=mt_read(k)
      mte=mtb
    endif
    do mt=mtb,mte
      mfmtexist(mf,mt,isom)=.true.
      if (Z_read(k) /= -1.) Zlib(mf,mt,isom)=Z_read(k)
      if (A_read(k) /= -1.) Alib(mf,mt,isom)=A_read(k)
      if (emin_read(k) /= -1.) emin(mf,mt,isom)=emin_read(k)
      if (emax_read(k) /= -1.) emax(mf,mt,isom)=emax_read(k)
      if (ebeg_read(k) /= -1.) ebeg(mf,mt,isom)=ebeg_read(k)
      if (eend_read(k) /= -1.) eend(mf,mt,isom)=eend_read(k)
      if (norm_read(k) /= -1.) norm(mf,mt,isom)=norm_read(k)
      if (width_read(k) /= -1.) width(mf,mt,isom)=width_read(k)
      if (lib_read(k) /= ' ') then
        lib(mf,mt,isom)=lib_read(k)
      else
        lib(mf,mt,isom)=library
      endif
    enddo
!
! If partial cross sections per level are included, then the total must be included
!
    do i=1,6
      if (i == 1) then
        mt=4
        mtb=51
        mte=91
      else
        mt=101+i
        mtb=500+i*50
        mte=mtb+49
      endif
      if (.not.mfmtexist(mf,mt,-1)) then
        do imt=mtb,mte
          if (mfmtexist(mf,imt,-1)) then
            mfmtexist(mf,mt,-1)=.true.
            Zlib(mf,mt,-1)=Zlib(mf,imt,-1)
            Alib(mf,mt,-1)=Alib(mf,imt,-1)
            emin(mf,mt,-1)=emin(mf,imt,-1)
            emax(mf,mt,-1)=emax(mf,imt,-1)
            ebeg(mf,mt,-1)=ebeg(mf,imt,-1)
            eend(mf,mt,-1)=eend(mf,imt,-1)
            norm(mf,mt,-1)=norm(mf,imt,-1)
            width(mf,mt,-1)=width(mf,imt,-1)
            lib(mf,mt,-1)=lib(mf,imt,-1)
          endif
        enddo
      endif
    enddo
  enddo
  return
end subroutine processinput
