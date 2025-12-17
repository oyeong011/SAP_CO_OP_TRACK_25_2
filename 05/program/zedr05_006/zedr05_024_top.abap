
*&---------------------------------------------------------------------*

*& Include ZEDR05_024_TOP

*&---------------------------------------------------------------------*




TABLES: ZEDT05_001.






*&-- ALV ### ### ### (## ### ## ##)




DATA: BEGIN OF GS_STUDENT,

        ZCOLOR  TYPE C LENGTH 4,        " ALV ###

        ZCODE   LIKE ZEDT05_001-ZCODE,   " ####

        ZPERNR  LIKE ZEDT05_001-ZPERNR,  " ####

        ZKNAME  LIKE ZEDT05_001-ZKNAME,  " ###

        ZENAME  LIKE ZEDT05_001-ZENAME,  " ###

        ZGENDER LIKE ZEDT05_001-ZGENDER, " ##

        ZTEL    LIKE ZEDT05_001-ZTEL,    " ####

        CRNAME  LIKE ZEDT05_001-CRNAME,  " ###

        CRDATE  LIKE ZEDT05_001-CRDATE,  " ###



        AENAME  LIKE ZEDT05_001-AENAME,  " ###

        AEDATE  LIKE ZEDT05_001-AEDATE,  " ###

        AEZEIT  LIKE ZEDT05_001-AEZEIT,  " ####

      END OF GS_STUDENT.



DATA: GT_STUDENT LIKE TABLE OF GS_STUDENT.






*&-- ## ## ##




DATA: GC_CUSTOM TYPE REF TO CL_GUI_CUSTOM_CONTAINER,

      GC_GRID   TYPE REF TO CL_GUI_ALV_GRID.






*&-- Screen ##




DATA: OK_CODE TYPE SY-UCOMM.






*&-- ALV ## ##




DATA: GS_FIELDCAT TYPE LVC_S_FCAT,

      GT_FIELDCAT TYPE LVC_T_FCAT.



DATA: GS_LAYOUT TYPE LVC_S_LAYO.



DATA: GS_SORT TYPE LVC_S_SORT,

      GT_SORT TYPE LVC_T_SORT.