
*&---------------------------------------------------------------------*

*&  Include           ZEDR02_PRACTICE009_PBO

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  STATUS_0100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0100 OUTPUT.

  SET PF-STATUS 'STATUS 0100'.

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

  PERFORM CALL_ALV USING GC_GRID_EMP CHANGING GT_FIELDCAT_EMP GT_EMP_OUTPUT.

  PERFORM CALL_ALV USING GC_GRID_EVAL CHANGING GT_FIELDCAT_EVAL GT_EVAL_OUTPUT.

  PERFORM CALL_ALV USING GC_GRID_CONT CHANGING GT_FIELDCAT_CONT GT_CONT_OUTPUT.

ENDMODULE.