
*&---------------------------------------------------------------------*

*&  Include           ZEDR04_084_TOP

*&---------------------------------------------------------------------*




TABLES : ZEDT04_001.  " SELECT-OPTIONS# #### ##





DATA : BEGIN OF GS_STUDENT.

  include structure
ZEDT04_001
.

  DATA : ICON(4),

  END OF GS_STUDENT.

DATA GT_STUDENT LIKE TABLE OF GS_STUDENT.



DATA GS_SAVE TYPE ZEDT04_001. " ###

DATA GT_SAVE LIKE TABLE OF GS_SAVE.



DATA : GO_EVENT TYPE REF TO EVENT.  " ##. EVENT## #### ZEDR04_084_CLS## ### #



DATA : OK_CODE TYPE SY-UCOMM. " 100# ##### ### ### ##. USER_COMMAND## ##



DATA : GC_DOCKING TYPE REF TO CL_GUI_DOCKING_CONTAINER.

DATA : GC_GRID TYPE REF TO CL_GUI_ALV_GRID.



DATA : GS_VARIANT TYPE DISVARIANT.  " ALV####(####ID, #####, #### ## # ##)



" ## ####. FUNCTION 'SET_TABLE_FOR_FIRST_DISPLAY'## ##

DATA GS_FIELDCAT TYPE LVC_S_FCAT.

DATA GT_FIELDCAT TYPE LVC_T_FCAT.

" ALV ####

DATA GS_LAYOUT TYPE LVC_S_LAYO.



" ALV SORT ### ##

DATA GS_SORT TYPE LVC_S_SORT.

DATA GT_SORT TYPE LVC_T_SORT.