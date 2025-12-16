
*&---------------------------------------------------------------------*

*&  Include           ZMM21_003_PBO

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  STATUS_0100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0100 OUTPUT.

  SET PF-STATUS 'STATUS_0100'.

  SET TITLEBAR '100'.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_ALV  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_ALV OUTPUT.

    IF gc_docking IS INITIAL.

    PERFORM CREATE_OBJECT.

    PERFORM FIELDCAT.

    PERFORM ALV_LAYOUT.

    PERFORM ALV_DISPLAY.

  ELSE.

    PERFORM REFRESH.

  ENDIF.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  STATUS_0200  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0200 OUTPUT.

  SET PF-STATUS 'STATUS_0200'.

  SET TITLEBAR '200'.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SEARCH_ALV_DISPLAY  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SEARCH_ALV_DISPLAY OUTPUT.

   IF GC_DOCKING IS INITIAL.

     PERFORM CREATE_OBJECT.

     PERFORM FIELDCAT_SEARCH.

     PERFORM ALV_LAYOUT.

     PERFORM ALV_DISPLAY_SEARCH.

   ELSE.

     PERFORM REFRESH.

     ENDIF.

ENDMODULE.