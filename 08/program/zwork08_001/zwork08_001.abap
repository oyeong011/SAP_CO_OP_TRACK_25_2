
*&---------------------------------------------------------------------*

*& Report ZWORK08_001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZWORK08_001.



include
ZWORK08_001_CLS
.

include
ZWORK08_001_TOP
.

include
ZWORK08_001_SCR
.

include
ZWORK08_001_F01
.

include
ZWORK08_001_PBO
.

include
ZWORK08_001_PAI
.



" AT SELECTION-SCREEN: ## F4 ###

" ## ### P_FILE #### F4 ### ### # #### ###

AT SELECTION-SCREEN ON VALUE-REQUEST FOR P_FILE.

  PERFORM F4_FOR_FILE.



" ##### ## ## # # ##

INITIALIZATION.

  PERFORM SET_DEFAULTS.



" ## #### F8 ## ### # #### ##

START-OF-SELECTION.

  PERFORM START_SCREEN.








*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ##### #### ## #####.