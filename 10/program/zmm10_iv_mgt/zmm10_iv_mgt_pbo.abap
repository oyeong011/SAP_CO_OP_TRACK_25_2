
*&---------------------------------------------------------------------*

*& Module STATUS_0100 OUTPUT

*&---------------------------------------------------------------------*




MODULE STATUS_0100 OUTPUT.

  SET PF-STATUS 'S100'.

  SET TITLEBAR 'T100'.



  IF GO_CONTAINER IS INITIAL.

    PERFORM CREATE_OBJ.

    PERFORM REGI_EVENT.

    PERFORM SET_LAYOUT.

    PERFORM SET_FCAT.

    PERFORM DISPLAY.



  ELSE.

    " ## ####

    PERFORM GET_DATA.

    GO_ALV->REFRESH_TABLE_DISPLAY( ).

  ENDIF.

ENDMODULE.