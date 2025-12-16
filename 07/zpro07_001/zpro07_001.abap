
*&---------------------------------------------------------------------*

*& Report ZPRO07_001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZPRO07_001.



include
zpro07_001_cls
.

include
zpro07_001_top
.

include
zpro07_001_scr
.

include
zpro07_001_f01
.

include
zpro07_001_pbo
.

include
zpro07_001_pai
.



AT SELECTION-SCREEN.

  IF p_rad1 = 'X'.

    PERFORM verify_ktokk.

  ENDIF.





AT SELECTION-SCREEN OUTPUT.

  PERFORM set_screen.



START-OF-SELECTION.

  IF p_rad1 = 'X'.

    CALL SCREEN 100.

  ELSE.

    PERFORM get_data.



      IF gt_search IS INITIAL.

        MESSAGE '#### #### ####!' TYPE 'I'.

        RETURN.

      ENDIF.



    CALL SCREEN 200.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> #####

* T200 --> #####





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   #### # #### #####