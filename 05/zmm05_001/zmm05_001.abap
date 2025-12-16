
*&---------------------------------------------------------------------*

*& Report ZMM05_001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*






REPORT ZMM05_001 MESSAGE-ID ZMED05.



include
ZMM05_001_TOP
.

include
ZMM05_001_SCR
.

include
ZMM05_001_F01
.

include
ZMM05_001_PBO
.

include
ZMM05_001_PAI
.





INITIALIZATION.





AT SELECTION-SCREEN OUTPUT.

  PERFORM SELECTION_SCREEN.





START-OF-SELECTION.

  PERFORM CHECK_PARAM.

  IF P_CRE = C_X.

    PERFORM PREPARE_CREATE_MODE.

    CALL SCREEN 100.

  ELSEIF P_VIEW = C_X.

    PERFORM GET_DATA.

    IF GV_LIFNR IS NOT INITIAL.

      CALL SCREEN 100.

    ELSE.

      MESSAGE I001.

      LEAVE TO SCREEN 0.

    ENDIF.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* 0100 --> ##





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ### ### #####.