
*&---------------------------------------------------------------------*

*& Report ZPRO11_001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZPRO11_001.



include
zpro11_001_cls
.

include
zpro11_001_top
.

include
zpro11_001_scr
.

include
zpro11_001_f01
.

include
zpro11_001_pbo
.

include
zpro11_001_pai
.



AT SELECTION-SCREEN.

  IF pa_rad1 = 'X'.

    PERFORM check_vendor_group.

  ENDIF.



AT SELECTION-SCREEN OUTPUT.

  PERFORM control_screen_fields.



START-OF-SELECTION.

  IF pa_rad1 = 'X'.

    CALL SCREEN 100.

  ELSE.

    PERFORM select_vendor_data.



    IF gt_display IS INITIAL.

      MESSAGE '#### #### ####!' TYPE 'I'.

      RETURN.

    ENDIF.



    CALL SCREEN 200.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* TT_100 --> ### ##

* TT_200 --> #####





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ## #### #### #####.