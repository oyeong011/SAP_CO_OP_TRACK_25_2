
*&---------------------------------------------------------------------*

*&  Include           ZEDR17_023_PBO

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

  if gc_docking is initial. " docking# ### ## #

    perform create_object.

    perform field_catalog.

    perform alv_layout.

    perform alv_sort.

    perform class_event. " ### ## (gc_event) ## # ### ## ##

    perform alv_display.

  else. " ## ## ### refresh ## ##

    perform refresh.

  endif.

endmodule.