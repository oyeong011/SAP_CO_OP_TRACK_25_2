
*&---------------------------------------------------------------------*

*&  Include           ZEDR16_PROJECT001_TOP

*&---------------------------------------------------------------------*






TABLES : ZEDT16_LFA1.

TABLES : ZEDT16_LFB1.

TABLES : ZEDT16_LFM1.



DATA : BEGIN OF GS_LFA1.

    include structure
ZEDT16_LFA1
.

DATA : END OF GS_LFA1.

DATA : GT_LFA1 LIKE TABLE OF GS_LFA1.

" ZEDT16_LFA1 : #####

" LIFNR : #####

" NAME1 : ####

" LAND1 : ###

" KTOKK : #####

" STCD1 : ####

" STCD2 : #####

" STRAS : ##





DATA : BEGIN OF GS_LFB1.

    include structure
ZEDT16_LFB1
.

DATA : END OF GS_LFB1.

DATA : GT_LFB1 LIKE TABLE OF GS_LFB1.

" ZEDT16_LFB1 : #######

" LIFNR : #####

" BUKRS : ####

" LOEVM : #####

" AKONT : ##

" ZTERM : ####





DATA : BEGIN OF GS_LFM1.

    include structure
ZEDT16_LFM1
.

DATA : END OF GS_LFM1.

DATA : GT_LFM1 LIKE TABLE OF GS_LFM1.

" ZEDT16_LFM1 : #######

" LIFNR : #####

" EKORG : ####

" EKGRP : ####

" LOEVM : #####

" WAERS : ######

" MWSKZ : ####



DATA: BEGIN OF GS_PO_ALV,

        " ## ##

        LIFNR LIKE ZEDT16_LFA1-LIFNR,   " #####

        LOEVM LIKE ZEDT16_LFB1-LOEVM,  " #####



        " ZEDT16_LFA1 : #####

        NAME1 LIKE ZEDT16_LFA1-NAME1,  " ####

        LAND1 LIKE ZEDT16_LFA1-LAND1,  " ###

        KTOKK LIKE ZEDT16_LFA1-KTOKK,  " #####

        STCD1 LIKE ZEDT16_LFA1-STCD1,  " ####

        STCD2 LIKE ZEDT16_LFA1-STCD2,  " #####

        STRAS LIKE ZEDT16_LFA1-STRAS,  " ##



        " ZEDT16_LFB1 : #######

        BUKRS LIKE ZEDT16_LFB1-BUKRS,  " ####

        AKONT LIKE ZEDT16_LFB1-AKONT,  " ##

        ZTERM LIKE ZEDT16_LFB1-ZTERM,  " ####



        " ZEDT16_LFM1 : #######

        EKORG LIKE ZEDT16_LFM1-EKORG,  " ####

        EKGRP LIKE ZEDT16_LFM1-EKGRP,  " ####

        WAERS LIKE ZEDT16_LFM1-WAERS,  " ######

        MWSKZ LIKE ZEDT16_LFM1-MWSKZ,  " ####

      END OF GS_PO_ALV.

DATA: GT_PO_ALV LIKE TABLE OF GS_PO_ALV.



DATA : INPUT_LIFNR LIKE ZEDT16_LFA1-LIFNR,   " #####



       " ZEDT16_LFA1 : #####

       INPUT_NAME1 LIKE ZEDT16_LFA1-NAME1,  " ####

       INPUT_LAND1 LIKE ZEDT16_LFA1-LAND1,  " ###

       INPUT_KTOKK LIKE ZEDT16_LFA1-KTOKK,  " #####

       INPUT_STCD1 LIKE ZEDT16_LFA1-STCD1,  " ####

       INPUT_STCD2 LIKE ZEDT16_LFA1-STCD2,  " #####

       INPUT_STRAS LIKE ZEDT16_LFA1-STRAS,  " ##



       " ZEDT16_LFB1 : #######

       INPUT_BUKRS LIKE ZEDT16_LFB1-BUKRS,  " ####

       INPUT_AKONT LIKE ZEDT16_LFB1-AKONT,  " ##

       INPUT_ZTERM LIKE ZEDT16_LFB1-ZTERM,  " ####



       " ZEDT16_LFM1 : #######

       INPUT_EKORG LIKE ZEDT16_LFM1-EKORG,  " ####

       INPUT_EKGRP LIKE ZEDT16_LFM1-EKGRP,  " ####

       INPUT_WAERS LIKE ZEDT16_LFM1-WAERS,  " ######

       INPUT_MWSKZ LIKE ZEDT16_LFM1-MWSKZ.  " ####





DATA : OK_CODE TYPE SY-UCOMM.






*DATA : GC_DOCKING TYPE REF TO CL_GUI_DOCKING_CONTAINER.

*

*DATA : GC_GRID TYPE REF TO CL_GUI_ALV_GRID.

*

*DATA : GO_EVENT TYPE REF TO EVENT.

*

*DATA : GS_VARIANT TYPE DISVARIANT.

*

*DATA : GS_FIELDCAT TYPE LVC_S_FCAT.

*DATA : GT_FIELDCAT TYPE LVC_T_FCAT.

*DATA : GS_LAYOUT TYPE LVC_S_LAYO.

*DATA : GS_SORT TYPE LVC_S_SORT .

*DATA : GT_SORT TYPE LVC_T_SORT.