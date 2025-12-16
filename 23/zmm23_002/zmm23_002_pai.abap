
*&---------------------------------------------------------------------*

*&  Include           ZMM23_002_PAI

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0100  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0100 INPUT.

  CASE OK_CODE.

    WHEN 'OK_CODE'.

      "###

    WHEN 'CREATE'.       "##

      GV_DYNNR = '0101'.

    WHEN 'SEARCH'.       "##

      GV_DYNNR = '0102'.

    WHEN 'ADD'.          "##

      PERFORM CHECK_REQUIRED.

      CHECK GV_FLAG EQ '1'.

        PERFORM ADD_LINE.

        CALL SCREEN 200.

    WHEN 'SCH'.          "##

      PERFORM CHECK_REQUIRED.

      CHECK GV_FLAG EQ '1'.

        PERFORM GETDATA_300.

        CALL SCREEN 300.

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




*&---------------------------------------------------------------------*

*&      Module  EXIT_COMMAND_200  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE EXIT_COMMAND_200 INPUT.

  CASE OK_CODE.

    WHEN 'BACK' OR 'CANC'.

      CLEAR GT_PO.

      GV_EBELPNUM = 10.

      LEAVE TO SCREEN 0.

    WHEN 'EXIT'.

      LEAVE PROGRAM.

  ENDCASE.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  PAI_TABLE_CONTROL  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE PAI_TABLE_CONTROL INPUT.

  MODIFY GT_PO FROM GS_PO INDEX CTR_200-CURRENT_LINE.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0200  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0200 INPUT.

  CASE : OK_CODE.

    WHEN '200_ADD'.

      PERFORM ADD_LINE.

    WHEN '200_DEL'.

      PERFORM UPDATE_GV_EBELN.

    WHEN 'CREA'.  "PO##

      PERFORM CHECK_DATA.

      CHECK GV_FLAG EQ '1'.

        PERFORM SAVE_PO.

  ENDCASE.



ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  PAI_TABLE_CONTROL_300  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE PAI_TABLE_CONTROL_300 INPUT.

  MODIFY GT_EKPO FROM GS_EKPO INDEX CTR_300-CURRENT_LINE.

ENDMODULE.