
*&---------------------------------------------------------------------*

*&  Include           ZMM14_002_PBO

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

*&      Module  T100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_ALV_0100 OUTPUT.



  LOOP AT SCREEN.

    SCREEN-INPUT = 0.

    MODIFY SCREEN.

  ENDLOOP.



  IF GO_CUSTOM_100 IS INITIAL.

    PERFORM CREATE_OBJECT_100.

    PERFORM FIELD_CATALOG_100.

    PERFORM ALV_LAYOUT_100.

    PERFORM CALL_METHOD_100.

  ELSE.

    PERFORM REFRESH_ALV_100.

  ENDIF.



ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  STATUS_0200  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0200 OUTPUT.

  SET PF-STATUS 'STATUS_200'.

  SET TITLEBAR 'T200'.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_ALV_0200  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_ALV_0200 OUTPUT.



  IF GO_DOCKING IS INITIAL.

    PERFORM CREATE_OBJECT.

    PERFORM FIELD_CATALOG.

    PERFORM ALV_LAYOUT.

    PERFORM CALL_METHOD.

  ELSE.

    PERFORM REFRESH_ALV.

  ENDIF.



ENDMODULE.