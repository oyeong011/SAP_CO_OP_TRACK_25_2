
*&---------------------------------------------------------------------*

*&  Include           ZMM15_004_I01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0100  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0100 INPUT.

  CASE OK_CODE.

    WHEN 'CREATE'.

       PERFORM CREATE_INVOICE.




*     WHEN 'REFRESH'.




  ENDCASE.



  CLEAR OK_CODE.

ENDMODULE.






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

*&      Module  USER_COMMAND_0200  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0200 INPUT.

    CASE OK_CODE.

    WHEN 'CANCEL'.

       PERFORM CANCEL_INVOICE.




*     WHEN 'REFRESH'.




  ENDCASE.



  CLEAR OK_CODE.



ENDMODULE.