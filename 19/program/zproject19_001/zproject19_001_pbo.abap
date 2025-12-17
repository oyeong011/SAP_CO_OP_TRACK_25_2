
*&---------------------------------------------------------------------*

*&  Include           ZPROJECT19_001_PBO

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  STATUS_0100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0100 OUTPUT.

  IF p_rad1 = C_X.

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

      PERFORM SAVE_DATA.

    WHEN 'CHANGE'.

      PERFORM CHANGE_DATA.

  ENDCASE.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_ALV  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_ALV OUTPUT.

  IF p_rad2 = C_X.

  PERFORM CREATE_OBJECT.

  PERFORM FIELD_CATALOG.

  PERFORM ALV_LAYOUT.

  PERFORM CALL_ALV.

  ELSE.

    PERFORM CREATE_OBJECT2.

    PERFORM FIELD_CATALOG2.

    PERFORM ALV_LAYOUT2.

    PERFORM CALL_ALV2.

    PERFORM REGISTER_F4.

    PERFORM SET_HANDLER.

  ENDIF.

ENDMODULE.