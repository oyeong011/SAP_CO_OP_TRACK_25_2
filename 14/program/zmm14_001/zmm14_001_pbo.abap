
*&---------------------------------------------------------------------*

*&  Include           ZMM14_001_PBO

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  STATUS_0100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0100 OUTPUT.

  SET PF-STATUS 'STATUS_100'.

  SET TITLEBAR 'T100'.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_ALV_0100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_SCREEN_0100 OUTPUT.



  LOOP AT SCREEN.



    IF GV_MODE = 'I'.

      SCREEN-INPUT = 1.

    ELSE.

      SCREEN-INPUT = 0.

    ENDIF.



    IF SCREEN-GROUP1 = 'G1' OR SCREEN-GROUP1 = 'G2'.

      SCREEN-ACTIVE = 1.



      CASE P_KTOKK.

        WHEN '1000'.

          "1000: ######

          IF SCREEN-GROUP1 = 'G1'.

            SCREEN-ACTIVE = 0.

          ENDIF.

        WHEN '2000'.

          "2000: # # # #

          IF SCREEN-GROUP1 = 'G1' OR SCREEN-GROUP1 = 'G2'.

            SCREEN-ACTIVE = 0.

          ENDIF.

        WHEN '3000'.

          "3000: #####

          IF SCREEN-GROUP1 = 'G2'.

            SCREEN-ACTIVE = 0.

          ENDIF.

      ENDCASE.

    ENDIF.



    MODIFY SCREEN.

  ENDLOOP.



ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  STATUS_0200  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0200 OUTPUT.

  SET PF-STATUS 'STATUS_200'.

  SET TITLEBAR 'T200'.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_ALV_0200  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_ALV_0200 OUTPUT.



  IF GO_DOCKING IS INITIAL.

    PERFORM CREATE_OBJECT.

    PERFORM FIELD_CATALOG.

    PERFORM ALV_LAYOUT.

    PERFORM CALL_METHOD.

  ELSE.

    PERFORM REFRESH_ALV.

  ENDIF.



ENDMODULE.