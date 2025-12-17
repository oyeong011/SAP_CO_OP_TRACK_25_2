
*&---------------------------------------------------------------------*

*&  Include           ZMM06_003_PBO

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  STATUS_0200  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0200 OUTPUT.

  SET PF-STATUS 'STATUS_0200'.

  SET TITLEBAR 'T200'.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  STATUS_0300  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0300 OUTPUT.

  SET PF-STATUS 'STATUS_0300'.

  SET TITLEBAR 'T300'.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_ALV  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_ALV_200 OUTPUT.

  IF GC_GRID IS INITIAL.

    PERFORM CREATE_OBJECT_200.

    PERFORM ALV_FIELDCAT_200.

    PERFORM ALV_LAYOUT_200.

    PERFORM ALV_SORT_200.

    PERFORM ALV_DISPLAY_200.



    PERFORM CLASS_EVENT_200.

  ELSE.

    PERFORM REFRESH_200.

  ENDIF.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_ALV_300  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_ALV_300 OUTPUT.

    PERFORM CREATE_OBJECT_300.

    PERFORM ALV_FIELDCAT_300.

    PERFORM ALV_LAYOUT_300.

    PERFORM ALV_SORT_300.

    PERFORM CLASS_EVENT_300.

    PERFORM ALV_DISPLAY_300.

ENDMODULE.