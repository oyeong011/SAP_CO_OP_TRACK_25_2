
*&---------------------------------------------------------------------*

*&  Include           ZMM06_001_TOP

*&---------------------------------------------------------------------*




TABLES : ZEDT06_LFA1,

         ZEDT06_LFB1,

         ZEDT06_LFM1.




*&---------------------------------------------------------------------*

*& USER COMMAND ### ## OK_CODE.

*&---------------------------------------------------------------------*




DATA : OK_CODE TYPE SY-UCOMM.

DATA : GV_MODE TYPE C.




*&---------------------------------------------------------------------*

*& ### ## #### ## ###

*&---------------------------------------------------------------------*




DATA : BEGIN OF GS_LFA1,

  LIFNR TYPE ZEDT06_LFA1-LIFNR, " #####

  NAME1 TYPE ZEDT06_LFA1-NAME1, " ####

  LAND1 TYPE ZEDT06_LFA1-LAND1, " ###

  KTOKK TYPE ZEDT06_LFA1-KTOKK, " #####

  STCD1 TYPE ZEDT06_LFA1-STCD1, " ####

  STCD2 TYPE ZEDT06_LFA1-STCD2, " #####

  STRAS TYPE ZEDT06_LFA1-STRAS, " ##

  KTOKK_N TYPE C LENGTH 20,     " ##### #

  END OF GS_LFA1.

DATA : GT_LFA1 LIKE TABLE OF GS_LFA1.

DATA : BEGIN OF GS_LFB1,

  LIFNR TYPE ZEDT06_LFB1-LIFNR, " #####

  BUKRS TYPE ZEDT06_LFB1-BUKRS, " ####

  LOEVM TYPE ZEDT06_LFB1-LOEVM, " #####

  AKONT TYPE ZEDT06_LFB1-AKONT, " ##

  ZTERM TYPE ZEDT06_LFB1-ZTERM, " ####

  AKONT_N TYPE C LENGTH 20 ,    " ## #

  ZTERM_N TYPE C LENGTH 20,     " #### #

  END OF GS_LFB1.

DATA : GT_LFB1 LIKE TABLE OF GS_LFB1.

DATA : BEGIN OF GS_LFM1,

  LIFNR TYPE ZEDT06_LFM1-LIFNR, " #####

  EKORG TYPE ZEDT06_LFM1-EKORG, " ####

  EKGRP TYPE ZEDT06_LFM1-EKGRP, " ####

  LOEVM TYPE ZEDT06_LFM1-LOEVM, " #####

  WAERS TYPE ZEDT06_LFM1-WAERS, " ######

  MWSKZ TYPE ZEDT06_LFM1-MWSKZ, " ####

  MWSKZ_N TYPE C LENGTH 20,     " #### #

  END OF GS_LFM1.

DATA : GT_LFM1 LIKE TABLE OF GS_LFM1.




*&---------------------------------------------------------------------*

*& ## #### ### ## ##.

*&---------------------------------------------------------------------*




"===== LFA1 ## ### =====

DATA: LIFNR_A1     TYPE ZEDT06_LFA1-LIFNR,

      NAME1     TYPE ZEDT06_LFA1-NAME1,

      LAND1     TYPE ZEDT06_LFA1-LAND1,

      KTOKK     TYPE ZEDT06_LFA1-KTOKK,

      STCD1     TYPE ZEDT06_LFA1-STCD1,

      STCD2     TYPE ZEDT06_LFA1-STCD2,

      STRAS     TYPE ZEDT06_LFA1-STRAS.

"===== LFB1 #### ### =====

DATA: LIFNR_B1  TYPE ZEDT06_LFB1-LIFNR,

      BUKRS     TYPE ZEDT06_LFB1-BUKRS,

      LOEVM_B1  TYPE ZEDT06_LFB1-LOEVM,

      AKONT     TYPE ZEDT06_LFB1-AKONT,

      ZTERM     TYPE ZEDT06_LFB1-ZTERM.

"===== LFM1 #### ### =====

DATA: LIFNR_M1  TYPE ZEDT06_LFM1-LIFNR,

      EKORG     TYPE ZEDT06_LFM1-EKORG,

      EKGRP     TYPE ZEDT06_LFM1-EKGRP,

      LOEVM_M1  TYPE ZEDT06_LFM1-LOEVM,

      WAERS     TYPE ZEDT06_LFM1-WAERS,

      MWSKZ     TYPE ZEDT06_LFM1-MWSKZ.




*&---------------------------------------------------------------------*

*& ## ### ##

*&---------------------------------------------------------------------*




DATA: BEGIN OF GS_ALV,

        LIFNR     TYPE ZEDT06_LFA1-LIFNR,

        LIFNR_A1  TYPE ZEDT06_LFA1-LIFNR,

        NAME1     TYPE ZEDT06_LFA1-NAME1,

        LAND1     TYPE ZEDT06_LFA1-LAND1,

        KTOKK_N   TYPE C LENGTH 20,         " ##### #

        KTOKK     TYPE ZEDT06_LFA1-KTOKK,

        STCD1     TYPE ZEDT06_LFA1-STCD1,

        STCD2     TYPE ZEDT06_LFA1-STCD2,

        STRAS     TYPE ZEDT06_LFA1-STRAS,

        LIFNR_B1  TYPE ZEDT06_LFB1-LIFNR,

        BUKRS     TYPE ZEDT06_LFB1-BUKRS,

        LOEVM_B1  TYPE ZEDT06_LFB1-LOEVM,

        AKONT_N   TYPE C LENGTH 20 ,        " ## #

        ZTERM_N   TYPE C LENGTH 20,         " #### #

        LIFNR_M1  TYPE ZEDT06_LFM1-LIFNR,

        EKORG     TYPE ZEDT06_LFM1-EKORG,

        EKGRP     TYPE ZEDT06_LFM1-EKGRP,

        LOEVM_M1  TYPE ZEDT06_LFM1-LOEVM,

        WAERS     TYPE ZEDT06_LFM1-WAERS,   " #### #

        MWSKZ_N   TYPE C LENGTH 20,

      END OF GS_ALV.




*&---------------------------------------------------------------------*

*& ## ### ## CONTAINER ## ## ## ##.

*&---------------------------------------------------------------------*




" ## #### / ALV ### ##

DATA : GC_DOCKING TYPE REF TO CL_GUI_DOCKING_CONTAINER.

DATA : GC_GRID TYPE REF TO CL_GUI_ALV_GRID.

" ALV ###### / #### / ####

DATA : GS_FIELDCAT TYPE LVC_S_FCAT.

DATA : GT_FIELDCAT TYPE LVC_T_FCAT.

DATA : GS_LAYOUT TYPE LVC_S_LAYO.

DATA : GS_SORT TYPE LVC_S_SORT.

DATA : GT_SORT TYPE LVC_T_SORT.