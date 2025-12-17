
*&---------------------------------------------------------------------*

*&  Include           ZEDR09_035_TOP

*&---------------------------------------------------------------------*








TABLES : ZEDT09_001.



"## ######

DATA : BEGIN OF GS_STUDENT,

  ZCOLOR TYPE C LENGTH 4,

  ZCODE LIKE ZEDT09_001-ZCODE,

  ZPERNR LIKE ZEDT09_001-ZPERNR,

  ZKNAME LIKE ZEDT09_001-ZKNAME,

  ZENAME LIKE ZEDT09_001-ZENAME,

  ZGENDER LIKE ZEDT09_001-ZGENDER,

END OF GS_STUDENT.

DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.



DATA : OK_CODE TYPE SY-UCOMM.



"docking #### #### ## ## ##

DATA : GC_DOCKING TYPE REF TO CL_GUI_DOCKING_CONTAINER.



"grid ## ## ##

DATA : GC_GRID TYPE REF TO CL_GUI_ALV_GRID.



"######, ####, ## ## ##

DATA : GS_FIELDCAT TYPE LVC_S_FCAT,

       GT_FIELDCAT TYPE LVC_T_FCAT.



DATA : GS_LAYOUT TYPE LVC_S_LAYO.



DATA : GS_SORT TYPE LVC_S_SORT,

       GT_SORT TYPE LVC_T_SORT.



"#### ## ## ##

DATA : GS_VARIANT TYPE DISVARIANT.