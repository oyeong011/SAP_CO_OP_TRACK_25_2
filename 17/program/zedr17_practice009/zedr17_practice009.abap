
*&---------------------------------------------------------------------*

*& Report ZEDR17_PRACTICE009

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




report zedr17_practice009 message-id zmed17.



include
zedr17_practice009_top
.

include
zedr17_practice009_scr
.

include
zedr17_practice009_f01
.

include
zedr17_practice009_pbo
.

include
zedr17_practice009_pai
.



initialization.

  perform set_init.



start-of-selection.

  perform set_input. " ## ## ## ##  ##

  perform set_zqflag. " ### #### ## ##

  perform get_data. " ### ## # ### #### select

  perform modify_data. " ### ##



  if gt_emp[] is not initial or gt_eval[] is not initial or gt_salary[] is not initial.

    call screen 100.

    exit.

  endif.






*GUI Texts

*----------------------------------------------------------

* T100 --> ## ## ###

* T100 --> ## ## ###