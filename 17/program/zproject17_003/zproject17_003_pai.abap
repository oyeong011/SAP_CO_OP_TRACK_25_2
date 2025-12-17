
*&---------------------------------------------------------------------*

*&  Include           ZPROJECT17_003_PAI

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0100  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE user_command_0100 INPUT.



  gv_code = ok_code.

  CLEAR ok_code.



  CASE gv_code.

    WHEN 'BACK' OR 'CANC' OR 'EXIT'.

      LEAVE TO SCREEN 0.



    WHEN 'SAVE'.          " ####

      PERFORM create_gr_document.   " MKPF/MSEG ## ##



    WHEN OTHERS.

  ENDCASE.



ENDMODULE.



MODULE user_command_0200 INPUT.



  gv_code = ok_code.

  CLEAR ok_code.



  CASE gv_code.

    WHEN 'BACK' OR 'CANC' OR 'EXIT'.

      LEAVE TO SCREEN 0.



    WHEN 'C_GR'.     " <-- PF-STATUS S0200# ## ## ## UCOMM

      PERFORM cancel_gr_document.



    WHEN OTHERS.

  ENDCASE.



ENDMODULE.