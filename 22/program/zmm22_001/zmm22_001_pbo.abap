
*&---------------------------------------------------------------------*

*&  Include           ZMM22_001_PBO

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  STATUS_0100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0100 OUTPUT.

  "## ### ## ADD/SAVE ###

  IF P_CRE = 'X'.

    SET PF-STATUS 'STATUS_0100' EXCLUDING ''.

  ELSE.

    SET PF-STATUS 'STATUS_0100' EXCLUDING 'ADD'.

  ENDIF.



  SET TITLEBAR 'T100'.




*  IF P_CRE = 'X'.

*    SET PF-STATUS 'STATUS_0100' EXCLUDING 'NONE'.

*  ELSEIF P_VIEW = 'X'.

*    SET PF-STATUS 'STATUS_0100' EXCLUDING 'ADD'.

*  ENDIF.

*  SET TITLEBAR 'T100'.






ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_ALV  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_ALV OUTPUT.

    IF GC_GRID1 IS INITIAL.

    PERFORM CREATE_OBJECT.

    PERFORM FIELD_CATALOG.

    PERFORM ALV_SORT.

    PERFORM ALV_LAYOUT.

    PERFORM CALL_ALV.

  ELSE.

    CALL METHOD GC_GRID1->REFRESH_TABLE_DISPLAY( ).

    CALL METHOD GC_GRID2->REFRESH_TABLE_DISPLAY( ).

    CALL METHOD GC_GRID3->REFRESH_TABLE_DISPLAY( ).

  ENDIF.




*  PERFORM CREATE_OBJECT.

*  PERFORM FIELD_CATALOG.

*  PERFORM ALV_SORT.

*  PERFORM ALV_LAYOUT.

*  PERFORM CALL_ALV.




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

*&      Module  SET_ALV_200  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE set_alv_200 OUTPUT.

  PERFORM CREATE_OBJECT2.

  PERFORM FILED_CATALOG2.

  PERFORM ALV_LAYOUT2.

  PERFORM ALV_SORT2.

  PERFORM CALL_ALV2.



ENDMODULE.