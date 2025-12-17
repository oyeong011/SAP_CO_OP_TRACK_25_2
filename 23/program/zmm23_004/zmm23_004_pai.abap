
*&---------------------------------------------------------------------*

*&  Include           ZMM23_004_PAI

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0100  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0100 INPUT.

  CASE OK_CODE.

    WHEN 'BACK' OR 'CANC' OR 'EXIT'.

      LEAVE PROGRAM.

    WHEN 'CREATE'.       "####

      GV_DYNNR = '0101'.

    WHEN 'SEARCH'.       "####

      GV_DYNNR = '0102'.

    WHEN 'ADD'.   "#### -> ##

      PERFORM GET_PO.

      OK_CODE = ''.

      CHECK GV_FLAG EQ '0'.

        CALL SCREEN 200.

    WHEN 'SCH'.   "#### -> ##

      PERFORM GET_RBKP.

      OK_CODE = ''.

      CHECK GV_FLAG EQ '0'.

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

*&      Module  USER_COMMAND_0200  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0200 INPUT.

  CASE OK_CODE.

    WHEN '200_TAB1' OR '200_TAB2'.

      TAB_200-ACTIVETAB = OK_CODE.

    WHEN 'BACK' OR 'CANC'.

      GV_DYNNR = '0101'.

      LEAVE TO SCREEN 0.

    WHEN 'EXIT'.

      LEAVE PROGRAM.

    WHEN 'CREA'.  "##

      PERFORM SAVE_RSEG.

      OK_CODE = ''.

    WHEN 'CAL'. "## # ## ##

      PERFORM CALCULATE_TAX.

      OK_CODE = ''.

    WHEN 'SIMUL'. "#####

      PERFORM SIMULATION.

      OK_CODE = ''.

  ENDCASE.



ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  PAI_TABLE_CONTROL_200  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE PAI_TABLE_CONTROL_200 INPUT.

  MODIFY GT_EKPO FROM GS_EKPO INDEX CTR_200-CURRENT_LINE.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  PAI_TABLE_CONTROL_300  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE PAI_TABLE_CONTROL_300 INPUT.

  MODIFY GT_RBKP_ITAB FROM GS_RBKP_ITAB INDEX CTR_300-CURRENT_LINE.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0300  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0300 INPUT.

  CASE OK_CODE.

    WHEN 'DEL'.  "######

      PERFORM REMOVE_RBKP.

      OK_CODE = ''.



    WHEN 'BACK' OR 'CANC'.

       GV_DYNNR = '0102'.

       LEAVE TO SCREEN 0.

     WHEN 'EXIT'.

       LEAVE PROGRAM.

  ENDCASE.



ENDMODULE.