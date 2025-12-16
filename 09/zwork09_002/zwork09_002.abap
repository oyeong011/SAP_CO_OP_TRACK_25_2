
*&---------------------------------------------------------------------*

*& Report ZWORK09_002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZWORK09_002.



include
ZWORK09_002_CLS
.

include
ZWORK09_002_TOP
.

include
ZWORK09_002_SCR
.

include
ZWORK09_002_F01
.

include
ZWORK09_002_PBO
.

include
ZWORK09_002_PAI
.



"## ####

START-OF-SELECTION.

  "### ####

  PERFORM GET_DATA.



  "### #### ## #

  IF GT_CURR_ALV[] IS INITIAL.

    MESSAGE '#### ## #### ####' TYPE 'I'.

    EXIT.

  ELSE.

    CALL SCREEN 100.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> ####





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   PDF ##### #### #####. ## #### ### ######.