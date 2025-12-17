
*&---------------------------------------------------------------------*

*& Report ZEDR17_020

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




" [USER COMMAND]

" ZDOCKING_CONTAINER17 20251030 docking_container ## ## ### usercommand ## ##

report zedr17_020 message-id zmed17.



include
zedr17_020_top
.

include
zedr17_020_scr
.

include
zedr17_020_f01
.

include
zedr17_020_pbo
.

include
zedr17_020_pai
.



initialization.

  perform set_init.



start-of-selection.

  if s_zcode is initial.

    message i000.

    exit.

  endif.

  perform get_data.



  if gt_student[] is not initial.

    call screen 100.

    exit.

  endif.






*GUI Texts

*----------------------------------------------------------

* T100 --> #####