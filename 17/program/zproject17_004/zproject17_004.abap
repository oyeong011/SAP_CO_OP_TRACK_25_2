
*&---------------------------------------------------------------------*

*& Report ZPROJECT17_004

*&---------------------------------------------------------------------*

*& #####

*& 1) GR ## ###? GR -> IR. ## ## #### ## ## ## ##

*& 2) GR ## 0##? IR -> GR. PO ## #### ## ## ## (###) ##

*&---------------------------------------------------------------------*




REPORT ZPROJECT17_004 message-id zmed17.



include
zproject17_004_cls
.   " ## ### (### ###)

include
zproject17_004_top
.   " ##, ### ##

include
zproject17_004_scr
.   " SELECTION-SCREEN

include
zproject17_004_f01
.   " FORM ## (screen 100)

include
zproject17_004_f02
.   " FORM ## (screen 200)

include
zproject17_004_pbo
.   " PBO ##

include
zproject17_004_pai
.   " PAI ##



initialization.

  perform init_selection.



at selection-screen output.

    perform modify_screen.



at selection-screen.

  " ## ## (#### / ####)

  perform determine_mode.



  " ### ### ##

  if sy-ucomm = 'ONLI'.

    perform check_selection.

    gv_budat = p_budat.

  endif.



  start-of-selection.

    perform determine_mode.

    IF gv_mode = c_mode_cre. " ## ## ##

      CALL SCREEN 100.

    ELSE.                     " ## ## ##

      CALL SCREEN 200.

    ENDIF.






*GUI Texts

*----------------------------------------------------------

* T0100 --> ## ##

* T0200 --> ## ##





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ##### #####.