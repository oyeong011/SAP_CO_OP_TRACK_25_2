
*&---------------------------------------------------------------------*

*&  Include           ZMM12_001_PAI

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




*    WHEN 'BTN_ADD'.   "#### ###, ###### ## #### ##.

*      GV_MODE = 'A'.   "## ## ##

*      APPEND GS_ALV_OUTPUT TO GT_ALV_OUTPUT.




    WHEN 'BTN_SAVE'.  "####### ### DB#### ####




*      GV_MODE = 'S'.




      PERFORM SAVE_VENDOR.   "INSERT LFA1/LFB1/LFM1

  ENDCASE.



ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0200  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0200 INPUT.



  CASE OK_CODE.



    WHEN 'BTN_SAVE2'.       "## # ## ##




*      PERFORM UPDATE_VENDOR.




       MODIFY ZLFA1_12 FROM TABLE GT_ALV_OUTPUT.

  ENDCASE.

ENDMODULE.