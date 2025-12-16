
*&---------------------------------------------------------------------*

*& Report ZWORK07_002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZWORK07_002.



include
zwork07_002_top
.

include
zwork07_002_scr
.

include
zwork07_002_f01
.

include
zwork07_002_pbo
.

include
zwork07_002_pai
.



AT SELECTION-SCREEN.

  CASE sy-ucomm.

    WHEN 'ONLI'. "F8 ## ###

      IF p_date IS INITIAL.

        MESSAGE '##### #####.' TYPE 'E'.

      ENDIF.

  ENDCASE.



START-OF-SELECTION.

  PERFORM get_data.

  PERFORM modi_data.

  CALL SCREEN 100.






*GUI Texts

*----------------------------------------------------------

* T100 --> ##

* T100 --> ##





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   SMW0 #### ## # ####.