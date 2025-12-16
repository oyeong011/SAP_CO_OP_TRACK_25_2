
*&---------------------------------------------------------------------*

*& Report ZEDR17_021

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR17_021 message-id zmed17.

" [CLASS EVENT]

" ZDOCKING_CONTAINER17 20251030 docking_container ## ## ### usercommand + classevent ## ##



include
zedr17_021_cls
. " class ### ## ## # ##, #### ####### top ## #### #

include
zedr17_021_top
.

include
zedr17_021_scr
.

include
zedr17_021_f01
.

include
zedr17_021_pbo
.

include
zedr17_021_pai
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