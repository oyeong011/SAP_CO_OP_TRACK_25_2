
*&---------------------------------------------------------------------*

*&  Include           ZPROJECT19_004_PBO

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  STATUS_0100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0100 OUTPUT.

  IF RB_CR = C_X.

    SET PF-STATUS 'STATUS_0100'.

  ELSE.

    SET PF-STATUS 'STATUS_0200'.

  ENDIF.

  SET TITLEBAR 'T100'.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0100  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0100 INPUT.

  CASE OK_CODE.

    WHEN 'BACK' OR 'CANC'.

      LEAVE TO SCREEN 0.

    WHEN 'EXIT'.

      LEAVE PROGRAM.

    WHEN 'ADD'.

      PERFORM ADD_DATA.

    WHEN 'DELETE'.

      PERFORM DELETE_DATA.

    ENDCASE.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_ALV  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_ALV OUTPUT.

  IF RB_CR = C_X.

    IF gc_grid1 IS NOT BOUND.

      PERFORM CREATE_OBJECT.

      PERFORM FIELD_CATALOG.

      PERFORM CALL_ALV.

    ENDIF.

  ELSE.



    IF gc_grid2 IS NOT BOUND.

      PERFORM CREATE_OBJECT2.

      PERFORM FIELD_CATALOG2.

      PERFORM CALL_ALV2.

    ENDIF.

  ENDIF.

ENDMODULE.