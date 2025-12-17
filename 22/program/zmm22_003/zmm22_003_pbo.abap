
*&---------------------------------------------------------------------*

*&  Include           ZMM22_003_PBO

*&---------------------------------------------------------------------*

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

*&      Module  INIT_HEADER  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE INIT_HEADER OUTPUT.



  DATA: LS_ITEM_HEADER LIKE LINE OF GT_ITEM.



  " ###: #### P_DATE# ### ##

  GS_HEADER-BUDAT = P_DATE.



  " ####: P_DATE# ### 4### ### ##

  " #: 20251130 -> 2025

  GS_HEADER-MJAHR = P_DATE+0(4).



  " #### ##

  GS_HEADER-BLART = 'WE'.



  " ### ## (#### ### # # ##, ### ###)

  IF GT_ITEM IS NOT INITIAL.

    READ TABLE GT_ITEM INTO LS_ITEM_HEADER INDEX 1.

    IF SY-SUBRC = 0.

      GS_HEADER-BLDAT = LS_ITEM_HEADER-BEDAT.

    ENDIF.

  ELSE.

    GS_HEADER-BLDAT = P_DATE.

  ENDIF.



  " 2. ######(MBLNR) ##

  " ### ## ## ## ##### #####.

  " ##(Post) ### ## ### ## ### ###

  " #### ## ## ## #####, ### ## ### #####.



  " 3. ## ## ## (## ##)

  LOOP AT SCREEN.

    IF SCREEN-NAME = 'GS_HEADER-MBLNR'

    OR SCREEN-NAME = 'GS_HEADER-MJAHR'

    OR SCREEN-NAME = 'GS_HEADER-BLART'

    OR SCREEN-NAME = 'GS_HEADER-BLDAT'

    OR SCREEN-NAME = 'GS_HEADER-BUDAT'.

      SCREEN-INPUT = 0. " ## ##

      MODIFY SCREEN.

    ENDIF.

  ENDLOOP.



ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_ALV  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_ALV OUTPUT.

  IF GC_GRID IS INITIAL.

    PERFORM CREATE_OBJECT.

    PERFORM FIELD_CATALOG.

    PERFORM ALV_LAYOUT.

    PERFORM CALL_ALV.

    "PERFORM CLASS_EVENT.

  ENDIF.

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




MODULE SET_ALV_200 OUTPUT.

  PERFORM SET_ALV_200.

ENDMODULE.