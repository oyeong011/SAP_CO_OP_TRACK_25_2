
*&---------------------------------------------------------------------*

*&  Include           ZMM21_002_PAI

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  EXIT_COMMAND  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE EXIT_COMMAND INPUT.

  CASE ok_code.

    WHEN 'BACK' or 'CANC'.

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



  CASE ok_code.

    WHEN 'ADD'.

      PERFORM ADD_PRODUCT.

    WHEN 'DELETE'.

      PERFORM DELETE_PRODUCT.

    WHEN 'CREATE'.

      CLEAR OK_CODE.

      PERFORM VERIFY_INPUTD.

      PERFORM CREATE_PRODUCT.



      LEAVE TO SCREEN 0.

  ENDCASE.

ENDMODULE.