
*&---------------------------------------------------------------------*

*& Report ZMM10_FK01

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZMM10_FK01 MESSAGE-ID ZME10.



include
ZMM10_FK01_TOP
.

include
ZMM10_FK01_SCR
.

include
ZMM10_FK01_F01
.

include
ZMM10_FK01_O01
.

include
ZMM10_FK01_I01
.



INITIALIZATION.

  CLEAR GS_VENDER.



AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    IF PR_CREA = 'X'.

      " ## ##.

      IF SCREEN-GROUP1 = 'CRE'.

        SCREEN-ACTIVE = 1.




*        SCREEN-REQUIRED = 1.




      ELSEIF SCREEN-GROUP1 = 'SEA'.

        SCREEN-ACTIVE = 0.




*        SCREEN-REQUIRED = 0.




      ENDIF.

    ELSE.

      IF SCREEN-GROUP1 = 'CRE'.

        SCREEN-ACTIVE = 0.




*        SCREEN-REQUIRED = 0.




      ELSEIF SCREEN-GROUP1 = 'SEA'.

        SCREEN-ACTIVE = 1.




*        SCREEN-REQUIRED = 1.




      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.



AT SELECTION-SCREEN.

  CASE SY-UCOMM.

    WHEN 'ONLI'.

      PERFORM CHECK_PARAMETERS.

    WHEN OTHERS.

      " PASS. START_SELECTION

  ENDCASE.



START-OF-SELECTION.

  PERFORM GET_DATA.




*  PERFORM MODI_DATA.






END-OF-SELECTION.

  CALL SCREEN 100.








*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ### ## ####.