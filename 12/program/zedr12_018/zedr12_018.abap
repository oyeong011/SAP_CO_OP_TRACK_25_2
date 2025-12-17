
*&---------------------------------------------------------------------*

*& Report ZEDR12_16

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_018.

DATA: GS_ZEDG12 TYPE ZTG12_ZED12.

DATA: GV_ZTITLE TYPE ZTG12_ZTITLE.



GS_ZEDG12-ZCODE = 'SSU-01'.

GS_ZEDG12-ZKNAME = '###'.

GS_ZEDG12-ZENAME = 'KANG'.

GS_ZEDG12-ZGENDER = 'M'.

GS_ZEDG12-ZTEL = '01012345678'.

GV_ZTITLE = '####'.



  WRITE:/ GS_ZEDG12-ZCODE.

  WRITE:/ GS_ZEDG12-ZKNAME.

  WRITE:/ GS_ZEDG12-ZENAME.

  WRITE:/ GS_ZEDG12-ZGENDER.

  WRITE:/ GS_ZEDG12-ZTEL.

  WRITE:/ GV_ZTITLE.