
*&---------------------------------------------------------------------*

*& Report ZPROJECT25_001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZMMR25_001.



include
ZMMR25_001_CLS
.

include
ZMMR25_001_TOP
.

include
ZMMR25_001_SCR
.

include
ZMMR25_001_F01
.

include
ZMMR25_001_PBO
.

include
ZMMR25_001_PAI
.



INITIALIZATION.

  PERFORM INIT_DEFAULT_VALUES.



AT SELECTION-SCREEN OUTPUT.

  PERFORM SELECTION_SCREEN.



AT SELECTION-SCREEN.

  IF SY-UCOMM = 'ONLI'.

    IF P_VIEW = C_X.

      PERFORM CHECK_VENDOR_EXISTS.

    ENDIF.

  ENDIF.



START-OF-SELECTION.

  PERFORM CHECK_PARAM.



  IF P_CRE = C_X.

    PERFORM PREPARE_CREATE_MODE.

    CALL SCREEN 100.

  ELSEIF P_VIEW = C_X.

    PERFORM GET_DATA.

      CALL SCREEN 100.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* 0100 --> ### ##





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ## #### #### ####.