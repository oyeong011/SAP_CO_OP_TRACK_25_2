
*&---------------------------------------------------------------------*

*&  Include           ZEDR05_PRACTICE008_PBO

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  EXIT_COMMAND  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




module STATUS_0100 output.

  SET PF-STATUS 'STATUS_0100'.

  SET TITLEBAR 'T100'.

endmodule.



MODULE STATUS_0200 OUTPUT.

  SET PF-STATUS 'STATUS_0200'.

  SET TITLEBAR 'T200'.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  ALV_0100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




module SET_ALV_100 output.

  PERFORM CREATE_OBJECT USING GC_DOCKING GC_GRID_100.

  PERFORM FIELD_CATALOG_100.

  PERFORM ALV_LAYOUT.

  PERFORM ALV_SORT.

  PERFORM CALL_ALV USING GT_100 GC_GRID_100 GS_LAYOUT GS_VARIANT.

endmodule.



module SET_ALV_200 output.

  PERFORM CREATE_OBJECT USING GC_DOCKING GC_GRID_200.

  PERFORM FIELD_CATALOG_200.

  PERFORM ALV_LAYOUT.

  PERFORM ALV_SORT.

  PERFORM CALL_ALV USING GT_200 GC_GRID_100 GS_LAYOUT GS_VARIANT.

endmodule.