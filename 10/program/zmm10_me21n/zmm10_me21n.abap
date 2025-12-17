
*&---------------------------------------------------------------------*

*& Report ZMM10_ME21N

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZMM10_ME21N.



include
ZMM10_ME21N_TOP
.

include
ZMM10_ME21N_SCR
.

include
ZMM10_ME21N_CLS
.

include
ZMM10_ME21N_F01
.

include
ZMM10_ME21N_O01
.

include
ZMM10_ME21N_I01
.



INITIALIZATION.



AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    IF PR_CREA = 'X'.

      IF SCREEN-GROUP1 = 'MC'.

        SCREEN-ACTIVE = 1.

      ELSEIF SCREEN-GROUP1 = 'MS'.

        SCREEN-ACTIVE = 0.

      ENDIF.

    ELSE.

      IF SCREEN-GROUP1 = 'MC'.

        SCREEN-ACTIVE = 0.

      ELSEIF SCREEN-GROUP1 = 'MS'.

        SCREEN-ACTIVE = 1.

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.



START-OF-SELECTION.

  PERFORM GET_DATA.

  CALL SCREEN 100.



END-OF-SELECTION.

  CALL  SCREEN 100.








*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ## ## ## ##