
*&---------------------------------------------------------------------*

*&  Include           ZMM02_004_PBO

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

*&      Module  SET_DATA_100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_DATA_100 OUTPUT.

  IF GC_GRID IS INITIAL.

    G_BLDAT = P_BUDAT. "###

    G_BUDAT = P_BUDAT. "###

    G_WAERS = GS_EKKO-WAERS. "##

    G_BUKRS = GS_EKKO-BUKRS. "####

    G_MWSKZ = GS_LFM1-MWSKZ.

    G_MWSKZ_OLD = GS_LFM1-MWSKZ.

    G_BUPLA = 1000.

    G_SECCO = 1000.

    G_LIGHT = '@0A@'.

    G_WAERS_OUT = G_WAERS.

  ENDIF.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_ALV  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_ALV_100 OUTPUT.

  IF GC_CUSTOM IS INITIAL. "#### ##

    PERFORM CREATE_OBJECT USING 'CON1' CHANGING GC_CUSTOM GC_GRID.

    PERFORM FIELD_CATALOG_100.

    PERFORM ALV_LAYOUT.

    PERFORM ALV_SORT.

    PERFORM CLASS_EVENT CHANGING GC_GRID GO_EVENT.

    PERFORM CALL_ALV USING GC_GRID CHANGING GT_FIELDCAT GT_PO.

  ELSE.

    PERFORM REFRESH USING GC_GRID.

  ENDIF.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  STATUS_0200  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0200 OUTPUT.

  SET PF-STATUS 'STATUS 0200'.

  SET TITLEBAR 'T200'.



  IF GC_CUSTOM IS INITIAL.

    PERFORM GET_RSEG.

    PERFORM GET_RBKP.

    PERFORM CREATE_OBJECT USING 'CON1' CHANGING GC_CUSTOM GC_GRID.

    PERFORM FIELD_CATALOG_200.

    PERFORM ALV_LAYOUT.

    PERFORM ALV_SORT.

    PERFORM CLASS_EVENT CHANGING GC_GRID GO_EVENT.



    PERFORM CALL_ALV USING GC_GRID CHANGING GT_FIELDCAT GT_RBKP.

  ENDIF.

  PERFORM REFRESH USING GC_GRID.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  STATUS_0300  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0300 OUTPUT.

  SET PF-STATUS 'STATUS 0300'.

  SET TITLEBAR 'T300'.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_DATA_300  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_DATA_300 OUTPUT.



  READ TABLE GT_PO_300 INTO GS_PO INDEX 1.

    IF SY-SUBRC = 0 AND GS_PO-BELNR = GV_BELNR.

      "## ## ## #### # ### #### ### # #

      EXIT.

    ENDIF.

    PERFORM GET_GT_PO_300.



ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_ALV_300  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_ALV_300 OUTPUT.

  IF GC_CUSTOM300 IS INITIAL.

    PERFORM CREATE_OBJECT USING 'CON2' CHANGING GC_CUSTOM300 GC_GRID300.

    PERFORM CLASS_EVENT CHANGING GC_GRID300 GO_EVENT300.

    PERFORM FIELD_CATALOG_300.

    PERFORM ALV_LAYOUT.

    PERFORM ALV_SORT.

  ENDIF.

  PERFORM CALL_ALV USING GC_GRID300 CHANGING GT_FIELDCAT GT_PO_300.

  PERFORM REFRESH USING GC_GRID300.

ENDMODULE.






*&SPWIZARD: OUTPUT MODULE FOR TS 'TS_HEAD'. DO NOT CHANGE THIS LINE!

*&SPWIZARD: SETS ACTIVE TAB




MODULE TS_HEAD_ACTIVE_TAB_SET OUTPUT.

  TS_HEAD-ACTIVETAB = G_TS_HEAD-PRESSED_TAB.

  CASE G_TS_HEAD-PRESSED_TAB.

    WHEN C_TS_HEAD-TAB1.

      G_TS_HEAD-SUBSCREEN = '0101'.

    WHEN C_TS_HEAD-TAB2.

      G_TS_HEAD-SUBSCREEN = '0102'.

    WHEN OTHERS.




*&SPWIZARD:      DO NOTHING




  ENDCASE.

ENDMODULE.