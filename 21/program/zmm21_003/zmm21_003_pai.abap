
*&---------------------------------------------------------------------*

*&  Include           ZMM21_003_PAI

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

    WHEN 'CREATE'.

      PERFORM CREATE_IPGO.

      LEAVE TO SCREEN 0.

      ENDCASE.

ENDMODULE.



MODULE USER_COMMAND_0200 INPUT.

   CASE OK_CODE.

     WHEN 'CANCEL'.

       PERFORM CANCEL_IPGO.

       LEAVE TO SCREEN 0.

       ENDCASE.

ENDMODULE.