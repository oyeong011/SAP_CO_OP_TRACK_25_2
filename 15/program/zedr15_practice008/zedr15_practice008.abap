
*&---------------------------------------------------------------------*

*& Report ZEDR15_PRACTICE008

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR15_PRACTICE008 MESSAGE-ID ZMED15.



include
ZEDR15_PRACTICE008_TOP
.

include
ZEDR15_PRACTICE008_SCR
.

include
ZEDR15_PRACTICE008_F01
.

include
ZEDR15_PRACTICE008_PBO
.

include
ZEDR15_PRACTICE008_PAI
.






*## ### # ## ## # ###




INITIALIZATION.

  PERFORM DATE_INIT. "####/#### default ##






*### layout### ##




AT SELECTION-SCREEN OUTPUT.

  PERFORM SCREEN_CONTROL. "### ### ## ####/#### #####



START-OF-SELECTION.

  PERFORM SCREEN_CHECK. "#### ## #### #####/###### RANGE##

  IF P_R1 = 'X'."####

    PERFORM SELECT_ORDER.

    PERFORM MODIFY_ORDER.

    CALL SCREEN 100.



  ELSEIF P_R2 = 'X'."####

    PERFORM SELECT_DELIVER.

    PERFORM MODIFY_DELIVER.

    CALL SCREEN 200.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> ######

* T200 --> ######

* T100 --> ######

* T200 --> ######