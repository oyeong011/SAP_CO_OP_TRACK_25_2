
*&---------------------------------------------------------------------*

*&  Include           ZEDR25_024_PBO

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

*&      Module  ALV_DISPLAY  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE ALV_DISPLAY OUTPUT.



  IF GC_DOCKING IS INITIAL.

   PERFORM CREATE_OBJECT.

  PERFORM FIELD_CATALOG.

  PERFORM ALV_SORT.

  PERFORM ALV_EVENT.

  PERFORM LAYOUT_SET.

  PERFORM CALL_ALV.

  ELSE.

    PERFORM REFRESH.

  ENDIF.

ENDMODULE.