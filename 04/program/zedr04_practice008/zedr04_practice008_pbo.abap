
*&---------------------------------------------------------------------*

*&  Include           ZEDR04_PRACTICE008_PBO

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  STATUS_0100  OUTPUT

*&---------------------------------------------------------------------*




MODULE STATUS_0100 OUTPUT.

  SET PF-STATUS 'STATUS_0100'.

  SET TITLEBAR 'T100'.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_ALV_0100  OUTPUT

*&---------------------------------------------------------------------*




MODULE SET_ALV_0100 OUTPUT.

  PERFORM CREATE_OBJECT.

  PERFORM FIELD_CATALOG_0100.

  PERFORM ALV_LAYOUT.

  PERFORM ALV_SORT.

  PERFORM ALV_DISPLAY USING GT_WRITE_ORD.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  STATUS_0200  OUTPUT

*&---------------------------------------------------------------------*




MODULE STATUS_0200 OUTPUT.

  SET PF-STATUS 'STATUS_0200'.

  SET TITLEBAR 'T200'.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_ALV_0200  OUTPUT

*&---------------------------------------------------------------------*




MODULE SET_ALV_0200 OUTPUT.

  PERFORM CREATE_OBJECT.

  PERFORM FIELD_CATALOG_0200.

  PERFORM ALV_LAYOUT.

  PERFORM ALV_SORT.

  PERFORM ALV_DISPLAY USING GT_WRITE_DEL.

ENDMODULE.