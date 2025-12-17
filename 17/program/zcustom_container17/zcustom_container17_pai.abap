
*&---------------------------------------------------------------------*

*&  Include           ZCUSTOM_CONTAINER17_PAI

*&---------------------------------------------------------------------*




module user_command_0100 input.




*  break-point. " back(E) ## ## #, ## ### #### exit_command# ###




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