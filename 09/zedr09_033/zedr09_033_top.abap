
*&---------------------------------------------------------------------*

*&  Include           ZEDT09_033_TOP

*&---------------------------------------------------------------------*






TABLES : ZEDT09_001.



"## ######

DATA : BEGIN OF GS_STUDENT,

  ZCOLOR TYPE C LENGTH 4,

  ZCODE LIKE ZEDT09_001-ZCODE,    "####

  ZPERNR LIKE ZEDT09_001-ZPERNR,  "####

  ZKNAME LIKE ZEDT09_001-ZKNAME,  "##

  ZENAME LIKE ZEDT09_001-ZENAME,  "####

  ZGENDER LIKE ZEDT09_001-ZGENDER, "##

END OF GS_STUDENT.

DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.



"### ## ### ###, ###### ### ## ####### ### ## ##

DATA : OK_CODE TYPE SY-UCOMM.



"######, ####, ##

DATA : GS_FIELDCAT TYPE SLIS_FIELDCAT_ALV.

DATA : GT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV.



DATA : GS_LAYOUT TYPE SLIS_LAYOUT_ALV.



DATA : GS_SORT TYPE SLIS_SORTINFO_ALV.

DATA : GT_SORT TYPE SLIS_T_SORTINFO_ALV.