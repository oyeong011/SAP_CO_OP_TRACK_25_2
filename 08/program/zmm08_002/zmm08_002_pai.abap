
*&---------------------------------------------------------------------*

*&  Include           ZMM08_002_PAI

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0100  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0100 INPUT.



  CASE OK_CODE.

    WHEN 'CANC' OR 'BACK'.

      LEAVE TO SCREEN 0.

    WHEN 'EXIT'.

      LEAVE PROGRAM.

    WHEN C_OK_ADD.

      PERFORM ADD_ITEM.

    WHEN C_OK_DEL.

      PERFORM DELETE_ITEM.

    WHEN C_OK_SAVE.

      PERFORM CREATE_PO.

    WHEN OTHERS.

  ENDCASE.



  CLEAR OK_CODE.



ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0200  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0200 INPUT.



  CASE OK_CODE.

    WHEN 'BACK' OR 'CANC'.

      LEAVE TO SCREEN 0.

    WHEN 'EXIT'.

      LEAVE PROGRAM.

    WHEN OTHERS.

  ENDCASE.



  CLEAR OK_CODE.



ENDMODULE.