
*&---------------------------------------------------------------------*

*&  Include           ZEDR20_PROJECT001_PBO

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  STATUS_0100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0100 OUTPUT.

  SET PF-STATUS 'STATUS_0100'.

  SET TITLEBAR 'T100'.



  LOOP AT SCREEN.

    IF P_R1 = 'X'.

      IF SCREEN-NAME = 'GV_LIFNR' OR SCREEN-NAME = 'GV_KTOKK' OR SCREEN-NAME = 'GV_BUKRS'.

        SCREEN-INPUT = 0.

      ENDIF.

    ELSE.

      IF SCREEN-NAME = 'GV_STCD2' OR SCREEN-NAME = 'GV_SAVE_BTN'.

        SCREEN-INPUT = 1.

      ELSE.

        SCREEN-INPUT = 0.

      ENDIF.

    ENDIF.





    IF SCREEN-NAME = 'GV_STCD1' OR SCREEN-NAME = 'GV_STCD1_TXT'.

      SCREEN-ACTIVE = 0.

    ENDIF.



    CASE GV_KTOKK.

        WHEN '2000'.

          IF SCREEN-NAME = 'GV_STCD2' OR SCREEN-NAME = 'GV_STCD2_TXT'.

            SCREEN-ACTIVE = 0.

          ENDIF.

        WHEN '3000'.

          IF SCREEN-NAME = 'GV_STCD1' OR SCREEN-NAME = 'GV_STCD1_TXT'.

            SCREEN-ACTIVE = 1.

          ENDIF.

        ENDCASE.

    MODIFY SCREEN.

  ENDLOOP.

ENDMODULE.