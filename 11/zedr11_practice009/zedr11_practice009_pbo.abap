
*&---------------------------------------------------------------------*

*& Include ZEDR11_PRACTICE009_PBO

*&---------------------------------------------------------------------*




MODULE status_0100 OUTPUT.

  SET PF-STATUS 'S100'.

  SET TITLEBAR 'T100'.

ENDMODULE.



MODULE set_alv OUTPUT.

  " Singleton ### F01# create_object## ##### ## ##

  PERFORM create_object.

  PERFORM set_field_cat.

  PERFORM set_sort.

  PERFORM set_layout.

  PERFORM display_alv.

ENDMODULE.