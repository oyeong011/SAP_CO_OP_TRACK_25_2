
*&---------------------------------------------------------------------*

*&  Include           ZEDR11_PRACTICE008_PBO

*&---------------------------------------------------------------------*




MODULE status_0100 OUTPUT.

  SET PF-STATUS 'STATUS_0100'.

  SET TITLEBAR  'T100'.

ENDMODULE.



MODULE alv_0100 OUTPUT.

  PERFORM create_object USING gc_docking gc_grid_100.

  PERFORM field_catalog_0100.

  PERFORM alv_sort.

  PERFORM layout_set.

  PERFORM call_alv USING gt_order_print[] gc_grid_100 gs_layout gs_variant.

ENDMODULE.



MODULE status_0200 OUTPUT.

  SET PF-STATUS 'STATUS_0200'.

  SET TITLEBAR  'T200'.

ENDMODULE.



MODULE alv_0200 OUTPUT.

  PERFORM create_object USING gc_docking gc_grid_200.

  PERFORM field_catalog_0200.

  PERFORM alv_sort.

  PERFORM layout_set.

  PERFORM call_alv USING gt_deli_print[] gc_grid_200 gs_layout gs_variant.

ENDMODULE.