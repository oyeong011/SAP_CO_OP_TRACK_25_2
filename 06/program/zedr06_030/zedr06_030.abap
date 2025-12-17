
*&---------------------------------------------------------------------*

*& Report ZEDR06_030

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR06_030 MESSAGE-ID ZMED006.



include
ZEDR06_030_TOP
.

include
ZEDR06_030_SCR
.

include
ZEDR06_030_F01
.

include
ZEDR06_030_PBO
.

include
ZEDR06_030_PAI
.



INITIALIZATION.

  PERFORM SET_INIT.



START-OF-SELECTION.

  PERFORM GET_DATA.



  " CUSTOM CONTROLLER -> CONTAINER -> GRID

  " 1. CUSTOM CONTROLLER# ##### ## # ## -> CALL SCREEN# ## SCREEN ##.

  " 2. ##### CUSTOM CONTROLLER# ## # ## ## ### ## CONTAINER##(## ## ### ## ## ##)

  " 3. ### ## ALV GRID ### ### CONTAINER# #####.

  " 4. ##. SET_TABLE_FOR_FIRST_DISPLAY.

  IF GT_STUDENT[] IS NOT INITIAL.

    CALL SCREEN 100.

  ELSE.

    MESSAGE I001.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> #####