
*&---------------------------------------------------------------------*

*&  Include           ZMM08_001_PAI

*&---------------------------------------------------------------------*




MODULE USER_COMMAND_0100 INPUT.



  OK_CODE = SY-UCOMM.



  CASE OK_CODE.

    WHEN 'CHGID'.

      PERFORM UPDATE_STCD2.

    WHEN 'SAVE'.

      PERFORM CHECK_UPDATE_ID_ONLY.

      PERFORM UPDATE_VENDOR_ID.

    WHEN 'BACK' OR 'CANC'.

      LEAVE TO SCREEN 0.

    WHEN 'EXIT'.

      LEAVE PROGRAM.

    WHEN OTHERS.

  ENDCASE.



ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0200  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0200 INPUT.



  OK_CODE = SY-UCOMM.



  CASE OK_CODE.

    WHEN 'SAVE'.

      PERFORM MM_SAVE.

    WHEN 'ADD'.

      PERFORM SAVE_TEST.

      PERFORM CHECK_ADD_BUTTON.

    WHEN 'BACK' OR 'CANC'.

      LEAVE TO SCREEN 0.

    WHEN 'EXIT'.

      LEAVE PROGRAM.

  ENDCASE.



ENDMODULE.