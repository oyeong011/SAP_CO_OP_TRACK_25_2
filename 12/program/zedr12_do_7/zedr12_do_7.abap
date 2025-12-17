
*&---------------------------------------------------------------------*

*& Report ZEDR12_DO_7

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_DO_7.

DATA: BEGIN OF GS_ZEDT12,

  ZCODE TYPE ZEDT12_001-ZCODE, "####

  ZKNAME TYPE ZEDT12_001-ZKNAME, "##

  ZENAME TYPE ZEDT12_001-ZENAME, "####

  ZGENDER TYPE ZEDT12_001-ZGUBUN, "##

  ZTEL TYPE ZEDT12_001-ZTEL, "####

  END OF GS_ZEDT12.



  DATA: BEGIN OF GS_ZEDT12_2,

  ZCODE TYPE ZEDT12_001-ZCODE, "####

  ZKNAME TYPE ZEDT12_001-ZKNAME, "##

  ZENAME TYPE ZEDT12_001-ZENAME, "####

  ZGENDER TYPE ZEDT12_001-ZGUBUN, "##

  ZTEL TYPE ZEDT12_001-ZTEL, "####

  END OF GS_ZEDT12_2.



  GS_ZEDT12-ZCODE ='SSU01'.

  GS_ZEDT12-ZKNAME = '###'.

  GS_ZEDT12-ZENAME = 'KANG'.

  GS_ZEDT12-ZGENDER = 'M'.

  GS_ZEDT12-ZTEL = '123456789'.



  MOVE-CORRESPONDING GS_ZEDT12 TO GS_ZEDT12_2.  "MOVE-CORRESPONDING# ### ### ##### OK, MOVE TO# ### ## ###.



  WRITE:/ GS_ZEDT12_2-ZCODE.

  WRITE:/ GS_ZEDT12_2-ZKNAME.

  WRITE:/ GS_ZEDT12_2-ZENAME.

  WRITE:/ GS_ZEDT12_2-ZGENDER.

  WRITE:/ GS_ZEDT12_2-ZTEL.