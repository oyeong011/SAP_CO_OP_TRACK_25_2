
*&---------------------------------------------------------------------*

*&  Include           ZMM18_002_PBO

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  STATUS_0100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0100 OUTPUT.

  DATA: LT_EXCLUDE TYPE TABLE OF SY-UCOMM.



  " 1. ## ## -> ## ## ## ###

  IF GV_MODE = 'D'.

    APPEND 'ADD' TO LT_EXCLUDE. " ## ## ## ##

    APPEND 'DEL' TO LT_EXCLUDE. " ## ## ## ##

    APPEND 'SAVE' TO LT_EXCLUDE. " ## ## ##

  ENDIF.



  " 2. ## ## ##

  SET PF-STATUS 'STATUS_0100' EXCLUDING LT_EXCLUDE.



  " 3. ### ##

  IF GV_MODE = 'C'.

    SET TITLEBAR 'T100'.

  ELSE.

    SET TITLEBAR 'T200'.

  ENDIF.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_ALV  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_ALV OUTPUT.

  IF GO_GRID IS INITIAL.

    PERFORM CREATE_OBJECT.

    PERFORM FIELD_CATALOG.

    PERFORM ALV_LAYOUT.

    PERFORM ALV_SORT.

    PERFORM CLASS_EVENT.

    PERFORM ALV_DISPLAY.

  ELSE.

    PERFORM REFRESH.

  ENDIF.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  MODIFY_SCREEN  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE MODIFY_SCREEN OUTPUT.

  PERFORM MODIFY_SCREEN_0100.

ENDMODULE.