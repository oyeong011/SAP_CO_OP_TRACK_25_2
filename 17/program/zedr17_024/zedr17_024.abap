
*&---------------------------------------------------------------------*

*& Report ZEDR17_024

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR17_024 message-id zmed17.



include
zedr17_024_cls
.

include
zedr17_024_top
.

include
zedr17_024_scr
.

include
zedr17_024_f01
.

include
zedr17_024_pbo
.

include
zedr17_024_pai
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



include
zedr17_024_alv_handler_dataf01
.








*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ##########