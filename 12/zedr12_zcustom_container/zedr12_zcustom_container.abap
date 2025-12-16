
*&---------------------------------------------------------------------*

*& Report ZEDR12_ZCUSTOM_CONTAINER

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_ZCUSTOM_CONTAINER MESSAGE-ID ZMED12.



include
ZEDR12_ZCUSTOM_CONTAINER_TOP
. "######(# ## ## OK

include
ZEDR12_ZCUSTOM_CONTAINER_SCR
. "Selection-screen#

include
ZEDR12_ZCUSTOM_CONTAINER_F01
. "Subroutine#

include
ZEDR12_ZCUSTOM_CONTAINER_PBO
. "PBO (Process Before Ou

include
ZEDR12_ZCUSTOM_CONTAINER_PAI
. "PAI (Process After Inpu



INITIALIZATION.

  PERFORM SET_INIT.



START-OF-SELECTION.

  PERFORM GET_DATA.



  IF GT_STUDENT[] IS NOT INITIAL.

    CALL SCREEN 100.

  ELSE.

    MESSAGE I000.

    EXIT.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> #####