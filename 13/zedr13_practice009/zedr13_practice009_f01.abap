
*&---------------------------------------------------------------------*

*&  Include           ZEDR13_PRACTICE009_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SET_DATE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_DATE.

  S_DATE-SIGN   = 'I'.

  S_DATE-OPTION = 'EQ'.

  S_DATE-LOW = SY-DATUM(6) && '01'.           "#### ##"

  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

    EXPORTING

      DAY_IN                  = S_DATE-LOW    "#### ##"

    IMPORTING

      LAST_DAY_OF_MONTH       = S_DATE-LOW.   "#### ####"

  APPEND S_DATE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_FG

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_FG.

  R_QFG-SIGN = 'I'.  "## ##"

  R_QFG-OPTION = 'EQ'. "LOW# ## #### ## ##"

  R_QFG-LOW = ' '. "#### ##"

  APPEND R_QFG.

  IF P1 = 'X'.      "#######"

    R_QFG-LOW = C_X. "##### ##"

    APPEND R_QFG.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MAIN

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MAIN.

  IF S_PERNR IS INITIAL AND S_DEP IS INITIAL.           "##### ##### ##### #####"

    MESSAGE S000 DISPLAY LIKE 'E'.

    STOP.

  ENDIF.

  PERFORM GET_DATA.

  PERFORM MODIFY_DATA.

  IF GT_PERINFO IS NOT INITIAL.

    CALL SCREEN 100.

  ELSE.

    MESSAGE I001.

    EXIT.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA.

  PERFORM GET_PERINFO.          "## ## ##"

  IF GT_PERINFO IS NOT INITIAL. "FOR ALL ENTRIES ## #####"

    PERFORM GET_EVALCHECK.      "## ## ##"

    PERFORM GET_SALARY.         "## ## ##"

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_PERINFO

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_PERINFO.

  SELECT *

    FROM ZEDT13_102 AS A

    INNER JOIN ZEDT13_103 AS B ON A~ZPERNR = B~ZPERNR

    WHERE A~ZPERNR IN @S_PERNR

    AND A~ZDEPCODE IN @S_DEP

    AND DATBI <= @S_DATE-LOW

    AND DATAB >= @S_DATE-LOW

    AND ZQFLAG IN @R_QFG

    INTO CORRESPONDING FIELDS OF TABLE @GT_PERINFO.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_EVALCHECK

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_EVALCHECK .

  SELECT * FROM ZEDT13_104

    INTO CORRESPONDING FIELDS OF TABLE GT_EVALCHECK

    FOR ALL ENTRIES IN GT_PERINFO

    WHERE ZPERNR = GT_PERINFO-ZPERNR

    AND ZDEPCODE = GT_PERINFO-ZDEPCODE

    AND ZYEAR = S_DATE-LOW(4)

    AND DATBI <= S_DATE-LOW

    AND DATAB >= S_DATE-LOW.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_SALARY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_SALARY.

  SELECT * FROM ZEDT13_106

    INTO CORRESPONDING FIELDS OF TABLE GT_SALARY

    FOR ALL ENTRIES IN GT_PERINFO

    WHERE ZPERNR = GT_PERINFO-ZPERNR

    AND ZYEAR = S_DATE-LOW(4)

    AND DATBI <= S_DATE-LOW

    AND DATAB >= S_DATE-LOW.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_DATA.

  PERFORM MODIFY_PERINFO.

  PERFORM MODIFY_EVALCHECK.

  PERFORM MODIFY_SALARY.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_PERINFO

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_PERINFO.

  CLEAR : GS_PERINFO.

  LOOP AT GT_PERINFO INTO GS_PERINFO.

    MOVE-CORRESPONDING GS_PERINFO TO GS_WPERINFO.



    PERFORM ZDEPNAME USING GS_PERINFO-ZDEPCODE

                     CHANGING GS_WPERINFO-ZDEPNAME.



    PERFORM ZDEPRANK USING GS_PERINFO-ZDEPRANK

                     CHANGING GS_WPERINFO-ZDEPRANK.

    CASE GS_PERINFO-ZGENDER.

    WHEN 'M'.

      GS_WPERINFO-ZGENDER = '##'.

    WHEN 'F'.

      GS_WPERINFO-ZGENDER = '##'.

    ENDCASE.

    IF GS_PERINFO-ZQFLAG = 'X'.

      GS_WPERINFO-ZICON = '@0A@'.

    ELSE.

      IF GS_PERINFO-ZDEPRANK = 'A'.

        GS_WPERINFO-ZICON = '@09@'.

      ELSE.

        GS_WPERINFO-ZICON = '@08@'.

      ENDIF.

    ENDIF.

    APPEND GS_WPERINFO TO GT_WPERINFO.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_EVALCHECK

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_EVALCHECK.

 CLEAR GS_EVALCHECK.

 LOOP AT GT_EVALCHECK INTO GS_EVALCHECK.

    MOVE-CORRESPONDING GS_EVALCHECK TO GS_WEVALCHECK.

    PERFORM ZDEPNAME USING GS_EVALCHECK-ZDEPCODE

                   CHANGING GS_WEVALCHECK-ZDEPNAME.

    APPEND GS_WEVALCHECK TO GT_WEVALCHECK.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_SALARY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_SALARY.

  CLEAR GS_SALARY.

  LOOP AT GT_SALARY INTO GS_SALARY.

    MOVE-CORRESPONDING GS_SALARY TO GS_WSALARY.

    PERFORM ZBANKNAME USING GS_SALARY-ZBANKCODE

                       CHANGING GS_WSALARY-ZBANKNAME.

    IF GS_SALARY-ZBANKCODE BETWEEN '001' AND '010'.

      GS_WSALARY-ZWAERS = 'KRW'.

    ENDIF.

    APPEND GS_WSALARY TO GT_WSALARY.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ZDEPNAME

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_PERINFO_ZDEPCODE  text

*      -->P_GS_WPERINFO_ZDEPCODE  text

*----------------------------------------------------------------------*




FORM ZDEPNAME  USING P_DEPCODE

               CHANGING P_DEPNAME.

    CASE P_DEPCODE.

      WHEN C_SS1. P_DEPNAME = '###'.

      WHEN C_SS2. P_DEPNAME = '###'.

      WHEN C_SS3. P_DEPNAME = '###'.

      WHEN C_SS4. P_DEPNAME = '###'.

      WHEN C_SS5. P_DEPNAME = '###'.

      WHEN C_SS6. P_DEPNAME = '###'.

    ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ZDEPRANK

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_PERINFO_ZDEPRANK  text

*      <--P_GS_WPERINFO_ZDEPRANK  text

*----------------------------------------------------------------------*




FORM ZDEPRANK  USING    P_DEPRANK

               CHANGING P_WDEPRANK.

  CASE P_DEPRANK.

    WHEN C_A. P_WDEPRANK = '##'.

    WHEN C_B. P_WDEPRANK = '##'.

    WHEN C_C. P_WDEPRANK = '##'.

    WHEN C_D. P_WDEPRANK = '##'.

    WHEN C_E. P_WDEPRANK = '##'.

    WHEN C_F. P_WDEPRANK = '##'.

    WHEN C_G. P_WDEPRANK = '##'.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ZBACNKNAME

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_SALARY_ZBANKCODE  text

*      <--P_GS_WSALARY_ZBACKNAME  text

*----------------------------------------------------------------------*




FORM ZBANKNAME  USING    P_BANKCODE

                 CHANGING P_BANKNAME.

  CASE P_BANKCODE.

    WHEN '001'. P_BANKNAME = '####'.

    WHEN '002'. P_BANKNAME = '####'.

    WHEN '003'. P_BANKNAME = '####'.

    WHEN '004'. P_BANKNAME = '####'.

    WHEN '005'. P_BANKNAME = '#####'.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CREATE_OBJECT.

CREATE OBJECT GC_DOCKING

  EXPORTING

    REPID                       = SY-REPID

    DYNNR                       = SY-DYNNR

    EXTENSION                   = 2000.

CREATE OBJECT GC_SPLITTER1

  EXPORTING

    PARENT            = GC_DOCKING

    ROWS              = 2          "#### ###"

    COLUMNS           = 1.



CALL METHOD GC_SPLITTER1->GET_CONTAINER

  EXPORTING

    ROW       = 1

    COLUMN    = 1

  RECEIVING

    CONTAINER = GC_CONTAINER1. "## ##, ### ##"



CALL METHOD GC_SPLITTER1->GET_CONTAINER

  EXPORTING

    ROW       = 2

    COLUMN    = 1

  RECEIVING

    CONTAINER = GC_CONTAINER2. "### ##"

CREATE OBJECT GC_SPLITTER2

  EXPORTING

    PARENT            = GC_CONTAINER1

    ROWS              = 1            "#### ###"

    COLUMNS           = 2.

CALL METHOD GC_SPLITTER2->GET_CONTAINER "## ## ##"

  EXPORTING

    ROW       = 1

    COLUMN    = 1

  RECEIVING

    CONTAINER = GC_CONTAINER3.

CALL METHOD GC_SPLITTER2->GET_CONTAINER "## ## ##"

  EXPORTING

    ROW       = 1

    COLUMN    = 2

  RECEIVING

    CONTAINER = GC_CONTAINER4.

CREATE OBJECT GC_GRID1

  EXPORTING

    I_PARENT          = GC_CONTAINER2. "### ## ##"

CREATE OBJECT GC_GRID2

  EXPORTING

    I_PARENT          = GC_CONTAINER3. "## ## ##"

CREATE OBJECT GC_GRID3

  EXPORTING

    I_PARENT          = GC_CONTAINER4. "## ## ##"

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

  PERFORM FIELD_CATALOG1.

  PERFORM FIELD_CATALOG2.

  PERFORM FIELD_CATALOG3.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG1

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG1.

CLEAR : GS_FIELDCAT, GT_FIELDCAT1.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZICON'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-ICON = C_X.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-KEY = 'X'.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZPNAME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZDEPNAME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'DATBI'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'DATAB'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZDEPRANK'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'ZGENDER'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'ZEDATE'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'ZADDRESS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  IF P1 = C_X.

    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 11.

    GS_FIELDCAT-FIELDNAME = 'ZQDATE'.

    GS_FIELDCAT-SCRTEXT_M = '####'.

    GS_FIELDCAT-OUTPUTLEN = '10'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT1.



    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 12.

    GS_FIELDCAT-FIELDNAME = 'ZQFLAG'.

    GS_FIELDCAT-SCRTEXT_M = '####'.

    GS_FIELDCAT-OUTPUTLEN = '8'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT1.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG2

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG2.

CLEAR : GS_FIELDCAT , GT_FIELDCAT2.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-KEY = 'X'.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZDEPNAME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZYEAR'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'DATBI'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'DATAB'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZRANK'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG3

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG3.

CLEAR : GS_FIELDCAT , GT_FIELDCAT3.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-KEY = 'X'.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZYEAR'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'DATBI'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'DATAB'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZSALARY'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-DO_SUM = C_X.

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-OUTPUTLEN = '15'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-NO_OUT = C_X.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZBANKNAME'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'ZACCOUNT'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



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

  GS_LAYOUT-ZEBRA = C_X.

  GS_LAYOUT-TOTALS_BEF = C_X.



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

  CLEAR : GS_SORT, GT_SORT1, GT_SORT2, GT_SORT3.

  GS_SORT-SPOS = 1.

  GS_SORT-FIELDNAME = 'ZPERNR'.

  GS_SORT-UP = C_X.

  APPEND GS_SORT TO GT_SORT1.

  APPEND GS_SORT TO GT_SORT2.

  APPEND GS_SORT TO GT_SORT3.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_DISPLAY .

CALL METHOD GC_GRID1->SET_TABLE_FOR_FIRST_DISPLAY

  EXPORTING




*    I_BUFFER_ACTIVE               =

*    I_BYPASSING_BUFFER            =

*    I_CONSISTENCY_CHECK           =

*    I_STRUCTURE_NAME              =




    IS_VARIANT                    = GS_VARIANT

    I_SAVE                        = C_A




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

    IT_OUTTAB                     = GT_WPERINFO

    IT_FIELDCATALOG               = GT_FIELDCAT1

    IT_SORT                       = GT_SORT1




*    IT_FILTER                     =

*  EXCEPTIONS

*    INVALID_PARAMETER_COMBINATION = 1

*    PROGRAM_ERROR                 = 2

*    TOO_MANY_LINES                = 3

*    others                        = 4




        .

CALL METHOD GC_GRID2->SET_TABLE_FOR_FIRST_DISPLAY

  EXPORTING




*    I_BUFFER_ACTIVE               =

*    I_BYPASSING_BUFFER            =

*    I_CONSISTENCY_CHECK           =

*    I_STRUCTURE_NAME              =




    IS_VARIANT                    = GS_VARIANT

    I_SAVE                        = C_A




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

    IT_OUTTAB                     = GT_WEVALCHECK

    IT_FIELDCATALOG               = GT_FIELDCAT2

    IT_SORT                       = GT_SORT2




*    IT_FILTER                     =

*  EXCEPTIONS

*    INVALID_PARAMETER_COMBINATION = 1

*    PROGRAM_ERROR                 = 2

*    TOO_MANY_LINES                = 3

*    others                        = 4




        .

CALL METHOD GC_GRID3->SET_TABLE_FOR_FIRST_DISPLAY

  EXPORTING




*    I_BUFFER_ACTIVE               =

*    I_BYPASSING_BUFFER            =

*    I_CONSISTENCY_CHECK           =

*    I_STRUCTURE_NAME              =




    IS_VARIANT                    = GS_VARIANT

    I_SAVE                        = C_A




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

    IT_OUTTAB                     = GT_WSALARY

    IT_FIELDCATALOG               = GT_FIELDCAT3

    IT_SORT                       = GT_SORT3




*    IT_FILTER                     =

*  EXCEPTIONS

*    INVALID_PARAMETER_COMBINATION = 1

*    PROGRAM_ERROR                 = 2

*    TOO_MANY_LINES                = 3

*    others                        = 4




        .

ENDFORM.