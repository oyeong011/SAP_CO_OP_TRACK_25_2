
*&---------------------------------------------------------------------*

*&  Include           ZCUSTOM_CONTAINER17_PBO

*&---------------------------------------------------------------------*




module status_0100 output.

  SET PF-STATUS 'STATUS_0100'.

  SET TITLEBAR 'T100'.

endmodule.




*&---------------------------------------------------------------------*

*&      Module  SET_ALV  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




module set_alv output.

  perform create_object.

  perform field_catalog.

  perform alv_layout.

  perform alv_sort.

  perform call_alv.

endmodule.