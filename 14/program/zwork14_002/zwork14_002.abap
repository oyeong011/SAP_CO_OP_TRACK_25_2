
*&---------------------------------------------------------------------*

*& Report ZWORK14_002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZWORK14_002.



include
ZWORK14_002_TOP
.

include
ZWORK14_002_SCR
.

include
ZWORK14_002_F01
.

include
ZWORK14_002_PBO
.

include
ZWORK14_002_PAI
.





START-OF-SELECTION.

  PERFORM GET_DATA.



  IF GT_OUT IS INITIAL.

    MESSAGE '### #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

  ELSE.

    CALL SCREEN 100.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> PDF ####





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ### #### ####.