
*&---------------------------------------------------------------------*

*& Report ZEDR03_017_CLASS_ALV

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR03_017_CLASS_ALV MESSAGE-ID ZMED03.



include
ZEDR03_017_TOP
. "####

include
ZEDR03_017_SCR
. "##

include
ZEDR03_017_F01
. "PERFORM#

include
ZEDR03_017_PBO
. "PBO ##

include
ZEDR03_017_PAI
. "PAI ##



INITIALIZATION.

  PERFORM SET_INIT.



START-OF-SELECTION.

  PERFORM GET_DATA.



END-OF-SELECTION.

  IF GT_STUDENT[] IS NOT INITIAL.

    CALL SCREEN 100.

  ELSE.

    MESSAGE I100.

  ENDIF.