
*&---------------------------------------------------------------------*

*&  Include           ZMMR13_004_O01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  STATUS_0100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0100 OUTPUT.

  SET PF-STATUS 'STATUS_0100'.

  SET TITLEBAR 'T001'.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_COLOR  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_COLOR OUTPUT.

  IF GV_BALANCE = 0.

    GV_COLOR = '@08@'.

  ELSE.

    GV_COLOR = '@0A@'.

  ENDIF.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_ALV  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_ALV OUTPUT.

  IF GC_GRID IS INITIAL.

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

*&      Module  STATUS_0200  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0200 OUTPUT.

  SET PF-STATUS 'STATUS_0200'.

  SET TITLEBAR 'T002'.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_ALV2  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_ALV2 OUTPUT.

  IF GC_DOCKING IS INITIAL.

    PERFORM CREATE_OBJECT2.

    PERFORM FIELD_CATALOG2.

    PERFORM ALV_LAYOUT.

    PERFORM ALV_SORT.

    PERFORM CLASS_EVENT2.

    PERFORM ALV_DISPLAY2.

  ELSE.

    PERFORM REFRESH.

  ENDIF.

ENDMODULE.