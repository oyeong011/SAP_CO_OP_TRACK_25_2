
*&---------------------------------------------------------------------*

*&  Include           ZCLASS_EVENT18_TOP

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&  Include  ZEDR018_020_TOP

*&---------------------------------------------------------------------*




TABLES : ZEDT018_001.





DATA : BEGIN OF GS_STUDENT,

         ICON(4),

         ZCODE   TYPE ZEDT018_001-ZCODE,

         ZPERNR  TYPE ZEDT018_001-ZPERNR,

         ZKNAME  TYPE ZEDT018_001-ZKNAME,

         ZENAME  TYPE ZEDT018_001-ZENAME,

         ZGENDER TYPE ZEDT018_001-ZGENDER,

         ZTEL    TYPE ZEDT018_001-ZTEL,

       END OF GS_STUDENT.

DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.



DATA : GS_SAVE TYPE ZEDT018_001.

DATA : GT_SAVE LIKE TABLE OF GS_SAVE.



DATA : GV_CHECK(1).



DATA : GC_DOCKING TYPE REF TO CL_GUI_DOCKING_CONTAINER.

DATA : GC_GRID TYPE REF TO CL_GUI_ALV_GRID.



DATA : GO_EVENT TYPE REF TO EVENT. "EVNET ## ##



DATA : GS_VARIANT TYPE DISVARIANT.



" SCREEN OK CODE

DATA : OK_CODE TYPE SY-UCOMM. " ### ## ### ### ###### ### ## ####### ### ## ##.



DATA : GS_FIELDCAT TYPE LVC_S_FCAT.

DATA : GT_FIELDCAT TYPE LVC_T_FCAT.



DATA : GS_LAYOUT TYPE LVC_S_LAYO.



DATA : GS_SORT TYPE LVC_S_SORT.

DATA : GT_SORT TYPE LVC_T_SORT.