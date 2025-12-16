
*&---------------------------------------------------------------------*

*&  Include           ZEDR03_PRACTICE9_F01

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

  "### ## ##

  CLEAR GR_ZDATE.

  GR_ZDATE-SIGN = 'I'.

  GR_ZDATE-OPTION = 'BT'.

  GR_ZDATE-LOW = |{ SY-DATUM+0(4) }{ SY-DATUM+4(2) }01|.



  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

  EXPORTING

    DAY_IN                  = GR_ZDATE-LOW

   IMPORTING

     LAST_DAY_OF_MONTH       = GR_ZDATE-HIGH

   EXCEPTIONS

     DAY_IN_NO_DATE          = 1

     OTHERS                 = 2.

  APPEND GR_ZDATE.



  S_DATE-LOW = GR_ZDATE-HIGH.

  APPEND S_DATE.

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

  CREATE OBJECT GC_DOCKING

    EXPORTING




*      PARENT                      =




      REPID                       = SY-REPID "#### ID

      DYNNR                       = SY-DYNNR "### ##"




*      SIDE                        = DOCK_AT_LEFT




      EXTENSION                   = 2000




*      STYLE                       =

*      LIFETIME                    = lifetime_default

*      CAPTION                     =

*      METRIC                      = 0

*      RATIO                       =

*      NO_AUTODEF_PROGID_DYNNR     =

*      NAME                        =

*    EXCEPTIONS

*      CNTL_ERROR                  = 1

*      CNTL_SYSTEM_ERROR           = 2

*      CREATE_ERROR                = 3

*      LIFETIME_ERROR              = 4

*      LIFETIME_DYNPRO_DYNPRO_LINK = 5

*      others                      = 6




      .

  IF SY-SUBRC <> 0.




*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.



  "##(## ####)

  CREATE OBJECT GC_SPLITTER_MAIN

    EXPORTING




*      LINK_DYNNR        =

*      LINK_REPID        =

*      SHELLSTYLE        =

*      LEFT              =

*      TOP               =

*      WIDTH             =

*      HEIGHT            =

*      METRIC            = cntl_metric_dynpro

*      ALIGN             = 15




      PARENT            = GC_DOCKING

      ROWS              = 2

      COLUMNS           = 1




*      NO_AUTODEF_PROGID_DYNNR =

*      NAME              =

*    EXCEPTIONS

*      CNTL_ERROR        = 1

*      CNTL_SYSTEM_ERROR = 2

*      others            = 3




      .

  IF SY-SUBRC <> 0.




*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.



  "## ##### # ## #### ##

   CALL METHOD GC_SPLITTER_MAIN->GET_CONTAINER

    EXPORTING

      ROW       = 1

      COLUMN    = 1

    RECEIVING

      CONTAINER = GC_CONTAINER_TOP.



   CALL METHOD GC_SPLITTER_MAIN->GET_CONTAINER

    EXPORTING

      ROW       = 2

      COLUMN    = 1

    RECEIVING

      CONTAINER = GC_CONTAINER_BOTTOM.



  "## #### (## : ## ####)

  CREATE OBJECT GC_SPLITTER_TOP

    EXPORTING




*      LINK_DYNNR        =

*      LINK_REPID        =

*      SHELLSTYLE        =

*      LEFT              =

*      TOP               =

*      WIDTH             =

*      HEIGHT            =

*      METRIC            = cntl_metric_dynpro

*      ALIGN             = 15




      PARENT            = GC_CONTAINER_TOP

      ROWS              = 1

      COLUMNS           = 2




*      NO_AUTODEF_PROGID_DYNNR =

*      NAME              =

*    EXCEPTIONS

*      CNTL_ERROR        = 1

*      CNTL_SYSTEM_ERROR = 2

*      others            = 3




      .

  IF SY-SUBRC <> 0.




*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.



  "## ##### ## #### ##

   CALL METHOD GC_SPLITTER_TOP->GET_CONTAINER

    EXPORTING

      ROW       = 1

      COLUMN    = 2

    RECEIVING

      CONTAINER = GC_CONTAINER_TOP_RIGHT.



   CALL METHOD GC_SPLITTER_TOP->GET_CONTAINER

    EXPORTING

      ROW       = 1

      COLUMN    = 1

    RECEIVING

      CONTAINER = GC_CONTAINER_TOP_LEFT.



  "### ##

  CREATE OBJECT GC_GRID_TOP_LEFT

    EXPORTING




*        I_SHELLSTYLE      = 0

*        I_LIFETIME        =




        I_PARENT          = GC_CONTAINER_TOP_LEFT.




*        I_APPL_EVENTS     = space

*        I_PARENTDBG       =

*        I_APPLOGPARENT    =

*        I_GRAPHICSPARENT  =

*        I_NAME            =

*        I_FCAT_COMPLETE   = SPACE

*      EXCEPTIONS

*        ERROR_CNTL_CREATE = 1

*        ERROR_CNTL_INIT   = 2

*        ERROR_CNTL_LINK   = 3

*        ERROR_DP_CREATE   = 4

*        others            = 5




        .

    IF SY-SUBRC <> 0.




*     MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*                WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




    ENDIF.



  CREATE OBJECT GC_GRID_TOP_RIGHT

    EXPORTING




*        I_SHELLSTYLE      = 0

*        I_LIFETIME        =




        I_PARENT          = GC_CONTAINER_TOP_RIGHT.




*        I_APPL_EVENTS     = space

*        I_PARENTDBG       =

*        I_APPLOGPARENT    =

*        I_GRAPHICSPARENT  =

*        I_NAME            =

*        I_FCAT_COMPLETE   = SPACE

*      EXCEPTIONS

*        ERROR_CNTL_CREATE = 1

*        ERROR_CNTL_INIT   = 2

*        ERROR_CNTL_LINK   = 3

*        ERROR_DP_CREATE   = 4

*        others            = 5




        .

    IF SY-SUBRC <> 0.




*     MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*                WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




    ENDIF.



  CREATE OBJECT GC_GRID_BOTTOM

    EXPORTING




*        I_SHELLSTYLE      = 0

*        I_LIFETIME        =




        I_PARENT          = GC_CONTAINER_BOTTOM.




*        I_APPL_EVENTS     = space

*        I_PARENTDBG       =

*        I_APPLOGPARENT    =

*        I_GRAPHICSPARENT  =

*        I_NAME            =

*        I_FCAT_COMPLETE   = SPACE

*      EXCEPTIONS

*        ERROR_CNTL_CREATE = 1

*        ERROR_CNTL_INIT   = 2

*        ERROR_CNTL_LINK   = 3

*        ERROR_DP_CREATE   = 4

*        others            = 5




        .

    IF SY-SUBRC <> 0.




*     MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*                WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




    ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATATOG

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATATOG .

  PERFORM CONTAINER_FIELD1.

  PERFORM CONTAINER_FIELD2.

  PERFORM CONTAINER_FIELD3.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CONTAINER_FIELD1

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CONTAINER_FIELD1 .

  CLEAR GT_FIELDCAT1.



  CLEAR GS_FIELDCAT.  GS_FIELDCAT-COL_POS = 1.  GS_FIELDCAT-FIELDNAME = 'ZCOLOR'.      GS_FIELDCAT-COLTEXT = '##'.   APPEND GS_FIELDCAT TO GT_FIELDCAT1.

  CLEAR GS_FIELDCAT.  GS_FIELDCAT-COL_POS = 2.  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.      GS_FIELDCAT-COLTEXT = '####'.   GS_FIELDCAT-KEY = C_X. APPEND GS_FIELDCAT TO GT_FIELDCAT1.

  CLEAR GS_FIELDCAT. GS_FIELDCAT-COL_POS = 3.  GS_FIELDCAT-FIELDNAME = 'ZPNAME'.      GS_FIELDCAT-COLTEXT = '##'.  APPEND GS_FIELDCAT TO GT_FIELDCAT1.

  CLEAR GS_FIELDCAT. GS_FIELDCAT-COL_POS = 4.  GS_FIELDCAT-FIELDNAME = 'ZDEPCODE_KR'.  GS_FIELDCAT-COLTEXT = '##'.     APPEND GS_FIELDCAT TO GT_FIELDCAT1.

  CLEAR GS_FIELDCAT. GS_FIELDCAT-COL_POS = 5.  GS_FIELDCAT-FIELDNAME = 'DATBI'.  GS_FIELDCAT-COLTEXT = '####'.     APPEND GS_FIELDCAT TO GT_FIELDCAT1.

  CLEAR GS_FIELDCAT. GS_FIELDCAT-COL_POS = 6.  GS_FIELDCAT-FIELDNAME = 'DATAB'.      GS_FIELDCAT-COLTEXT = '####'.     APPEND GS_FIELDCAT TO GT_FIELDCAT1.

  CLEAR GS_FIELDCAT. GS_FIELDCAT-COL_POS = 7.  GS_FIELDCAT-FIELDNAME = 'ZDEPRANK_KR'.    GS_FIELDCAT-COLTEXT = '##'.   APPEND GS_FIELDCAT TO GT_FIELDCAT1.

  CLEAR GS_FIELDCAT.  GS_FIELDCAT-COL_POS = 8.  GS_FIELDCAT-FIELDNAME = 'ZGENDER_KR'.   GS_FIELDCAT-COLTEXT = '##'.       APPEND GS_FIELDCAT TO GT_FIELDCAT1.

  CLEAR GS_FIELDCAT. GS_FIELDCAT-COL_POS = 9.  GS_FIELDCAT-FIELDNAME = 'ZEDATE'.    GS_FIELDCAT-COLTEXT = '####'.       APPEND GS_FIELDCAT TO GT_FIELDCAT1.

  CLEAR GS_FIELDCAT. GS_FIELDCAT-COL_POS = 10. GS_FIELDCAT-FIELDNAME = 'ZADDRESS'.   GS_FIELDCAT-COLTEXT = '##'.   APPEND GS_FIELDCAT TO GT_FIELDCAT1.

  CLEAR  GS_FIELDCAT. GS_FIELDCAT-COL_POS = 11. GS_FIELDCAT-FIELDNAME = 'ZQDATE'. GS_FIELDCAT-COLTEXT = '####'.     APPEND GS_FIELDCAT TO GT_FIELDCAT1.

  CLEAR GS_FIELDCAT. GS_FIELDCAT-COL_POS = 12. GS_FIELDCAT-FIELDNAME = 'ZQFLAG'.    GS_FIELDCAT-COLTEXT = '####'.   APPEND GS_FIELDCAT TO GT_FIELDCAT1.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CONTAINER_FIELD2

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CONTAINER_FIELD2 .

  CLEAR GT_FIELDCAT2.



  CLEAR GS_FIELDCAT.  GS_FIELDCAT-COL_POS = 1.  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.      GS_FIELDCAT-COLTEXT = '####'.   GS_FIELDCAT-KEY = C_X. APPEND GS_FIELDCAT TO GT_FIELDCAT2.

  CLEAR GS_FIELDCAT.  GS_FIELDCAT-COL_POS = 2.  GS_FIELDCAT-FIELDNAME = 'ZDEPCODE_KR'.      GS_FIELDCAT-COLTEXT = '##'.    APPEND GS_FIELDCAT TO GT_FIELDCAT2.

  CLEAR GS_FIELDCAT. GS_FIELDCAT-COL_POS = 3.  GS_FIELDCAT-FIELDNAME = 'ZYEAR'.      GS_FIELDCAT-COLTEXT = '##'.  APPEND GS_FIELDCAT TO GT_FIELDCAT2.

  CLEAR GS_FIELDCAT. GS_FIELDCAT-COL_POS = 4.  GS_FIELDCAT-FIELDNAME = 'DATBI'.  GS_FIELDCAT-COLTEXT = '####'.     APPEND GS_FIELDCAT TO GT_FIELDCAT2.

  CLEAR GS_FIELDCAT. GS_FIELDCAT-COL_POS = 5.  GS_FIELDCAT-FIELDNAME = 'DATAB'.  GS_FIELDCAT-COLTEXT = '####'.     APPEND GS_FIELDCAT TO GT_FIELDCAT2.

  CLEAR GS_FIELDCAT. GS_FIELDCAT-COL_POS = 6.  GS_FIELDCAT-FIELDNAME = 'ZRANK'.      GS_FIELDCAT-COLTEXT = '##'.     APPEND GS_FIELDCAT TO GT_FIELDCAT2.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CONTAINER_FIELD3

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CONTAINER_FIELD3 .

  CLEAR GT_FIELDCAT3.



  CLEAR GS_FIELDCAT.  GS_FIELDCAT-COL_POS = 1.  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.      GS_FIELDCAT-COLTEXT = '####'.   GS_FIELDCAT-KEY = C_X. APPEND GS_FIELDCAT TO GT_FIELDCAT3.

  CLEAR GS_FIELDCAT.  GS_FIELDCAT-COL_POS = 2.  GS_FIELDCAT-FIELDNAME = 'ZYEAR'.      GS_FIELDCAT-COLTEXT = '##'.    APPEND GS_FIELDCAT TO GT_FIELDCAT3.

  CLEAR GS_FIELDCAT. GS_FIELDCAT-COL_POS = 3.  GS_FIELDCAT-FIELDNAME = 'DATBI'.      GS_FIELDCAT-COLTEXT = '####'.  APPEND GS_FIELDCAT TO GT_FIELDCAT3.

  CLEAR GS_FIELDCAT. GS_FIELDCAT-COL_POS = 4.  GS_FIELDCAT-FIELDNAME = 'DATAB'.  GS_FIELDCAT-COLTEXT = '####'.     APPEND GS_FIELDCAT TO GT_FIELDCAT3.

  CLEAR GS_FIELDCAT. GS_FIELDCAT-COL_POS = 5.  GS_FIELDCAT-FIELDNAME = 'ZSALARY'.  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-DO_SUM = 'X'.

  GS_FIELDCAT-OUTPUTLEN = 15. "## #### ##!

    APPEND GS_FIELDCAT TO GT_FIELDCAT3.

  CLEAR GS_FIELDCAT. GS_FIELDCAT-COL_POS = 6.  GS_FIELDCAT-FIELDNAME = 'ZBANKCODE_KR'.      GS_FIELDCAT-COLTEXT = '###'.     APPEND GS_FIELDCAT TO GT_FIELDCAT3.

  CLEAR GS_FIELDCAT. GS_FIELDCAT-COL_POS = 7.  GS_FIELDCAT-FIELDNAME = 'ZACCOUNT'.      GS_FIELDCAT-COLTEXT = '####'.     APPEND GS_FIELDCAT TO GT_FIELDCAT3.



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

  GS_LAYOUT-TOTALS_BEF = 'X'.

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

  GS_SORT-FIELDNAME = 'ZPERNR'.

  GS_SORT-UP = 'X'.

  APPEND GS_SORT TO GT_SORT.

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




*  PERFORM RANGES_CONTROL.




  PERFORM GET_DATA1.

  PERFORM GET_DATA2.

  PERFORM GET_DATA3.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA1

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA1 .

" 1# ### : ####, ###### ###




*DATA : BEGIN OF GS_EMP1,

*    ZCOLOR TYPE C LENGTH 4, "### ## ##

*    ZPERNR LIKE ZEDT03_102-ZPERNR, "####

*    ZPNAME LIKE ZEDT03_103-ZPNAME, "####

*    ZDEPCODE LIKE ZEDT03_102-ZDEPCODE, "####

*    ZDEPCODE_KR TYPE C LENGTH 20, "#####

*    DATBI LIKE ZEDT03_106-DATBI, "####

*    DATAB LIKE ZEDT03_106-DATAB, "####

*    ZDEPRANK LIKE ZEDT03_102-ZDEPRANK, "####

*    ZDEPRANK_KR TYPE C LENGTH 20, "#####

*    ZGENDER LIKE ZEDT03_103-ZGENDER, "##

*    ZGENDER_KR TYPE C LENGTH 20, "###

*    ZEDATE LIKE ZEDT03_102-ZEDATE, "####

*    ZADDRESS LIKE ZEDT03_103-ZADDRESS, "##

*    ZQDATE LIKE ZEDT03_102-ZQDATE, "####

*    ZQFLAG LIKE ZEDT03_102-ZQFLAG, "####

*  END OF GS_EMP1.

*DATA : GT_EMP1 LIKE TABLE OF GS_EMP1.




  CLEAR GT_EMP1.

  IF P_CH1 = 'X'.

    SELECT

    T1~ZPERNR,

    T2~ZPNAME,

    T1~ZDEPCODE,

    T3~DATBI,

    T3~DATAB,

    T1~ZDEPRANK,

    T2~ZGENDER,

    T1~ZEDATE,

    T2~ZADDRESS,

    T1~ZQDATE,

    T1~ZQFLAG

      FROM ZEDT03_102 AS T1

      INNER JOIN ZEDT03_103 AS T2 ON T1~ZPERNR = T2~ZPERNR

      INNER JOIN ZEDT03_106 AS T3 ON T1~ZPERNR = T3~ZPERNR

      INTO CORRESPONDING FIELDS OF TABLE @GT_EMP1

      WHERE T3~DATBI <= @S_DATE-LOW

      AND T3~DATAB >= @S_DATE-LOW

      AND T1~ZPERNR IN @S_ZPERNR

      AND T1~ZDEPCODE IN @S_DEPT

      AND ( T1~ZQDATE >= @S_DATE-LOW OR T1~ZQDATE = '00000000' OR T1~ZQDATE IS NULL ).

   ELSE.

    SELECT

      T1~ZPERNR,

      T2~ZPNAME,

      T1~ZDEPCODE,

      T3~DATBI,

      T3~DATAB,

      T1~ZDEPRANK,

      T2~ZGENDER,

      T1~ZEDATE,

      T2~ZADDRESS,

      T1~ZQDATE,

      T1~ZQFLAG

      FROM ZEDT03_102 AS T1

      INNER JOIN ZEDT03_103 AS T2 ON T1~ZPERNR = T2~ZPERNR

      INNER JOIN ZEDT03_106 AS T3 ON T1~ZPERNR = T3~ZPERNR

      INTO CORRESPONDING FIELDS OF TABLE @GT_EMP1

      WHERE T3~DATBI <= @S_DATE-LOW

      AND T3~DATAB >= @S_DATE-LOW

      AND T1~ZPERNR IN @S_ZPERNR

      AND T1~ZDEPCODE IN @S_DEPT

      AND T1~ZQFLAG = ' '.

   ENDIF.



   IF GT_EMP1 IS INITIAL.

     MESSAGE E001.

     EXIT.

   ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA2

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA2 .

  " 2# ### : ####




*DATA : BEGIN OF GS_EMP2,

*    ZPERNR LIKE ZEDT03_104-ZPERNR, "####

*    ZDEPCODE LIKE ZEDT03_104-ZDEPCODE, "####

*    ZDEPCODE_KR TYPE C LENGTH 20, "#####

*    ZYEAR LIKE ZEDT03_104-ZYEAR, "##

*    DATBI LIKE ZEDT03_104-DATBI, "####

*    DATAB LIKE ZEDT03_104-DATAB, "####

*    ZRANK LIKE ZEDT03_104-ZRANK, "####

*  END OF GS_EMP2.




  CLEAR GT_EMP2.

  IF P_CH1 = 'X'.

    SELECT

      T1~ZPERNR,

      T1~ZDEPCODE,

      T1~ZYEAR,

      T1~DATBI,

      T1~DATAB,

      T1~ZRANK

      FROM ZEDT03_104 AS T1

      INNER JOIN ZEDT03_102 AS T2 ON T1~ZPERNR = T2~ZPERNR

      INTO CORRESPONDING FIELDS OF TABLE @GT_EMP2

      WHERE T1~DATBI <= @S_DATE-LOW

      AND T1~DATAB >= @S_DATE-LOW

      AND T1~ZPERNR IN @S_ZPERNR

      AND T1~ZDEPCODE IN @S_DEPT

      AND ( T2~ZQDATE >= @S_DATE-LOW OR T2~ZQDATE = '00000000' OR T2~ZQDATE IS NULL ).

   ELSE.

    SELECT

      T1~ZPERNR,

      T1~ZDEPCODE,

      T1~ZYEAR,

      T1~DATBI,

      T1~DATAB,

      T1~ZRANK

      FROM ZEDT03_104 AS T1

      INNER JOIN ZEDT03_102 AS T2 ON T1~ZPERNR = T2~ZPERNR

      INTO CORRESPONDING FIELDS OF TABLE @GT_EMP2

      WHERE T1~DATBI <= @S_DATE-LOW

      AND T1~DATAB >= @S_DATE-LOW

      AND T1~ZPERNR IN @S_ZPERNR

      AND T1~ZDEPCODE IN @S_DEPT

      AND T2~ZQFLAG = ' '.

   ENDIF.



   IF GT_EMP2 IS INITIAL.

     MESSAGE E001.

     EXIT.

   ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA3

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA3 .

" 3# ### : #### ###




*DATA : BEGIN OF GS_EMP3,

*    ZPERNR LIKE ZEDT03_106-ZPERNR, "####

*    ZYEAR LIKE ZEDT03_106-ZYEAR, "##

*    DATBI LIKE ZEDT03_106-DATBI, "####

*    DATAB LIKE ZEDT03_106-DATAB, "####

*    ZSALARY LIKE ZEDT03_106-ZSALARY, "####

*    ZBANKCODE LIKE ZEDT03_106-ZBANKCODE, "####

*    ZBANKCODE_KR TYPE C LENGTH 20, "#####

*    ZACCOUNT LIKE ZEDT03_106-ZACCOUNT, "####

*  END OF GS_EMP3.




  CLEAR GT_EMP3.

  IF P_CH1 = 'X'.

    SELECT

      T1~ZPERNR,

      T1~ZYEAR,

      T1~DATBI,

      T1~DATAB,

      T1~ZSALARY,

      T1~ZBANKCODE,

      T1~ZACCOUNT

      FROM ZEDT03_106 AS T1

      INNER JOIN ZEDT03_102 AS T2 ON T1~ZPERNR = T2~ZPERNR

      INTO CORRESPONDING FIELDS OF TABLE @GT_EMP3

      WHERE T1~DATBI <= @S_DATE-LOW

      AND T1~DATAB >= @S_DATE-LOW

      AND T1~ZPERNR IN @S_ZPERNR

      AND T2~ZDEPCODE IN @S_DEPT

      AND ( T2~ZQDATE >= @S_DATE-LOW OR T2~ZQDATE = '00000000' OR T2~ZQDATE IS NULL ).

   ELSE.

    SELECT

      T1~ZPERNR,

      T1~ZYEAR,

      T1~DATBI,

      T1~DATAB,

      T1~ZSALARY,

      T1~ZBANKCODE,

      T1~ZACCOUNT

      FROM ZEDT03_106 AS T1

      INNER JOIN ZEDT03_102 AS T2 ON T1~ZPERNR = T2~ZPERNR

      INTO CORRESPONDING FIELDS OF TABLE @GT_EMP3

      WHERE T1~DATBI <= @S_DATE-LOW

      AND T1~DATAB >= @S_DATE-LOW

      AND T1~ZPERNR IN @S_ZPERNR

      AND T2~ZDEPCODE IN @S_DEPT

      AND T2~ZQFLAG = ' '.

   ENDIF.



   IF GT_EMP3 IS INITIAL.

     MESSAGE E001.

     EXIT.

   ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_DATA .

  PERFORM MODIFY_DATA1.

  PERFORM MODIFY_DATA2.

  PERFORM MODIFY_DATA3.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA1

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_DATA1 .

  LOOP AT GT_EMP1 INTO GS_EMP1.

    PERFORM MODIFY_ZCOLOR USING GS_EMP1. "### ####

    PERFORM MODIFY_ZDEPCODE USING GS_EMP1. "### ##

    PERFORM MODIFY_ZDEPRANK USING GS_EMP1. "### ##

    PERFORM MODIFY_ZGENDER USING GS_EMP1. "## ##

    MODIFY GT_EMP1 FROM GS_EMP1 INDEX SY-TABIX.

    CLEAR GS_EMP1.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA2

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_DATA2 .

  LOOP AT GT_EMP2 INTO GS_EMP2.

    PERFORM MODIFY_ZDEPCODE2 USING GS_EMP2. "### ##

    MODIFY GT_EMP2 FROM GS_EMP2 INDEX SY-TABIX.

    CLEAR GS_EMP2.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA3

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_DATA3 .

  LOOP AT GT_EMP3 INTO GS_EMP3.

    PERFORM MODIFY_ZBANKCODE USING GS_EMP3. "### ##

    PERFORM SET_CURRENCY USING GS_EMP3-ZBANKCODE "##### ## ## ##

                         CHANGING GS_EMP3-ZWAERS.

    MODIFY GT_EMP3 FROM GS_EMP3 INDEX SY-TABIX.

    CLEAR GS_EMP3.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_ZDEPCODE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_EMP1  text

*----------------------------------------------------------------------*




FORM MODIFY_ZDEPCODE  USING    P_GS_EMP1 STRUCTURE GS_EMP1.

  CASE P_GS_EMP1-ZDEPCODE.

    WHEN 'SS0001'.

      P_GS_EMP1-ZDEPCODE_KR = '###'.

    WHEN 'SS0002'.

      P_GS_EMP1-ZDEPCODE_KR = '###'.

    WHEN 'SS0003'.

      P_GS_EMP1-ZDEPCODE_KR = '###'.

    WHEN 'SS0004'.

      P_GS_EMP1-ZDEPCODE_KR = '###'.

    WHEN 'SS0005'.

      P_GS_EMP1-ZDEPCODE_KR = '###'.

    WHEN 'SS0006'.

      P_GS_EMP1-ZDEPCODE_KR = '###'.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_ZCOLOR

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_EMP1  text

*----------------------------------------------------------------------*




FORM MODIFY_ZCOLOR  USING    P_GS_EMP1 STRUCTURE GS_EMP1.

  IF P_GS_EMP1-ZQFLAG = 'X'.

    P_GS_EMP1-ZCOLOR = '@0A@'. "#### ## ##

  ELSE.

    IF P_GS_EMP1-ZDEPRANK = 'A'.

       P_GS_EMP1-ZCOLOR = '@09@'."### ## ##

    ELSE.

      P_GS_EMP1-ZCOLOR = '@08@'. "#### ##

    ENDIF.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_ZDEPRANK

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_EMP1  text

*----------------------------------------------------------------------*




FORM MODIFY_ZDEPRANK  USING    P_GS_EMP1 STRUCTURE GS_EMP1.

  CASE P_GS_EMP1-ZDEPRANK.

    WHEN 'A'.

      P_GS_EMP1-ZDEPRANK_KR = '##'.

    WHEN 'B'.

      P_GS_EMP1-ZDEPRANK_KR = '##'.

    WHEN 'C'.

      P_GS_EMP1-ZDEPRANK_KR = '##'.

    WHEN 'D'.

      P_GS_EMP1-ZDEPRANK_KR = '##'.

    WHEN 'E'.

      P_GS_EMP1-ZDEPRANK_KR = '##'.

    WHEN 'F'.

      P_GS_EMP1-ZDEPRANK_KR = '##'.

    WHEN 'G'.

      P_GS_EMP1-ZDEPRANK_KR = '##'.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_ZGENDER

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_EMP1  text

*----------------------------------------------------------------------*




FORM MODIFY_ZGENDER  USING    P_GS_EMP1 STRUCTURE GS_EMP1.

  CASE P_GS_EMP1-ZGENDER.

    WHEN 'M'.

      P_GS_EMP1-ZGENDER_KR = '##'.

    WHEN 'F'.

      P_GS_EMP1-ZGENDER_KR = '##'.

   ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_ZDEPCODE2

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_EMP2  text

*----------------------------------------------------------------------*




FORM MODIFY_ZDEPCODE2  USING    P_GS_EMP2 STRUCTURE GS_EMP2.

    CASE P_GS_EMP2-ZDEPCODE.

    WHEN 'SS0001'.

      P_GS_EMP2-ZDEPCODE_KR = '###'.

    WHEN 'SS0002'.

      P_GS_EMP2-ZDEPCODE_KR = '###'.

    WHEN 'SS0003'.

      P_GS_EMP2-ZDEPCODE_KR = '###'.

    WHEN 'SS0004'.

      P_GS_EMP2-ZDEPCODE_KR = '###'.

    WHEN 'SS0005'.

      P_GS_EMP2-ZDEPCODE_KR = '###'.

    WHEN 'SS0006'.

      P_GS_EMP2-ZDEPCODE_KR = '###'.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_ZBANKCODE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_EMP3  text

*----------------------------------------------------------------------*




FORM MODIFY_ZBANKCODE  USING    P_GS_EMP3 STRUCTURE GS_EMP3.

  CASE P_GS_EMP3-ZBANKCODE.

      WHEN '001'.

        P_GS_EMP3-ZBANKCODE_KR = '##'.

      WHEN '002'.

        P_GS_EMP3-ZBANKCODE_KR = '##'.

      WHEN '003'.

        P_GS_EMP3-ZBANKCODE_KR = '##'.

      WHEN '004'.

        P_GS_EMP3-ZBANKCODE_KR = '##'.

      WHEN '005'.

        P_GS_EMP3-ZBANKCODE_KR = '###'.

  ENDCASE.

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

  CALL METHOD GC_GRID_BOTTOM->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING




*      I_BUFFER_ACTIVE               =

*      I_BYPASSING_BUFFER            =

*      I_CONSISTENCY_CHECK           =

*      I_STRUCTURE_NAME              =

*      IS_VARIANT                    =

*      I_SAVE                        =

*      I_DEFAULT                     = 'X'




      IS_LAYOUT                     = GS_LAYOUT




*      IS_PRINT                      =

*      IT_SPECIAL_GROUPS             =

*      IT_TOOLBAR_EXCLUDING          =

*      IT_HYPERLINK                  =

*      IT_ALV_GRAPHICS               =

*      IT_EXCEPT_QINFO               =

*      IR_SALV_ADAPTER               =




    CHANGING

      IT_OUTTAB                     = GT_EMP1

      IT_FIELDCATALOG               = GT_FIELDCAT1

      IT_SORT                       = GT_SORT




*      IT_FILTER                     =

*    EXCEPTIONS

*      INVALID_PARAMETER_COMBINATION = 1

*      PROGRAM_ERROR                 = 2

*      TOO_MANY_LINES                = 3

*      others                        = 4




          .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.



  CALL METHOD GC_GRID_TOP_LEFT->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING




*      I_BUFFER_ACTIVE               =

*      I_BYPASSING_BUFFER            =

*      I_CONSISTENCY_CHECK           =

*      I_STRUCTURE_NAME              =

*      IS_VARIANT                    =

*      I_SAVE                        =

*      I_DEFAULT                     = 'X'




      IS_LAYOUT                     = GS_LAYOUT




*      IS_PRINT                      =

*      IT_SPECIAL_GROUPS             =

*      IT_TOOLBAR_EXCLUDING          =

*      IT_HYPERLINK                  =

*      IT_ALV_GRAPHICS               =

*      IT_EXCEPT_QINFO               =

*      IR_SALV_ADAPTER               =




    CHANGING

      IT_OUTTAB                     = GT_EMP2

      IT_FIELDCATALOG               = GT_FIELDCAT2

      IT_SORT                       = GT_SORT




*      IT_FILTER                     =

*    EXCEPTIONS

*      INVALID_PARAMETER_COMBINATION = 1

*      PROGRAM_ERROR                 = 2

*      TOO_MANY_LINES                = 3

*      others                        = 4




          .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.



  CALL METHOD GC_GRID_TOP_RIGHT->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING




*      I_BUFFER_ACTIVE               =

*      I_BYPASSING_BUFFER            =

*      I_CONSISTENCY_CHECK           =

*      I_STRUCTURE_NAME              =

*      IS_VARIANT                    =

*      I_SAVE                        =

*      I_DEFAULT                     = 'X'




      IS_LAYOUT                     = GS_LAYOUT




*      IS_PRINT                      =

*      IT_SPECIAL_GROUPS             =

*      IT_TOOLBAR_EXCLUDING          =

*      IT_HYPERLINK                  =

*      IT_ALV_GRAPHICS               =

*      IT_EXCEPT_QINFO               =

*      IR_SALV_ADAPTER               =




    CHANGING

      IT_OUTTAB                     = GT_EMP3

      IT_FIELDCATALOG               = GT_FIELDCAT3

      IT_SORT                       = GT_SORT




*      IT_FILTER                     =

*    EXCEPTIONS

*      INVALID_PARAMETER_COMBINATION = 1

*      PROGRAM_ERROR                 = 2

*      TOO_MANY_LINES                = 3

*      others                        = 4




          .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_CURRENCY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_EMP3_BANKCODE  text

*      <--P_GS_EMP3_ZWAERS  text

*----------------------------------------------------------------------*




FORM SET_CURRENCY  USING    P_GS_EMP3_ZBANKCODE

                   CHANGING P_GS_EMP3_ZWAERS.



  IF P_GS_EMP3_ZBANKCODE BETWEEN '001' AND '010'.

    P_GS_EMP3_ZWAERS = 'KRW'.

  ENDIF.

ENDFORM.




**&---------------------------------------------------------------------*

**&      Form  RANGES_CONTROL

**&---------------------------------------------------------------------*

**       text

**----------------------------------------------------------------------*

**  -->  p1        text

**  <--  p2        text

**----------------------------------------------------------------------*

*FORM RANGES_CONTROL .

*  CLEAR GR_ZQFLAG.

*  RANGES : LS_ZQFLAG FOR GR_ZQFLAG.

*

*  LS_ZQFLAG-SIGN = 'I'.

*  LS_ZQFLAG-OPTION = 'EQ'.

*  LS_ZQFLAG-LOW = ' '.

*  APPEND LS_ZQFLAG TO GR_ZQFLAG.

*  LS_ZQFLAG-LOW = C_X.

*  APPEND LS_ZQFLAG TO GR_ZQFLAG.

*ENDFORM.