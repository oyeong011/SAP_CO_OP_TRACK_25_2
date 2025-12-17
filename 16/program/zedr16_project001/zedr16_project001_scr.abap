
*&---------------------------------------------------------------------*

*&  Include           ZEDR16_PROJECT001_SCR

*&---------------------------------------------------------------------*






SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

PARAMETERS : P_BUKRS1 TYPE ZEDT16_LFB1-BUKRS MODIF ID MD1,

             P_KTOKK  TYPE ZEDT16_LFA1-KTOKK MODIF ID MD1.

SELECTION-SCREEN END OF BLOCK B1.



SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

PARAMETERS : P_LIFNR  TYPE ZEDT16_LFA1-LIFNR MODIF ID MD2,

             P_BUKRS2 TYPE ZEDT16_LFB1-BUKRS MODIF ID MD2.

SELECTION-SCREEN END OF BLOCK B2.



SELECTION-SCREEN BEGIN OF BLOCK B3 WITH FRAME.

PARAMETERS: P_CRE RADIOBUTTON GROUP G1 DEFAULT 'X' USER-COMMAND UC1,

            P_DIS RADIOBUTTON GROUP G1.

SELECTION-SCREEN END OF BLOCK B3.



AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    CASE SCREEN-GROUP1.



        " B1 : MD1 ## (### ## ##)

      WHEN 'MD1'.

        IF P_CRE = 'X'.

          SCREEN-ACTIVE = '1'.

        ELSE.

          SCREEN-ACTIVE = '0'.

        ENDIF.

        MODIFY SCREEN.



        " B2 : MD2 ## (### ## ##)

      WHEN 'MD2'.

        IF P_DIS = 'X'.

          SCREEN-ACTIVE = '1'.

        ELSE.

          SCREEN-ACTIVE = '0'.

        ENDIF.

        MODIFY SCREEN.



    ENDCASE.

  ENDLOOP.






*DATA: BEGIN OF GS_PO_ALV,

*        " ## ##

*        LIFNR LIKE ZEDT16_LFA1-LIFNR,   " #####

*        LOEVM LIKE ZEDT16_LFB1-LOEVM,  " #####

*

*        " ZEDT16_LFA1 : #####

*        NAME1 LIKE ZEDT16_LFA1-NAME1,  " ####

*        LAND1 LIKE ZEDT16_LFA1-LAND1,  " ###

*        KTOKK LIKE ZEDT16_LFA1-KTOKK,  " #####

*        STCD1 LIKE ZEDT16_LFA1-STCD1,  " ####

*        STCD2 LIKE ZEDT16_LFA1-STCD2,  " #####

*        STRAS LIKE ZEDT16_LFA1-STRAS,  " ##

*

*        " ZEDT16_LFB1 : #######

*        BUKRS LIKE ZEDT16_LFB1-BUKRS,  " ####

*        AKONT LIKE ZEDT16_LFB1-AKONT,  " ##

*        ZTERM LIKE ZEDT16_LFB1-ZTERM,  " ####

*

*        " ZEDT16_LFM1 : #######

*        EKORG LIKE ZEDT16_LFM1-EKORG,  " ####

*        EKGRP LIKE ZEDT16_LFM1-EKGRP,  " ####

*        WAERS LIKE ZEDT16_LFM1-WAERS,  " ######

*        MWSKZ LIKE ZEDT16_LFM1-MWSKZ,  " ####

*      END OF GS_PO_ALV.

*DATA: GT_PO_ALV LIKE TABLE OF GS_PO_ALV.