
*&---------------------------------------------------------------------*

*& Report ZEDR12_MODULEPOOL

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_MODULEPOOL. "Module Pool#######,##,##,#### ### ### ##



include
ZEDR12_MODULEPOOL_TOP
.  "######(# ## ## OK_CODE##)

include
ZEDR12_MODULEPOOL_SCR
.  "Selection-screen#

include
ZEDR12_MODULEPOOL_F01
.  "Subroutine#

include
ZEDR12_MODULEPOOL_PBO
.  "PBO (Process Before Output) : ###############

include
ZEDR12_MODULEPOOL_PAI
.  "PAI (Process After Input) : ######USER#########



INITIALIZATION.

  PERFORM SET_INIT. "####



START-OF-SELECTION.

  PERFORM GET_DATA.



  CALL SCREEN 100. "100####### #####.






*GUI Texts

*----------------------------------------------------------

* T100 --> #####