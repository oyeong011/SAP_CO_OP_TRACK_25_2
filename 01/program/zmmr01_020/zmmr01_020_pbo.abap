
*&---------------------------------------------------------------------*

*&  INCLUDE           ZMMR01_020_PBO

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      MODULE  STATUS_0100  OUTPUT

*&---------------------------------------------------------------------*

*       TEXT

*----------------------------------------------------------------------*




MODULE STATUS_0200 OUTPUT.

  SET PF-STATUS 'STATUS_0200'.

  SET TITLEBAR 'T200'.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      MODULE  SET_ALV_0100  OUTPUT

*&---------------------------------------------------------------------*

*       TEXT

*----------------------------------------------------------------------*




MODULE SET_ALV_0200 OUTPUT.

 IF GV_ALV_INITIALIZED = ABAP_FALSE.



  PERFORM CREATE_OBJECT USING 'CON1'

                        CHANGING GC_CUSTOM GC_GRID.

  PERFORM FIELD_CATALOG.

  PERFORM ALV_LAYOUT.

  PERFORM CLASS_EVENT.

  PERFORM ALV_DISPLAY USING GT_DISP_100.



  GV_ALV_INITIALIZED = ABAP_TRUE.



  ELSE.

    " ## ### ALV# REFRESH# ## #

    PERFORM REFRESH.

  ENDIF.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      MODULE  SET_ACTIVE_TAB_0100  OUTPUT

*&---------------------------------------------------------------------*

*       TEXT

*----------------------------------------------------------------------*




MODULE SET_ACTIVE_TAB_0200 OUTPUT.

  CASE GC_TABSTRIP_HEADER-ACTIVETAB.

    WHEN 'FC_TAB1'.

      GV_DYNNR = '0201'.



    WHEN 'FC_TAB2'.

      GV_DYNNR = '0202'.



    WHEN OTHERS.

      GV_DYNNR = '0201'.

      GC_TABSTRIP_HEADER-ACTIVETAB = 'FC_TAB1'.

  ENDCASE.



  CASE GC_TABSTRIP_ITEM-ACTIVETAB.

    WHEN 'FC_ITEM_TAB1'.

      GV_DYNNR2 = '0211'.



    WHEN 'FC_ITEM_TAB2'.

      GV_DYNNR2 = '0212'.



    WHEN 'FC_ITEM_TAB3'.

      GV_DYNNR2 = '0213'.



    WHEN 'FC_ITEM_TAB4'.

      GV_DYNNR2 = '0214'.



    WHEN OTHERS.

      GV_DYNNR2 = '0211'.

      GC_TABSTRIP_HEADER-ACTIVETAB = 'FC_ITEM_TAB1'.

  ENDCASE.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_ACTIVE_TAB_0100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_ACTIVE_TAB_0100 OUTPUT.

  CASE GC_TABSTRIP_HEADER-ACTIVETAB.

    WHEN 'FC_TAB1'.

      GV_DYNNR = '0201'.



    WHEN 'FC_TAB2'.

      GV_DYNNR = '0202'.



    WHEN 'FC_TAB3'.

      GV_DYNNR = '0203'.



    WHEN OTHERS.

      GV_DYNNR = '0201'.

      GC_TABSTRIP_HEADER-ACTIVETAB = 'FC_TAB1'.

  ENDCASE.



  CASE GC_TABSTRIP_ITEM-ACTIVETAB.

    WHEN 'FC_ITEM_TAB1'.

      GV_DYNNR2 = '0211'.



    WHEN 'FC_ITEM_TAB2'.

      GV_DYNNR2 = '0212'.



    WHEN 'FC_ITEM_TAB3'.

      GV_DYNNR2 = '0213'.



    WHEN 'FC_ITEM_TAB4'.

      GV_DYNNR2 = '0214'.



    WHEN OTHERS.

      GV_DYNNR2 = '0211'.

      GC_TABSTRIP_HEADER-ACTIVETAB = 'FC_ITEM_TAB1'.

  ENDCASE.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      MODULE  SET_SCREEN_UNIT_0200  OUTPUT

*&---------------------------------------------------------------------*

*       TEXT

*----------------------------------------------------------------------*




MODULE SET_SCREEN_UNIT_0200 OUTPUT.

  MEINS1 = GS_DISP_100-MEINS.

  MEINS2 = GS_DISP_100-MEINS.

  MEINS3 = GS_DISP_100-MEINS.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  STATUS_0100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0100 OUTPUT.

  SET PF-STATUS 'STATUS_0100'.

  SET TITLEBAR 'T100'.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_ALV_0100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_ALV_0100 OUTPUT.

  IF GC_GRID IS INITIAL.



    PERFORM CREATE_OBJECT_DISP.

    PERFORM FIELD_CATALOG_DISP.

    PERFORM FILL_NODE.

    PERFORM CLASS_EVENT_0100.

    PERFORM ALV_LAYOUT.

    PERFORM ALV_DISPLAY_DISP USING GT_DISP_100.

  ELSE.

    PERFORM REFRESH.

  ENDIF.

ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  SET_SCREEN_UNIT_0100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_SCREEN_UNIT_0100 OUTPUT.

  MEINS1 = GS_DISP_100-MEINS.

  MEINS2 = GS_DISP_100-MEINS.

  MEINS3 = GS_DISP_100-MEINS.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_FI_ALV  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_FI_ALV OUTPUT.

  IF GC_GRID3 IS INITIAL.

    PERFORM CREATE_OBJECT USING 'CON3'

                        CHANGING GC_CUSTOM3 GC_GRID3.

    PERFORM SET_FIELDCAT_FI.

    PERFORM EXCLUDE_TOOLBAR.





    CLEAR : GS_SORT.

    GS_SORT-FIELDNAME = 'SHKZG'.   " #/#

    GS_SORT-UP        = 'X'.

    GS_SORT-SUBTOT    = 'X'.       " # ##

    APPEND GS_SORT TO GT_SORT.



   CALL METHOD GC_GRID3->SET_TABLE_FOR_FIRST_DISPLAY

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



    CALL METHOD GC_GRID3->REFRESH_TABLE_DISPLAY

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

*&      Module  STATUS_0500  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0500 OUTPUT.

  SET PF-STATUS 'STATUS_0500'.

  SET TITLEBAR 'T0500'.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_SCREEN_DISP  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_SCREEN_DISP OUTPUT.

  LOOP AT SCREEN.

    IF GV_MODE = C_DISP.

      IF SCREEN-GROUP1 = 'M1'.

        SCREEN-INPUT = 0.

      ENDIF.

    ENDIF.

  MODIFY SCREEN.

  ENDLOOP.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_SCREEN_201  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_SCREEN_201 OUTPUT.

  LOOP AT SCREEN.

    IF GV_MODE = C_DISP.

      IF SCREEN-GROUP1 = 'M1'.

        SCREEN-INPUT = 0.

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.

ENDMODULE.