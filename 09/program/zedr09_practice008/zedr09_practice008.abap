
*&---------------------------------------------------------------------*

*& Report ZEDR09_PRACTICE008

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR09_PRACTICE008 MESSAGE-ID ZMED09.



include
ZEDR09_PRACTICE008_TOP
.

include
ZEDR09_PRACTICE008_SCR
.

include
ZEDR09_PRACTICE008_F01
.

include
ZEDR09_PRACTICE008_PBO
.

include
ZEDR09_PRACTICE008_PAI
.





INITIALIZATION.

  PERFORM SET_DATE. "## #### ## (####, ####)



AT SELECTION-SCREEN OUTPUT.

  PERFORM CONTROL_SCREEN. "#### (####### ####, #### ## ### ##)



"## ####

START-OF-SELECTION.

  PERFORM CHECK_SCREEN. "### ## (####,## ##### ##, ###### range ##)



  IF P_R1 = C_X.        "######

    PERFORM SELECT_R1.

    PERFORM MODIFY_R1.



    IF GT_ORDER IS NOT INITIAL.

      CALL SCREEN 100.

    ELSE.

      MESSAGE I013. "##### ## #### ####

      EXIT.

    ENDIF.





  ELSEIF P_R2 = C_X.    "######

    PERFORM SELECT_R2.

    PERFORM MODIFY_R2.



    IF GT_DELIVERY IS NOT INITIAL.

      CALL SCREEN 200.

    ELSE.

      MESSAGE I013.

      EXIT.

    ENDIF.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> ######

* T100 --> ######