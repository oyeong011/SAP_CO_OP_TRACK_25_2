
*&---------------------------------------------------------------------*

*&  Include           ZMM09_001_PAI

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0100  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0100 INPUT.



  "####, ##, ####

  GF_MWSKZ = ZLFM1_09-MWSKZ.

  GF_AKONT = ZLFB1_09-AKONT.

  GF_ZTERM = ZLFB1_09-ZTERM.



  CASE OK_CODE.

    WHEN 'APND'.

      GV_EDIT_MODE = ABAP_TRUE.



    WHEN 'SAVE'.

      PERFORM SAVE_DATA.



  ENDCASE.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  EXIT_COMMAND_0100  INPUT

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






MODULE USER_COMMAND_0200 INPUT.

  CASE OK_CODE.

    WHEN 'SAVE'.

      CLEAR : GS_ALV, GS_LFA1.



      LOOP AT GT_ALV INTO GS_ALV.

        "##### ####

        MOVE-CORRESPONDING GS_ALV TO GS_LFA1.

        GS_LFA1-MANDT = SY-MANDT.

        APPEND GS_LFA1 TO GT_LFA1.

      ENDLOOP.



     MODIFY ZLFA1_09 FROM TABLE GT_LFA1.



     IF SY-SUBRC = 0.

        MESSAGE '####' TYPE 'I'.

     ELSE.

        MESSAGE '####' TYPE 'I'.

     ENDIF.

  ENDCASE.



ENDMODULE.