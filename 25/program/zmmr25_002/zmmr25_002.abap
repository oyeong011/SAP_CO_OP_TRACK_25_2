
*&---------------------------------------------------------------------*

*& Report ZMMR25_002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*






REPORT ZMMR25_002.



include
ZMMR25_002_CLS
.

include
ZMMR25_002_TOP
.

include
ZMMR25_002_SCR
.

include
ZMMR25_002_F01
.

include
ZMMR25_002_PBO
.

include
ZMMR25_002_PAI
.



INITIALIZATION.

  PERFORM INIT_SELECTION.



AT SELECTION-SCREEN OUTPUT.

  PERFORM SELECTION_SCREEN_CONTROL.



AT SELECTION-SCREEN.

  PERFORM DETERMINE_MODE.



  IF GV_MODE = C_MODE_CREATE.

    IF P_BUKRS IS INITIAL

       OR P_LIFNR1 IS INITIAL

       OR P_BEDAT IS INITIAL.

      MESSAGE '#### #####.' TYPE 'S' DISPLAY LIKE 'E'.

      STOP.

    ENDIF.

    PERFORM CHECK_VENDOR_VALID.



  ELSEIF GV_MODE = C_MODE_DISP.

    IF P_LIFNR2 IS INITIAL

       OR P_BUKRS2 IS INITIAL

       OR P_EBELN IS INITIAL.

      MESSAGE '#### #####.' TYPE 'S' DISPLAY LIKE 'E'.

      STOP.

    ENDIF.

  ENDIF.



START-OF-SELECTION.

  PERFORM DETERMINE_MODE.



  IF GV_MODE = C_MODE_CREATE.

    CALL SCREEN 100.



  ELSEIF GV_MODE = C_MODE_DISP.

    PERFORM RUN_DISPLAY_MODE.

    CALL SCREEN 100.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* 0100 --> ## ##

* 0100 --> ## ##





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ## PO #### ####.