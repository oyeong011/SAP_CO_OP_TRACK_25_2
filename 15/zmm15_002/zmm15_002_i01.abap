
*&---------------------------------------------------------------------*

*&  Include           ZMM15_002_I01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0100  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0100 INPUT.

  CASE OK_CODE.

    WHEN 'ADD'.

      "## ##

      IF GV_BUKRS = '' OR GV_EKGRP = '' OR GV_EKORG = '' OR GV_LIFNR = '' OR GV_BEDAT = ''.

        MESSAGE '### ## #####' TYPE 'S' DISPLAY LIKE 'E'.

        EXIT.

      ENDIF.



      PERFORM ADD_PO.

    WHEN 'DELETE'.

      PERFORM DELETE_PO.

    WHEN 'SAVE'.

      PERFORM SAVE_PO.

   ENDCASE.

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