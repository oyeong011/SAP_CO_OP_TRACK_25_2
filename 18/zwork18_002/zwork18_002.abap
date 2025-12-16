
*&---------------------------------------------------------------------*

*& Report ZWORK18_002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZWORK18_002 MESSAGE-ID ZMED18.



include
ZWORK18_002_TOP
.

include
ZWORK18_002_SCR
.

include
ZWORK18_002_F01
.

include
ZWORK18_002_PBO
.

include
ZWORK18_002_PAI
.



INITIALIZATION.





AT SELECTION-SCREEN OUTPUT.



START-OF-SELECTION.

  IF P_DATE IS NOT INITIAL.

    PERFORM GET_DATA.

    IF GT_CURR[] IS NOT INITIAL.

      CALL SCREEN 100.

    ELSE.

      MESSAGE I001.

    ENDIF.

  ELSE.

    MESSAGE I000.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> ## ####





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ## ### #### #####.