
*&---------------------------------------------------------------------*

*& Report ZWORK10_002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZWORK10_002 MESSAGE-ID ZME10.



include
ZWORK10_2_TOP
.

include
ZWORK10_2_SCR
.

include
ZWORK10_2_F01
.

include
ZWORK10_2_O01
.

include
ZWORK10_2_I01
.



INITIALIZATION.

  SET TITLEBAR 'T0100'.

  CONVERT DATE SY-DATUM INTO INVERTED-DATE P_DATE.



AT SELECTION-SCREEN ON VALUE-REQUEST FOR P_DATE.

  " search help #### ## ##.

  PERFORM GDATU_SH.



START-OF-SELECTION.

  IF P_DATE IS NOT INITIAL.

    PERFORM GET_DATA.

  ELSE.

    MESSAGE I000.

    EXIT.

  ENDIF.



  IF GT_EXCEL_DATA[] IS NOT INITIAL.

    CALL SCREEN 100.

  ELSE.

    MESSAGE I000.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T0100 --> ## ## ## # ####





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ### ######.