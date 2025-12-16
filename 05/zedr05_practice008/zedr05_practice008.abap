
*&---------------------------------------------------------------------*

*& Report ZEDR05_PRACTICE008

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




report ZEDR05_PRACTICE008 MESSAGE-ID ZMED05.



include
ZEDR05_PRACTICE008_TOP
.

include
ZEDR05_PRACTICE008_SCR
.

include
ZEDR05_PRACTICE008_F01
.

include
ZEDR05_PRACTICE008_PBO
.

include
ZEDR05_PRACTICE008_PAI
.





initialization.

  perform SET_INIT.



at selection-screen output.

  perform SET_SCREEN.





start-of-selection.

  PERFORM CHECK_DATA.





  IF P_R1 = 'X'.

    PERFORM GET_ORDER.

    IF GT_ORDER[] IS NOT INITIAL.

      CALL SCREEN 100.

    ELSE.

      MESSAGE I001.

      EXIT.

    ENDIF.

  ELSEIF P_R2 = 'X'.

    PERFORM GET_DELIVERY.

    IF GT_DELIVERY[] IS NOT INITIAL.

      CALL SCREEN 200.

    ELSE.

      MESSAGE I001.

      EXIT.

    ENDIF.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> ######

* T200 --> ######

* T100 --> ######

* T200 --> ######