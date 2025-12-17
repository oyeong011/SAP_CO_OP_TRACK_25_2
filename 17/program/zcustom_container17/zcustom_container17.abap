
*&---------------------------------------------------------------------*

*& Report ZCUSTOM_CONTAINER17

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




report zcustom_container17 message-id zmed17.



include
zcustom_container17_top
.

include
zcustom_container17_scr
.

include
zcustom_container17_f01
.

include
zcustom_container17_pbo
. " process before output: #### ### #### ## ## (field cat #..)

include
zcustom_container17_pai
. " process after input: ### ### user action# ### # ##



initialization.

  perform set_initial. "####






*at selection-screen output.

*  perform set_screen.






start-of-selection.

  perform get_data.



  if gt_student[] is not initial.

    call screen 100.

  else.

    message i000.

    exit.

  endif.






*GUI Texts

*----------------------------------------------------------

* T100 --> #####