
*&---------------------------------------------------------------------*

*&  Include           ZPRO07_002_PAI

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

    WHEN 'PLUS'.

      PERFORM plus_product.

    WHEN 'MINUS'.

      PERFORM minus_product.

    WHEN 'CREATE'.

      PERFORM verify_prdat.

      PERFORM create_product.



      MESSAGE '##### #######!' TYPE 'S'.

      LEAVE TO SCREEN 0.

  ENDCASE.

ENDMODULE.