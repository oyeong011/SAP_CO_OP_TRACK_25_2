
*&---------------------------------------------------------------------*

*&  Include           ZMM03_003_PBO

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  STATUS_0100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0100 OUTPUT.

  "1. ## ## ### ###

  REFRESH GT_EXCLUDE.

  " 2. ### ### ## ## ## ##

  IF P_R1 = 'X'.

    "## ##### '####(BTN_CANCEL)'## ###

    APPEND 'BTN_CANC' TO GT_EXCLUDE.

    "### : ## ## ## ##

    SET TITLEBAR 'T100' WITH '##'.

  ELSEIF P_R2 = 'X'.

    "## ##### '####(BTN_POST)' ## ###

    APPEND 'BTN_POST' TO GT_EXCLUDE.

    "### : ## ## ## ##

    SET TITLEBAR 'T100' WITH '##'.

  ENDIF.



  SET PF-STATUS 'STATUS_0100' EXCLUDING GT_EXCLUDE.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_ALV  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_ALV OUTPUT.

  IF GC_DOCKING IS INITIAL.

    PERFORM CREATE_OBJECT.

    PERFORM FIELD_CATALOG.

    PERFORM ALV_LAYOUT.

    PERFORM ALV_SORT.

    PERFORM CLASS_EVENT.

    PERFORM CALL_ALV.

  ELSE.

    PERFORM REFRESH. "## ### ## #

  ENDIF.

ENDMODULE.