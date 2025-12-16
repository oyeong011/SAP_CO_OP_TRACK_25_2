
*&---------------------------------------------------------------------*

*&  Include           ZEDR17_PRACTICE008_O01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  STATUS_0100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




module status_0100 output.

  set pf-status 'STATUS_0100'.

  set titlebar 'T100'.

endmodule.




*&---------------------------------------------------------------------*

*&      Module  STATUS_0200  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




module status_0200 output.

  set pf-status 'STATUS_0200'.

  set titlebar 'T200'.

endmodule.




*&---------------------------------------------------------------------*

*&      Module  SET_ALV_100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




module set_alv_100 output.

  perform create_object using gc_docking gc_grid_100.

  perform field_catalog_100.

  perform alv_layout.

  perform alv_sort.

  perform call_alv using gt_order_print[]

                          gc_grid_100

                          gs_layout

                          gs_variant.

endmodule.




*&---------------------------------------------------------------------*

*&      Module  SET_ALV_200  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




module set_alv_200 output.

  perform create_object using gc_docking gc_grid_200.

  perform field_catalog_200.

  perform alv_layout.

  perform alv_sort.

  perform call_alv using gt_shipping_print[]

                          gc_grid_200

                         gs_layout

                         gs_variant.

endmodule.