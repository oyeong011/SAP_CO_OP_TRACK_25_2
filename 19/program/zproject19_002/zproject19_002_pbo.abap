
*&---------------------------------------------------------------------*

*&  Include           ZPROJECT19_002_PBO

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

*&      Module  SET_ALV  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_ALV OUTPUT.

  IF RB_CR = C_X.

    IF gc_grid1 IS INITIAL.

      PERFORM CREATE_OBJECT.

      PERFORM FIELD_CATALOG.

      PERFORM ALV_LAYOUT.

      PERFORM REGISTER_F4.

      PERFORM SET_HANDLER.

      PERFORM CALL_ALV.

    ELSE.

      CALL METHOD gc_grid1->refresh_table_display.

    ENDIF.

  ELSEIF RB_DSP = C_X.

      IF gc_grid2 IS INITIAL AND gc_grid3 IS INITIAL.

        PERFORM CREATE_OBJECT2.

        PERFORM FIELD_CATALOG2.

        PERFORM CALL_ALV2.

      ENDIF.

  ENDIF.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0100  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0100 INPUT.



  "ALV #### ## ##

  IF gc_grid1 IS BOUND.

    CALL METHOD gc_grid1->check_changed_data.

  ENDIF.



  CASE OK_CODE.

    WHEN 'BACK' OR 'CANC'.

      LEAVE TO SCREEN 0.

    WHEN 'EXIT'.

      LEAVE PROGRAM.

    WHEN 'ADD'.

      PERFORM ADD_DATA.

    WHEN 'DELETE'.

      PERFORM DELETE_DATA.

    WHEN 'CREATE'.

      PERFORM ADD_ITEM_LINE.

  ENDCASE.

ENDMODULE.