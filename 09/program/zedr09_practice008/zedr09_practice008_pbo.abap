
*&---------------------------------------------------------------------*

*&  Include           ZEDR09_PRACTICE008_PBO

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  STATUS_0100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0100 OUTPUT.

  SET PF-STATUS 'STATUS_100'.

  SET TITLEBAR 'T100'.

ENDMODULE.








*&---------------------------------------------------------------------*

*&      Module  ALV_0100  OUTPUT

*&---------------------------------------------------------------------*

* create object, sort, layout, call_alv ## 100### 200## ###

* ####### ## ###






MODULE ALV_0100 OUTPUT.

  PERFORM CREATE_OBJECT USING GC_DOCKING_100

                              GC_GRID_100.

  PERFORM FIELDCATALOG_0100.

  PERFORM ALV_LAYOUT.

  PERFORM ALV_SORT.

  PERFORM CALL_ALV USING GC_GRID_100

                         GT_ORDER_ALV.

ENDMODULE.








*&---------------------------------------------------------------------*

*&      Module  STATUS_0200  OUTPUT

*&---------------------------------------------------------------------*




MODULE STATUS_0200 OUTPUT.

  SET PF-STATUS 'STATUS_200'.

  SET TITLEBAR 'T200'.

ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  ALV_0200  OUTPUT

*&---------------------------------------------------------------------*




MODULE ALV_0200 OUTPUT.

  PERFORM CREATE_OBJECT USING GC_DOCKING_200

                              GC_GRID_200.

  PERFORM FIELDCATALOG_0200.

  PERFORM ALV_LAYOUT.

  PERFORM ALV_SORT.

  PERFORM CALL_ALV USING GC_GRID_200

                         GT_DELIVERY_ALV.

ENDMODULE.