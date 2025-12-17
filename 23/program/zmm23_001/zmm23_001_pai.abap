
*&---------------------------------------------------------------------*

*&  Include           ZMM23_001_PAI

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0100  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0100 INPUT.

  GV_KTOKK = Z23LFA1-KTOKK.

  CASE OK_CODE.

    WHEN 'OK_CODE'.



    WHEN 'CREATE'.       "##

      GV_DYNNR = '0101'.

    WHEN 'SEARCH'.       "##

      GV_DYNNR = '0102'.

    WHEN 'ADD'.          "##

      PERFORM CHECK_DATA.

      CALL SCREEN 200.

    WHEN 'SCH'.          "##

      PERFORM CHECK_DATA.

      PERFORM GETDATA_300.

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

  GV_AKONT = Z23LFB1-AKONT.

  GV_ZTERM = Z23LFB1-ZTERM.

  GV_MWSKZ = Z23LFM1-MWSKZ.



  CASE OK_CODE.



    WHEN 'CREA'.

      PERFORM CHECK_REQUIRED.



      CHECK GV_FLAG EQ '1'.

        PERFORM ADD_TO_VENDOR.

        GV_DYNNR = '0101'.

        LEAVE TO SCREEN 0.

    WHEN 'BACK' OR 'CANC'.

      GV_DYNNR = '0101'.

      LEAVE TO SCREEN 0.

    WHEN 'EXIT'.

      LEAVE PROGRAM.



  ENDCASE.



ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0300  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0300 INPUT.

  CASE OK_CODE.

    WHEN 'BT_SAVE'.

      PERFORM SAVE_TO_VENDOR_300.

      OK_CODE = ''.

    WHEN 'BACK' OR 'CANC'.

      "GV_DYNNR = '0102'.

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

 " MODIFY GT_PRINT FROM GS_PRINT INDEX CTR_300-CURRENT_LINE. "ALV## ### ### ITAB# ##, SCREEN# ##

ENDMODULE.