
*&---------------------------------------------------------------------*

*& Report ZEDR03_016_MODULE_POOL

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR03_016_MODULE_POOL.



include
ZEDR03_016_TOP
. " ####

include
ZEDR03_016_SCR
. " ##

include
ZEDR03_016_F01
. " PERFORM#

include
ZEDR03_016_PBO
. " PBO ##

include
ZEDR03_016_PAI
. " PAI ##



INITIALIZATION.

  PERFORM SET_INIT.



START-OF-SELECTION.

  PERFORM GET_DATA.



END-OF-SELECTION.

  CALL SCREEN 100.






*GUI Texts

*----------------------------------------------------------

* T100 --> #####