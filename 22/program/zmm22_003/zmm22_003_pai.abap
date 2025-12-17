
*&---------------------------------------------------------------------*

*&  Include           ZMM22_003_PAI

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0100  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0100 INPUT.



  DATA: LV_UCOMM TYPE SY-UCOMM.



  " OK_CODE# ## ### ## ## ### (## ## ##)

  LV_UCOMM = OK_CODE.

  CLEAR OK_CODE.



  CASE LV_UCOMM.

    WHEN 'POST'. " GUI Status## ### ## ## (#: POST)



      " ALV #### ####(####, #### #) ##

      IF GC_GRID IS NOT INITIAL.

        CALL METHOD GC_GRID->CHECK_CHANGED_DATA.

      ENDIF.



      " ## ## ##

      PERFORM SAVE_DATA.



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



DATA: LV_UCOMM2 TYPE SY-UCOMM.

  LV_UCOMM2 = OK_CODE.

  CLEAR OK_CODE.



  CASE LV_UCOMM2.

    WHEN 'REFRESH'.

      "PBO ####

    WHEN 'CANCLE'. " [####] ## ####

      " ALV #### ##

      IF GC_GRID_BOTTOM IS NOT INITIAL.

        CALL METHOD GC_GRID_BOTTOM->CHECK_CHANGED_DATA.

      ENDIF.



      " ## ## ##

      PERFORM CANCEL_GOODS_RECEIPT.

  ENDCASE.



ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  EXIT_COMMAND2  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE EXIT_COMMAND2 INPUT.

    CASE OK_CODE.

    WHEN 'BACK' OR 'CANC'.

      LEAVE TO SCREEN 0.



    WHEN 'EXIT'.

      LEAVE PROGRAM.

  ENDCASE.



ENDMODULE.