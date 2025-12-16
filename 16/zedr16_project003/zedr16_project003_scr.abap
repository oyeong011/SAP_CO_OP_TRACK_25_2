
*&---------------------------------------------------------------------*

*&  Include           ZEDR16_PROJECT003_SCR

*&---------------------------------------------------------------------*






SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

PARAMETERS : P_EBELN1 TYPE ZEDT16_EKKO-EBELN MODIF ID MD1,

             P_WERKS1 TYPE ZEDT16_EKPO-WERKS MODIF ID MD1,

             P_DATE   TYPE SY-DATUM MODIF ID MD1.



PARAMETERS : P_EBELN2 TYPE ZEDT16_EKKO-EBELN MODIF ID MD2,

             P_WERKS2 TYPE ZEDT16_EKPO-WERKS MODIF ID MD2.

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