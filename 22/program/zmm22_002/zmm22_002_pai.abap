
*&---------------------------------------------------------------------*

*&  Include           ZMM22_002_PAI

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  EXIT_COMMAND  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE EXIT_COMMAND INPUT.

    CASE OK_CODE.

    WHEN 'BACK' OR 'CANC'.

      LEAVE TO SCREEN 0.

    WHEN 'EXIT'.

      LEAVE PROGRAM.

  ENDCASE.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0100  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0100 INPUT.

  CASE OK_CODE.

    WHEN 'ADD'.

      CLEAR OK_CODE.

      PERFORM ADD_ITEM_LINE.



    WHEN 'DELETE'.

      CLEAR OK_CODE.

      PERFORM DEL_ITEM_LINE.



    WHEN 'CREATE'.  " PO##

      CLEAR OK_CODE.

      PERFORM CREATE_PO.



  ENDCASE.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0200  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0200 INPUT.



ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  EXIT_COMMAND_0200  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE EXIT_COMMAND_0200 INPUT.

  CASE OK_CODE.

    WHEN 'BACK' OR 'CANC'.

      LEAVE TO SCREEN 0.

    WHEN 'EXIT'.

      LEAVE PROGRAM.

  ENDCASE.



ENDMODULE.