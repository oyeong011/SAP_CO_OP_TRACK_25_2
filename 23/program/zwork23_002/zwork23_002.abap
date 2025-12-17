
*&---------------------------------------------------------------------*

*& Report ZWORK23_002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZWORK23_002.



include
ZWORK23_002_CLS
.

include
ZWORK23_002_TOP
.

include
ZWORK23_002_SCR
.

include
ZWORK23_002_F01
.

include
ZWORK23_002_PBO
.

include
ZWORK23_002_PAI
.



INITIALIZATION.



AT SELECTION-SCREEN OUTPUT.



START-OF-SELECTION.

  PERFORM GET_DATA.



  CALL SCREEN 100.






*GUI Texts

*----------------------------------------------------------

* T100 --> ####





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ### ##