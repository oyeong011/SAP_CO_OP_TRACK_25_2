
*&---------------------------------------------------------------------*

*& Report ZWORK17_002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT zwork17_002.



include
zwork17_002_cls
.

include
zwork17_002_top
.

include
zwork17_002_scr
.

include
zwork17_002_f01
.

include
zwork17_002_pbo
.

include
zwork17_002_pai
.



START-OF-SELECTION.

  PERFORM get_data.

  IF gt_rate[] IS NOT INITIAL.

    CALL SCREEN 100.

  ELSE.

    MESSAGE '### ## #### ####.' TYPE 'I'.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> T100





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   PDF# ### #### ####.