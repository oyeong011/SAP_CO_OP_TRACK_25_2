
*&---------------------------------------------------------------------*

*&  Include           ZWORK06_001_TOP

*&---------------------------------------------------------------------*




TABLES ZTCURR06.



DATA : OK_CODE TYPE SY-UCOMM. " ## OK ##



" DB ## ###

DATA : BEGIN OF GS_ZTCURR06,

  MANDT TYPE ZTCURR06-MANDT,

  KURST TYPE ZTCURR06-KURST,  " ## ##

  FCURR TYPE ZTCURR06-FCURR,  " ## ##

  TCURR TYPE ZTCURR06-TCURR,  " ## ##

  GDATU TYPE ZTCURR06-GDATU,  " ## ###

  UKURS TYPE ZTCURR06-UKURS,  " ##

  FFACT TYPE ZTCURR06-FFACT,  " ## ## ##

  TFACT TYPE ZTCURR06-TFACT,  " ## ## ##

  AENAM TYPE ZTCURR06-AENAM,  " ###

  AEDAT TYPE ZTCURR06-AEDAT,  " ###

  END OF GS_ZTCURR06.

DATA : GT_ZTCURR06 LIKE TABLE OF GS_ZTCURR06.



" AVL ### ## TABLE

DATA : BEGIN OF GS_ZTCURR06_ALV,

  KURST TYPE ZTCURR06-KURST,  " ## ##

  FCURR TYPE ZTCURR06-FCURR,  " ## ##

  TCURR TYPE ZTCURR06-TCURR,  " ## ##

  GDATU TYPE ZTCURR06-GDATU,  " ## ###

  UKURS TYPE ZTCURR06-UKURS,  " ##

  FFACT TYPE ZTCURR06-FFACT,  " ## ## ##

  TFACT TYPE ZTCURR06-TFACT,  " ## ## ##

  AENAM TYPE SY-UNAME,        " ###

  AEDAT TYPE SY-DATUM,        " ####

  END OF GS_ZTCURR06_ALV.

DATA : GT_ZTCURR06_ALV LIKE TABLE OF GS_ZTCURR06_ALV.





" ## #### / ALV ### ##

DATA : GC_DOCKING TYPE REF TO CL_GUI_DOCKING_CONTAINER. " ## ####

DATA : GC_GRID    TYPE REF TO CL_GUI_ALV_GRID.           " ALV ###



" ## ALV# ###### / #### / ####

DATA : GS_FIELDCAT TYPE LVC_S_FCAT.     " ###### ## ##

DATA : GT_FIELDCAT TYPE LVC_T_FCAT.     " ###### ###

DATA : GS_LAYOUT   TYPE LVC_S_LAYO.     " ALV ####

DATA : GS_SORT     TYPE LVC_S_SORT.     " ## ##

DATA : GT_SORT     TYPE LVC_T_SORT.     " ## ## ###





" ####/## ### ##

DATA : GS_VARIANT TYPE DISVARIANT.      " ALV #### ##



" ### ### ####

DATA : GO_EVENT TYPE REF TO EVENT.      " ALV ### ###