
*&---------------------------------------------------------------------*

*& Report ZMM10_MIGO

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZMM10_MIGO.



include
ZMM10_MIGO_TOP
.  " ### ##

include
ZMM10_MIGO_SCR
.  " ## ## (Selection Screen)

include
ZMM10_MIGO_CLS
.  " ## ### (ALV ### #)

include
ZMM10_MIGO_F01
.  " ## ## (PERFORM)

include
ZMM10_MIGO_O01
.  " PBO (## ## #)

include
ZMM10_MIGO_I01
.  " PAI (### ## #)



INITIALIZATION.

  " ### ## (## # ##)



AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    " 1. ## ##(R_CREA) ### #

    IF R_CREA = 'X'.

      IF SCREEN-GROUP1 = 'DIS'.

        SCREEN-ACTIVE = 1.

      ENDIF.



      " 2. ## ##(R_DISP) ### #

    ELSEIF R_DISP = 'X'.

      IF SCREEN-GROUP1 = 'DIS'.

        SCREEN-ACTIVE = 0.

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.





START-OF-SELECTION.

  PERFORM GET_DATA.      " ### ## ## ##



END-OF-SELECTION.

  CALL SCREEN 100.       " ## ## ##








*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   #### ### #####.