
*&---------------------------------------------------------------------*

*&  Include           ZMM23_001_PBO

*&---------------------------------------------------------------------*



*&---------------------------------------------------------------------*

*&      Module  SET_SUBSCREEN  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_SUBSCREEN OUTPUT.

  IF OK_CODE = 'CREATE'.

      GV_DYNNR = '0101'.

  ELSEIF OK_CODE = 'SEARCH'.

      GV_DYNNR = '0102'.

  ENDIF.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  STATUS_0100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0100 OUTPUT.

   SET TITLEBAR 'T100'.

   SET PF-STATUS 'STATUS_0100'.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  STATUS_0200  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0200 OUTPUT.

   SET TITLEBAR 'T200'.

   SET PF-STATUS 'STATUS_0200'.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_SCREEN_200  OUTPUT

*&      Module  SET_SCREEN_200  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_SCREEN_200 OUTPUT.

  "####

  " P_KTOKK

  LOOP AT SCREEN.

    IF GV_KTOKK EQ '2000'.  "STCD1, STCD2 # # ### ##

      CASE : SCREEN-NAME.

        WHEN 'TEXT3'. SCREEN-INVISIBLE = '1'.

        WHEN 'GV_STCD1'. SCREEN-ACTIVE = '0'.

        WHEN 'TEXT4'. SCREEN-INVISIBLE = '1'.

        WHEN 'GV_STCD2'. SCREEN-ACTIVE = '0'.

      ENDCASE.

    ELSEIF GV_KTOKK EQ '3000'. "STCD2 ##

      CASE : SCREEN-NAME.

        WHEN 'TEXT3'. SCREEN-INVISIBLE = '0'.

        WHEN 'GV_STCD1'. SCREEN-ACTIVE = '1'.

        WHEN 'TEXT4'. SCREEN-INVISIBLE = '1'.

        WHEN 'GV_STCD2'. SCREEN-ACTIVE = '0'.

      ENDCASE.

    ELSE.

      CASE : SCREEN-NAME.

        WHEN 'TEXT3'. SCREEN-INVISIBLE = '1'.

        WHEN 'GV_STCD1'. SCREEN-ACTIVE = '0'.

      ENDCASE.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  STATUS_0300  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0300 OUTPUT.




*  SET PF-STATUS 'xxxxxxxx'.




  SET TITLEBAR 'T300'.



  PERFORM GETDATA_300.

  "CTR_300-LINES = SY-DBCNT. "### #####..



  "DESCRIBE TABLE GT_PRINT LINES CTR_300-LINES. "#### ##

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_SCREEN_300  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_SCREEN_300 OUTPUT.

  LOOP AT SCREEN.

    IF GS_PRINT-KTOKK EQ '2000'.  "STCD1, STCD2 # # ### ##

      CASE : SCREEN-NAME.

        WHEN 'TEXT_STCD1'. SCREEN-ACTIVE = '0'.

        WHEN 'GS_PRINT-STCD1'. SCREEN-ACTIVE = '0'.

        WHEN 'TEXT_STCD2'. SCREEN-ACTIVE = '0'.

        WHEN 'GS_PRINT-STCD2'. SCREEN-ACTIVE = '0'.

      ENDCASE.

    ELSEIF GS_PRINT-KTOKK EQ '3000'. "STCD2 ##

      CASE : SCREEN-NAME.

        WHEN 'TEXT_STCD1'. SCREEN-ACTIVE = '1'.

        WHEN 'GS_PRINT-STCD1'. SCREEN-ACTIVE = '1'.

        WHEN 'TEXT_STCD2'. SCREEN-ACTIVE = '0'.

        WHEN 'GS_PRINT-STCD2'. SCREEN-ACTIVE = '0'.

      ENDCASE.

    ELSEIF GS_PRINT-KTOKK EQ '1000'.

      CASE : SCREEN-NAME. "1000

        WHEN 'TEXT_STCD1'. SCREEN-ACTIVE = '0'.

        WHEN 'GS_PRINT-STCD1'. SCREEN-ACTIVE = '0'.

        WHEN 'TEXT_STCD2'. SCREEN-ACTIVE = '1'.

        WHEN 'GS_PRINT-STCD2'. SCREEN-ACTIVE = '1'.

      ENDCASE.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.

ENDMODULE.