
*&---------------------------------------------------------------------*

*& Report ZWORK04_002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZWORK04_002 MESSAGE-ID ZMED04.



include
ZWORK04_002_TOP
.

include
ZWORK04_002_SCR
.

include
ZWORK04_002_F01
.

include
ZWORK04_002_PBO
.

include
ZWORK04_002_PAI
.



INITIALIZATION.

  PERFORM SET_INIT.



START-OF-SELECTION.

  PERFORM SELECT_DATA.



  IF GT_ZTCURR04[] IS NOT INITIAL.

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

*   PageSetup ### ### # ####.