
*&---------------------------------------------------------------------*

*&  Include           ZWORK21_001_PBO

*&---------------------------------------------------------------------**&---------------------------------------------------------------------*

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

  IF gc_docking IS INITIAL.

    "FIELD CATALOG ##, ## ##, ### ###, ## ## ## FORM# ##

    PERFORM CREATE_OBJECT.

    PERFORM FIELDCAT.

    PERFORM ALV_LAYOUT.

    PERFORM CLASS_EVENT.

    PERFORM ALV_DISPLAY.



  ELSE.

    "## ### ## REFRESH FORM

    PERFORM REFRESH.

  ENDIF.

ENDMODULE.