
*&---------------------------------------------------------------------*

*&  Include           ZEDR21_PRACTICE008_PBO

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

*&      Module  STATUS_0200  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0200 OUTPUT.

  SET PF-STATUS 'STATUS_0200'.

  SET TITLEBAR 'T200'.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  ALV_0100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE ALV_0100 OUTPUT.

  PERFORM create_object USING gc_docking gc_grid_100.

  PERFORM field_catalog_0100.

  PERFORM alv_sort.

  PERFORM layout_set.

  PERFORM call_alv USING gt_0100[] gc_grid_100 gs_layout gs_variant.

ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  ALV_0200  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE ALV_0200 OUTPUT.

  PERFORM create_object USING gc_docking gc_grid_200.

  PERFORM field_catalog_0200.

  PERFORM alv_sort.

  PERFORM layout_set.

  PERFORM call_alv USING gt_0200[] gc_grid_200 gs_layout gs_variant.

ENDMODULE.