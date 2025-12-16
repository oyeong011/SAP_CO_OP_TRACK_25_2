
*&---------------------------------------------------------------------*

*& Report ZPROJECT17_001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT zproject17_001.



include
zproject17_001_cls
.   " ## ### (### ###)

include
zproject17_001_top
.   " ##, ### ##

include
zproject17_001_scr
.   " SELECTION-SCREEN

include
zproject17_001_f01
.   " FORM ##

include
zproject17_001_pbo
.   " PBO ##

include
zproject17_001_pai
.   " PAI ##



INITIALIZATION.

  PERFORM init_selection.



AT SELECTION-SCREEN OUTPUT.

  PERFORM selection_screen_control.



AT SELECTION-SCREEN.



  " ## ## (## / ##)

  PERFORM determine_mode.



  " F8(##)# ## ## ## ##

  IF sy-ucomm = 'ONLI'.

    PERFORM check_selection.

  ENDIF.





START-OF-SELECTION.



  PERFORM determine_mode.



  IF gv_mode = c_mode_create.

    PERFORM init_data_create. " ## ##

    CALL SCREEN 0100.

  ELSEIF gv_mode = c_mode_disp.

    PERFORM run_display_mode. " ## ##

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T0100 --> ### &1





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ## ##: ####/###### ## #####.