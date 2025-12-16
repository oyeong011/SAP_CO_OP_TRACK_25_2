
*&---------------------------------------------------------------------*

*& Report ZMM10_IV_MGT

*&---------------------------------------------------------------------*




REPORT ZMM10_IV_MGT MESSAGE-ID ZMM10.



include
ZMM10_IV_MGT_TOP
.

include
ZMM10_IV_MGT_SCR
.

include
ZMM10_IV_MGT_CLS
.  " (## ALV ### ##)

include
ZMM10_IV_MGT_F01
. " (Form ##)

include
ZMM10_IV_MGT_PBO
.

include
ZMM10_IV_MGT_PAI
.



" ## ## ## (### ## - ### ## ## ##/### ## #)



AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    " #: ## ### ## ## ## #### ## ## ##

    IF SCREEN-GROUP1 = 'M01'.

      IF R_DISP = 'X'.

        SCREEN-ACTIVE = '0'.

      ELSE.

        SCREEN-ACTIVE = '1'.

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.



  " ### ## (Validation) [3]



AT SELECTION-SCREEN.

  CASE SY-UCOMM.

    WHEN 'ONLI'.

      " F8 ## ### ## ### ##

      IF S_EBELN[] IS INITIAL.

        MESSAGE '#### ### #####.' TYPE 'E'.

      ENDIF.



      IF S_WERKS[] IS INITIAL.

        MESSAGE '#### #####.' TYPE 'E'.

      ENDIF.

      IF R_CREA = 'X'.



        IF P_BUDAT IS INITIAL.

          MESSAGE '#####(###)# #####.' TYPE 'E'.

        ENDIF.



      ELSEIF R_DISP = 'X'.

        " ## ## ## (## #)

      ENDIF.



      PERFORM CHECK_INPUT_DATA.



    WHEN 'UCMD'.

      " ### ## ## #

      " OUTPUT ##### #### ## ##### ## ## ###



    WHEN OTHERS.

      " ## USER-COMMAND (#### #)

  ENDCASE.



START-OF-SELECTION.

  PERFORM GET_DATA.



END-OF-SELECTION.

  CALL SCREEN 100.






*GUI Texts

*----------------------------------------------------------

* T100 --> ## ## ##





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ### #### ### #### ####.