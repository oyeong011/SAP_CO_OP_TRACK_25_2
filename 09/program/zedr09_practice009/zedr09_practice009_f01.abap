
*&---------------------------------------------------------------------*

*&  Include           ZEDR09_PRACTICE009_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SET_DATE

*&---------------------------------------------------------------------*






"####(S_DATBI) #### : #####.####.##### ##

FORM SET_DATE .

  DATA : LV_FIRST_DATE TYPE SY-DATUM.



  "LV_FIRST_DATE : ##### + # + '01'

  CONCATENATE SY-DATUM+0(6) '01' INTO LV_FIRST_DATE.



  "S_DATBI ## (### ### ###)

  S_DATBI-SIGN = 'I'.

  S_DATBI-OPTION = 'EQ'.



  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

    EXPORTING

      DAY_IN = LV_FIRST_DATE

    IMPORTING

      LAST_DAY_OF_MONTH = S_DATBI-LOW.

  .

  APPEND S_DATBI.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CHECK_SCREEN

*&---------------------------------------------------------------------*




"### ## ##

FORM CHECK_SCREEN .

  " #### ## #### ## ## ###, #####

  IF S_PERNR[] IS INITIAL AND S_DEPCO[] IS INITIAL.

    MESSAGE I018.

    EXIT.

  ENDIF.



  "####(Z_CHECK) ## -> ### ## -> ##, ## ## ##

  "               ### -> ### ## -> ### ##

  CLEAR : GR_QFLAG.



  GR_QFLAG-SIGN = 'I'.

  GR_QFLAG-OPTION = 'EQ'.

  IF Z_CHECK = C_X. "##### ###

    GR_QFLAG-LOW = ' '. "### ## ## ##

    APPEND GR_QFLAG.

    GR_QFLAG-LOW = C_X.

    APPEND GR_QFLAG.

  ELSE.             "##### ####

    GR_QFLAG-LOW = ' '. "###

    APPEND GR_QFLAG.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SELECT_DATA

*&---------------------------------------------------------------------*






FORM SELECT_DATA .



  "1# ### -> ##### ## ####, ###### ### ####

  SELECT

    a~ZPERNR    "####

    b~ZPNAME    "####

    a~ZDEPCODE  "####

    a~DATBI     "####

    a~DATAB     "####

    a~ZDEPRANK  "####

    b~ZGENDER   "##

    a~ZEDATE    "####

    b~ZADDRESS  "##

    a~ZQDATE    "####

    a~ZQFLAG    "####

  FROM ZEDT09_102 AS a

  INNER JOIN ZEDT09_103 AS b

  ON a~ZPERNR = b~ZPERNR

  INTO CORRESPONDING FIELDS OF TABLE GT_EMP

  WHERE a~ZPERNR IN S_PERNR  "####

  AND a~ZDEPCODE IN S_DEPCO   "####

  AND ( a~DATBI <= S_DATBI-LOW AND a~DATAB >= S_DATBI-LOW ) "##### #### ## && ##### #### ##

  AND a~ZQFLAG IN GR_QFLAG. "### ## ###



  "###

  IF GT_EMP[] IS NOT INITIAL.

    "2# ### -> ####

    SELECT *

    FROM ZEDT09_104

    INTO CORRESPONDING FIELDS OF TABLE GT_ASSESS

    FOR ALL ENTRIES IN GT_EMP "## #### ###### #### GT_ASSESS ####

    WHERE ZPERNR = GT_EMP-ZPERNR.



    "3# ### -> ####

    SELECT *

    FROM ZEDT09_106

    INTO CORRESPONDING FIELDS OF TABLE GT_SALARY

    FOR ALL ENTRIES IN GT_EMP

    WHERE ZPERNR = GT_EMP-ZPERNR.

  ENDIF.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA

*&---------------------------------------------------------------------*






FORM MODIFY_DATA .



  "1# ### (####, ######)

  LOOP AT GT_EMP INTO GS_EMP.

    MOVE-CORRESPONDING GS_EMP TO GS_EMP_ALV.



    "### ####

    PERFORM CHANGE_ZDEPCODE_NAME USING GS_EMP-ZDEPCODE

                                 CHANGING GS_EMP_ALV-ZDEPCODE_NAME.

    "### ####

    PERFORM CHANGE_ZDEPRANK_NAME USING GS_EMP-ZDEPRANK

                                 CHANGING GS_EMP_ALV-ZDEPRANK_NAME.

    "## ####

    PERFORM CHANGE_ZGENDER_NAME USING GS_EMP-ZGENDER

                                CHANGING GS_EMP_ALV-ZGENDER_NAME.



    "### - #### ##, ### ##, #### ##

    IF GS_EMP-ZQFLAG = C_X.

      GS_EMP_ALV-ZCOLOR = '@0A@'. "##

    ELSEIF GS_EMP-ZDEPRANK = 'A'.

      GS_EMP_ALV-ZCOLOR = '@09@'. "##

    ELSE.

      GS_EMP_ALV-ZCOLOR = '@08@'. "##

    ENDIF.



    APPEND GS_EMP_ALV TO GT_EMP_ALV.

  ENDLOOP.



  "2# ### (####)

  LOOP AT GT_ASSESS INTO GS_ASSESS.

    MOVE-CORRESPONDING GS_ASSESS TO GS_ASSESS_ALV.



    "### ####

    PERFORM CHANGE_ZDEPCODE_NAME USING GS_ASSESS-ZDEPCODE

                                 CHANGING GS_ASSESS_ALV-ZDEPCODE_NAME.



    APPEND GS_ASSESS_ALV TO GT_ASSESS_ALV.

  ENDLOOP.



  "3# ### (####)

  LOOP AT GT_SALARY INTO GS_SALARY.

    MOVE-CORRESPONDING GS_SALARY TO GS_SALARY_ALV.



    "##### 001~010 ### ##### KRW

    IF GS_SALARY-ZBANKCODE BETWEEN '001' AND '010'.

      GS_SALARY_ALV-ZWAERS = 'KRW'.

    ENDIF.



    "### ####

    PERFORM CHANGE_ZBANKCODE_NAME USING GS_SALARY-ZBANKCODE

                                  CHANGING GS_SALARY_ALV-ZBANKCODE_NAME.



    APPEND GS_SALARY_ALV TO GT_SALARY_ALV.

  ENDLOOP.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CHANGE_ZDEPCODE_NAME

*&---------------------------------------------------------------------*




FORM CHANGE_ZDEPCODE_NAME  USING    P_GS_EMP_ZDEPCODE

                           CHANGING P_GS_EMP_ALV_ZDEPCODE_NAME.

  CASE P_GS_EMP_ZDEPCODE.

    WHEN 'SS0001'.

      P_GS_EMP_ALV_ZDEPCODE_NAME = '###'.

    WHEN 'SS0002'.

      P_GS_EMP_ALV_ZDEPCODE_NAME = '###'.

    WHEN 'SS0003'.

      P_GS_EMP_ALV_ZDEPCODE_NAME = '###'.

    WHEN 'SS0004'.

      P_GS_EMP_ALV_ZDEPCODE_NAME = '###'.

    WHEN 'SS0005'.

      P_GS_EMP_ALV_ZDEPCODE_NAME = '###'.

    WHEN 'SS0006'.

      P_GS_EMP_ALV_ZDEPCODE_NAME = '###'.

  ENDCASE.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CHANGE_ZDEPRANK_NAME

*&---------------------------------------------------------------------*




FORM CHANGE_ZDEPRANK_NAME  USING    P_GS_EMP_ZDEPRANK

                           CHANGING P_GS_EMP_ALV_ZDEPRANK_NAME.

  CASE P_GS_EMP_ZDEPRANK.

    WHEN 'A'.

      P_GS_EMP_ALV_ZDEPRANK_NAME = '##'.

    WHEN 'B'.

      P_GS_EMP_ALV_ZDEPRANK_NAME = '##'.

    WHEN 'C'.

      P_GS_EMP_ALV_ZDEPRANK_NAME = '##'.

    WHEN 'D'.

      P_GS_EMP_ALV_ZDEPRANK_NAME = '##'.

    WHEN 'E'.

      P_GS_EMP_ALV_ZDEPRANK_NAME = '##'.

    WHEN 'F'.

      P_GS_EMP_ALV_ZDEPRANK_NAME = '##'.

    WHEN 'G'.

      P_GS_EMP_ALV_ZDEPRANK_NAME = '##'.

  ENDCASE.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CHANGE_ZGENDER_NAME

*&---------------------------------------------------------------------*




FORM CHANGE_ZGENDER_NAME  USING    P_GS_EMP_ZGENDER

                          CHANGING P_GS_EMP_ALV_ZGENDER_NAME.



  CASE P_GS_EMP_ZGENDER.

    WHEN 'M'.

      P_GS_EMP_ALV_ZGENDER_NAME = '##'.

    WHEN 'F'.

      P_GS_EMP_ALV_ZGENDER_NAME = '##'.

  ENDCASE.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CHANGE_ZBANKCODE_NAME

*&---------------------------------------------------------------------*




FORM CHANGE_ZBANKCODE_NAME  USING    P_GS_SALARY_ZBANKCODE

                            CHANGING P_GS_SALARY_ALV_ZBANKCODE_NAME.

  CASE P_GS_SALARY_ZBANKCODE.

    WHEN '001'.

      P_GS_SALARY_ALV_ZBANKCODE_NAME = '##'.

    WHEN '002'.

      P_GS_SALARY_ALV_ZBANKCODE_NAME = '##'.

    WHEN '003'.

      P_GS_SALARY_ALV_ZBANKCODE_NAME = '##'.

    WHEN '004'.

      P_GS_SALARY_ALV_ZBANKCODE_NAME = '##'.

    WHEN '005'.

      P_GS_SALARY_ALV_ZBANKCODE_NAME = '###'.

  ENDCASE.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*




FORM CREATE_OBJECT .

  "1. ## #### ##

  CREATE OBJECT GC_DOCKING

    EXPORTING

      REPID                       = SY-REPID

      DYNNR                       = SY-DYNNR

      EXTENSION                   = 2000

      .



  "2. #/## #### (2# 1#), ### GC_DOCKING

  CREATE OBJECT GC_SPLITTER

    EXPORTING

       PARENT            = GC_DOCKING

       ROWS              = 2

       COLUMNS           = 1

      .



  "3. ## #### #### (1# 1#)

  CALL METHOD GC_SPLITTER->GET_CONTAINER

    EXPORTING

      ROW       = 1

      COLUMN    = 1

    RECEIVING

      CONTAINER = GC_CON_TOP

      .



  "4. ## #### #### (2# 1#)

  CALL METHOD GC_SPLITTER->GET_CONTAINER

    EXPORTING

      ROW       = 2

      COLUMN    = 1

    RECEIVING

      CONTAINER = GC_CON_BOTTOM

      .



  "5. #/# #### (1# 2#), ### ## ####

  CREATE OBJECT GC_SPLITTER_TOP

     EXPORTING

       PARENT            = GC_CON_TOP "(1,1) #### ### ## ###

       ROWS              = 1

       COLUMNS           = 2

      .



  "6. ## # #### #### (1# 1#)

  CALL METHOD GC_SPLITTER_TOP->GET_CONTAINER

    EXPORTING

      ROW       = 1

      COLUMN    = 1

    RECEIVING

      CONTAINER = GC_CON_LEFT

      .



  "7. ## # #### #### (1# 2#)

  CALL METHOD GC_SPLITTER_TOP->GET_CONTAINER

    EXPORTING

      ROW       = 1

      COLUMN    = 2

    RECEIVING

      CONTAINER = GC_CON_RIGHT

      .



  "8. # ### ###### GRID ## ##

  CREATE OBJECT GC_GRID1

    EXPORTING

      I_PARENT          = GC_CON_LEFT

      .



  CREATE OBJECT GC_GRID2

    EXPORTING

      I_PARENT          = GC_CON_RIGHT

      .



  CREATE OBJECT GC_GRID3

    EXPORTING

      I_PARENT          = GC_CON_BOTTOM

      .

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*




FORM FIELD_CATALOG .

  PERFORM ASSESS_FIELD. "#### ######

  PERFORM SALARY_FIELD. "#### ######

  PERFORM EMP_FIELD.  "#### ######

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ASSESS_FIELD

*&---------------------------------------------------------------------*




FORM ASSESS_FIELD .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT1.



  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-KEY = C_X.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZDEPCODE_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZYEAR'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'DATBI'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'DATAB'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZRANK'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SALARY_FIELD

*&---------------------------------------------------------------------*




FORM SALARY_FIELD .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT2.



  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-KEY = C_X.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZYEAR'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'DATBI'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'DATAB'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZSALARY'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-DO_SUM = C_X.          "#### SUM# ##

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'.  "cfieldname## ## ## ##

  GS_FIELDCAT-OUTPUTLEN = '20'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZBANKCODE_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZACCOUNT'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  EMP_FIELD

*&---------------------------------------------------------------------*






FORM EMP_FIELD .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT3.



  "### ##

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZCOLOR'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-ICON = C_X.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-KEY = C_X.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZPNAME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZDEPCODE_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'DATBI'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'DATAB'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZDEPRANK_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'ZGENDER_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'ZEDATE'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'ZADDRESS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  " ##### #### ## #, ####, #### ####

  IF Z_CHECK = C_X.

    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 11.

    GS_FIELDCAT-FIELDNAME = 'ZQDATE'.

    GS_FIELDCAT-SCRTEXT_M = '####'.

    GS_FIELDCAT-OUTPUTLEN = '10'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT3.



    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 12.

    GS_FIELDCAT-FIELDNAME = 'ZQFLAG'.

    GS_FIELDCAT-SCRTEXT_M = '####'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT3.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*






FORM ALV_LAYOUT .

  CLEAR : GS_LAYOUT.



  "### ##

  GS_LAYOUT-ZEBRA = C_X.

  "##### # ## ####

  GS_LAYOUT-TOTALS_BEF = C_X.



  "variant# #### ##### #### #######

  CLEAR : GS_VARIANT.

  GS_VARIANT-REPORT = SY-REPID.

  GS_VARIANT-USERNAME = SY-UNAME.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ALV_SORT

*&---------------------------------------------------------------------*




FORM ALV_SORT .

  CLEAR : GS_SORT, GT_SORT.



  "##### ####

  GS_SORT-SPOS = 1.

  GS_SORT-FIELDNAME = 'ZPERNR'.

  GS_SORT-UP = C_X.

  APPEND GS_SORT TO GT_SORT.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CALL_ALV

*&---------------------------------------------------------------------*




FORM CALL_ALV .

  "(1,1) ## - ####

  CALL METHOD GC_GRID1->SET_TABLE_FOR_FIRST_DISPLAY

     EXPORTING

       IS_VARIANT                    = GS_VARIANT

       I_SAVE                        = 'A'

       IS_LAYOUT                     = GS_LAYOUT

     CHANGING

       IT_OUTTAB                     = GT_ASSESS_ALV

       IT_FIELDCATALOG               = GT_FIELDCAT1

       IT_SORT                       = GT_SORT.



  "(1,2) ## - ####

    CALL METHOD GC_GRID2->SET_TABLE_FOR_FIRST_DISPLAY

     EXPORTING

       IS_VARIANT                    = GS_VARIANT

       I_SAVE                        = 'A'

       IS_LAYOUT                     = GS_LAYOUT

     CHANGING

       IT_OUTTAB                     = GT_SALARY_ALV

       IT_FIELDCATALOG               = GT_FIELDCAT2

       IT_SORT                       = GT_SORT.



  "(2,1) ## - ####, ######

    CALL METHOD GC_GRID3->SET_TABLE_FOR_FIRST_DISPLAY

     EXPORTING

       IS_VARIANT                    = GS_VARIANT

       I_SAVE                        = 'A'

       IS_LAYOUT                     = GS_LAYOUT

     CHANGING

       IT_OUTTAB                     = GT_EMP_ALV

       IT_FIELDCATALOG               = GT_FIELDCAT3

       IT_SORT                       = GT_SORT.

ENDFORM.