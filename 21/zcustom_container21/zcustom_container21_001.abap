
*&---------------------------------------------------------------------*

*&  Include  ZCUSTOM_CONTAINER21_001

*&---------------------------------------------------------------------*






MODULE SET_ALV OUTPUT.





  PERFORM create_object.

  PERFORM field_catalog.

  PERFORM alv_layout.

  PERFORM alv_sort.  " FIELD_CATALOG ##!

  PERFORM call_alv.





ENDMODULE.