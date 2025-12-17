
*&---------------------------------------------------------------------*

*&  Include           ZEDR01_025_PBO

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  STATUS_0100  OUTPUT

*&---------------------------------------------------------------------*




MODULE STATUS_0100 OUTPUT.

  SET PF-STATUS 'STATUS_0100'.

  SET TITLEBAR 'T100'.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_ALV  OUTPUT

*&---------------------------------------------------------------------*




MODULE SET_ALV OUTPUT.

  IF GC_DOCKING IS INITIAL.

    PERFORM CREATE_OBJECT.

    PERFORM FIELD_CATALOG.

    PERFORM ALV_LAYOUT.

    PERFORM ALV_SORT.

    PERFORM CLASS_EVENT.

    PERFORM ALV_DISPLAY.

  ELSE.

    PERFORM REFRESH.

  ENDIF.



ENDMODULE.