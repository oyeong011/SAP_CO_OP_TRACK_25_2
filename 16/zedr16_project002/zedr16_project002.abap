
*&---------------------------------------------------------------------*

*& Report ZEDR16_PROJECT002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR16_PROJECT002 MESSAGE-ID ZMED16.



include
ZEDR16_PROJECT002_CLS
.

include
ZEDR16_PROJECT002_TOP
.

include
ZEDR16_PROJECT002_SCR
.

include
ZEDR16_PROJECT002_F01
.

include
ZEDR16_PROJECT002_PBO
.

include
ZEDR16_PROJECT002_PAI
.



INITIALIZATION.

  PERFORM SET_INIT.



START-OF-SELECTION.

  PERFORM INIT_PARAMETER.



  IF P_CRE = 'X'.

    PERFORM CHECK_LIFNR.



    CALL SCREEN 100.



  ELSEIF P_DIS = 'X'.

    PERFORM GET_DATA.



    CALL SCREEN 100.



  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> PO##





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ### ### #####.