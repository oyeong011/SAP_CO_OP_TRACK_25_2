
*&---------------------------------------------------------------------*

*& Report ZWORK07_001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZWORK07_001.



include
zwork07_001_cls
.

include
zwork07_001_top
.

include
zwork07_001_scr
.

include
zwork07_001_f01
.

include
zwork07_001_pbo
.

include
zwork07_001_pai
.



INITIALIZATION.

  g_function_key-icon_id = icon_total_down. "## ### ## ###, ## ##

  g_function_key-icon_text = '### ####'.

  g_function_key-text = '### ####'.

  sscrfields-functxt_01 = g_function_key.



AT SELECTION-SCREEN OUTPUT.

  PERFORM set_screen.



AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_file.

  CALL FUNCTION 'F4_FILENAME'

    IMPORTING

      FILE_NAME           = p_file "#### ### ## ### p_file# ##.

      .



AT SELECTION-SCREEN.

  CASE sy-ucomm.

    WHEN 'ONLI'. "F8 ## # (## ##)

      IF p_date IS INITIAL.

        MESSAGE '##### #####.' TYPE 'E'.

      ENDIF.

      IF p_file IS INITIAL.

        MESSAGE '#### #####.' TYPE 'E'.

      ENDIF.

  ENDCASE.



  CASE sscrfields-ucomm. "### #### ### ### #

    WHEN 'FC01'.

      PERFORM templete_down. "### #### ## ##

  ENDCASE.





START-OF-SELECTION.

  PERFORM get_data.

  PERFORM modi_data.

  CALL SCREEN 100. "### ####






*GUI Texts

*----------------------------------------------------------

* T100 --> ##





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   #### ## # ####.