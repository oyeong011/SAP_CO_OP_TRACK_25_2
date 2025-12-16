
*&---------------------------------------------------------------------*

*&  Include           ZEDR12_ZCUSTOM_CONTAINER_PBO

*&---------------------------------------------------------------------*




MODULE STATUS_0100 OUTPUT.  "PBO##

  SET PF-STATUS 'STATUS_0100'.

  SET TITLEBAR 'T100'.  "#######REPORT##

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_ALV  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_ALV OUTPUT.



  PERFORM CREATE_OBJECT. "####.

  PERFORM FIELD_CATALOG.

  PERFORM ALV_LAYOUT.

  PERFORM ALV_SORT.

  PERFORM ALV_DISPLAY.



ENDMODULE.