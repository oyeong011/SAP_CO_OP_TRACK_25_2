
*&---------------------------------------------------------------------*

*&  Include           ZEDR16_PRACTICE008_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SET_DEFAULT_DATE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_DEFAULT_DATE .

  DATA: LV_FIRST_DAY TYPE D,

        LV_LAST_DAY  TYPE D,

        LV_NEXT_MON  TYPE D.



  " #### # #




*  LV_FIRST_DAY = SY-DATUM.




  LV_FIRST_DAY = '20250301'.

  LV_FIRST_DAY+6(2) = '01'.



  " #### # #

  LV_NEXT_MON = LV_FIRST_DAY.

  ADD 1 TO LV_NEXT_MON+4(2).  " # +1

  IF LV_NEXT_MON+4(2) > '12'.

    LV_NEXT_MON+0(4) = LV_NEXT_MON+0(4) + 1. " ## +1

    LV_NEXT_MON+4(2) = '01'.

  ENDIF.



  " #### ### #

  LV_LAST_DAY = LV_NEXT_MON - 1.





  S_ZJDATE-SIGN   = 'I'.

  S_ZJDATE-OPTION = 'BT'.



  S_ZJDATE-LOW    = LV_FIRST_DAY.

  S_ZJDATE-HIGH   = LV_LAST_DAY.



  APPEND S_ZJDATE.





  S_ZDDATE-SIGN   = 'I'.

  S_ZDDATE-OPTION = 'BT'.



  S_ZDDATE-LOW    = LV_FIRST_DAY.

  S_ZDDATE-HIGH   = LV_LAST_DAY.

  APPEND S_ZDDATE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_SELECTION_SCREEN

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_SELECTION_SCREEN .



  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'M1'.

      IF P_R1 = 'X'.

        SCREEN-ACTIVE = '1'.

      ELSEIF P_R2 = 'X'.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ENDIF.



    IF SCREEN-GROUP1 = 'M2'.

      IF P_R1 = 'X'.

        SCREEN-ACTIVE = '0'.

      ELSEIF P_R2 = 'X'.

        SCREEN-ACTIVE = '1'.

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_ORDER

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_ORDER .



  SELECT * FROM ZEDT16_100

    INTO CORRESPONDING FIELDS OF TABLE GT_ORDER

    WHERE ZORDNO IN S_ZORDNO

    AND ZIDCODE IN S_ZID

    AND ZMATNR IN S_ZMATNR

    AND ZJDATE IN S_ZJDATE

    AND ZSALE_FG IN GR_ZSALE_FG.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_ORDER

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_ORDER .






*  DATA : BEGIN OF GS_ORDER_ALV,

*         ICON       TYPE CHAR4,

*         ZORDNO     LIKE ZEDT16_100-ZORDNO, "####

*         ZIDCODE    LIKE ZEDT16_100-ZIDCODE, "##ID

*         ZMATNR     LIKE ZEDT16_100-ZMATNR, "####

*         ZMTART     LIKE ZEDT16_100-ZMTART, "####

*         ZMTARTNAME TYPE CHAR10, "#####

*         ZMATNAME   LIKE ZEDT16_100-ZMATNAME, "###

*         ZVOLUM     LIKE ZEDT16_100-ZVOLUM, "##

*         VRKME      LIKE ZEDT16_100-VRKME, "####

*         ZNSAMT     LIKE ZEDT16_100-ZNSAMT, "####

*         ZSLAMT     LIKE ZEDT16_100-ZSLAMT, "####

*         ZDCAMT     LIKE ZEDT16_100-ZDCAMT, "####

*         ZWAERS     LIKE ZEDT16_100-ZWAERS, "##

*         ZDC_FG     LIKE ZEDT16_100-ZDC_FG, "####

*         ZDCNAME    TYPE CHAR10, "#####

*         ZSALE_FG   LIKE ZEDT16_100-ZSALE_FG, "####

*         ZSALENAME  TYPE CHAR2, "#####

*         ZRET_FG    LIKE ZEDT16_100-ZRET_FG, "####

*         ZRETNAME   TYPE CHAR4, "#####

*         ZJDATE     LIKE ZEDT16_100-ZJDATE, "####

*         ZRDATE     LIKE ZEDT16_100-ZRDATE, "####

*       END OF GS_ORDER_ALV.

*DATA : GT_ORDER_ALV LIKE TABLE OF GS_ORDER_ALV.






  " ICON, ZMTARTNAME(#####), ZDCNAME(#####), ZSALENAME(#####), ZRETNAME(#####)



  CLEAR : GS_ORDER, GS_ORDER_ALV.



  LOOP AT GT_ORDER INTO GS_ORDER.

    MOVE-CORRESPONDING GS_ORDER TO GS_ORDER_ALV.



    " ICON, ZSALENAME : ###, #####

    PERFORM CHANGING_ZSALE_FG USING GS_ORDER-ZSALE_FG

          CHANGING GS_ORDER_ALV-ICON

            GS_ORDER_ALV-ZSALENAME.



    " ZMTARTNAME : #####

    PERFORM CHANGING_ZMTART USING GS_ORDER-ZMTART

          CHANGING GS_ORDER_ALV-ZMTARTNAME.



    " ZDCNAME : #####

    PERFORM CHANGING_ZDC_FG USING GS_ORDER-ZDC_FG

          CHANGING GS_ORDER_ALV-ZDCNAME.



    " ZRETNAME : #####

    PERFORM CHANGING_ZRET_FG USING GS_ORDER-ZRET_FG

          CHANGING GS_ORDER_ALV-ZRETNAME.



    APPEND GS_ORDER_ALV TO GT_ORDER_ALV.



    CLEAR : GS_ORDER, GS_ORDER_ALV.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DELIVER

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DELIVER .



  SELECT * FROM ZEDT16_101

    INTO CORRESPONDING FIELDS OF TABLE GT_DELIVER

    WHERE ZORDNO IN S_ZORDNO

    AND ZIDCODE IN S_ZID

    AND ZMATNR IN S_ZMATNR

    AND ZDDATE IN S_ZDDATE

    AND ZFLAG IN GR_ZFLAG.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DELIVER

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_DELIVER .






*DATA : BEGIN OF GS_DELIVER_ALV,

*         ICON        TYPE CHAR4,

*         ZORDNO      LIKE ZEDT16_101-ZORDNO, "####

*         ZIDCODE     LIKE ZEDT16_101-ZIDCODE, "##ID

*         ZMATNR      LIKE ZEDT16_101-ZMATNR, "####

*         ZMTART      LIKE ZEDT16_101-ZMTART, "####

*         ZMTARTNAME  TYPE CHAR10, "#####

*         ZMATNAME    LIKE ZEDT16_101-ZMATNAME, "###

*         ZVOLUM      LIKE ZEDT16_101-ZVOLUM, "##

*         VRKME       LIKE ZEDT16_101-VRKME, "####

*         ZSLAMT      LIKE ZEDT16_101-ZSLAMT, "####

*         ZWAERS      LIKE ZEDT16_101-ZWAERS, "##

*         ZDFLAG      LIKE ZEDT16_101-ZDFLAG, "####

*         ZDNAME      TYPE CHAR10, "#####

*         ZDGUBUN     LIKE ZEDT16_101-ZDGUBUN, "####

*         ZDGUBUNNAME TYPE CHAR3, "#####

*         ZDDATE      LIKE ZEDT16_101-ZDDATE, "####

*         ZRDATE      LIKE ZEDT16_101-ZRDATE, "####

*         ZFLAG       LIKE ZEDT16_101-ZFLAG, "FLAG

*       END OF GS_DELIVER_ALV.

*DATA : GT_DELIVER_ALV LIKE TABLE OF GS_DELIVER_ALV.






  " ICON, ZMTARTNAME(#####), ZDNAME(#####), ZDGUBUNNAME(#####)



  CLEAR : GS_DELIVER, GS_DELIVER_ALV.



  LOOP AT GT_DELIVER INTO GS_DELIVER.

    MOVE-CORRESPONDING GS_DELIVER TO GS_DELIVER_ALV.



    " ICON : ###

    IF GS_DELIVER-ZFLAG = 'X'.

      GS_DELIVER_ALV-ICON = '@0A@'.

    ELSE.

      GS_DELIVER_ALV-ICON = '@08@'.

    ENDIF.



    " ZMTARTNAME : #####

    PERFORM CHANGING_ZMTART USING GS_DELIVER-ZMTART

          CHANGING GS_DELIVER_ALV-ZMTARTNAME.



    " ZDNAME : #####

    PERFORM CHANGING_ZDFLAG USING GS_DELIVER-ZDFLAG

          CHANGING GS_DELIVER_ALV-ZDNAME.



    " ZDGUBUNNAME : #####

    PERFORM CHANGING_ZDGUBUN USING GS_DELIVER-ZDGUBUN

          CHANGING GS_DELIVER_ALV-ZDGUBUNNAME.



    APPEND GS_DELIVER_ALV TO GT_DELIVER_ALV.



    CLEAR : GS_DELIVER, GS_DELIVER_ALV.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_RANGE_TABLE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_RANGE_TABLE .



  IF P_R1 = 'X'.

    GR_ZSALE_FG-SIGN = 'I'.

    GR_ZSALE_FG-OPTION = 'BT'.



    IF P_CH1 = 'X'.

      GR_ZSALE_FG-LOW = '1'.

      GR_ZSALE_FG-HIGH = '2'.

    ELSE.

      GR_ZSALE_FG-LOW = '1'.

      GR_ZSALE_FG-HIGH = '1'.

    ENDIF.



    APPEND GR_ZSALE_FG.



  ELSEIF P_R2 = 'X'.

    GR_ZFLAG-SIGN = 'I'.

    GR_ZFLAG-OPTION = 'EQ'.

    GR_ZFLAG-LOW = ' '.

    APPEND GR_ZFLAG.



    IF P_CH1 = 'X'.

      GR_ZFLAG-LOW = 'X'.

      APPEND GR_ZFLAG.

    ENDIF.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHANGING_ZMTART

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_ORDER_ZMTART  text

*      <--P_GS_ORDER_ALV_ZMTARTNAME  text

*----------------------------------------------------------------------*




FORM CHANGING_ZMTART  USING    P_GS_ORDER_ZMTART

                      CHANGING P_GS_ORDER_ALV_ZMTARTNAME.



  CASE P_GS_ORDER_ZMTART.

    WHEN '001'.

      P_GS_ORDER_ALV_ZMTARTNAME = '##'.

    WHEN '002'.

      P_GS_ORDER_ALV_ZMTARTNAME = '##'.

    WHEN '003'.

      P_GS_ORDER_ALV_ZMTARTNAME = '##'.

    WHEN '004'.

      P_GS_ORDER_ALV_ZMTARTNAME = '##'.

    WHEN '005'.

      P_GS_ORDER_ALV_ZMTARTNAME = '##'.

    WHEN '006'.

      P_GS_ORDER_ALV_ZMTARTNAME = '###'.

  ENDCASE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHANGING_ZSALE_FG

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_ORDER_ZSALE_FG  text

*      <--P_GS_ORDER_ALV_ICON  text

*      <--P_GS_ORDER_ALV_ZSALENAME  text

*----------------------------------------------------------------------*




FORM CHANGING_ZSALE_FG  USING    P_GS_ORDER_ZSALE_FG

                        CHANGING P_GS_ORDER_ALV_ICON

                                 P_GS_ORDER_ALV_ZSALENAME.



  CASE P_GS_ORDER_ZSALE_FG.

    WHEN '1'.

      P_GS_ORDER_ALV_ICON = '@08@'.

      P_GS_ORDER_ALV_ZSALENAME = '##'.

    WHEN '2'.

      P_GS_ORDER_ALV_ICON = '@0A@'.

      P_GS_ORDER_ALV_ZSALENAME = '##'.

  ENDCASE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHANGING_ZDC_FG

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_ORDER_ZDC_FG  text

*      <--P_GS_ORDER_ALV_ZDCNAME  text

*----------------------------------------------------------------------*




FORM CHANGING_ZDC_FG  USING    P_GS_ORDER_ZDC_FG

                      CHANGING P_GS_ORDER_ALV_ZDCNAME.



  CASE P_GS_ORDER_ZDC_FG.

    WHEN '1'.

      P_GS_ORDER_ALV_ZDCNAME = '#####'.

    WHEN '2'.

      P_GS_ORDER_ALV_ZDCNAME = '######'.

    WHEN '3'.

      P_GS_ORDER_ALV_ZDCNAME = '####'.

    WHEN '4'.

      P_GS_ORDER_ALV_ZDCNAME = '####'.

  ENDCASE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHANGING_ZRET_FG

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_ORDER_ZRET_FG  text

*      <--P_GS_ORDER_ALV_ZRETNAME  text

*----------------------------------------------------------------------*




FORM CHANGING_ZRET_FG  USING    P_GS_ORDER_ZRET_FG

                       CHANGING P_GS_ORDER_ALV_ZRETNAME.



  CASE P_GS_ORDER_ZRET_FG.

    WHEN '1'.

      P_GS_ORDER_ALV_ZRETNAME = '####'.

    WHEN '2'.

      P_GS_ORDER_ALV_ZRETNAME = '####'.

    WHEN '3'.

      P_GS_ORDER_ALV_ZRETNAME = '####'.

  ENDCASE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHANGING_ZDFLAG

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_DELIVER_ZDFLAG  text

*      <--P_GS_DELIVER_ALV_ZDNAME  text

*----------------------------------------------------------------------*




FORM CHANGING_ZDFLAG  USING    P_GS_DELIVER_ZDFLAG

                      CHANGING P_GS_DELIVER_ALV_ZDNAME.



  CASE P_GS_DELIVER_ZDFLAG.

    WHEN '1'.

      P_GS_DELIVER_ALV_ZDNAME = '####'.

    WHEN '2'.

      P_GS_DELIVER_ALV_ZDNAME = '###'.

    WHEN '3'.

      P_GS_DELIVER_ALV_ZDNAME = '####'.

  ENDCASE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHANGING_ZDGUBUN

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_DELIVER_ZDGUBUN  text

*      <--P_GS_DELIVER_ALV_ZDGUBUNNAME  text

*----------------------------------------------------------------------*




FORM CHANGING_ZDGUBUN  USING    P_GS_DELIVER_ZDGUBUN

                       CHANGING P_GS_DELIVER_ALV_ZDGUBUNNAME.



  CASE P_GS_DELIVER_ZDGUBUN.

    WHEN '1'.

      P_GS_DELIVER_ALV_ZDGUBUNNAME = '###'.

    WHEN '2'.

      P_GS_DELIVER_ALV_ZDGUBUNNAME = '###'.

    WHEN '3'.

      P_GS_DELIVER_ALV_ZDGUBUNNAME = '###'.

    WHEN '4'.

      P_GS_DELIVER_ALV_ZDGUBUNNAME = '###'.

    WHEN '5'.

      P_GS_DELIVER_ALV_ZDGUBUNNAME = '###'.

    WHEN '6'.

      P_GS_DELIVER_ALV_ZDGUBUNNAME = '###'.

    WHEN '7'.

      P_GS_DELIVER_ALV_ZDGUBUNNAME = '###'.

  ENDCASE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GC_DOCKING  text

*      -->P_GC_GRID1  text

*----------------------------------------------------------------------*




FORM CREATE_OBJECT  USING    P_GC_DOCKING TYPE REF TO CL_GUI_DOCKING_CONTAINER

                             P_GC_GRID TYPE REF TO CL_GUI_ALV_GRID.



  CREATE OBJECT P_GC_DOCKING

    EXPORTING




*     PARENT    =




      REPID     = SY-REPID

      DYNNR     = SY-DYNNR




*     SIDE      = DOCK_AT_LEFT




      EXTENSION = 2000




*     STYLE     =

*     LIFETIME  = lifetime_default

*     CAPTION   =

*     METRIC    = 0

*     RATIO     =

*     NO_AUTODEF_PROGID_DYNNR     =

*     NAME      =

*    EXCEPTIONS

*     CNTL_ERROR                  = 1

*     CNTL_SYSTEM_ERROR           = 2

*     CREATE_ERROR                = 3

*     LIFETIME_ERROR              = 4

*     LIFETIME_DYNPRO_DYNPRO_LINK = 5

*     OTHERS    = 6




    .

  IF SY-SUBRC <> 0.




*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.



  CREATE OBJECT P_GC_GRID

    EXPORTING




*     I_SHELLSTYLE      = 0

*     I_LIFETIME        =




      I_PARENT = P_GC_DOCKING




*     I_APPL_EVENTS     = space

*     I_PARENTDBG       =

*     I_APPLOGPARENT    =

*     I_GRAPHICSPARENT  =

*     I_NAME   =

*     I_FCAT_COMPLETE   = SPACE

*    EXCEPTIONS

*     ERROR_CNTL_CREATE = 1

*     ERROR_CNTL_INIT   = 2

*     ERROR_CNTL_LINK   = 3

*     ERROR_DP_CREATE   = 4

*     OTHERS   = 5




    .

  IF SY-SUBRC <> 0.




*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATELOG_0100

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATELOG_0100 .






*  DATA : BEGIN OF GS_ORDER_ALV,

*         ICON       TYPE CHAR4,

*         ZORDNO     LIKE ZEDT16_100-ZORDNO, "####

*         ZIDCODE    LIKE ZEDT16_100-ZIDCODE, "##ID

*         ZMATNR     LIKE ZEDT16_100-ZMATNR, "####

*         ZMTART     LIKE ZEDT16_100-ZMTART, "####

*         ZMTARTNAME TYPE CHAR10, "#####

*         ZMATNAME   LIKE ZEDT16_100-ZMATNAME, "###

*         ZVOLUM     LIKE ZEDT16_100-ZVOLUM, "##

*         VRKME      LIKE ZEDT16_100-VRKME, "####

*         ZNSAMT     LIKE ZEDT16_100-ZNSAMT, "####

*         ZSLAMT     LIKE ZEDT16_100-ZSLAMT, "####

*         ZDCAMT     LIKE ZEDT16_100-ZDCAMT, "####

*         ZWAERS     LIKE ZEDT16_100-ZWAERS, "##

*         ZDC_FG     LIKE ZEDT16_100-ZDC_FG, "####

*         ZDCNAME    TYPE CHAR10, "#####

*         ZSALE_FG   LIKE ZEDT16_100-ZSALE_FG, "####

*         ZSALENAME  TYPE CHAR2, "#####

*         ZRET_FG    LIKE ZEDT16_100-ZRET_FG, "####

*         ZRETNAME   TYPE CHAR4, "#####

*         ZJDATE     LIKE ZEDT16_100-ZJDATE, "####

*         ZRDATE     LIKE ZEDT16_100-ZRDATE, "####

*       END OF GS_ORDER_ALV.

*DATA : GT_ORDER_ALV LIKE TABLE OF GS_ORDER_ALV.






  CLEAR : GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ICON'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-ICON = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZORDNO'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZIDCODE'.

  GS_FIELDCAT-COLTEXT = '##ID'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZMATNR'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZMATNAME'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZMTARTNAME'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZVOLUM'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-QFIELDNAME = 'VRKME'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'VRKME'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'ZNSAMT'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-DO_SUM = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'ZSLAMT'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-DO_SUM = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'ZDCAMT'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-DO_SUM = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 12.

  GS_FIELDCAT-FIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-EMPHASIZE = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 13.

  GS_FIELDCAT-FIELDNAME = 'ZSALENAME'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 14.

  GS_FIELDCAT-FIELDNAME = 'ZJDATE'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  IF P_CH1 = 'X'.

    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 15.

    GS_FIELDCAT-FIELDNAME = 'ZRETNAME'.

    GS_FIELDCAT-COLTEXT = '####'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.



    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 16.

    GS_FIELDCAT-FIELDNAME = 'ZRDATE'.

    GS_FIELDCAT-COLTEXT = '####'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_LAYOUT .

  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.



  " VARIANT ##



  CLEAR GS_VARIANT.

  GS_VARIANT-REPORT = SY-REPID.

  GS_VARIANT-USERNAME = SY-UNAME.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_SORT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_SORT .



  CLEAR : GS_SORT.

  CLEAR : GT_SORT.



  GS_SORT-SPOS = 1. " ## ####

  GS_SORT-FIELDNAME = 'ZIDCODE'. " ### ### ### ##

  GS_SORT-UP = 'X'. " #### #### ##




*  gs_sort-down = 'X'. " #### #### ##




  GS_SORT-SUBTOT = 'X'. " ####

  APPEND GS_SORT TO GT_SORT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALL_ALV

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GT_ORDER_ALV[]  text

*      -->P_GC_GRID1  text

*----------------------------------------------------------------------*




FORM CALL_ALV  USING    P_GT_ALV TYPE ANY TABLE

                        P_GC_GRID TYPE REF TO CL_GUI_ALV_GRID.



  CALL METHOD P_GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING




*     I_BUFFER_ACTIVE =

*     I_BYPASSING_BUFFER            =

*     I_CONSISTENCY_CHECK           =

*     I_STRUCTURE_NAME              =




      IS_VARIANT      = GS_VARIANT

      I_SAVE          = 'A'




*     I_DEFAULT       = 'X'




      IS_LAYOUT       = GS_LAYOUT




*     IS_PRINT        =

*     IT_SPECIAL_GROUPS             =

*     IT_TOOLBAR_EXCLUDING          =

*     IT_HYPERLINK    =

*     IT_ALV_GRAPHICS =

*     IT_EXCEPT_QINFO =

*     IR_SALV_ADAPTER =




    CHANGING

      IT_OUTTAB       = P_GT_ALV

      IT_FIELDCATALOG = GT_FIELDCAT

      IT_SORT         = GT_SORT




*     IT_FILTER       =

*    EXCEPTIONS

*     INVALID_PARAMETER_COMBINATION = 1

*     PROGRAM_ERROR   = 2

*     TOO_MANY_LINES  = 3

*     OTHERS          = 4




    .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATELOG_0200

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATELOG_0200 .






*  DATA : BEGIN OF GS_DELIVER_ALV,

*         ICON        TYPE CHAR4,

*         ZORDNO      LIKE ZEDT16_101-ZORDNO, "####

*         ZIDCODE     LIKE ZEDT16_101-ZIDCODE, "##ID

*         ZMATNR      LIKE ZEDT16_101-ZMATNR, "####

*         ZMTART      LIKE ZEDT16_101-ZMTART, "####

*         ZMTARTNAME  TYPE CHAR10, "#####

*         ZMATNAME    LIKE ZEDT16_101-ZMATNAME, "###

*         ZVOLUM      LIKE ZEDT16_101-ZVOLUM, "##

*         VRKME       LIKE ZEDT16_101-VRKME, "####

*         ZSLAMT      LIKE ZEDT16_101-ZSLAMT, "####

*         ZWAERS      LIKE ZEDT16_101-ZWAERS, "##

*         ZDFLAG      LIKE ZEDT16_101-ZDFLAG, "####

*         ZDNAME      TYPE CHAR10, "#####

*         ZDGUBUN     LIKE ZEDT16_101-ZDGUBUN, "####

*         ZDGUBUNNAME TYPE CHAR3, "#####

*         ZDDATE      LIKE ZEDT16_101-ZDDATE, "####

*         ZRDATE      LIKE ZEDT16_101-ZRDATE, "####

*         ZFLAG       LIKE ZEDT16_101-ZFLAG, "FLAG

*       END OF GS_DELIVER_ALV.

*DATA : GT_DELIVER_ALV LIKE TABLE OF GS_DELIVER_ALV.






  CLEAR : GT_FIELDCAT.

  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ICON'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-ICON = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZORDNO'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZIDCODE'.

  GS_FIELDCAT-COLTEXT = '##ID'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZMATNR'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZMATNAME'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZMTARTNAME'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZVOLUM'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-QFIELDNAME = 'VRKME'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'VRKME'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'ZSLAMT'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-DO_SUM = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-EMPHASIZE = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'ZDNAME'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 12.

  GS_FIELDCAT-FIELDNAME = 'ZDGUBUNNAME'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-EMPHASIZE = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 13.

  GS_FIELDCAT-FIELDNAME = 'ZDDATE'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  IF P_CH1 = 'X'.

    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 14.

    GS_FIELDCAT-FIELDNAME = 'ZRDATE'.

    GS_FIELDCAT-COLTEXT = '####'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.



    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 15.

    GS_FIELDCAT-FIELDNAME = 'ZFLAG'.

    GS_FIELDCAT-COLTEXT = '####'.

    GS_FIELDCAT-EMPHASIZE = 'X'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_INITIAL_INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_INITIAL_INPUT .



  IF P_R1 = 'X'.

    IF S_ZJDATE IS INITIAL AND S_ZORDNO IS INITIAL.

      MESSAGE I000.

      STOP.

    ENDIF.

  ELSEIF P_R2 = 'X'.

    IF S_ZDDATE IS INITIAL AND S_ZORDNO IS INITIAL.

      MESSAGE I000.

      STOP.

    ENDIF.

  ENDIF.



ENDFORM.