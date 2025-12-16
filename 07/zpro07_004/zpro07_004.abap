
*&---------------------------------------------------------------------*

*& Report ZPRO07_004

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZPRO07_004.



include
zpro07_004_top
.

include
zpro07_004_scr
.

include
zpro07_004_f01
.

include
zpro07_004_pbo
.

include
zpro07_004_pai
.



INITIALIZATION.

  PERFORM set_date.



AT SELECTION-SCREEN.

  PERFORM verify_ebeln.



AT SELECTION-SCREEN OUTPUT.

  PERFORM set_screen.



  START-OF-SELECTION.

  IF p_rad1 = 'X'.

    PERFORM get_data.

    CALL SCREEN 100.

  ELSE.

    PERFORM get_search_data.

    CALL SCREEN 200.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> ######

* T200 --> ######





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ## ##### ### ### #### ####.