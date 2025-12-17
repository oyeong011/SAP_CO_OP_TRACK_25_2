
*&---------------------------------------------------------------------*

*&  Include           ZMMR01_001_TOP

*&---------------------------------------------------------------------*

*&--------------------------------------------------------------------*

*&  CONTROLS

*&--------------------------------------------------------------------*




CONTROLS : GC_TABSTRIP TYPE TABSTRIP.




*&--------------------------------------------------------------------*

*&  CONSTANTS

*&--------------------------------------------------------------------*




CONSTANTS : C_1 TYPE N           VALUE '1',

            C_2 TYPE N           VALUE '2',

            C_3 TYPE N           VALUE '3',

            C_4 TYPE N           VALUE '4',

            C_5 TYPE N           VALUE '5',

            C_6 TYPE N           VALUE '6',

            C_7 TYPE N           VALUE '7',

            C_8 TYPE N           VALUE '8',

            C_9 TYPE N           VALUE '9',

            C_0 TYPE N           VALUE '0',



            C_A TYPE C           VALUE 'A',

            C_B TYPE C           VALUE 'B',

            C_C TYPE C           VALUE 'C',

            C_D TYPE C           VALUE 'D',

            C_E TYPE C           VALUE 'E',

            C_F TYPE C           VALUE 'F',

            C_G TYPE C           VALUE 'G',

            C_H TYPE C           VALUE 'H',

            C_I TYPE C           VALUE 'I',

            C_J TYPE C           VALUE 'J',

            C_K TYPE C           VALUE 'K',

            C_L TYPE C           VALUE 'L',

            C_M TYPE C           VALUE 'M',

            C_N TYPE C           VALUE 'N',

            C_O TYPE C           VALUE 'O',

            C_P TYPE C           VALUE 'P',

            C_Q TYPE C           VALUE 'Q',

            C_R TYPE C           VALUE 'R',

            C_S TYPE C           VALUE 'S',

            C_T TYPE C           VALUE 'T',

            C_U TYPE C           VALUE 'U',

            C_V TYPE C           VALUE 'V',

            C_W TYPE C           VALUE 'W',

            C_X TYPE C           VALUE 'X',

            C_Y TYPE C           VALUE 'Y',

            C_Z TYPE C           VALUE 'Z'.



CONSTANTS:  C_KTOKK_DOMESTIC   TYPE ZLFA1_01-KTOKK VALUE '1000',   "##

            C_KTOKK_FOREIGN    TYPE ZLFA1_01-KTOKK VALUE '2000',   "##

            C_KTOKK_PERSON     TYPE ZLFA1_01-KTOKK VALUE '3000',   "##

            C_KTOKK_CARD       TYPE ZLFA1_01-KTOKK VALUE '4000',   "####

            C_KTOKK_BANK       TYPE ZLFA1_01-KTOKK VALUE '5000',   "####

            C_KTOKK_ONETIME    TYPE ZLFA1_01-KTOKK VALUE '9000'.   "1##



CONSTANTS : C_INSR(4) TYPE C           VALUE 'INSR',

            C_DELE(4) TYPE C           VALUE 'DELE',

            C_SAVE(4) TYPE C           VALUE 'SAVE',

            C_BACK(4) TYPE C           VALUE 'BACK',

            C_EXIT(4) TYPE C           VALUE 'EXIT',

            C_ENTR(4) TYPE C           VALUE 'ENTR',

            C_CANC(4) TYPE C           VALUE 'CANC',

            C_SALL(4) TYPE C           VALUE 'SALL',

            C_DALL(4) TYPE C           VALUE 'DALL',

            C_TEXT(4) TYPE C           VALUE 'TEXT'.




*----------------------------------------------------------------------*

* VARIANT

*----------------------------------------------------------------------*




DATA: GV_OKCODE   TYPE SY-UCOMM,

      GV_MODE     TYPE CHAR10.     " 'CREATE' 'DISPLAY'

DATA : GV_DYNNR   TYPE SY-DYNNR.




*----------------------------------------------------------------------*

* TYPES

*----------------------------------------------------------------------*






TYPES: BEGIN OF TY_100,

         LIFNR     TYPE ZLFA1_01-LIFNR,

         NAME1     TYPE ZLFA1_01-NAME1,

         KTOKK     TYPE ZLFA1_01-KTOKK,

         KTOKK_TX  TYPE CHAR30,

         STCD1     TYPE ZLFA1_01-STCD1,

         STCD2     TYPE ZLFA1_01-STCD2,

         STRAS     TYPE ZLFA1_01-STRAS,

         LAND1     TYPE ZLFA1_01-LAND1,

         ORT01     TYPE ZLFA1_01-ORT01,

         PSTLZ     TYPE ZLFA1_01-PSTLZ, "####



         BUKRS    TYPE ZLFB1_01-BUKRS,

         BUKRS_TX TYPE CHAR30,

         AKONT    TYPE ZLFB1_01-AKONT,

         AKONT_TX TYPE CHAR30,

         ZTERM    TYPE ZLFB1_01-ZTERM,

         ZTERM_TX TYPE CHAR30,

         BANKL    TYPE ZLFB1_01-BANKL,

         BANKL_TX TYPE CHAR30,

         BANKN    TYPE ZLFB1_01-BANKN,



         EKORG    TYPE ZLFM1_01-EKORG,

         EKORG_TX TYPE CHAR30,

         EKGRP    TYPE ZLFM1_01-EKGRP,

         EKGRP_TX TYPE CHAR30,

         WAERS    TYPE ZLFM1_01-WAERS,

         MWSKZ    TYPE ZLFM1_01-MWSKZ,

         MWSKZ_TX TYPE CHAR30,

        END OF TY_100.




*----------------------------------------------------------------------*

* Structure & Tables

*----------------------------------------------------------------------*




DATA : GS_DISP_100 TYPE TY_100,

       GT_DISP_100 LIKE TABLE OF GS_DISP_100.



DATA : GS_LFA1 TYPE ZLFA1_01,

       GT_LFA1 LIKE TABLE OF GS_LFA1.



DATA : GS_LFB1 TYPE ZLFB1_01,

       GT_LFB1 LIKE TABLE OF GS_LFB1.



DATA : GS_LFM1 TYPE ZLFM1_01,

       GT_LFM1 LIKE TABLE OF GS_LFM1.




*----------------------------------------------------------------------*

* Containers

*----------------------------------------------------------------------*




DATA : GC_DOCKING TYPE REF TO CL_GUI_DOCKING_CONTAINER.

DATA : GC_GRID TYPE REF TO CL_GUI_ALV_GRID.



DATA : GS_FIELDCAT TYPE LVC_S_FCAT.

DATA : GT_FIELDCAT TYPE LVC_T_FCAT.

DATA : GS_VARIANT TYPE DISVARIANT.

DATA : GS_LAYOUT TYPE LVC_S_LAYO.

DATA : GS_SORT TYPE LVC_S_SORT.

DATA : GT_SORT TYPE LVC_T_SORT.