
*&---------------------------------------------------------------------*

*&  Include           ZMMR01_030_PBO

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

*&      Module  SET_ACTIVE_TAB_0100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_ACTIVE_TAB_0100 OUTPUT.

  CASE GC_TABSTRIP_HEADER-ACTIVETAB.

    WHEN 'FC_HEADER_TAB1'.

      GV_DYNNR = '0110'.



    WHEN 'FC_HEADER_TAB2'.

      GV_DYNNR = '0120'.



    WHEN 'FC_HEADER_TAB3'.

      GV_DYNNR = '0130'.



    WHEN 'FC_HEADER_TAB4'.

      GV_DYNNR = '0140'.



    WHEN OTHERS.

      GV_DYNNR = '0110'.

      GC_TABSTRIP_HEADER-ACTIVETAB = 'FC_HEADER_TAB1'.



  ENDCASE.



  CASE GC_TABSTRIP_ITEM-ACTIVETAB.

    WHEN 'FC_ITEM_TAB1'.

      GV_DYNNR2 = '0200'.



    WHEN 'FC_ITEM_TAB2'.

      GV_DYNNR2 = '0210'.



    WHEN 'FC_ITEM_TAB3'.

      GV_DYNNR2 = '0220'.



    WHEN OTHERS.

      GC_TABSTRIP_ITEM-ACTIVETAB = 'FC_ITEM_TAB1'.

      GV_DYNNR2 = '0200'.

  ENDCASE.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_ALV_0200  OUTPUT

*&---------------------------------------------------------------------*




MODULE SET_ALV_CON1 OUTPUT.

  IF GC_GRID IS INITIAL.

    IF GV_MODE = C_CRUD.

      PERFORM CREATE_OBJECT USING 'CON1'

                          CHANGING GC_CUSTOM GC_GRID.

      PERFORM CLASS_EVENT.

      PERFORM FIELD_CATALOG_CON1.

      PERFORM SET_LAYOUT CHANGING GS_LAYOUT.

      PERFORM ALV_DISPLAY USING GC_GRID GS_LAYOUT

                          CHANGING GT_DISP_100 GT_FIELDCAT.

    ELSEIF GV_MODE = C_DISP.

      PERFORM CREATE_OBJECT USING 'CON1'

                          CHANGING GC_CUSTOM GC_GRID.

      PERFORM CLASS_EVENT.

      PERFORM FIELD_CATALOG_DISP.

      PERFORM SET_LAYOUT CHANGING GS_LAYOUT.

      PERFORM ALV_DISPLAY USING GC_GRID GS_LAYOUT

                          CHANGING GT_DISP_100 GT_FIELDCAT.

    ENDIF.

  ENDIF.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_ALV_CON2  OUTPUT

*&---------------------------------------------------------------------*




MODULE SET_ALV_CON2 OUTPUT.

  IF GC_GRID2 IS INITIAL.

    PERFORM CREATE_OBJECT USING 'CON2'

                        CHANGING GC_CUSTOM2 GC_GRID2.

    PERFORM CLASS_EVENT.

    PERFORM FIELD_CATALOG_CON2.

    PERFORM SET_LAYOUT CHANGING GS_LAYOUT2.

    PERFORM ALV_DISPLAY USING GC_GRID2 GS_LAYOUT2

                        CHANGING GT_TAXCODE GT_FIELDCAT2.

  ENDIF.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_ALV_CON3  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_ALV_CON3 OUTPUT.

  IF GC_GRID3 IS INITIAL.

    PERFORM CREATE_OBJECT USING 'CON3'

                        CHANGING GC_CUSTOM3 GC_GRID3.

    PERFORM CLASS_EVENT.

    PERFORM SET_DROPDOWN_SHKZG.

    PERFORM SET_FCAT_GLA.

    PERFORM SET_LAYOUT CHANGING GS_LAYOUT.

    PERFORM ALV_DISPLAY USING GC_GRID3 GS_LAYOUT

                        CHANGING GT_GLA GT_FIELDCAT.

  ENDIF.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_ALV_CON4  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_ALV_CON4 OUTPUT.

  IF GC_GRID5 IS INITIAL.

    PERFORM CREATE_OBJECT USING 'CON4'

                        CHANGING GC_CUSTOM3 GC_GRID5.

    PERFORM CLASS_EVENT.

    PERFORM SET_DROPDOWN_SHKZG.

    PERFORM SET_FCAT_MAT.

    PERFORM SET_LAYOUT CHANGING GS_LAYOUT.

    PERFORM ALV_DISPLAY USING GC_GRID2 GS_LAYOUT

                        CHANGING GT_MAT GT_FIELDCAT.

  ENDIF.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_DROPDOWN_LIST  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_DROPDOWN_LIST OUTPUT.

  IF GV_LIST_INITIALIZED = ABAP_TRUE.

    RETURN.

  ENDIF.



  DATA : LS_TAXCODE TYPE ZTAXCODE01,

         LT_TAXCODE LIKE TABLE OF LS_TAXCODE.

  DATA : LT_VALUES TYPE VRM_VALUES,

         LS_VALUE  TYPE VRM_VALUE.



  SELECT * FROM ZTAXCODE01

    INTO CORRESPONDING FIELDS OF TABLE LT_TAXCODE.



  LOOP AT LT_TAXCODE INTO LS_TAXCODE.

    LS_VALUE-KEY  = LS_TAXCODE-MWSKZ.

    LS_VALUE-TEXT = LS_TAXCODE-TEXT.

    APPEND LS_VALUE TO LT_VALUES.

  ENDLOOP.



  CALL FUNCTION 'VRM_SET_VALUES'

    EXPORTING

      ID     = 'P_LIST'

      VALUES = LT_VALUES.



  GV_LIST_INITIALIZED = ABAP_TRUE.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_AMOUNT  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_AMOUNT OUTPUT.

  IF GS_HEADER_100-AMOUNT > 0.

    PERFORM REFRESH_BALANCE_DATA.

  ENDIF.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  STATUS_0300  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0300 OUTPUT.

  SET PF-STATUS 'STATUS_0300'.

  SET TITLEBAR 'T0300'.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_TREE_0300  OUTPUT

*&---------------------------------------------------------------------*




MODULE SET_TREE_0300 OUTPUT.



  IF GO_TREE IS INITIAL.

    PERFORM CREATE_OBJECT_DISP.

    PERFORM FILL_NODE.

    PERFORM CLASS_EVENT_0100.

  ELSE.

    PERFORM REFRESH.

  ENDIF.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_ALV_0500  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_ALV_0500 OUTPUT.

  IF GC_GRID5 IS INITIAL.

    PERFORM CREATE_OBJECT USING 'CON7'

                        CHANGING GC_CUSTOM5 GC_GRID5.

    PERFORM SET_FIELDCAT_FI.

    PERFORM EXCLUDE_TOOLBAR.

    CLEAR : GS_LAYOUT.

    CLEAR : GS_SORT.

    GS_SORT-FIELDNAME = 'SHKZG'.   " #/#

    GS_SORT-UP        = 'X'.

    GS_SORT-SUBTOT    = 'X'.       " # ##

    APPEND GS_SORT TO GT_SORT.



   CALL METHOD GC_GRID5->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_VARIANT      = GS_VARIANT

      I_SAVE          = 'A'

      IS_LAYOUT       = GS_LAYOUT

      IT_TOOLBAR_EXCLUDING = GT_EXCLUDE

    CHANGING

      IT_SORT         = GT_SORT

      IT_OUTTAB       = GT_FI_ALV

      IT_FIELDCATALOG = GT_FIELDCAT.





  ELSE.

    DATA : LS_STABLE TYPE LVC_S_STBL.

    LS_STABLE-ROW = 'X'.

    LS_STABLE-COL = 'X'.



    CALL METHOD GC_GRID5->REFRESH_TABLE_DISPLAY

       EXPORTING

        IS_STABLE      = LS_STABLE




*        I_SOFT_REFRESH =

*      EXCEPTIONS

*        FINISHED       = 1

*        OTHERS         = 2




            .

  ENDIF.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  CONTROL_SCREEN  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE CONTROL_SCREEN OUTPUT.

  LOOP AT SCREEN.

    IF GV_MODE = C_DISP.

      IF SCREEN-GROUP1 = 'DP'.

        SCREEN-INPUT = 0.

      ENDIF.

    MODIFY SCREEN.

    ENDIF.

  ENDLOOP.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  STATUS_0400  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0400 OUTPUT.

  SET PF-STATUS 'STATUS_0400'.

  SET TITLEBAR 'T0400'.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  MODIFY_SCREEN_0400  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE MODIFY_SCREEN_0400 OUTPUT.

  DESCRIBE TABLE GT_SIMU LINES TC_SIMU-lines.

  READ TABLE GT_SIMU INTO GS_SIMU INDEX TC_SIMU-current_line.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_SCREEN_0130  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_SCREEN_0130 OUTPUT.

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'M1'.

      IF GS_HEADER_100-WAERS = 'KRW'.

        SCREEN-INPUT = 0.

      ENDIF.

    ENDIF.

    IF GV_MODE = C_DISP.

      IF SCREEN-GROUP2 = 'DP'.

        SCREEN-INPUT = 0.

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  STATUS_0500  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0500 OUTPUT.

  SET PF-STATUS 'STATUS_0500'.

  SET TITLEBAR 'T0500'.

ENDMODULE.