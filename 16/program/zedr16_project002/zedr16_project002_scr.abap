
*&---------------------------------------------------------------------*

*&  Include           ZEDR16_PROJECT002_SCR

*&---------------------------------------------------------------------*






SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

PARAMETERS : P_BUKRS1 TYPE ZEDT16_EKKO-BUKRS MODIF ID MD1,

             P_LIFNR1 TYPE ZEDT16_EKKO-LIFNR MODIF ID MD1,

             P_BEDAT  TYPE ZEDT16_EKKO-BEDAT MODIF ID MD1.



PARAMETERS : P_LIFNR2 TYPE ZEDT16_EKKO-LIFNR MODIF ID MD2,

             P_BUKRS2 TYPE ZEDT16_EKKO-BUKRS MODIF ID MD2,

             P_EBELN  TYPE ZEDT16_EKKO-EBELN MODIF ID MD2.

SELECTION-SCREEN END OF BLOCK B1.



SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

PARAMETERS: P_CRE RADIOBUTTON GROUP G1 DEFAULT 'X' USER-COMMAND UC1,

            P_DIS RADIOBUTTON GROUP G1.

SELECTION-SCREEN END OF BLOCK B2.



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








*DATA : BEGIN OF GS_HEADER,

*         EBELN TYPE ZEDT16_EKKO-EBELN, " ######

*         BUKRS TYPE ZEDT16_EKKO-BUKRS, " ####

*         EKGRP TYPE ZEDT16_EKKO-EKGRP, " ####

*         EKORG TYPE ZEDT16_EKKO-EKORG, " ####

*         LIFNR TYPE ZEDT16_EKKO-LIFNR, " ###

*         BEDAT TYPE ZEDT16_EKKO-BEDAT, " ###

*         WAERS TYPE ZEDT16_EKKO-WAERS, " ##

*       END OF GS_HEADER.

*DATA : GT_HEADER LIKE TABLE OF GS_HEADER.

*

*DATA : BEGIN OF GS_ITEM, " ##, #### ##

*         EBELN TYPE ZEDT16_EKPO-EBELN, " ###### *

*         EBELP TYPE ZEDT16_EKPO-EBELP, " ## *

*         MATNR TYPE ZEDT16_EKPO-MATNR, " #### *

*         MAKTX TYPE ZEDT16_EKPO-MAKTX, " ### *

*         MENGE TYPE ZEDT16_EKPO-MENGE, " ## *

*         MEINS TYPE ZEDT16_EKPO-MEINS, " ## *

*         WAERS TYPE ZEDT16_EKKO-WAERS, " ##(##)

*         MWSKZ TYPE ZEDT16_LFM1-MWSKZ, " ####(##)

*         BPRME TYPE ZEDT16_EKPO-BPRME, " ## *

*         PRDAT TYPE ZEDT16_EKPO-PRDAT, "### *

*         WERKS TYPE ZEDT16_EKPO-WERKS, " ### *

*         LGORT TYPE ZEDT16_EKPO-LGORT, " #### *

*       END OF GS_ITEM.

*DATA : GT_ITEM LIKE TABLE OF GS_ITEM.