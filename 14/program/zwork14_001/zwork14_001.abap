
*&---------------------------------------------------------------------*

*& Report ZWORK14_001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZWORK14_001.



include
ZWORK14_001_TOP
.

include
ZWORK14_001_SCR
.

include
ZWORK14_001_F01
.

include
ZWORK14_001_PBO
.

include
ZWORK14_001_PAI
.





START-OF-SELECTION.

  PERFORM UPLOAD_EXCEL.  " ## ###



  IF GT_EXCEL IS NOT INITIAL.  " #### ## ## ##

    PERFORM MODIFY_DATA.

    CALL SCREEN 100.

  ELSE.

    MESSAGE '#### #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> ## ####





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ## #### # # ####.