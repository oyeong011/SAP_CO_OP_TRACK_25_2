
*&---------------------------------------------------------------------*

*& Report ZEDR17_018

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR17_018.



include
zedr17_018_top
.

include
zedr17_018_scr
.

include
zedr17_018_f01
.

include
zedr17_018_pbo
. " process before output: #### ### #### ## ## (field cat #..)

include
zedr17_018_pai
. " process after input: ### ### user action# ### # ##



initialization.

  perform set_init. "####



start-of-selection.

  perform get_data.



  call screen 100.






*GUI Texts

*----------------------------------------------------------

* T100 --> #####