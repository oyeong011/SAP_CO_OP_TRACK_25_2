
*&---------------------------------------------------------------------*

*&  Include           ZPRO07_002_PBO

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

*&      Module  STATUS_0200  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0200 OUTPUT.

  SET PF-STATUS 'STATUS_0200'.

  SET TITLEBAR 'T200'.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_ALV  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_ALV OUTPUT.

  IF gc_docking IS INITIAL.

    PERFORM create_object.

    PERFORM fieldcat.

    PERFORM alv_layout.

    PERFORM alv_sort.

    PERFORM class_event.

    PERFORM alv_display.

  ELSE.

    PERFORM refresh.

  ENDIF.



ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_CHECK_ALV  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_CHECK_ALV OUTPUT.

  PERFORM create_object.

  PERFORM fieldcat_check.

  PERFORM alv_layout.

  PERFORM alv_sort.

  PERFORM alv_display_check.

ENDMODULE.