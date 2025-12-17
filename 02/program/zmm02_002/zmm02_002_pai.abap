
*&---------------------------------------------------------------------*

*&  Include           ZMM02_002_PAI

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0100  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0100 INPUT.

  DATA: LV_VALID TYPE C, "### ## ### ##

        LV_ERROR TYPE C.

  CASE OK_CODE.

    WHEN 'SAVE'. "PO## ## ### #

      CALL METHOD GC_GRID->CHECK_CHANGED_DATA "ALV# ## # ### #### ##

        IMPORTING

          E_VALID = LV_VALID.

      IF GT_PO IS NOT INITIAL. "#### ### DB# ##

        PERFORM VALID_PO CHANGING LV_ERROR.

        IF LV_ERROR = 'X'.

          EXIT.

        ENDIF.

        PERFORM APPEND_EKKO.

        MODIFY ZEKKO_02 FROM TABLE GT_EKKO.

        PERFORM APPEND_EKPO.

        MODIFY ZEKPO_02 FROM TABLE GT_EKPO.



        IF SY-SUBRC = 0.

          MESSAGE '####' TYPE 'I'.

        ELSE.

          MESSAGE '####' TYPE 'I' DISPLAY LIKE 'E'.

          EXIT.

        ENDIF.

      ENDIF.



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



ENDMODULE.