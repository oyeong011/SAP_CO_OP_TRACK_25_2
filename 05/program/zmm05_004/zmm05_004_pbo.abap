
MODULE STATUS_0100 OUTPUT.

  SET PF-STATUS 'S100'.

  SET TITLEBAR 'T100'.

  GS_COMMON_HEADER-BLDAT = P_DATE.



  " #### # ### ##

  CLEAR: GT_VRM_VALUES.



  IF GV_GR_EXIST = 'X'.

    CLEAR GS_VRM_VALUE.

    GS_VRM_VALUE-KEY = 'GR'.

    GS_VRM_VALUE-TEXT = '## ##'.

    APPEND GS_VRM_VALUE TO GT_VRM_VALUES.

  ENDIF.



  IF GV_PO_EXIST = 'X'.

    CLEAR GS_VRM_VALUE.

    GS_VRM_VALUE-KEY = 'PO'.

    GS_VRM_VALUE-TEXT = 'PO ##'.

    APPEND GS_VRM_VALUE TO GT_VRM_VALUES.

  ENDIF.



  " #### # ### ##

  IF GT_VRM_VALUES IS NOT INITIAL.

    CALL FUNCTION 'VRM_SET_VALUES'

      EXPORTING

        ID     = 'GV_SEL_TYPE'

        VALUES = GT_VRM_VALUES.

  ENDIF.





  " ## ##### ### #### ##

  IF GV_SEL_TYPE = 'GR' AND GT_ITEM_GR IS NOT INITIAL.

    GT_ITEM = GT_ITEM_GR.

  ELSEIF GV_SEL_TYPE = 'PO' AND GT_ITEM_PO IS NOT INITIAL.

    GT_ITEM = GT_ITEM_PO.

  ENDIF.



  LOOP AT SCREEN.



    " #### ###/#### ##

    IF SCREEN-NAME = 'GV_SEL_TYPE'.

      IF GV_GR_EXIST = 'X' AND GV_PO_EXIST = 'X'.

        " # # ### #### ###

        SCREEN-INPUT = 1.

        SCREEN-ACTIVE = 1.

        SCREEN-REQUIRED = 2.

      ELSEIF GV_GR_EXIST = 'X'.

        " ### ### #### #### (## ## ##)

        SCREEN-INPUT = 0.

        SCREEN-ACTIVE = 1.

        GV_SEL_TYPE = 'GR'.

      ELSEIF GV_PO_EXIST = 'X'.

        " PO# ### #### #### (PO ## ##)

        SCREEN-INPUT = 0.

        SCREEN-ACTIVE = 1.

        GV_SEL_TYPE = 'PO'.

      ELSE.

        " # # ### ###

        SCREEN-INPUT = 0.

        SCREEN-ACTIVE = 0.

      ENDIF.

    ENDIF.



    MODIFY SCREEN.

  ENDLOOP.



  PERFORM DISPLAY_ALV.

ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  STATUS_0101  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




module STATUS_0101 output.

  GS_COMMON_HEADER-BLDAT = P_DATE.

  IF GS_AMOUNT_HEADER-ICON IS INITIAL.

    GS_AMOUNT_HEADER-ICON = C_YELLOW. " ### (@5D@)

  ENDIF.



  " 2. ## ## ## (## ##)

  " LOOP AT SCREEN.

  "   IF SCREEN-NAME = 'GS_AMOUNT_HEADER-WAERS'.

  "     SCREEN-INPUT = 0. " ### ## ##

  "   ENDIF.

  "   MODIFY SCREEN.

  " ENDLOOP.




*  SET PF-STATUS 'xxxxxxxx'.

*  SET TITLEBAR 'xxx'.




endmodule.




*&---------------------------------------------------------------------*

*&      Module  STATUS_0200  OUTPUT

*&---------------------------------------------------------------------*




MODULE STATUS_0200 OUTPUT.

  SET PF-STATUS 'S200'.

  SET TITLEBAR  'T200'.

  PERFORM DISPLAY_ALV_200.

ENDMODULE.








*&---------------------------------------------------------------------*

*&      Module  STATUS_0102  OUTPUT

*&---------------------------------------------------------------------*




MODULE STATUS_0102 OUTPUT.





  " 1. ###(ICON) ### ##

  "    ## #### # ### '###(##)' ### #####.

  IF GS_AMOUNT_HEADER-ICON IS INITIAL.

    GS_AMOUNT_HEADER-ICON = C_YELLOW.  " ### (@5D@)

  ENDIF.



  " 2. ## ##(WAERS) ####

  "    #### ## ##### ALV # ### ## #####.

  IF GS_AMOUNT_HEADER-WAERS IS INITIAL.

    READ TABLE GT_ITEM INTO GS_ITEM INDEX 1.

    IF SY-SUBRC = 0.

      GS_AMOUNT_HEADER-WAERS = GS_ITEM-WAERS.

    ENDIF.

  ENDIF.



  " 3. (##) ## ## ##

  "    ## ## ###### ### ##### # ### ### #####.

  LOOP AT SCREEN.

    " ###(ZAMOUNT)# ### ## #### #

    IF SCREEN-NAME = 'GS_AMOUNT_HEADER-ZAMOUNT'.

      SCREEN-INPUT = 1.

    ENDIF.



    " ###, ##, ## ## ## ###(##### #)

    IF SCREEN-NAME = 'GS_AMOUNT_HEADER-ICON' OR

       SCREEN-NAME = 'GS_AMOUNT_HEADER-LIFNR' OR

       SCREEN-NAME = 'GS_AMOUNT_HEADER-ZBALANCE' OR

       SCREEN-NAME = 'GS_AMOUNT_HEADER-WAERS' OR

       SCREEN-NAME = 'GS_AMOUNT_HEADER-NAME1' OR




*      SCREEN-NAME = 'GS_AMOUNT_HEADER-MWSKZ' OR




       SCREEN-NAME = 'GS_AMOUNT_HEADER-ZMEMO'.

       SCREEN-INPUT = 0.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.

ENDMODULE.