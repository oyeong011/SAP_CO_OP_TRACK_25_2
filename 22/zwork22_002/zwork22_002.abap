
*&---------------------------------------------------------------------*

*& Report ZWORK22_002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZWORK22_002.

include
ZWORK22_002_TOP
.

include
ZWORK22_002_SCR
.

include
ZWORK22_002_F01
.

include
ZWORK22_002_PBO
.

include
ZWORK22_002_PAI
.





INITIALIZATION.



AT SELECTION-SCREEN OUTPUT.



START-OF-SELECTION.

  PERFORM GET_DATA.



    IF GT_CURR_DIS IS INITIAL.

    MESSAGE |#### ### #### #### ####.| TYPE 'I'.

    EXIT.

  ENDIF.



  CALL SCREEN 100.






*GUI Texts

*----------------------------------------------------------

* T100 --> ##





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   PDF ## ### #####.