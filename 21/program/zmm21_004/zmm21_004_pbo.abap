
*&---------------------------------------------------------------------*

*&  Include           ZMM21_004_PBO

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

*&      Module  ALV_DISPALY  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE ALV_DISPALY OUTPUT.

  IF GC_DOCKING IS INITIAL.

    PERFORM CREATE_OBJECT.

    PERFORM FIELDCAT.

    PERFORM ALV_LAYOUT.

    PERFORM ALV_DISPLAY.

  ELSE .

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

*&      Module  ALV_DISPLAY_SEARCH  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE ALV_DISPLAY_SEARCH OUTPUT.

  IF GC_DOCKING IS INITIAL.

    PERFORM CREATE_OBJECT.

    PERFORM FIELDCAT_SEARCH.

    PERFORM ALV_LAYOUT.

    PERFORM ALV_DISPLAY_SEARCH.

 ELSE.

   PERFORM REFRESH.

 ENDIF.

ENDMODULE.