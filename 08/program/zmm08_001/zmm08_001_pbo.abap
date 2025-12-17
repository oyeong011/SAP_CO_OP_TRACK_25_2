
*&---------------------------------------------------------------------*

*&  Include           ZMM08_001_PBO

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  STATUS_0100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0100 OUTPUT.

  SET PF-STATUS 'STATUS_0100'.

  SET TITLEBAR 'T01'.



  PERFORM MODIFY_SCREEN.

  PERFORM LOCK_ALL_EXCEPT_STCD.

  " PERFORM MODIFY_SCREEN_BY_KTOKK.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  STATUS_0200  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0200 OUTPUT.

  SET PF-STATUS 'STATUS_0200'.

  SET TITLEBAR 'T02'.

ENDMODULE.



MODULE STATUS_0100 INPUT.

  OK_CODE = SY-UCOMM.



  CASE OK_CODE.

    WHEN 'BACK' OR 'CANC' OR 'EXIT'.

      LEAVE TO SCREEN 0.

  ENDCASE.



  CLEAR OK_CODE.



ENDMODULE.



MODULE STATUS_0200 INPUT.

  OK_CODE = SY-UCOMM.



  CASE OK_CODE.

    WHEN 'SAVE'.

      PERFORM MAP_INPUT_TO_STRUCTS.

      PERFORM MM_SAVE.

    WHEN 'CHGID'.

      PERFORM UPDATE_VENDOR_ID.

  ENDCASE.



  CLEAR OK_CODE.



ENDMODULE.



MODULE EXIT_COMMAND INPUT.

  CASE OK_CODE.

    WHEN 'BACK' OR 'CANC'.

      LEAVE TO SCREEN 0.

    WHEN 'EXIT'.

      LEAVE PROGRAM.

  ENDCASE.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  STATUS_0300  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0300 OUTPUT.

  SET PF-STATUS 'STATUS_0300'.

  SET TITLEBAR 'T03'.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0300  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0300 INPUT.



  OK_CODE = SY-UCOMM.



  CASE OK_CODE.

    WHEN 'BACK' OR 'CANC' OR 'EXIT'.

      LEAVE TO SCREEN 0.

  ENDCASE.



  CLEAR OK_CODE.



ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  MODIFY_SCREEN_0200  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE MODIFY_SCREEN_0200 OUTPUT.



  SET PF-STATUS 'STATUS_0200'.

  SET TITLEBAR 'T02'.



  IF GV_MODE = 'C'.

    KTOKK = GS_LFA1-KTOKK.

    BUKRS = GS_LFB1-BUKRS.

  ENDIF.



  " ####, ##### ## ##

  PERFORM LOCK_FIXED_FIELDS.

  " ## ## ## ##

  PERFORM MODIFY_SCREEN_BY_KTOKK.



ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  MODIFY_SCREEN_0100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE MODIFY_SCREEN_0100 OUTPUT.



  SET PF-STATUS 'STATUS_0100'.

  SET TITLEBAR 'T01'.



  IF GV_MODE = 'Q'.

    KTOKK = GS_LFA1-KTOKK.

    BUKRS = GS_LFB1-BUKRS.

  ENDIF.



ENDMODULE.