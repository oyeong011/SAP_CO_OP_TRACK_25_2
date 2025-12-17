
*&---------------------------------------------------------------------*

*&  Include           ZEDR06_PRACTICE008_PBO

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  STATUS_0100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0100 OUTPUT.

  SET PF-STATUS 'STATUS_0100'.

  SET TITLEBAR 'T100'.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_ALV  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_ALV_0100 OUTPUT.

  " #### ###

  PERFORM CREATE_OBJECT CHANGING GC_DOCKING_100 GC_GRID_100.

  PERFORM FIELD_CATALOG_0100.

  PERFORM ALV_LAYOUT.

  PERFORM ALV_SORT.

  PERFORM ALV_DISPLAY USING GC_GRID_100 GT_ORDER_0100[].

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  STATUS_0200  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0200 OUTPUT.

  SET PF-STATUS 'STATUS_0200'.

  SET TITLEBAR 'T200'.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_VLA_0200  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_VLA_0200 OUTPUT.

  PERFORM CREATE_OBJECT CHANGING GC_DOCKING_0200 GC_GRID_0200.

  PERFORM FIELD_CATALOG_0200.

  PERFORM ALV_LAYOUT.

  PERFORM ALV_SORT.

  PERFORM ALV_DISPLAY USING GC_GRID_0200 GT_DELIVERY_0200[].

ENDMODULE.