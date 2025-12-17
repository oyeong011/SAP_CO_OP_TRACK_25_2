
*&---------------------------------------------------------------------*

*& Report ZWORK03_001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZWORK03_002 MESSAGE-ID ZME03.



include
ZWORK03_002_CLS
.

include
ZWORK03_002_TOP
.

include
ZWORK03_002_SCR
.

include
ZWORK03_002_F01
.

include
ZWORK03_002_PBO
.

include
ZWORK03_002_PAI
.



INITIALIZATION. "#### ## ### ##

  TEXT01 = '####'.

  DATA : LV_DATE TYPE ZTCURR03-GDATU.

  CALL FUNCTION 'CONVERSION_EXIT_INVDT_INPUT' "### ## ##

    EXPORTING

      INPUT         = '20250101'

   IMPORTING

     OUTPUT        = LV_DATE.

            .

  P_DATE = LV_DATE.



AT SELECTION-SCREEN.



AT SELECTION-SCREEN OUTPUT.



START-OF-SELECTION.

  IF P_DATE IS INITIAL.

    MESSAGE I000.

    EXIT.

  ENDIF.

  PERFORM GET_DATA USING P_DATE.



  IF GT_CURR[] IS NOT INITIAL.

    CALL SCREEN 100.

  ELSE.

    MESSAGE I001.

    EXIT.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> ## ####





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   #### ## # ####.