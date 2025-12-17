
*&---------------------------------------------------------------------*

*&  Include           ZEDR03_017_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SET_INIT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_INIT .

  CLEAR GR_ZDATE.

  GR_ZDATE-SIGN = 'I'.

  GR_ZDATE-OPTION = 'BT'.

  GR_ZDATE-LOW = |{ SY-DATUM+0(4) }{ SY-DATUM+4(2) }01|.

  APPEND GR_ZDATE.



  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

  EXPORTING

    DAY_IN                  = GR_ZDATE-LOW

   IMPORTING

     LAST_DAY_OF_MONTH       = GR_ZDATE-HIGH

   EXCEPTIONS

     DAY_IN_NO_DATE          = 1

     OTHERS                 = 2.

  APPEND GR_ZDATE.



  S_ZJDATE-LOW = GR_ZDATE-LOW.

  S_ZJDATE-HIGH = GR_ZDATE-HIGH .

  APPEND S_ZJDATE.

  S_ZDDATE-LOW = GR_ZDATE-LOW.

  S_ZDDATE-HIGH = GR_ZDATE-HIGH .

  APPEND S_ZDDATE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA .



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CREATE_OBJECT .

IF SY-DYNNR = '0100'.

  IF GC_DOCKING IS NOT BOUND.

    CREATE OBJECT GC_DOCKING

      EXPORTING




*        PARENT                      =




        REPID                       = 'ZEDR03_PRACTICE008' "#### ID

        DYNNR                       = SY-DYNNR "### ##"




*        SIDE                        = DOCK_AT_LEFT




        EXTENSION                   = 2000




*        STYLE                       =

*        LIFETIME                    = lifetime_default

*        CAPTION                     =

*        METRIC                      = 0

*        RATIO                       =

*        NO_AUTODEF_PROGID_DYNNR     =

*        NAME                        =

*      EXCEPTIONS

*        CNTL_ERROR                  = 1

*        CNTL_SYSTEM_ERROR           = 2

*        CREATE_ERROR                = 3

*        LIFETIME_ERROR              = 4

*        LIFETIME_DYNPRO_DYNPRO_LINK = 5

*        others                      = 6




        .

    IF SY-SUBRC <> 0.




*     MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*                WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




    ENDIF.



  ENDIF.



  IF GC_GRID IS NOT BOUND.

    CREATE OBJECT GC_GRID

     EXPORTING




*       I_SHELLSTYLE      = 0

*       I_LIFETIME        =




       I_PARENT          = GC_DOCKING




*       I_APPL_EVENTS     = space

*       I_PARENTDBG       =

*       I_APPLOGPARENT    =

*       I_GRAPHICSPARENT  =

*       I_NAME            =

*       I_FCAT_COMPLETE   = SPACE

*     EXCEPTIONS

*       ERROR_CNTL_CREATE = 1

*       ERROR_CNTL_INIT   = 2

*       ERROR_CNTL_LINK   = 3

*       ERROR_DP_CREATE   = 4

*       others            = 5




       .

   IF SY-SUBRC <> 0.




*    MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*               WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




   ENDIF.

  ENDIF.

ELSEIF SY-DYNNR = '0200'.

  IF GC_DOCKING2 IS NOT BOUND.

    CREATE OBJECT GC_DOCKING2

      EXPORTING




*        PARENT                      =




        REPID                       = 'ZEDR03_PRACTICE008' "#### ID

        DYNNR                       = SY-DYNNR "### ##"




*        SIDE                        = DOCK_AT_LEFT




        EXTENSION                   = 2000




*        STYLE                       =

*        LIFETIME                    = lifetime_default

*        CAPTION                     =

*        METRIC                      = 0

*        RATIO                       =

*        NO_AUTODEF_PROGID_DYNNR     =

*        NAME                        =

*      EXCEPTIONS

*        CNTL_ERROR                  = 1

*        CNTL_SYSTEM_ERROR           = 2

*        CREATE_ERROR                = 3

*        LIFETIME_ERROR              = 4

*        LIFETIME_DYNPRO_DYNPRO_LINK = 5

*        others                      = 6




        .

    IF SY-SUBRC <> 0.




*     MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*                WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




    ENDIF.



  ENDIF.

  IF GC_GRID2 IS NOT BOUND.

     CREATE OBJECT GC_GRID2

     EXPORTING




*       I_SHELLSTYLE      = 0

*       I_LIFETIME        =




       I_PARENT          = GC_DOCKING2




*       I_APPL_EVENTS     = space

*       I_PARENTDBG       =

*       I_APPLOGPARENT    =

*       I_GRAPHICSPARENT  =

*       I_NAME            =

*       I_FCAT_COMPLETE   = SPACE

*     EXCEPTIONS

*       ERROR_CNTL_CREATE = 1

*       ERROR_CNTL_INIT   = 2

*       ERROR_CNTL_LINK   = 3

*       ERROR_DP_CREATE   = 4

*       others            = 5




       .

   IF SY-SUBRC <> 0.




*    MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*               WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




   ENDIF.

  ENDIF.

ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG .

"#### ###




*DATA : BEGIN OF GS_ORDER,

*  ZORDNO LIKE ZEDT03_100-ZORDNO, "####

*  ZIDCODE LIKE ZEDT03_100-ZIDCODE, "##ID

*  ZMATNR LIKE ZEDT03_100-ZMATNR , "####

*  ZMTART LIKE ZEDT03_100-ZMTART, "####

*  ZMTART_KR TYPE C LENGTH 20, "#####

*  ZMATNAME LIKE ZEDT03_100-ZMATNAME, "###

*  ZVOLUM LIKE ZEDT03_100-ZVOLUM, "##

*  VOLUM LIKE ZEDT03_100-VOLUM, "VOLUM

*  VRKME LIKE ZEDT03_100-VRKME, "Sales Unit

*  ZNSAMT LIKE ZEDT03_100-ZNSAMT, "####

*  ZSLAMT LIKE ZEDT03_100-ZSLAMT, "####

*  ZDCAMT LIKE ZEDT03_100-ZDCAMT, "####

*  ZWARS LIKE ZEDT03_100-ZWARS, "##

*  ZDC_FG LIKE ZEDT03_100-ZDC_FG, "####

*  ZSALE_FG LIKE ZEDT03_100-ZSALE_FG, "####

*  ZSALE_FG_KR TYPE C LENGTH 20, "#####

*  ZRET_FG LIKE ZEDT03_100-ZRET_FG, "####

*  ZRET_FG_KR TYPE C LENGTH 20, "#####

*  ZJDATE LIKE ZEDT03_100-ZJDATE, "####

*  ZRDATE LIKE ZEDT03_100-ZRDATE, "####

*  END OF GS_ORDER.

*DATA : GT_ORDER LIKE TABLE OF GS_ORDER.






  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZCOLOR'.

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

  GS_FIELDCAT-FIELDNAME = 'ZMTART_KR'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZVOLUM'.

  GS_FIELDCAT-COLTEXT = '##'.

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

  GS_FIELDCAT-CFIELDNAME = 'ZWARS'.

  GS_FIELDCAT-DO_SUM = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'ZSLAMT'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-CFIELDNAME = 'ZWARS'.

  GS_FIELDCAT-DO_SUM = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'ZDCAMT'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-CFIELDNAME = 'ZWARS'.

  GS_FIELDCAT-DO_SUM = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 12.

  GS_FIELDCAT-FIELDNAME = 'ZWARS'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-EMPHASIZE = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 13.

  GS_FIELDCAT-FIELDNAME = 'ZSALE_FG_KR'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 14.

  GS_FIELDCAT-FIELDNAME = 'ZJDATE'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  IF P_ZINCL = 'X'.

    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 15.

    GS_FIELDCAT-FIELDNAME = 'ZRET_FG_KR'.

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




*

*  CLEAR GS_VARIANT.

*  GS_VARIANT-REPORT = SY-REPID.

*  GS_VARIANT-USERNAME = SY-UNAME.




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





  "#### ### ## ALV# ###

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALL_ALV

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CALL_ALV .

CASE SY-DYNNR.

  WHEN '0100'.

    CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

      EXPORTING




*        I_BUFFER_ACTIVE               =

*        I_BYPASSING_BUFFER            =

*        I_CONSISTENCY_CHECK           =

*        I_STRUCTURE_NAME              =

*        IS_VARIANT                    =

*        I_SAVE                        =

*        I_DEFAULT                     = 'X'




        IS_LAYOUT                     = GS_LAYOUT




*        IS_PRINT                      =

*        IT_SPECIAL_GROUPS             =

*        IT_TOOLBAR_EXCLUDING          =

*        IT_HYPERLINK                  =

*        IT_ALV_GRAPHICS               =

*        IT_EXCEPT_QINFO               =

*        IR_SALV_ADAPTER               =




      CHANGING

        IT_OUTTAB                     = GT_ORDER

        IT_FIELDCATALOG               = GT_FIELDCAT

        IT_SORT                       = GT_SORT




*        IT_FILTER                     =

*      EXCEPTIONS

*        INVALID_PARAMETER_COMBINATION = 1

*        PROGRAM_ERROR                 = 2

*        TOO_MANY_LINES                = 3

*        others                        = 4




            .

    IF SY-SUBRC <> 0.




*     Implement suitable error handling here




    ENDIF.

  WHEN '0200'.

    CALL METHOD GC_GRID2->SET_TABLE_FOR_FIRST_DISPLAY

      EXPORTING




*        I_BUFFER_ACTIVE               =

*        I_BYPASSING_BUFFER            =

*        I_CONSISTENCY_CHECK           =

*        I_STRUCTURE_NAME              =

*        IS_VARIANT                    =

*        I_SAVE                        =

*        I_DEFAULT                     = 'X'




        IS_LAYOUT                     = GS_LAYOUT




*        IS_PRINT                      =

*        IT_SPECIAL_GROUPS             =

*        IT_TOOLBAR_EXCLUDING          =

*        IT_HYPERLINK                  =

*        IT_ALV_GRAPHICS               =

*        IT_EXCEPT_QINFO               =

*        IR_SALV_ADAPTER               =




      CHANGING

        IT_OUTTAB                     = GT_DELIVER

        IT_FIELDCATALOG               = GT_FIELDCAT2

        IT_SORT                       = GT_SORT




*        IT_FILTER                     =

*      EXCEPTIONS

*        INVALID_PARAMETER_COMBINATION = 1

*        PROGRAM_ERROR                 = 2

*        TOO_MANY_LINES                = 3

*        others                        = 4




            .

    IF SY-SUBRC <> 0.




*     Implement suitable error handling here




    ENDIF.

  ENDCASE.

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

  IF P_ZINCL = 'X'.

    SELECT *

      FROM ZEDT03_100

      INTO CORRESPONDING FIELDS OF TABLE GT_ORDER

      WHERE ZORDNO IN S_ZORDO

      AND ZIDCODE IN S_ZID

      AND ZMATNR IN S_ZMATNR

      AND ZJDATE IN S_ZJDATE.

   ELSE.

    SELECT *

      FROM ZEDT03_100

      INTO CORRESPONDING FIELDS OF TABLE GT_ORDER

      WHERE ZORDNO IN S_ZORDO

      AND ZIDCODE IN S_ZID

      AND ZMATNR IN S_ZMATNR

      AND ZJDATE IN S_ZJDATE

      AND ZSALE_FG = '1'.

   ENDIF.

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

  IF P_ZINCL = 'X'.

    SELECT *

      FROM ZEDT03_101

      INTO CORRESPONDING FIELDS OF TABLE GT_DELIVER

      WHERE ZORDNO IN S_ZORDO

        AND ZIDCODE IN S_ZID

        AND ZMATNR IN S_ZMATNR

        AND ZDDATE IN S_ZDDATE.

   ELSE.

    SELECT *

      FROM ZEDT03_101

      INTO CORRESPONDING FIELDS OF TABLE GT_DELIVER

      WHERE ZORDNO IN S_ZORDO

        AND ZIDCODE IN S_ZID

        AND ZMATNR IN S_ZMATNR

        AND ZDDATE IN S_ZDDATE

        AND ZFLAG = ' '.

   ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  MODIFY_ORDER

*&---------------------------------------------------------------------*

*




FORM MODIFY_ORDER .

  LOOP AT GT_ORDER INTO GS_ORDER.

    PERFORM MODIFY_ZCOLOR USING GS_ORDER. "### ## ##

    PERFORM MODIFY_ZMTART USING GS_ORDER. "#### ##

    PERFORM MODIFY_ZSALE USING GS_ORDER. "## ##

    PERFORM MODIFY_ZRET USING GS_ORDER. "#### ##

    MODIFY GT_ORDER FROM GS_ORDER INDEX SY-TABIX.



    CLEAR GS_ORDER.

  ENDLOOP.

ENDFORM.








*&---------------------------------------------------------------------*

*&      Form  MODIFY_ZMTART

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_ORDER  text

*----------------------------------------------------------------------*




FORM MODIFY_ZMTART  USING  P_GS_ORDER STRUCTURE GS_ORDER.

  CASE P_GS_ORDER-ZMTART.

    WHEN '001'.

      P_GS_ORDER-ZMTART_KR = '##'.

    WHEN '002'.

      P_GS_ORDER-ZMTART_KR = '##'.

    WHEN '003'.

      P_GS_ORDER-ZMTART_KR = '##'.

    WHEN '004'.

      P_GS_ORDER-ZMTART_KR = '##'.

    WHEN '005'.

      P_GS_ORDER-ZMTART_KR = '##'.

    WHEN '006'.

      P_GS_ORDER-ZMTART_KR = '###'.

    ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_ZSALE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_ORDER  text

*----------------------------------------------------------------------*




FORM MODIFY_ZSALE  USING P_GS_ORDER STRUCTURE GS_ORDER.

  CASE P_GS_ORDER-ZSALE_FG.

        WHEN '1'.

          P_GS_ORDER-ZSALE_FG_KR = '##'.

        WHEN '2'.

          P_GS_ORDER-ZSALE_FG_KR = '##'.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_ZRET

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_ORDER  text

*      -->P_ENDLOOP  text

*----------------------------------------------------------------------*




FORM MODIFY_ZRET  USING    P_GS_ORDER STRUCTURE GS_ORDER.

      CASE P_GS_ORDER-ZRET_FG.

        WHEN '1'.

          P_GS_ORDER-ZRET_FG_KR = '####'.

        WHEN '2'.

          P_GS_ORDER-ZRET_FG_KR = '####'.

        WHEN '3'.

          P_GS_ORDER-ZRET_FG_KR = '####'.

        WHEN ' '.

          P_GS_ORDER-ZRET_FG_KR = ' '.

      ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_ZCOLOR

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_ORDRR  text

*      -->P_PERFORM  text

*      -->P_MODIFY_ZMTART  text

*      -->P_GS_ORDER  text

*----------------------------------------------------------------------*




FORM MODIFY_ZCOLOR  USING    P_GS_ORDER STRUCTURE GS_ORDER.

  IF P_GS_ORDER-ZSALE_FG = '1'.

    P_GS_ORDER-ZCOLOR = '@08@'. "### ## ###

  ELSE.

    P_GS_ORDER-ZCOLOR = '@0A@'. "### ## ###

  ENDIF.



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

"#### ###




*DATA : BEGIN OF GS_DELIVER,

*  ZORDNO LIKE ZEDT03_101-ZORDNO, "####

*  ZIDCODE LIKE ZEDT03_101-ZIDCODE, "##ID

*  ZMATNR LIKE ZEDT03_101-ZMATNR , "####

*  ZMTART LIKE ZEDT03_101-ZMTART, "####

*  ZMTART_KR TYPE C LENGTH 20, "#####

*  ZMATNAME LIKE ZEDT03_101-ZMATNAME, "###

*  ZVOLUM LIKE ZEDT03_101-ZVOLUM, "##

*  VOLUM LIKE ZEDT03_101-VOLUM, "VOLUM

*  VRKME LIKE ZEDT03_101-VRKME, "Sales Unit

*  ZSLAMT LIKE ZEDT03_101-ZSLAMT, "####

*  ZWAERS LIKE ZEDT03_101-ZWAERS, "##

*  ZDFLAG LIKE ZEDT03_101-ZDFLAG, "####

*  ZDFLAG_KR TYPE C LENGTH 20, "#####

*  ZDGUBUN LIKE ZEDT03_101-ZDGUBUN, "####

*  ZDGUBUN_KR TYPE C LENGTH 20, "#####

*  ZDDATE LIKE ZEDT03_101-ZDDATE, "####

*  ZRDATE LIKE ZEDT03_101-ZRDATE, "####

*  ZFLAG LIKE ZEDT03_101-ZFLAG, "####

*  END OF GS_DELIVER.






  LOOP AT GT_DELIVER INTO GS_DELIVER.

    PERFORM MODIFY_ZCOLOR_D USING GS_DELIVER. "### ## ##

    PERFORM MODIFY_ZMTART_D USING GS_DELIVER. "#### ##

    PERFORM MODIFY_ZDFLAG USING GS_DELIVER. "#### ##

    PERFORM MODIFY_ZDGUBUN USING GS_DELIVER. "#### ##

    MODIFY GT_DELIVER FROM GS_DELIVER INDEX SY-TABIX.

    CLEAR GS_DELIVER.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_ZCOLOR_D

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_DELIVER  text

*----------------------------------------------------------------------*




FORM MODIFY_ZCOLOR_D  USING    P_GS_DELIVER STRUCTURE GS_DELIVER.

  IF P_GS_DELIVER-ZFLAG NE 'X'.

    P_GS_DELIVER-ZCOLOR = '@08@'. "### ## ###

  ELSE.

    P_GS_DELIVER-ZCOLOR = '@0A@'. "### ## ###

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_ZMTART_D

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_DELIVER  text

*----------------------------------------------------------------------*




FORM MODIFY_ZMTART_D  USING    P_GS_DELIVER STRUCTURE GS_DELIVER.

  CASE P_GS_DELIVER-ZMTART.

    WHEN '001'.

      P_GS_DELIVER-ZMTART_KR = '##'.

    WHEN '002'.

      P_GS_DELIVER-ZMTART_KR = '##'.

    WHEN '003'.

      P_GS_DELIVER-ZMTART_KR = '##'.

    WHEN '004'.

      P_GS_DELIVER-ZMTART_KR = '##'.

    WHEN '005'.

      P_GS_DELIVER-ZMTART_KR = '##'.

    WHEN '006'.

      P_GS_DELIVER-ZMTART_KR = '###'.

    ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_ZDFLAG

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_DELIVER  text

*----------------------------------------------------------------------*




FORM MODIFY_ZDFLAG  USING    P_GS_DELIVER STRUCTURE GS_DELIVER.

  CASE P_GS_DELIVER-ZDFLAG.

      WHEN '1'.

        P_GS_DELIVER-ZDFLAG_KR = '###'.

      WHEN '2'.

        P_GS_DELIVER-ZDFLAG_KR = '###'.

      WHEN '3'.

        P_GS_DELIVER-ZDFLAG_KR = '####'.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_ZDGUBUN

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_DELIVER  text

*----------------------------------------------------------------------*




FORM MODIFY_ZDGUBUN  USING    P_GS_DELIVER STRUCTURE GS_DELIVER.

  CASE P_GS_DELIVER-ZDGUBUN.

      WHEN '1'.

        P_GS_DELIVER-ZDGUBUN_KR = '###'.

      WHEN '2'.

        P_GS_DELIVER-ZDGUBUN_KR = '###'.

      WHEN '3'.

        P_GS_DELIVER-ZDGUBUN_KR = '###'.

      WHEN '4'.

        P_GS_DELIVER-ZDGUBUN_KR = '###'.

      WHEN '5'.

        P_GS_DELIVER-ZDGUBUN_KR = '###'.

      WHEN '6'.

        P_GS_DELIVER-ZDGUBUN_KR = '###'.

      WHEN '7'.

        P_GS_DELIVER-ZDGUBUN_KR = '###'.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG2

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG2 .

"#### ###




*DATA : BEGIN OF GS_DELIVER,

*  ZORDNO LIKE ZEDT03_101-ZORDNO, "####

*  ZIDCODE LIKE ZEDT03_101-ZIDCODE, "##ID

*  ZMATNR LIKE ZEDT03_101-ZMATNR , "####

*  ZMTART LIKE ZEDT03_101-ZMTART, "####

*  ZMTART_KR TYPE C LENGTH 20, "#####

*  ZMATNAME LIKE ZEDT03_101-ZMATNAME, "###

*  ZVOLUM LIKE ZEDT03_101-ZVOLUM, "##

*  VOLUM LIKE ZEDT03_101-VOLUM, "VOLUM

*  VRKME LIKE ZEDT03_101-VRKME, "Sales Unit

*  ZSLAMT LIKE ZEDT03_101-ZSLAMT, "####

*  ZWAERS LIKE ZEDT03_101-ZWAERS, "##

*  ZDFLAG LIKE ZEDT03_101-ZDFLAG, "####

*  ZDFLAG_KR TYPE C LENGTH 20, "#####

*  ZDGUBUN LIKE ZEDT03_101-ZDGUBUN, "####

*  ZDGUBUN_KR TYPE C LENGTH 20, "#####

*  ZDDATE LIKE ZEDT03_101-ZDDATE, "####

*  ZRDATE LIKE ZEDT03_101-ZRDATE, "####

*  ZFLAG LIKE ZEDT03_101-ZFLAG, "####

*  END OF GS_DELIVER.






  CLEAR : GS_FIELDCAT, GT_FIELDCAT2.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZCOLOR'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-ICON = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZORDNO'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZIDCODE'.

  GS_FIELDCAT-COLTEXT = '##ID'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZMATNR'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZMATNAME'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZMTART_KR'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZVOLUM'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'VRKME'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'ZSLAMT'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-DO_SUM = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-EMPHASIZE = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'ZDFLAG_KR'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 12.

  GS_FIELDCAT-FIELDNAME = 'ZDGUBUN_KR'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-EMPHASIZE = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 13.

  GS_FIELDCAT-FIELDNAME = 'ZDDATE'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  IF P_ZINCL = 'X'.

    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 14.

    GS_FIELDCAT-FIELDNAME = 'ZRDATE'.

    GS_FIELDCAT-COLTEXT = '####'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT2.



    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 15.

    GS_FIELDCAT-FIELDNAME = 'ZFLAG'.

    GS_FIELDCAT-COLTEXT = '####'.

    GS_FIELDCAT-EMPHASIZE = 'X'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT2.

  ENDIF.



ENDFORM.