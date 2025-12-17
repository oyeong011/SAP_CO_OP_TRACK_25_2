
*&---------------------------------------------------------------------*

*& Report ZEDR17_022

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR17_022 message-id zmed17.



include
zedr17_022_cls
. " class ### ## ## # ##, #### ####### top ## #### #

include
zedr17_022_top
.

include
zedr17_022_scr
.

include
zedr17_022_f01
.

include
zedr17_022_pbo
.

include
zedr17_022_pai
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





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ##########