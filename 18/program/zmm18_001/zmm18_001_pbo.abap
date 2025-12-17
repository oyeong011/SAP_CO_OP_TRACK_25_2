
*&---------------------------------------------------------------------*

*&  Include           ZMM18_001_PBO

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  STATUS_0100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0100 OUTPUT.

  SET PF-STATUS 'STATUS_0100'. "APND, ADD

  SET TITLEBAR 'T0100'.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_ALV_0100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_ALV_0100 OUTPUT.

  IF GC_GRID1 IS INITIAL.

    PERFORM CREATE_OBJECT_0100.

    PERFORM FIELD_CATALOG_0100.

    PERFORM ALV_SORT_0100.

    PERFORM ALV_LAYOUT.

    PERFORM ALV_DISPLAY_0100.

  ELSE.

    CALL METHOD GC_GRID1->REFRESH_TABLE_DISPLAY( ).

    CALL METHOD GC_GRID2->REFRESH_TABLE_DISPLAY( ).

    CALL METHOD GC_GRID3->REFRESH_TABLE_DISPLAY( ).

  ENDIF.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  STATUS_0200  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0200 OUTPUT.

  SET PF-STATUS 'STATUS_0200'.

  SET TITLEBAR 'T0200'.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_ALV_0200  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_ALV_0200 OUTPUT.

    IF GC_GRID_0200 IS INITIAL.

    PERFORM CREATE_OBJECT_0200.

    PERFORM FIELD_CATALOG_0200.

    PERFORM ALV_SORT_0200.

    PERFORM ALV_LAYOUT.

    PERFORM ALV_DISPLAY_0200.

  ELSE.

    CALL METHOD GC_GRID_0200->REFRESH_TABLE_DISPLAY( ).

  ENDIF.

ENDMODULE.