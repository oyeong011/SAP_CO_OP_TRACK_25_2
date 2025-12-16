
*&---------------------------------------------------------------------*

*&  Include           ZMM05_003_PAI

*&---------------------------------------------------------------------*






MODULE USER_COMMAND_0100 INPUT.



  CASE OK_CODE.

    WHEN 'BTN_CREATE'.  " GUI Status# # ## ### ### #

      PERFORM BTN_CREATE.

      LEAVE TO SCREEN 0.

  ENDCASE.

  PERFORM REFRESH.

ENDMODULE.



MODULE EXIT_COMMAND INPUT.

  CASE OK_CODE.

    WHEN 'CANC' OR 'BACK' OR 'EXIT'.

      LEAVE TO SCREEN 0.

  ENDCASE.

ENDMODULE.



MODULE USER_COMMAND_0101 INPUT.

  CALL METHOD CL_GUI_CFW=>DISPATCH.

ENDMODULE.



MODULE USER_COMMAND_0200 INPUT.

  CALL METHOD CL_GUI_CFW=>DISPATCH. " ##/ALV ### ##



  CASE OK_CODE.

    WHEN 'BTN_DEL'.      " ## ##

      PERFORM BTN_DEL.

    WHEN 'REFRESH_SCREEN'. " ## #### # OK_CODE

      PERFORM REFRESH_SCREEN.

  ENDCASE.

  PERFORM REFRESH2.

ENDMODULE.



MODULE USER_COMMAND_0201 INPUT.

  CALL METHOD CL_GUI_CFW=>DISPATCH.

ENDMODULE.