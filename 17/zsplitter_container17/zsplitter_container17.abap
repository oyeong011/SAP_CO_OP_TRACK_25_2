
*&---------------------------------------------------------------------*

*& Report ZSPLITTER_CONTAINER17

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZSPLITTER_CONTAINER17 message-id zmed17.



include
zsplitter_container17_top
.

include
zsplitter_container17_scr
.

include
zsplitter_container17_f01
.

include
zsplitter_container17_o01
.

include
zsplitter_container17_i01
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