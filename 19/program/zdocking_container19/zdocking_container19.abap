
*&---------------------------------------------------------------------*

*& Report ZDOCKING_CONTAINER19

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZDOCKING_CONTAINER19 MESSAGE-ID ZME00.



include
ZDOCKING_CONTAINER19_TOP
.

include
ZDOCKING_CONTAINER19_SCR
.

include
ZDOCKING_CONTAINER19_F01
.

include
ZDOCKING_CONTAINER19_PBO
.

include
ZDOCKING_CONTAINER19_PAI
.



INITIALIZATION.

  PERFORM SET_INIT.



START-OF-SELECTION.

  IF S_ZCODE IS INITIAL.

    IF P_ZERNR IS INITIAL.

      MESSAGE I000.

      EXIT.

    ENDIF.

  ENDIF.



  PERFORM GET_DATA.

  PERFORM MODIFY_DATA.



  IF GT_STUDENT[] IS NOT INITIAL.

    CALL SCREEN 100.

  ELSE.

    MESSAGE I000.

    EXIT.

  ENDIF.



include
zdocking_container19_statuso01
.



include
zdocking_container19_user_ci01
.