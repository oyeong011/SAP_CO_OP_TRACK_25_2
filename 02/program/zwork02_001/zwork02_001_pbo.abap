
*&---------------------------------------------------------------------*

*&  Include           ZWORK02_001_PBO

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  STATUS_0100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0100 OUTPUT.

  SET PF-STATUS 'STATUS 0100'.

  SET TITLEBAR 'T100'.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_ALV  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_ALV OUTPUT.



  IF GC_DOCKING IS INITIAL.

    PERFORM CREATE_OBJECT. "#### ##

    PERFORM FIELD_CATALOG. "## #### ##

    PERFORM ALV_LAYOUT. "#### ##

    PERFORM ALV_SORT. "## ##

    PERFORM CLASS_EVENT. "### ##

    PERFORM ALV_DISPLAY. "ALV##

  ELSE.

    PERFORM REFRESH.

  ENDIF.



ENDMODULE.