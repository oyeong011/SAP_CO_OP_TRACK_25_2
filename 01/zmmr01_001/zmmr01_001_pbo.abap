
*&---------------------------------------------------------------------*

*&  Include           ZMMR01_004_PBO

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  STATUS_0100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0100 OUTPUT.

  IF GV_MODE = 'DISPLAY'.

  SET PF-STATUS 'STATUS_0100'.

  SET TITLEBAR 'T100'.

  ELSE.

  SET PF-STATUS 'STATUS_0110'.

  SET TITLEBAR 'T110'.

  ENDIF.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_SCREEN_0100  OUTPUT

*&---------------------------------------------------------------------*




MODULE SET_SCREEN_0100 OUTPUT.

  LOOP AT SCREEN.

    IF GV_MODE = 'CREATE'.

      IF SCREEN-GROUP1 = 'M1'.

        IF GS_DISP_100-KTOKK <> '3000'.

          SCREEN-ACTIVE = 0.

        ENDIF.

      ENDIF.



      IF SCREEN-GROUP1 = 'M2'.

        IF GS_DISP_100-KTOKK = '2000'.

          SCREEN-ACTIVE = 0.

        ENDIF.

      ENDIF.



      IF SCREEN-GROUP1 = 'M3'.

        SCREEN-ACTIVE = 0.

      ENDIF.



    ELSEIF GV_MODE = 'DISPLAY'.

      IF SCREEN-GROUP1 = 'HD'.

        SCREEN-ACTIVE = 0.

      ENDIF.

      IF SCREEN-GROUP1 = 'M1'.

        IF GS_DISP_100-KTOKK <> '3000'.

          SCREEN-ACTIVE = 0.

        ENDIF.

      ENDIF.



      IF SCREEN-GROUP1 = 'M2'.

        IF GS_DISP_100-KTOKK = '2000'.

          SCREEN-ACTIVE = 0.

        ENDIF.

      ENDIF.



      IF SCREEN-GROUP2 = 'DP'.

        SCREEN-INPUT = 0.

      ENDIF.

    ENDIF.

  MODIFY SCREEN.

  ENDLOOP.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_ACTIVE_TAB_0100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_ACTIVE_TAB_0100 OUTPUT.

  CASE GC_TABSTRIP-ACTIVETAB.

    WHEN 'FC_TAB1'.

      GV_DYNNR = '0110'.



    WHEN 'FC_TAB2'.

      GV_DYNNR = '0120'.



    WHEN 'FC_TAB3'.

      GV_DYNNR = '0130'.



    WHEN OTHERS.

      GV_DYNNR = '0110'.

      GC_TABSTRIP-ACTIVETAB = 'FC_TAB1'.



  ENDCASE.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  GET_ACTIVE_TAB_0100  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE GET_ACTIVE_TAB_0100 INPUT.

  IF GV_OKCODE CP 'FC_TAB*'.

    GC_TABSTRIP-ACTIVETAB = GV_OKCODE.

  ENDIF.

ENDMODULE.