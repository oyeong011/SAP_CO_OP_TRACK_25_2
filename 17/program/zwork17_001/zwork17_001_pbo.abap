
*&---------------------------------------------------------------------*

*&  Include           ZWORK17_001_PBO

*&---------------------------------------------------------------------*




MODULE status_0100 OUTPUT.

  SET PF-STATUS 'STATUS_0100'.  " ## 0100# ### GUI STATUS ##

  SET TITLEBAR 'T100'. " ## ## #### ##

ENDMODULE.



MODULE set_alv OUTPUT.

  " ALV# ## #### ## ## ## ## ##

  IF gc_docking IS INITIAL.

    PERFORM create_object.        " Docking #### + ALV GRID ##

    PERFORM field_catalog.        " ALV ###### ##

    PERFORM alv_layout.           " ALV #### ## ##




*    perform alv_sort.            " ## ##### ## ##




    PERFORM class_event.          " ALV ### ### ##

    PERFORM alv_display.          " ALV ## ##

  ELSE.

    PERFORM refresh.              " ## ### ## #### ## ##

  ENDIF.

ENDMODULE.