
*&---------------------------------------------------------------------*

*&  Include           ZPRO11_002_PAI

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  EXIT_COMMAND  INPUT

*&---------------------------------------------------------------------*

*       ## ## ##

*----------------------------------------------------------------------*




MODULE EXIT_COMMAND INPUT.

  CASE ok_code.

    WHEN 'BACK' OR 'CANC'.

      LEAVE TO SCREEN 0.

    WHEN 'EXIT'.

      LEAVE PROGRAM.

  ENDCASE.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0100  INPUT

*&---------------------------------------------------------------------*

*       ## ## ### ## ##

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0100 INPUT.

  DATA: lv_ebeln TYPE zpro11_004-ebeln.



  CASE ok_code.

    WHEN 'PLUS'.

      PERFORM add_row.

    WHEN 'MINUS'.

      PERFORM delete_row.

    WHEN 'CREATE'.

      PERFORM check_prdat.

      PERFORM save_order CHANGING lv_ebeln.

      MESSAGE |#### { lv_ebeln }#(#) #######!| TYPE 'S'.

      LEAVE TO SCREEN 0.

  ENDCASE.

ENDMODULE.