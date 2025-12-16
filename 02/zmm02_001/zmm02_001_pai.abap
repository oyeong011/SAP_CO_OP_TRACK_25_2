
*&---------------------------------------------------------------------*

*&  Include           ZMM02_001_PAI

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0100  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0100 INPUT.

  CASE OK_CODE.

    WHEN 'VCRE'. "### ##

      PERFORM CREATE_VENDOR.

      IF SY-SUBRC <> 0.

        EXIT.

      ENDIF.

      PERFORM PUSH_DB.

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

    WHEN 'SAVE'.

      IF G_STCD2 <> GS_VENDOR-STCD2 OR G_STCD1 <> GS_VENDOR-STCD1. "##### ## ## ##

        CLEAR: GS_LFA1.

        GS_LFA1-LIFNR = G_LIFNR. "#####

        GS_LFA1-NAME1 = G_NAME1. "####

        GS_LFA1-LAND1 = G_LAND1. "###

        GS_LFA1-KTOKK = G_KTOKK. "#####

        GS_LFA1-STCD1 = G_STCD1. "####

        GS_LFA1-STCD2 = G_STCD2. "#####

        GS_LFA1-STRAS = G_STRAS. "##

        MODIFY ZLFA1_02 FROM GS_LFA1.

        MESSAGE '### #######.' TYPE 'S'.

      ENDIF.

  ENDCASE.

ENDMODULE.