
*&---------------------------------------------------------------------*

*&  Include           ZPRACTICE008_CONTAINER18_O01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  STATUS_0100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0100 OUTPUT.

  SET PF-STATUS 'STATUS_100'.

  SET TITLEBAR 'T100'. "######

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_ALV_100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_ALV_0100 OUTPUT.

  PERFORM CREATE_OBJECT USING GC_DOCKING GC_GRID_0100.

  PERFORM FIELD_CATALOG_0100.

  PERFORM ALV_LAYOUT.

  PERFORM ALV_SORT.

  PERFORM ALV_DISPLAY USING GT_ORDER GC_GRID_0100 GS_LAYOUT GS_VARIANT.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  STATUS_0200  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0200 OUTPUT.

  SET PF-STATUS 'STATUS_200'.

  SET TITLEBAR 'T200'. "######

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_ALV_200  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_ALV_0200 OUTPUT.

  PERFORM CREATE_OBJECT USING GC_DOCKING GC_GRID_0200.

  PERFORM FIELD_CATALOG_0200.

  PERFORM ALV_LAYOUT.

  PERFORM ALV_SORT.

  PERFORM ALV_DISPLAY USING GT_DELIVERY GC_GRID_0200 GS_LAYOUT GS_VARIANT.

ENDMODULE.