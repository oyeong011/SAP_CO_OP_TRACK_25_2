
*&---------------------------------------------------------------------*

*& Report ZMM02_001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZMM02_001 MESSAGE-ID ZMED02.



include
ZMM02_001_CLS
.

include
ZMM02_001_TOP
.

include
ZMM02_001_SCR
.

include
ZMM02_001_F01
.

include
ZMM02_001_PBO
.

include
ZMM02_001_PAI
.



INITIALIZATION.

  PERFORM SET_INIT.



AT SELECTION-SCREEN OUTPUT.

  PERFORM SET_SCREEN.



AT SELECTION-SCREEN.

  IF SY-UCOMM = 'ONLI'. "## ## ##

    PERFORM VALIDATE_INPUT.

  ENDIF.



START-OF-SELECTION.

  DATA: LV_ANSWER TYPE C.

  IF P_CRE = 'X'. "### #

    CALL FUNCTION 'POPUP_TO_CONFIRM' "## ##

      EXPORTING

       TITLEBAR                    = '### ##'




*       DIAGNOSE_OBJECT             = ''




        TEXT_QUESTION               = '### ### ##'

       TEXT_BUTTON_1               = '# (YES)'




*       ICON_BUTTON_1               = ' '




       TEXT_BUTTON_2               = '###(NO)'




*       ICON_BUTTON_2               = ' '

*       DEFAULT_BUTTON              = '1'




       DISPLAY_CANCEL_BUTTON       = ''




*       USERDEFINED_F1_HELP         = ' '

*       START_COLUMN                = 25

*       START_ROW                   = 6

*       POPUP_TYPE                  =

*       IV_QUICKINFO_BUTTON_1       = ' '

*       IV_QUICKINFO_BUTTON_2       = ' '




     IMPORTING

       ANSWER                      = LV_ANSWER




*     TABLES

*       PARAMETER                   =

*     EXCEPTIONS

*       TEXT_NOT_FOUND              = 1

*       OTHERS                      = 2




              .

    IF SY-SUBRC <> 0.

    ENDIF.

    IF LV_ANSWER = '1'.

      G_BUKRS = P_BUKRS. "####

      G_KTOKK = P_KTOKK. "#####

      CALL SCREEN 100.

    ELSE.

      LEAVE TO SCREEN 1000.

    ENDIF.

  ELSEIF P_VIEW = 'X'.

    G_BUKRS = P_BUKRS. "####

    G_LIFNR = P_LIFNR. "#####

    PERFORM GET_DATA.

    PERFORM SET_DATA.

    CALL SCREEN 200.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> ## ####: ##

* T200 --> ### ##





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ## ## ## ### ######.