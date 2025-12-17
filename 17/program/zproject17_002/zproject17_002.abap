
*&---------------------------------------------------------------------*

*& Report ZPROJECT17_002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT zproject17_002 MESSAGE-ID zmed17.



include
zproject17_002_cls
.   " ## ### (### ###)

include
zproject17_002_top
.   " ##, ### ##

include
zproject17_002_scr
.   " SELECTION-SCREEN

include
zproject17_002_f01
.   " FORM ##

include
zproject17_002_pbo
.   " PBO ##

include
zproject17_002_pai
.   " PAI ##



INITIALIZATION.

  PERFORM init_selection.



AT SELECTION-SCREEN OUTPUT.

  PERFORM selection_screen_control.



AT SELECTION-SCREEN.



  " ## ## ## (## / ##)

  PERFORM determine_mode.



  " ## ### #: #### / ### / ### ##

  IF gv_mode = c_mode_create.



    IF p_bukrs IS INITIAL

    OR p_lifnr IS INITIAL

    OR p_bedat IS INITIAL.

      MESSAGE i000.

      STOP. " ## ### stop

    ENDIF.



    " F8 ### # ### ##

    IF sy-ucomm = 'ONLI'.

      PERFORM check_selection.

    ENDIF.

    " ### ### + ## ## ##

    PERFORM check_vendor_valid.



    " ## ### #: ##### / #### / PO## ##

  ELSEIF gv_mode = c_mode_disp.



    IF p_lif_q IS INITIAL

    OR p_bukr_q IS INITIAL

    OR p_ebeln IS INITIAL.

      MESSAGE i000.

      STOP. " ## ### stop

    ENDIF.

  ENDIF.



START-OF-SELECTION.



  PERFORM determine_mode.



  IF gv_mode = c_mode_create. " ## ##

    CALL SCREEN 100.

  ELSEIF gv_mode = c_mode_disp. " ## ##

    PERFORM run_display_mode.

    CALL SCREEN 100.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T0100 --> #### &1





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ##### #####.