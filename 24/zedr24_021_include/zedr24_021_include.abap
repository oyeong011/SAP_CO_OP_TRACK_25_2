
*&---------------------------------------------------------------------*

*& Report ZEDR24_021_INCLUDE

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




include
ZEDR24_021_INCLUDE
.

BREAK-POINT.

"###, ALV(## ####, ####, ##) ##

include
ZEDR24_021_TOP
.



"SELECT-OPTIONS ##, TABLES# TOP# ####.

include
ZEDR24_021_SCR
.



"PERFORM## ##

include
ZEDR24_021_F01
.



include
ZEDR24_021_PBO
.



include
ZEDR24_021_PAI
.



INITIALIZATION.

  PERFORM SET_INIT. "## ## (F01)



START-OF-SELECTION.

  PERFORM GET_DATA. "### #### (F01)



  BREAK-POINT.

  CALL SCREEN 100. "### ##



  "# ## START-OF-SELECTION## #### ##

END-OF-SELECTION.

  WRITE :/ 'PBO', PBO_CALL.

  WRITE :/ 'PAI', PAI_CALL.