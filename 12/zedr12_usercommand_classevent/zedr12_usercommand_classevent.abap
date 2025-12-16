
*&---------------------------------------------------------------------*

*& Report ZEDR12_USERCOMMAND

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*



*#### ##### ###(CLASS-EVENT)#,

*# #### #### # ### ### #### ###(HANDLER)# ## #### ## ###.






REPORT ZEDR12_USERCOMMAND_CLASSEVENT MESSAGE-ID ZMED12.






*REPORT ZEDR12_ZDOCKING_CONTAINER MESSAGE-ID ZMED12.






include
ZEDR12_ZCLASSEVENT_CLS
.

include
ZEDR12_ZCLASSEVENT_TOP
. "######(# ## ## OK

include
ZEDR12_ZCLASSEVENT_SCR
.

include
ZEDR12_ZCLASSEVENT_F01
.

include
ZEDR12_ZCLASSEVENT_PBO
.

include
ZEDR12_ZCLASSEVENT_PAI
.





INITIALIZATION.

  PERFORM SET_INIT. "####



START-OF-SELECTION.

  IF S_ZCODE IS INITIAL.

    MESSAGE I000.

    EXIT.

  ENDIF.

  PERFORM GET_DATA.



  IF GT_STUDENT[] IS NOT INITIAL.

    CALL SCREEN 100.

  ELSE.

    MESSAGE I000.

    EXIT.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> USERCOMMAND





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ##########.