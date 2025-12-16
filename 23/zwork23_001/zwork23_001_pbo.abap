
*&---------------------------------------------------------------------*

*&  Include           ZWORK23_001_PBO

*&---------------------------------------------------------------------*






MODULE STATUS_0100 OUTPUT.

  SET PF-STATUS 'STATUS-0100'.

  SET TITLEBAR 'T100'.

ENDMODULE.



MODULE SET_ALV OUTPUT.

  IF GC_DOCKING IS INITIAL.

    PERFORM CREATE_OBJECT.

    PERFORM FIELD_CATALOG.

    PERFORM ALV_SORT.

    PERFORM ALV_LAYOUT.

    PERFORM CLASS_EVENT.

    PERFORM CALL_ALV.

  ELSE.

    PERFORM REFRESH.

  ENDIF.

ENDMODULE.