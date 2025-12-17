
*&---------------------------------------------------------------------*

*&  Include           ZEDR17_024_PAI

*&---------------------------------------------------------------------*




module user_command_0100 input.




*  break-point. " back(E) ## ## #, ## ### #### exit_command# ###

*  case ok_code.

*    when 'APND'.

*      clear gs_student.

*      gs_student-zcode = 'SSU-30'.

*      gs_student-zpernr = '0000000030'.

*      gs_student-zkname = '###'.

*      gs_student-zename = 'MI'.

*      gs_student-zgender = 'F'.

*      append gs_student to gt_student. " pai ## itab # ## -> screen# ## ## by REFRSH method

*    when 'SAVE'.

*      modify zedt17_001 from table gt_student.

*  endcase.




endmodule.




*&---------------------------------------------------------------------*

*&      Module  EXIT_COMMAND  INPUT

*&---------------------------------------------------------------------*

*       #### ##/## ## ## ##

*       back, exit, cancle # ##/## ##

*       ## #### ## ## ##

*       ok_code # ## ## ### ##

*       #### ####/## ## ## ##

*----------------------------------------------------------------------*




module exit_command input.




*  break-point. " Exit command# PAI ## ## #### ## ## ### ##.




  case ok_code.

    when 'BACK' or 'CANC'. " #### or ##

      leave to screen 0. " ## #### ##

    when 'EXIT'.        " #### ##

      leave program.

  endcase.



endmodule.