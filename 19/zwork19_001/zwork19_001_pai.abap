
*&---------------------------------------------------------------------*

*& Include  ZWORK19_001_PAI

*&---------------------------------------------------------------------*






MODULE user_command_0100 INPUT.

  gv_save_ok = ok_code.

  CLEAR ok_code.



  CASE gv_save_ok.

    WHEN 'SAVE'.                          " <-- Application Toolbar: ####

      PERFORM save_to_db.



    WHEN 'BACK' OR 'CANCEL' OR 'EXIT'.

      LEAVE TO SCREEN 0.



    WHEN OTHERS.

      " ALV ## #### on_user_command## ## (## #)

  ENDCASE.

ENDMODULE.