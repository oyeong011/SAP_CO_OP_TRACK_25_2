
*&---------------------------------------------------------------------*

*&  Include           ZWORK01_001_TOP

*&---------------------------------------------------------------------*




DATA: GT_EXCEL TYPE STANDARD TABLE OF ALSMEX_TABLINE,

      GS_EXCEL TYPE ALSMEX_TABLINE.



" ## #### ### ## (ZTCURR00# ##)






*---------------------------------------------------------------------*

* Table structure for ZTCURR01

*---------------------------------------------------------------------*




TYPES: BEGIN OF TY_CURR,

         MANDT  TYPE MANDT,

         KURST  TYPE ZTCURR01-KURST, "####

         FCURR  TYPE ZTCURR01-FCURR, "####

         TCURR  TYPE ZTCURR01-TCURR, "####

         GDATU  TYPE ZTCURR01-GDATU, "####

         UKURS  TYPE ZTCURR01-UKURS, "##

         FFACT  TYPE ZTCURR01-FFACT, "####

         TFACT  TYPE ZTCURR01-TFACT, "####

         CRNAME TYPE ZTCURR01-CRNAME,

         CRDATE TYPE ZTCURR01-CRDATE,

         CRZEIT TYPE ZTCURR01-CRZEIT,

       END OF TY_CURR.



DATA: GT_CURR TYPE STANDARD TABLE OF TY_CURR,

      GS_CURR LIKE LINE OF GT_CURR.

DATA : GS_CURR_SAVE TYPE ZTCURR01.

DATA : GT_CURR_SAVE LIKE TABLE OF GS_CURR_SAVE.



DATA : OK_CODE TYPE SY-UCOMM.                           " SCREEN OK_CODE

CONSTANTS : GV_GRID_SIZE TYPE I VALUE 2000.

DATA : GC_DOCKING TYPE REF TO CL_GUI_DOCKING_CONTAINER. "DOCKING CONTAINER #### ##

DATA : GC_GRID TYPE REF TO CL_GUI_ALV_GRID.             "GRID ### ##



DATA : GS_FIELDCAT TYPE LVC_S_FCAT.                     "ALV FCAT ### ### ##

DATA : GT_FIELDCAT TYPE LVC_T_FCAT.

DATA : GS_VARIANT TYPE DISVARIANT.                      "ALV VARIANT ##

DATA : GS_LAYOUT TYPE LVC_S_LAYO.                       "ALV LAYOUT ##

DATA : GS_SORT TYPE LVC_S_SORT.                         "ALV SORT ### ### ##

DATA : GT_SORT TYPE LVC_T_SORT.



INCLUDE <ICON>.

TABLES: SSCRFIELDS.



DATA G_FKEY TYPE SMP_DYNTXT.



DATA : GO_EVENT TYPE REF TO EVENT.

DATA: GT_EXCLUDE TYPE UI_FUNCTIONS,

      GS_EXCLUDE TYPE UI_FUNC.