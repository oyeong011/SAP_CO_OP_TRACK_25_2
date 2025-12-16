
*&---------------------------------------------------------------------*

*& Report ZMM22_001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZMM22_001.

"## ##(####, #####) ### ## ## -> ### ### #### ##(#)

"####(#####, ####) ### ### ### ## -> ###### #### ## #### ### ## ## ### DB#### ##(#)

"### ## ## ## ### DB#### #### ### ### #### #########(## ## ##)(#)

"#### 3000### # ####(LFA1-STCD1)### ##### 2000### LFA1-STCA1, LFA1-STCD2(####, #####) ### ### ##(#)

include
ZMM22_001_TOP
.

include
ZMM22_001_SCR
.

include
ZMM22_001_F01
.

include
ZMM22_001_PBO
.

include
ZMM22_001_PAI
.



INITIALIZATION.



AT SELECTION-SCREEN.

  IF SY-UCOMM = 'ONLI'."## ##(f8)

    PERFORM VALID_SCREEN_INPUT.

  ENDIF.



AT SELECTION-SCREEN OUTPUT.

  PERFORM SET_SCREEN.



AT SELECTION-SCREEN ON P_KTOKK.

  PERFORM REFRESH_FIELD_CATALOG.



START-OF-SELECTION.

  IF P_CRE = 'X'.

    G_BUKRS = P_BUKRS.

    G_KTOKK = P_KTOKK.



    PERFORM GET_DATA.

    CALL SCREEN 100.



  ELSEIF P_VIEW = 'X'.

    G_BUKRS = P_BUKRS.

    G_LIFNR = P_LIFNR.



    PERFORM GET_DATA_200.

    CALL SCREEN 200.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> ########

* T200 --> #####





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ### ### #### ####.