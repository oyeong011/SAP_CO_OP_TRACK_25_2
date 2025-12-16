
*&---------------------------------------------------------------------*

*& Report ZPROJECT17_003

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT zproject17_003 MESSAGE-ID zmed17.



include
zproject17_003_cls
.   " ## ### (### ###)

include
zproject17_003_top
.   " ##, ### ##

include
zproject17_003_scr
.   " SELECTION-SCREEN

include
zproject17_003_f01
.   " FORM ## (screen 100)

include
zproject17_003_f02
.   " FORM ## (screen 200)

include
zproject17_003_pbo
.   " PBO ##

include
zproject17_003_pai
.   " PAI ##



INITIALIZATION.

  PERFORM init_selection.



AT SELECTION-SCREEN OUTPUT.

  PERFORM modify_screen.



AT SELECTION-SCREEN.

  " ## ## (#### / ####)

  PERFORM determine_mode.



  " F8 ### # ### ##

  IF sy-ucomm = 'ONLI'.

    PERFORM check_selection.

  ENDIF.



START-OF-SELECTION.



  PERFORM determine_mode.



  " ### ###### MKPF ## ### ## ##

  zedt17_mkpf-budat = p_budat.



  IF gv_mode = c_mode_recv.      " #### ##

    CALL SCREEN 100.

  ELSEIF gv_mode = c_mode_disp.  " #### ##

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