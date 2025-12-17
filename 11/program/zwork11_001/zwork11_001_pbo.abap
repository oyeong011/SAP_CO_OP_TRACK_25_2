
"====================================================================="

include structure
ZWORK11_001_PBO
.

"====================================================================="

MODULE STATUS_0100 OUTPUT.

  SET PF-STATUS 'STATUS_0100'.

  SET TITLEBAR  'T100'.

ENDMODULE.



MODULE SET_ALV OUTPUT.

  IF GC_DOCKING IS INITIAL.

    PERFORM CREATE_OBJECT.

    PERFORM FIELDCAT.

    PERFORM ALV_LAYOUT.

    PERFORM ALV_SORT.

    PERFORM CLASS_EVENT.

    PERFORM ALV_DISPLAY.

  ELSE.

    PERFORM REFRESH.

  ENDIF.

ENDMODULE.