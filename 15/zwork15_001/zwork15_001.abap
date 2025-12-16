
*&---------------------------------------------------------------------*

*& Report ZWORK15_001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZWORK15_001.



include
ZWORK15_001_CLS
.

include
ZWORK15_001_TOP
.

include
ZWORK15_001_SCR
.

include
ZWORK15_001_F01
.

include
ZWORK15_001_O01
.

include
ZWORK15_001_I01
.



INITIALIZATION.

  PERFORM SET_BUTTON.  "### ## ##



AT SELECTION-SCREEN.

  IF SSCRFIELDS-UCOMM EQ 'FC01'. "## ###

    PERFORM DOWNLOAD_TEMP.

  ENDIF.



AT SELECTION-SCREEN OUTPUT.

  PERFORM SCREEN_CONTROL. "DEFAULT# ##.





AT SELECTION-SCREEN ON VALUE-REQUEST FOR P_EXCEL.

  PERFORM SET_EXCEL. "#### ##



START-OF-SELECTION.

  IF P_DATE IS INITIAL OR P_EXCEL IS INITIAL.

    MESSAGE '##### #####' TYPE 'E'.

  ENDIF.



  PERFORM EXCEL_TO_ITAB.

  PERFORM MODIFY_DATA.

  CALL SCREEN 100.






*GUI Texts

*----------------------------------------------------------

* T100 --> ## ####

* T100 --> ## ####





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   SMW0# ### ### ### #### ####