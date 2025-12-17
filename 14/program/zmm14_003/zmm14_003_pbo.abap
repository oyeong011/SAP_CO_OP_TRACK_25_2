
*&---------------------------------------------------------------------*

*&  Include           ZMM14_003_PBO

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

*&      Module  SET_SCREEN_0100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_SCREEN_0100 OUTPUT.



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

*&      Module  SET_SCREEN_0200  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_SCREEN_0200 OUTPUT.



  LOOP AT SCREEN.

    SCREEN-INPUT = 0.

    MODIFY SCREEN.

  ENDLOOP.



  IF GO_CUSTOM_200 IS INITIAL.

    PERFORM CREATE_OBJECT_200.

    PERFORM FIELD_CATALOG_200.

    PERFORM ALV_LAYOUT_200.

    PERFORM CALL_METHOD_200.

  ELSE.

    PERFORM REFRESH_ALV_200.

  ENDIF.



ENDMODULE.