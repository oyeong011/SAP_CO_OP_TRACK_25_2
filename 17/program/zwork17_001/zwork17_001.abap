
*&---------------------------------------------------------------------*

*& Report ZWORK17_001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT zwork17_001.



include
zwork17_001_cls
. " ## ### ###

include
zwork17_001_top
. " ####/## ###

include
zwork17_001_scr
. " #### ##

include
zwork17_001_f01
. " ## FORM ##(F01)

include
zwork17_001_pbo
. " ## 100 PBO

include
zwork17_001_pai
. " ## 100 PAI



START-OF-SELECTION.

  " ##### ## ##(F8) ### ### ##

  IF p_pdate IS INITIAL.

    MESSAGE '##### ### ###.' TYPE 'E'.

    EXIT.

  ENDIF.



  PERFORM load_csv. " ## ### # GT_RATE ##

  IF gt_rate[] IS NOT INITIAL. " #### #### ALV ## ##

    CALL SCREEN 100.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> T100





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ## ### #### #####.