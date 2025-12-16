
*&---------------------------------------------------------------------*

*& Report ZMM05_002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZMM05_002 MESSAGE-ID ZMED05.



include
ZMM05_002_CLS
.

include
ZMM05_002_TOP
.

include
ZMM05_002_SCR
.

include
ZMM05_002_F01
.

include
ZMM05_002_PBO
.

include
ZMM05_002_PAI
.







AT SELECTION-SCREEN OUTPUT.

  PERFORM MODIFY_SCREEN.



AT SELECTION-SCREEN.

  IF R_CRE = 'X'.

    PERFORM CHECK_VENDOR_VALID_ON_SCREEN.

  ENDIF.



START-OF-SELECTION.

  PERFORM CHECK_P.



  IF R_CRE = 'X'.




*    " ## ##




    PERFORM CHECK_VENDOR_VALID.

    PERFORM PREPARE_CREATE_MODE.

    CALL SCREEN 100.



  ELSEIF R_VIEW = 'X'.

    " ## ##

    PERFORM GET_PO_DATA.



    IF GT_ITEM IS INITIAL.

      MESSAGE '### #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

      STOP.

    ELSE.

      CALL SCREEN 100.

    ENDIF.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* 0100 --> 0100

* 0100 --> 0100





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   #### ## ######.