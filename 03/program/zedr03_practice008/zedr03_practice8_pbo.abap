
*&---------------------------------------------------------------------*

*&  Include           ZEDR03_017_PBO

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

*&      Module  SET_ALV  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_ALV OUTPUT.

  PERFORM CREATE_OBJECT.

  PERFORM FIELD_CATALOG.

  PERFORM ALV_LAYOUT.

  PERFORM ALV_SORT.

  PERFORM GET_ORDER.

  PERFORM MODIFY_ORDER.

  PERFORM CALL_ALV.

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

*&      Module  SET_ALV_2  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_ALV_2 OUTPUT.

    PERFORM CREATE_OBJECT.

    PERFORM FIELD_CATALOG2.

    PERFORM ALV_LAYOUT.

    PERFORM ALV_SORT.

    PERFORM GET_DELIVER.

    PERFORM MODIFY_DELIVER.

    PERFORM CALL_ALV.

ENDMODULE.