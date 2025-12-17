
*&---------------------------------------------------------------------*

*& Report ZEDR16_PROJECT004

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR16_PROJECT004 MESSAGE-ID ZMED16.



include
ZEDR16_PROJECT004_CLS
.

include
ZEDR16_PROJECT004_TOP
.

include
ZEDR16_PROJECT004_SCR
.

include
ZEDR16_PROJECT004_F01
.

include
ZEDR16_PROJECT004_F02
.

include
ZEDR16_PROJECT004_PBO
.

include
ZEDR16_PROJECT004_PAI
.



INITIALIZATION.

  PERFORM SET_INIT.



START-OF-SELECTION.



  IF P_CRE = 'X'.

    PERFORM CHECK_INPUT_DATA.

    PERFORM GET_DATA.

    PERFORM MODIFY_DATA.



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