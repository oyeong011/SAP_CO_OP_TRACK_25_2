
*&---------------------------------------------------------------------*

*& Report ZEDR17_023

*&---------------------------------------------------------------------*

*& from zedr17_022 (hotspot# double click #### ### ## ### ### ###

*&---------------------------------------------------------------------*




report zedr17_023 message-id zmed17.



include
zedr17_023_cls
. " class ### ## ## # ##, #### ####### top ## #### #

include
zedr17_023_top
.

include
zedr17_023_scr
.

include
zedr17_023_f01
.

include
zedr17_023_pbo
.

include
zedr17_023_pai
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