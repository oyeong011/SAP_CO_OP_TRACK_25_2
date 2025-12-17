
*&---------------------------------------------------------------------*

*&  Include           ZEDR09_PRACTICE008_F01

*&---------------------------------------------------------------------*





*&---------------------------------------------------------------------*

*&      Form  CONTROL_SCREEN

*&---------------------------------------------------------------------*






"##### ###### #### ####, ## ID, ####, ####

"##### ###### #### ####, ## ID, ####, #### ##### ### ##

FORM CONTROL_SCREEN .

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'M1'.     "M1 (#### ## ##)

      IF P_R1 = C_X.            "#### #### #### ###, ### ####

        SCREEN-ACTIVE = '1'.

      ELSE.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ELSEIF SCREEN-GROUP1 = 'M2'. "M2 (#### ## ##)

      IF P_R2 = C_X.            "#### #### #### ###, ### ####

        SCREEN-ACTIVE = '1'.

      ELSE.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ENDIF.



    MODIFY SCREEN.

  ENDLOOP.

ENDFORM.








*&---------------------------------------------------------------------*

*&      Form  SET_DATE

*&---------------------------------------------------------------------*






"##### ##### ## default# ###### ##,

"### ## + # + 01~ ### ## ## ### ### ## FIX

FORM SET_DATE .

  DATA : LV_FIRST_DAY TYPE SY-DATUM,

         LV_LAST_DAY TYPE SY-DATUM.



  "#### : ### ## + # + 01

  LV_FIRST_DAY = SY-DATUM+0(6) && '01'.



  "### ##

  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

    EXPORTING

      DAY_IN = LV_FIRST_DAY

    IMPORTING

      LAST_DAY_OF_MONTH = LV_LAST_DAY.



  IF S_ZJDATE[] IS INITIAL. "#### #### ##

    S_ZJDATE-LOW = LV_FIRST_DAY.

    S_ZJDATE-HIGH = LV_LAST_DAY.

    APPEND S_ZJDATE.

  ENDIF.



  IF S_ZDDATE[] IS INITIAL. "#### #### ##

    S_ZDDATE-LOW = LV_FIRST_DAY.

    S_ZDDATE-HIGH = LV_LAST_DAY.

    APPEND S_ZDDATE.

  ENDIF.

ENDFORM.








*&---------------------------------------------------------------------*

*&      Form  CHECK_SCREEN

*&---------------------------------------------------------------------*






FORM CHECK_SCREEN .



  "#### ## ##### ### 1## ##### ##

  IF P_R1 = C_X.  "##### #

    IF S_ZJDATE[] IS INITIAL AND S_ZORDNO[] IS INITIAL.

      MESSAGE I017.

    ENDIF.

  ENDIF.



  "#### ##

  CLEAR : R_ZFLAG.



  R_ZFLAG-SIGN = 'I'.

  R_ZFLAG-OPTION = 'EQ'.



  IF Z_CHECK = C_X.

    "## ## ## #, #### ### ### ## ## ##

    R_ZFLAG-LOW = 'X'.

    APPEND R_ZFLAG.

    R_ZFLAG-LOW = ' '.

    APPEND R_ZFLAG.

  ELSE.

    "## ## ####, ## ## ### ##

    R_ZFLAG-LOW = ' '.

    APPEND R_ZFLAG.

  ENDIF.

ENDFORM.








*&---------------------------------------------------------------------*

*&      Form  SELECT_R1

*&---------------------------------------------------------------------*






" ##### ## ## ### ## #, ##### ## ## #### #### ## ## # ## ### ##

" zedt00_101-zflag# x### #### ## ##### ### ##



FORM SELECT_R1 .

  SELECT

     a~ZORDNO   "####

     a~ZIDCODE  "##ID

     a~ZMATNR   "####

     a~ZMATNAME "###

     a~ZMTART   "####

     a~ZVOLUM   "##

     a~VRKME    "##

     a~ZNSAMT   "####

     a~ZSLAMT   "####

     a~ZDCAMT   "####

     a~ZWAERS   "##

     a~ZSALE_FG  "####

     a~ZJDATE   "####

     a~ZRET_FG  "####

     a~ZRDATE   "####

  FROM ZEDT09_100 AS a

  INNER JOIN ZEDT09_101 AS b

  ON a~ZORDNO = b~ZORDNO

  INTO CORRESPONDING FIELDS OF TABLE GT_ORDER

  WHERE a~ZORDNO IN S_ZORDNO    "####

  AND a~ZIDCODE IN S_ZID        "##ID

  AND a~ZMATNR IN S_ZMATNR      "####

  AND a~ZJDATE IN S_ZJDATE      "####

  AND b~ZFLAG IN R_ZFLAG.       "#### range##



ENDFORM.








*&---------------------------------------------------------------------*

*&      Form  MODIFY_R1

*&---------------------------------------------------------------------*






" #### #### #####, ####, ###### ### ## (###)

" ### ## : R1 -> ##### ##### ##, ### ## ##



FORM MODIFY_R1 .

  CLEAR : GS_ORDER.

  LOOP AT GT_ORDER INTO GS_ORDER.

    MOVE-CORRESPONDING GS_ORDER TO GS_ORDER_ALV.



    "####_## ###

    PERFORM CHANGE_ZMTART_NAME USING GS_ORDER-ZMTART

                               CHANGING GS_ORDER_ALV-ZMTART_NAME.

    "####_## ###

    PERFORM CHANGE_ZSALE_NAME USING GS_ORDER-ZSALE_FG

                              CHANGING GS_ORDER_ALV-ZSALE_NAME.



    "####_## ###

    PERFORM CHANGE_ZRET_NAME USING GS_ORDER-ZRET_FG

                             CHANGING GS_ORDER_ALV-ZRET_NAME.



    "### ## : ##### ### ## ##, ### ## ##

    IF GS_ORDER-ZSALE_FG = '1'. "### ##

      GS_ORDER_ALV-ZCOLOR = '@08@'.

    ELSEIF GS_ORDER-ZSALE_FG = '2'. "### ##

      GS_ORDER_ALV-ZCOLOR = '@0A@'.

    ENDIF.



    APPEND GS_ORDER_ALV TO GT_ORDER_ALV.

  ENDLOOP.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CHANGE_ZMTART_NAME

*&---------------------------------------------------------------------*




FORM CHANGE_ZMTART_NAME  USING    P_GS_ORDER_ZMTART

                         CHANGING P_GS_ORDER_ALV_ZMTART_NAME.



  CASE P_GS_ORDER_ZMTART.

    WHEN '001'.

      P_GS_ORDER_ALV_ZMTART_NAME = '##'.

    WHEN '002'.

      P_GS_ORDER_ALV_ZMTART_NAME = '##'.

    WHEN '003'.

      P_GS_ORDER_ALV_ZMTART_NAME = '##'.

    WHEN '004'.

      P_GS_ORDER_ALV_ZMTART_NAME = '##'.

    WHEN '005'.

      P_GS_ORDER_ALV_ZMTART_NAME = '##'.

    WHEN '006'.

      P_GS_ORDER_ALV_ZMTART_NAME = '###'.

  ENDCASE.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CHANGE_ZSALE_NAME

*&---------------------------------------------------------------------*




FORM CHANGE_ZSALE_NAME  USING    P_GS_ORDER_ZSALE_FG

                        CHANGING P_GS_ORDER_ALV_ZSALE_NAME.

  CASE P_GS_ORDER_ZSALE_FG.

    WHEN '1'.

      P_GS_ORDER_ALV_ZSALE_NAME = '##'.

    WHEN '2'.

      P_GS_ORDER_ALV_ZSALE_NAME = '##'.

  ENDCASE.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CHANGE_ZRET_NAME

*&---------------------------------------------------------------------*




FORM CHANGE_ZRET_NAME  USING    P_GS_ORDER_ZRET_FG

                       CHANGING P_GS_ORDER_ALV_ZRET_NAME.



  CASE P_GS_ORDER_ZRET_FG.

    WHEN '1'.

      P_GS_ORDER_ALV_ZRET_NAME = '####'.

    WHEN '2'.

      P_GS_ORDER_ALV_ZRET_NAME = '####'.

    WHEN '3'.

      P_GS_ORDER_ALV_ZRET_NAME = '####'.

  ENDCASE.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*




FORM CREATE_OBJECT  USING    P_GC_DOCKING TYPE REF TO CL_GUI_DOCKING_CONTAINER

                             P_GC_GRID TYPE REF TO CL_GUI_ALV_GRID.



  "docking #### ## ##

  CREATE OBJECT P_GC_DOCKING

     EXPORTING

      REPID                       = SY-REPID

      DYNNR                       = SY-DYNNR

      EXTENSION                   = 2000.





  "grid ## ##

  CREATE OBJECT P_GC_GRID

    EXPORTING

      I_PARENT          = P_GC_DOCKING.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CALL_ALV

*&---------------------------------------------------------------------*




FORM CALL_ALV  USING    P_GC_GRID TYPE REF TO CL_GUI_ALV_GRID

                        P_T_OUTTAB TYPE STANDARD TABLE.



   CALL METHOD P_GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

     EXPORTING

       IS_VARIANT                    = GS_VARIANT

       I_SAVE                        = 'A'

       IS_LAYOUT                     = GS_LAYOUT

     CHANGING

       IT_OUTTAB                     = P_T_OUTTAB

       IT_FIELDCATALOG               = GT_FIELDCAT

       IT_SORT                       = GT_SORT.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  FIELDCATALOG_0100

*&---------------------------------------------------------------------*

* ### ## ####



* - ### ## (ZCOLOR)

* - ## ### ### ## ## (CFIELD, QFIELD) ## ##, ## SUM# ####

* - ###### #### # # ### ## ##, ### ######.

* - ###### #### ### ### ####(R1), ####(R1,R2), ####(R2) ## ####




FORM FIELDCATALOG_0100 .



  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  "### ## (ZCOLOR)

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZCOLOR'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-ICON = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZORDNO'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZIDCODE'.

  GS_FIELDCAT-SCRTEXT_M = '##ID'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZMATNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZMATNAME'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZMTART_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  "QFIELDNAME## ## ## ##

  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZVOLUM'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-QFIELDNAME = 'VRKME'. "### 1# ###, 001 ## ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'VRKME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  "### ##### CFIELDNAME## ## ## ##

  "## sum# ## #

  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'ZNSAMT'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-DO_SUM = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'ZSLAMT'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-DO_SUM = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'ZDCAMT'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  GS_FIELDCAT-DO_SUM = 'X'.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 12.

  GS_FIELDCAT-FIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-EMPHASIZE = 'X'.      "### #### ####

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  GS_FIELDCAT-DO_SUM = 'X'.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 13.

  GS_FIELDCAT-FIELDNAME = 'ZSALE_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 14.

  GS_FIELDCAT-FIELDNAME = 'ZJDATE'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  "####, ##### ###### ##### #### ## ####

  IF Z_CHECK = C_X.

    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 15.

    GS_FIELDCAT-FIELDNAME = 'ZRET_NAME'.

    GS_FIELDCAT-SCRTEXT_M = '####'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.



    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 16.

    GS_FIELDCAT-FIELDNAME = 'ZRDATE'.

    GS_FIELDCAT-SCRTEXT_M = '####'.

    GS_FIELDCAT-OUTPUTLEN = 10.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*

* ##### ### ### #### VARIANT# #### ALV# ##




FORM ALV_LAYOUT .

  CLEAR : GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.



  "varient# #### ##### #### #######

  CLEAR : GS_VARIANT.

  GS_VARIANT-REPORT = SY-REPID.

  GS_VARIANT-USERNAME = SY-UNAME.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ALV_SORT

*&---------------------------------------------------------------------*

* ##ID## ###### ####, ID### ## SUM## ####




FORM ALV_SORT .

  CLEAR : GS_SORT.



  "##ID## ####

  GS_SORT-SPOS = 1.

  GS_SORT-FIELDNAME = 'ZIDCODE'.

  GS_SORT-UP = 'X'.



  "ID### ## SUM## ####

  GS_SORT-SUBTOT = 'X'.

  APPEND GS_SORT TO GT_SORT.

ENDFORM.








*&---------------------------------------------------------------------*

*&      Form  SELECT_R2

*&---------------------------------------------------------------------*



* ##### ###### ## # ##### ## ## #### ####, ## ## # ##### ##




FORM SELECT_R2 .

  SELECT *

  FROM ZEDT09_101

  INTO CORRESPONDING FIELDS OF TABLE GT_DELIVERY

  WHERE ZORDNO IN S_ZORDNO  "####

  AND ZIDCODE IN S_ZID      "##ID

  AND ZMATNR IN S_ZMATNR    "####

  AND ZDDATE IN S_ZDDATE    "####

  AND ZFLAG IN R_ZFLAG.     "#### range ##

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  MODIFY_R2

*&---------------------------------------------------------------------*






" #### #### #####, #####, ###### ### ## (###)

" ### ## : R2 -> ##### X### ## ##, #### ##



FORM MODIFY_R2 .

  CLEAR : GS_DELIVERY.

  LOOP AT GT_DELIVERY INTO GS_DELIVERY.

    MOVE-CORRESPONDING GS_DELIVERY TO GS_DELIVERY_ALV.



    "####_## ###

    PERFORM CHANGE_ZMTART_NAME USING GS_DELIVERY-ZMTART

                               CHANGING GS_DELIVERY_ALV-ZMTART_NAME.



    "####_## ###

    PERFORM CHANGE_ZDFLAG_NAME USING GS_DELIVERY-ZDFLAG

                               CHANGING GS_DELIVERY_ALV-ZDFLAG_NAME.



    "####_## ###

    PERFORM CHANGE_ZDGUBUN_NAME USING GS_DELIVERY-ZDGUBUN

                                CHANGING GS_DELIVERY_ALV-ZDGUBUN_NAME.



    "### ## : R2 -> ##### X### ## ##, #### ##

    IF GS_DELIVERY-ZFLAG = C_X.

      GS_DELIVERY_ALV-ZCOLOR = '@0A@'. "##

    ELSE.

      GS_DELIVERY_ALV-ZCOLOR = '@08@'. "##

    ENDIF.



    APPEND GS_DELIVERY_ALV TO GT_DELIVERY_ALV.

  ENDLOOP.



ENDFORM.








*&---------------------------------------------------------------------*

*&      Form  CHANGE_ZDFLAG_NAME

*&---------------------------------------------------------------------*




FORM CHANGE_ZDFLAG_NAME  USING    P_GS_DELIVERY_ZDFLAG

                         CHANGING P_GS_DELIVERY_ALV_ZDFLAG_NAME.



  CASE P_GS_DELIVERY_ZDFLAG.

    WHEN '1'.

      P_GS_DELIVERY_ALV_ZDFLAG_NAME = '####'.

    WHEN '2'.

      P_GS_DELIVERY_ALV_ZDFLAG_NAME = '###'.

    WHEN '3'.

      P_GS_DELIVERY_ALV_ZDFLAG_NAME = '####'.

  ENDCASE.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CHANGE_ZDGUBUN_NAME

*&---------------------------------------------------------------------*




FORM CHANGE_ZDGUBUN_NAME  USING    P_GS_DELIVERY_ZDGUBUN

                          CHANGING P_GS_DELIVERY_AL_ZDGUBUN_NAME.



  CASE P_GS_DELIVERY_ZDGUBUN.

    WHEN '1'.

      P_GS_DELIVERY_AL_ZDGUBUN_NAME = '###'.

    WHEN '2'.

      P_GS_DELIVERY_AL_ZDGUBUN_NAME = '###'.

    WHEN '3'.

      P_GS_DELIVERY_AL_ZDGUBUN_NAME = '###'.

    WHEN '4'.

      P_GS_DELIVERY_AL_ZDGUBUN_NAME = '###'.

    WHEN '5'.

      P_GS_DELIVERY_AL_ZDGUBUN_NAME = '###'.

    WHEN '6'.

      P_GS_DELIVERY_AL_ZDGUBUN_NAME = '###'.

    WHEN '7'.

      P_GS_DELIVERY_AL_ZDGUBUN_NAME = '###'.

  ENDCASE.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  FIELDCATALOG_0200

*&---------------------------------------------------------------------*




FORM FIELDCATALOG_0200 .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  "### ## (ZCOLOR)

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZCOLOR'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-ICON = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZORDNO'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZIDCODE'.

  GS_FIELDCAT-SCRTEXT_M = '##ID'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZMATNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZMATNAME'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZMTART_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  "QFIELDNAME## ## ## ##

  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZVOLUM'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-QFIELDNAME = 'VRKME'. "### 1# ###, 001 ## ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'VRKME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  "### ##### CFIELDNAME## ## ## ##

  "## sum# ## #



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'ZSLAMT'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-DO_SUM = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-EMPHASIZE = 'X'.      "### #### ####

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

  GS_FIELDCAT-DO_SUM = 'X'.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'ZDFLAG_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 12.

  GS_FIELDCAT-FIELDNAME = 'ZDGUBUN_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 13.

  GS_FIELDCAT-FIELDNAME = 'ZDDATE'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  "####, ##### ###### ##### #### ## ####

  IF Z_CHECK = C_X.

    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 14.

    GS_FIELDCAT-FIELDNAME = 'ZRDATE'.

    GS_FIELDCAT-SCRTEXT_M = '####'.

    GS_FIELDCAT-OUTPUTLEN = 10.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.



    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 15.

    GS_FIELDCAT-FIELDNAME = 'ZFLAG'.

    GS_FIELDCAT-SCRTEXT_M = '####'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

  ENDIF.

ENDFORM.