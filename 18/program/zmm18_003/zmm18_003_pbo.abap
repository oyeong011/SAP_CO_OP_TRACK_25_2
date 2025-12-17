
*&---------------------------------------------------------------------*

*&  Include           ZMM18_003_PBO

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  STATUS_0100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0100 OUTPUT.

  SET PF-STATUS 'STATUS_0100'.

  SET TITLEBAR 'T0100'.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_ALV_0100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_ALV_0100 OUTPUT.

  IF GO_GRID_100 IS INITIAL.

    PERFORM CREATE_OBJECT_0100.   "CONT1

    PERFORM FIELD_CATALOG_0100.

    PERFORM ALV_LAYOUT_0100.

    "PERFORM ALV_SORT_0100.

    PERFORM CLASS_EVENT_0100.     "data_changed #### ##

    PERFORM GET_PO_ITEMS.

    PERFORM ALV_DISPLAY_0100.

  ELSE.

    PERFORM REFRESH_GRID USING GO_GRID_100.

  ENDIF.

ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  MODIFY_SCREEN  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE MODIFY_SCREEN OUTPUT.

  PERFORM MODIFY_SCREEN_0100.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      MODULE  STATUS_0200  OUTPUT

*&---------------------------------------------------------------------*

*       TEXT

*----------------------------------------------------------------------*




MODULE STATUS_0200 OUTPUT.

  SET PF-STATUS 'STATUS_0200'.

  SET TITLEBAR 'T200'.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_ALV_0200  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_ALV_0200 OUTPUT.

  IF GO_GRID_200_L IS INITIAL OR GO_GRID_200_I IS INITIAL.

    PERFORM CREATE_OBJECT_0200.    "CONT2/CONT3 ##

    PERFORM FIELD_CATALOG_0200_L.

    PERFORM FIELD_CATALOG_0200_I.

    PERFORM ALV_LAYOUT_0200.

    PERFORM CLASS_EVENT_0200.      "double_click# ## ####(##)##

    PERFORM ALV_DISPLAY_0200_L.

    PERFORM ALV_DISPLAY_0200_I.

  ELSE.

    PERFORM REFRESH_GRID USING GO_GRID_200_I.

    PERFORM REFRESH_GRID USING GO_GRID_200_L.

  ENDIF.

ENDMODULE.