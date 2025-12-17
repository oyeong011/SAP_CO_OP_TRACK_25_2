
*&---------------------------------------------------------------------*

*& Report ZEDR16_PROJECT003

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR16_PROJECT003 MESSAGE-ID ZMED16.



include
ZEDR16_PROJECT003_CLS
.

include
ZEDR16_PROJECT003_TOP
.

include
ZEDR16_PROJECT003_SCR
.

include
ZEDR16_PROJECT003_F01
.

include
ZEDR16_PROJECT003_F02
.

include
ZEDR16_PROJECT003_PBO
.

include
ZEDR16_PROJECT003_PAI
.



INITIALIZATION.

  PERFORM SET_INIT.



START-OF-SELECTION.



  IF P_CRE = 'X'.

    PERFORM CHECK_INPUT_DATA.

    PERFORM GET_DATA.

    PERFORM MODIFY_DATA. " ## ##



    CALL SCREEN 100.



  ELSE.

    PERFORM CHECK_INPUT_DATA_DIS.

    PERFORM GET_DATA_DIS.



    CALL SCREEN 200.



  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> ####

* T200 --> ####





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ###(##)# ######.