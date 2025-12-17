
*&---------------------------------------------------------------------*

*&  Include           ZEDR15_PRACTICE008_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  DATE_INIT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM DATE_INIT .

  DATA : LV_MONTHLAST TYPE SY-DATUM. "### ## ## ######

  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS' "## # ### ### ### ####

    EXPORTING "#### ##

      DAY_IN = SY-DATUM

    IMPORTING "### ## ##

      LAST_DAY_OF_MONTH = LV_MONTHLAST.



   "####

   S_ZJDATE-LOW = SY-DATUM(6) && '01'.

   S_ZJDATE-HIGH = LV_MONTHLAST.

   S_ZJDATE-SIGN = 'I'.

   S_ZJDATE-OPTION = 'BT'.

   APPEND S_ZJDATE.



   "####

   S_ZDDATE-LOW = SY-DATUM(6) && '01'.

   S_ZDDATE-HIGH = LV_MONTHLAST.

   S_ZDDATE-SIGN = 'I'.

   S_ZDDATE-OPTION = 'BT'.

   APPEND S_ZDDATE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SCREEN_CONTROL

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SCREEN_CONTROL .

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'M1'.

      IF P_R1 = C_X.

        SCREEN-ACTIVE = '1'.

      ELSEIF P_R2 = C_X.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ELSEIF SCREEN-GROUP1 = 'M2'.

      IF P_R1 = C_X.

        SCREEN-ACTIVE = '0'.

      ELSEIF P_R2 = C_X.

        SCREEN-ACTIVE = '1'.

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SCREEN_CHECK

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SCREEN_CHECK .

  IF P_R1 = C_X. "####

    IF S_ZJDATE IS INITIAL.

      IF S_ZORDNO IS INITIAL.

         MESSAGE E001.

         STOP.

      ENDIF.

    ENDIF.

  ELSEIF P_R2 = C_X."####

    IF S_ZDDATE IS INITIAL.

      IF S_ZORDNO IS INITIAL.

         MESSAGE E001.

         STOP.

      ENDIF.

    ENDIF.

  ENDIF.



  R_ZFG-SIGN = 'I'.

  R_ZFG-OPTION = 'EQ'.

  R_ZFG-LOW = ''.

  APPEND R_ZFG.



  IF P_CH1 = C_X.

    R_ZFG-LOW = C_X.

  ENDIF.

  APPEND R_ZFG.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SELECT_ORDER

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SELECT_ORDER .



 " #### ##

  SELECT

    T1~ZORDNO "####

    T1~ZIDCODE "##ID

    T1~ZMATNR "####

    T1~ZMATNAME "###

    T1~ZMTART "#### (MODIFY)

    T1~ZVOLUM "##

    T1~VRKME "##

    T1~ZNSAMT "####

    T1~ZSLAMT "####

    T1~ZDCAMT "####

    T1~ZWAERS "##

    T1~ZSALE_FG " #### (MODIFY)

    T1~ZJDATE "####

    T1~ZRET_FG "#### (MODIFY)

    T1~ZRDATE "####

    T2~ZFLAG "####

  FROM ZEDT15_100 AS T1

    INNER JOIN ZEDT15_101 AS T2

    ON T1~ZORDNO = T2~ZORDNO

  INTO CORRESPONDING FIELDS OF TABLE GT_ORDER

  WHERE T1~ZIDCODE IN S_ZID "##### #### #### # ## ##.

    AND T1~ZORDNO IN S_ZORDNO "ALPHA### ## ### ### ###!!

    AND T1~ZMATNR IN S_ZMATNR

    AND T1~ZJDATE IN S_ZJDATE

    AND T2~ZFLAG IN R_ZFG.





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

   LOOP AT GT_ORDER INTO GS_ORDER.

      CLEAR : GS_ORDER_OUT.

      MOVE-CORRESPONDING GS_ORDER TO GS_ORDER_OUT.



      "##### MODIF

      PERFORM ZMTART_T USING GS_ORDER-ZMTART CHANGING GS_ORDER_OUT-ZMTART_T.



      "#### MODIF & ### ####

      CASE GS_ORDER-ZSALE_FG.

        WHEN '1'.

          GS_ORDER_OUT-ZSALE_FG_T = '##'.

          GS_ORDER_OUT-ICON = '@08@'. "##

        WHEN '2'.

          GS_ORDER_OUT-ZSALE_FG_T = '##'.

          GS_ORDER_OUT-ICON = '@0A@'."##

      ENDCASE.



      "#### MODIF

      PERFORM ZRET_FG_T USING GS_ORDER-ZRET_FG CHANGING GS_ORDER_OUT-ZRET_FG_T.



      APPEND GS_ORDER_OUT TO GT_ORDER_OUT.

    ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SELECT_DELIVER

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SELECT_DELIVER .

  SELECT *

    FROM ZEDT15_101

    INTO CORRESPONDING FIELDS OF TABLE GT_DELIVER

    WHERE ZIDCODE IN S_ZID

    AND ZORDNO IN S_ZORDNO

    AND ZMATNR IN S_ZMATNR

    AND ZDDATE IN S_ZDDATE

    AND ZFLAG IN R_ZFG.

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

    LOOP AT GT_DELIVER INTO GS_DELIVER.

      CLEAR : GS_DELIVER_OUT.

      MOVE-CORRESPONDING GS_DELIVER TO GS_DELIVER_OUT.



      "### ####

      CASE GS_DELIVER-ZFLAG.

        WHEN C_X.

          GS_DELIVER_OUT-ICON = '@0A@'. "##

        WHEN C_A.

          GS_DELIVER_OUT-ICON = '@08@'. "##

        ENDCASE.



      "##### MODIF

      PERFORM ZMTART_T USING GS_DELIVER-ZMTART CHANGING GS_DELIVER_OUT-ZMTART_T.



      "#### MODIF

      CASE GS_DELIVER-ZDFLAG.

        WHEN '1'.

          GS_DELIVER_OUT-ZDFLAG_T = '####'.

        WHEN '2'.

          GS_DELIVER_OUT-ZDFLAG_T = '###'.

        WHEN '3'.

          GS_DELIVER_OUT-ZDFLAG_T = '####'.

      ENDCASE.



      "#### MODIF

      PERFORM ZDGUBUN_T USING GS_DELIVER-ZDGUBUN CHANGING GS_DELIVER_OUT-ZDGUBUN_T.



      APPEND GS_DELIVER_OUT TO GT_DELIVER_OUT.

    ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ZMTART_T

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_ORDER_ZMTART  text

*      <--P_GS_ORDER_OUT_ZMTART_T  text

*----------------------------------------------------------------------*




FORM ZMTART_T  USING    P_ZMTART

               CHANGING P_ZMTART_T.



      CASE P_ZMTART.

      WHEN '001'.

        P_ZMTART_T = '##'.

      WHEN '002'.

        P_ZMTART_T = '##'.

      WHEN '003'.

        P_ZMTART_T = '##'.

      WHEN '004'.

        P_ZMTART_T = '##'.

      WHEN '005'.

        P_ZMTART_T = '##'.

      WHEN '006'.

        P_ZMTART_T = '###'.

      ENDCASE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ZRET_FG_T

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_ORDER_ZRET_FG  text

*      <--P_GS_ORDER_OUT_ZRET_FG_T  text

*----------------------------------------------------------------------*




FORM ZRET_FG_T  USING    P_ZRET_FG

                CHANGING P_ZRET_FG_T.



    CASE P_ZRET_FG.

      WHEN '1'.

        P_ZRET_FG_T = '####'.

      WHEN '2'.

        P_ZRET_FG_T = '####'.

      WHEN '3'.

        P_ZRET_FG_T = '####'.

      WHEN ''.

        P_ZRET_FG_T = ''.

      ENDCASE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ZDGUBUN_T

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_DELIVER_ZDGUBUN  text

*      <--P_GS_DELIVER_OUT_ZDGUBUN_T  text

*----------------------------------------------------------------------*




FORM ZDGUBUN_T  USING    P_ZDGUBUN

                CHANGING P_ZDGUBUN_T.



    CASE P_ZDGUBUN.

      WHEN '1'.

        P_ZDGUBUN_T = '###'.

      WHEN '2'.

        P_ZDGUBUN_T = '###'.

      WHEN '3'.

        P_ZDGUBUN_T = '###'.

      WHEN '4'.

        P_ZDGUBUN_T = '###'.

      WHEN '5'.

        P_ZDGUBUN_T = '###'.

      WHEN '6'.

        P_ZDGUBUN_T = '###'.

      WHEN '7'.

        P_ZDGUBUN_T = '###'.

      ENDCASE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GC_GRID100  text

*----------------------------------------------------------------------*




FORM CREATE_OBJECT  USING    P_GRID TYPE REF TO CL_GUI_ALV_GRID.

CREATE OBJECT GC_DOCKING

  EXPORTING




*    PARENT                      =




    REPID                       = SY-REPID

    DYNNR                       = SY-DYNNR




*    SIDE                        = DOCK_AT_LEFT




    EXTENSION                   = 2000




*    STYLE                       =

*    LIFETIME                    = lifetime_default

*    CAPTION                     =

*    METRIC                      = 0

*    RATIO                       =

*    NO_AUTODEF_PROGID_DYNNR     =

*    NAME                        =

*  EXCEPTIONS

*    CNTL_ERROR                  = 1

*    CNTL_SYSTEM_ERROR           = 2

*    CREATE_ERROR                = 3

*    LIFETIME_ERROR              = 4

*    LIFETIME_DYNPRO_DYNPRO_LINK = 5

*    others                      = 6




    .

IF SY-SUBRC <> 0.




* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




ENDIF.



CREATE OBJECT P_GRID "100,200# ## ##### ##

  EXPORTING




*    I_SHELLSTYLE      = 0

*    I_LIFETIME        =




    I_PARENT          = GC_DOCKING




*    I_APPL_EVENTS     = space

*    I_PARENTDBG       =

*    I_APPLOGPARENT    =

*    I_GRAPHICSPARENT  =

*    I_NAME            =

*    I_FCAT_COMPLETE   = SPACE

*  EXCEPTIONS

*    ERROR_CNTL_CREATE = 1

*    ERROR_CNTL_INIT   = 2

*    ERROR_CNTL_LINK   = 3

*    ERROR_DP_CREATE   = 4

*    others            = 5




    .

IF SY-SUBRC <> 0.




* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




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

  CLEAR : GS_SORT, GT_SORT.

  GS_SORT-SPOS = 1.

  GS_SORT-FIELDNAME = 'ZIDCODE'.

  GS_SORT-UP = 'X'.

  GS_SORT-SUBTOT = 'X'.

  APPEND GS_SORT TO GT_SORT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALL_ALV

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GC_GRID100  text

*      -->P_GT_ORDEROUT  text

*----------------------------------------------------------------------*




FORM CALL_ALV  USING    P_GRID TYPE REF TO CL_GUI_ALV_GRID

                        PT_OUT TYPE STANDARD TABLE.



CALL METHOD P_GRID->SET_TABLE_FOR_FIRST_DISPLAY

  EXPORTING




*    I_BUFFER_ACTIVE               =

*    I_BYPASSING_BUFFER            =

*    I_CONSISTENCY_CHECK           =

*    I_STRUCTURE_NAME              =




    IS_VARIANT                    = GS_VARIANT

    I_SAVE                        = 'A'




*    I_DEFAULT                     = 'X'




    IS_LAYOUT                     = GS_LAYOUT




*    IS_PRINT                      =

*    IT_SPECIAL_GROUPS             =

*    IT_TOOLBAR_EXCLUDING          =

*    IT_HYPERLINK                  =

*    IT_ALV_GRAPHICS               =

*    IT_EXCEPT_QINFO               =

*    IR_SALV_ADAPTER               =




  CHANGING

    IT_OUTTAB                     = PT_OUT

    IT_FIELDCATALOG               = GT_FIELDCAT

    IT_SORT                       = GT_SORT




*    IT_FILTER                     =

*  EXCEPTIONS

*    INVALID_PARAMETER_COMBINATION = 1

*    PROGRAM_ERROR                 = 2

*    TOO_MANY_LINES                = 3

*    others                        = 4




        .

IF SY-SUBRC <> 0.




* Implement suitable error handling here




ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG_100

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG_100 .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1. "## ##

  GS_FIELDCAT-FIELDNAME = 'ICON'. "#### ITAB### #### #

  GS_FIELDCAT-COLTEXT = '##'. "##TEXT

  GS_FIELDCAT-ICON = 'X'. "### ###

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

  GS_FIELDCAT-FIELDNAME = 'ZMTART_T'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZVOLUM'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-QFIELDNAME = 'VRKME'. "####

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

  GS_FIELDCAT-EMPHASIZE = 'X'. "### ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 13.

  GS_FIELDCAT-FIELDNAME = 'ZSALE_FG_T'.

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

    GS_FIELDCAT-FIELDNAME = 'ZRET_FG_T'.

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

*&      Form  FIELD_CATALOG_200

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG_200 .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1. "## ##

  GS_FIELDCAT-FIELDNAME = 'ICON'. "#### ITAB### #### #

  GS_FIELDCAT-COLTEXT = '##'. "##TEXT

  GS_FIELDCAT-ICON = 'X'. "### ###

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

  GS_FIELDCAT-FIELDNAME = 'ZMTART_T'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZVOLUM'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-QFIELDNAME = 'VRKME'. "####

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

  GS_FIELDCAT-EMPHASIZE = 'X'. "##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'ZDFLAG_T'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 12.

  GS_FIELDCAT-FIELDNAME = 'ZDGUBUN_T'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-EMPHASIZE = 'X'. "##

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

      GS_FIELDCAT-EMPHASIZE = 'X'. "##

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

  ENDIF.



ENDFORM.