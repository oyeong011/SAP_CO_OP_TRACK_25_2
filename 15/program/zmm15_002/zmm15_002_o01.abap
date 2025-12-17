
*&---------------------------------------------------------------------*

*&  Include           ZMM15_002_O01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  STATUS_0100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0100 OUTPUT.



  DATA : LT_EXCL TYPE TABLE OF SY-UCOMM.



  IF P_R1 = 'X'.

    GV_LIFNR = P_LIFNR1.

    GV_BUKRS = P_BUKRS1.

    GV_BEDAT = P_BEDAT.

  ELSEIF P_R2 = 'X'.

    APPEND 'SAVE' TO LT_EXCL.

    APPEND 'ADD' TO LT_EXCL.

    APPEND 'DELETE' TO LT_EXCL.

  ENDIF.



  SET PF-STATUS 'STATUS100' EXCLUDING LT_EXCL.

  SET TITLEBAR 'T100'.



  PERFORM MODIFY_100.



ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_ALV  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_ALV OUTPUT.

  IF GC_CUSTOM IS INITIAL.

    PERFORM CREATE_OBJECT.

    PERFORM FIELD_CATALOG.

    PERFORM ALV_LAYOUT.

    PERFORM CLASS_EVENT.

    PERFORM ALV_DISPLAY.

  ELSE.

    PERFORM REFRESH.

  ENDIF.

ENDMODULE.