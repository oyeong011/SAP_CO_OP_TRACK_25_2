
*&---------------------------------------------------------------------*

*&  Include           ZMM22_004_PBO

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  STATUS_0100  OUTPUT

*&---------------------------------------------------------------------*




MODULE STATUS_0100 OUTPUT.

  SET PF-STATUS 'STATUS_0100'.

  SET TITLEBAR 'T100'.



  " 1. ## ## ## (## ##)

  IF ZRBKP_22-WAERS IS NOT INITIAL.

    WAERS = ZRBKP_22-WAERS.

  ELSE.

    WAERS = 'KRW'.

  ENDIF.



  PERFORM CALCULATE_BALANCE.



  " 3. # ## (## ##)

  IF GV_SUB_DYNNR IS INITIAL.

    GV_SUB_DYNNR = '0110'.

    TS_INFO-ACTIVETAB = 'TAB1'.

  ENDIF.

ENDMODULE.



MODULE SET_ALV OUTPUT.

  IF GC_GRID IS INITIAL.

    PERFORM CREATE_OBJECT.

    PERFORM FIELD_CATALOG.

    PERFORM ALV_LAYOUT.

    PERFORM CALL_ALV.

    PERFORM CLASS_EVENT.

  ELSE.

    " PAI# #### # ## ##

    CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY.

  ENDIF.

ENDMODULE.



MODULE INIT_DATA_0110 OUTPUT.

  " 1. ## ## ## (## ##)

  IF ZRBKP_22-BLDAT IS INITIAL.

    ZRBKP_22-BLDAT = P_DATE.

  ENDIF.



  IF ZRBKP_22-BUDAT IS INITIAL.

    ZRBKP_22-BUDAT = P_DATE.

  ENDIF.



  " 2. [##] ### ## ## (#### #### ##)

  IF ZRBKP_22-WAERS IS INITIAL.



    " Selection Screen## #### P_EBELN## ##

    SELECT SINGLE WAERS

      INTO ZRBKP_22-WAERS

      FROM ZEKKO_22

      WHERE EBELN = P_EBELN.



    " ## ##### ## ##### KRW ### ##

    IF SY-SUBRC <> 0 OR ZRBKP_22-WAERS IS INITIAL.

      ZRBKP_22-WAERS = 'KRW'.

    ENDIF.



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



  " ## ##(GS_RBKP-xxx)# ###### ## ####

  LOOP AT SCREEN.

    IF SCREEN-NAME CS 'GS_RBKP-'.

      SCREEN-INPUT = 0.

      MODIFY SCREEN.

    ENDIF.

  ENDLOOP.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  SET_ALV_200  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_ALV_200 OUTPUT.

  PERFORM SET_ALV_200.

ENDMODULE.