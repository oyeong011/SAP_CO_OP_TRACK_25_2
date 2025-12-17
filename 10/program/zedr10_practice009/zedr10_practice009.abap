
*&---------------------------------------------------------------------*

*& Report ZEDR10_PRACTICE009

*&---------------------------------------------------------------------*

*&

*&--------------------------------------------------------------




REPORT ZEDR10_PRACTICE009 MESSAGE-ID ZEDM10.



include
ZEDR10_PRACTICE009_TOP
.  " ## ##, ###, ## ## [1]

include
ZEDR10_PRACTICE009_SCR
.  " ## ## (Select-Options #) [2]

include
ZEDR10_PRACTICE009_F01
.  " ##, ##, ALV ## ## [3]

include
ZEDR10_PRACTICE009_PBO
.  " ## ## # ## [4]

include
ZEDR10_PRACTICE009_PAI
.  " ### ## # ## [5]



" 4. ### ###

" ####: INITIALIZATION #### ### #### ####. [6]

INITIALIZATION.

  PERFORM SET_DATE. " #### ### ## (## ## ##) [7]



" 5. ## ###

" ####: START-OF-SELECTION #### ### #### ####. [6]

START-OF-SELECTION.

  PERFORM CHECK_DATA.   " ### ## (### ## #) [8]

  PERFORM GET_DATA.     " ### ## (ZEDT10 ### JOIN) [9]

  PERFORM CONVERT_DATA. " ### ## (###, ### ##) [10]



  " #### ### ## ## ##, ### ### ##

  IF GT_EMP[] IS NOT INITIAL.

    CALL SCREEN 100.

  ELSE.

    MESSAGE I001. " ### #### ####. [11]

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T0100 --> ## ## ###

* T0100 --> ## ## ###