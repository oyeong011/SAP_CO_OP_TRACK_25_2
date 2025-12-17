
*&---------------------------------------------------------------------*

*&  Include           ZEDR16_PRACTICE008_PBO

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

*&      Module  SET_ALV_0100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_ALV_0100 OUTPUT.



  PERFORM CREATE_OBJECT USING GC_DOCKING GC_GRID1.

  PERFORM FIELD_CATELOG_0100.

  PERFORM ALV_LAYOUT.

  PERFORM ALV_SORT.

  PERFORM CALL_ALV USING GT_ORDER_ALV[] GC_GRID1.



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

*&      Module  SET_ALV_0200  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_ALV_0200 OUTPUT.



  PERFORM CREATE_OBJECT USING GC_DOCKING GC_GRID2.

  PERFORM FIELD_CATELOG_0200.

  PERFORM ALV_LAYOUT.

  PERFORM ALV_SORT.

  PERFORM CALL_ALV USING GT_DELIVER_ALV[] GC_GRID2.



ENDMODULE.