
REPORT ZEDR21_022 MESSAGE-ID ZMED21.

  include
ZEDR21_022_CLS
.

  include
ZEDR21_022_TOP
.

  include
ZEDR21_022_SCR
.

  include
ZEDR21_022_F01
.

  include
ZEDR21_022_PBO
.

  include
ZEDR21_022_PAI
.



  INITIALIZATION.

  PERFORM SET_INIT.



  AT SELECTION-SCREEN OUTPUT.

    PERFORM SET_INIT.



  START-OF-SELECTION.

    PERFORM GET_DATA.

    PERFORM MODITY_DATA.



    IF GT_STUDENT[] IS NOT INITIAL.

      CALL SCREEN 100.



    ELSE.

      MESSAGE I000.

      EXIT.

    ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> #####





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ##########