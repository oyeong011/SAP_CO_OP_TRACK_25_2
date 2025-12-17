
*&---------------------------------------------------------------------*

*&  Include           ZEDR15_PRACTICE009_F01

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

"#### ##### ##

  S_DATE-SIGN = 'I'.

  S_DATE-OPTION = 'EQ'.

  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

    EXPORTING

      DAY_IN = SY-DATUM

    IMPORTING

      LAST_DAY_OF_MONTH = S_DATE-LOW.

  APPEND S_DATE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  RANGE_CONTROL

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM RANGE_CONTROL .

"#######

  GR_ZFG-SIGN = 'I'.

  GR_ZFG-OPTION = 'EQ'.

  GR_ZFG-LOW = ''.

  APPEND GR_ZFG. "###



  IF P_CH1 = C_X.

    GR_ZFG-LOW = C_X.

  ENDIF.

  APPEND GR_ZFG. "### ##

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SELECT_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SELECT_DATA .

"ZEDT15_102# ZEDT15_103# #### GT_EMP# ####

  SELECT

    T1~ZPERNR, "####

    T2~ZPNAME, "####

    T1~ZDEPCODE, "####

    T1~DATBI, "####

    T1~DATAB, "####

    T1~ZDEPRANK, "##

    T2~ZGENDER, "##

    T1~ZEDATE, "####

    T2~ZADDRESS, "##

    T1~ZQDATE, "####

    T1~ZQFLAG "####

  FROM ZEDT15_102 AS T1

    INNER JOIN ZEDT15_103 AS T2

    ON T1~ZPERNR = T2~ZPERNR

  INTO CORRESPONDING FIELDS OF TABLE @GT_EMP

  WHERE T1~DATBI < @S_DATE-LOW

    AND T1~DATAB > @S_DATE-LOW

    AND T1~ZPERNR IN @S_ZPERNR

    AND T1~ZDEPCODE IN @S_ZDEP

    AND T1~ZQFLAG IN @GR_ZFG.



"##### ## #### GT_TEST ####

  SELECT

    T1~ZPERNR, "####

    T1~ZDEPCODE, "####

    T1~ZYEAR, "##

    T1~DATBI, "####

    T1~DATAB, "####

    T1~ZRANK "##

  FROM ZEDT15_104 AS T1

  INTO CORRESPONDING FIELDS OF TABLE @GT_TEST

  FOR ALL ENTRIES IN @GT_EMP

  WHERE T1~DATBI < @S_DATE-LOW

    AND T1~DATAB > @S_DATE-LOW

    AND T1~ZPERNR = @GT_EMP-ZPERNR

    AND T1~ZDEPCODE = @GT_EMP-ZDEPCODE.



"##### ## #### GT_SAL ####

  SELECT

    T1~ZPERNR, "####

    T1~ZYEAR, "##

    T1~DATBI, "####

    T1~DATAB, "####

    T1~ZSALARY, "####

    T1~ZBANKCODE, "###

    T1~ZACCOUNT "####

  FROM ZEDT15_106 AS T1

  INTO CORRESPONDING FIELDS OF TABLE @GT_SAL

  FOR ALL ENTRIES IN @GT_EMP

  WHERE T1~DATBI < @S_DATE-LOW

    AND T1~DATAB > @S_DATE-LOW

    AND T1~ZPERNR = @GT_EMP-ZPERNR.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIF_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIF_DATA .




*GT_EMP->GT_EMP_OUT




  LOOP AT GT_EMP INTO GS_EMP.

    MOVE-CORRESPONDING GS_EMP TO GS_EMP_OUT.



    "###

    PERFORM ZDEPCODE_T USING GS_EMP-ZDEPCODE

                        CHANGING GS_EMP_OUT-ZDEPCODE_T.

    "##

    PERFORM ZDEPRANK_T USING GS_EMP-ZDEPRANK

                        CHANGING GS_EMP_OUT-ZDEPRANK_T.

    "##

    PERFORM ZGENDER_T USING GS_EMP-ZGENDER

                        CHANGING GS_EMP_OUT-ZGENDER_T.

    "##

    IF GS_EMP-ZQFLAG = C_X. "###

      GS_EMP_OUT-ICON = '@0A@'.

    ELSE.

      IF GS_EMP-ZDEPRANK = 'A'. "##

        GS_EMP_OUT-ICON = '@09@'.

      ELSE.

        GS_EMP_OUT-ICON = '@08@'.

      ENDIF.

    ENDIF.



    APPEND GS_EMP_OUT TO GT_EMP_OUT.

    CLEAR :GS_EMP, GS_EMP_OUT.

  ENDLOOP.






*GT_TEST->GT_TEST_OUT




  LOOP AT GT_TEST INTO GS_TEST.

    MOVE-CORRESPONDING GS_TEST TO GS_TEST_OUT.



    "###

    PERFORM ZDEPCODE_T USING GS_TEST-ZDEPCODE

                        CHANGING GS_TEST_OUT-ZDEPCODE_T.



    APPEND GS_TEST_OUT TO GT_TEST_OUT.

    CLEAR :GS_TEST, GS_TEST_OUT.

  ENDLOOP.






*GT_SAL->GT_SAL_OUT




  LOOP AT GT_SAL INTO GS_SAL.

    MOVE-CORRESPONDING GS_SAL TO GS_SAL_OUT.



    "###

    PERFORM ZBANKCODE_T USING GS_SAL-ZBANKCODE

                        CHANGING GS_SAL_OUT-ZBANKCODE_T.



    "####

    IF GS_SAL-ZBANKCODE BETWEEN '001' AND '010'.

      GS_SAL_OUT-ZWAERS = 'KRW'.

    ENDIF.



    APPEND GS_SAL_OUT TO GT_SAL_OUT.

    CLEAR :GS_SAL, GS_SAL_OUT.

  ENDLOOP.





ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ZDEPCODE_T

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_EMP_ZDEPCODE  text

*      <--P_GS_EMP_OUT_ZDEPCODE_T  text

*----------------------------------------------------------------------*




FORM ZDEPCODE_T  USING    P_ZDEPCODE

                 CHANGING P_ZDEPCODE_T.



     CASE: P_ZDEPCODE. "###

        WHEN 'SS0001'. P_ZDEPCODE_T = '###'.

        WHEN 'SS0002'. P_ZDEPCODE_T = '###'.

        WHEN 'SS0003'. P_ZDEPCODE_T = '###'.

        WHEN 'SS0004'. P_ZDEPCODE_T = '###'.

        WHEN 'SS0005'. P_ZDEPCODE_T = '###'.

        WHEN 'SS0006'. P_ZDEPCODE_T = '###'.

      ENDCASE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ZDEPRANK_T

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_EMP_ZDEPRANK  text

*      <--P_GS_EMP_OUT_ZDEPRANK_T  text

*----------------------------------------------------------------------*




FORM ZDEPRANK_T  USING    P_ZDEPRANK

                 CHANGING P_ZDEPRANK_T.



      CASE: P_ZDEPRANK. "###

        WHEN 'A'. P_ZDEPRANK_T = '##'.

        WHEN 'B'. P_ZDEPRANK_T = '##'.

        WHEN 'C'. P_ZDEPRANK_T = '##'.

        WHEN 'D'. P_ZDEPRANK_T = '##'.

        WHEN 'E'. P_ZDEPRANK_T = '##'.

        WHEN 'F'. P_ZDEPRANK_T = '##'.

        WHEN 'G'. P_ZDEPRANK_T = '##'.

      ENDCASE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ZGENDER_T

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_EMP_ZGENDER  text

*      <--P_GS_EMP_OUT_ZGENDER_T  text

*----------------------------------------------------------------------*




FORM ZGENDER_T  USING    P_ZGENDER

                CHANGING P_ZGENDER_T.



      CASE : P_ZGENDER. "##

        WHEN 'M'. P_ZGENDER_T = '##'.

        WHEN 'F'. P_ZGENDER_T = '##'.

      ENDCASE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ZBANKCODE_T

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_SAL_ZBANKCODE  text

*      <--P_GS_SAL_OUT_ZBANKCODE_T  text

*----------------------------------------------------------------------*




FORM ZBANKCODE_T  USING    P_ZBANKCODE

                  CHANGING P_ZBANKCODE_T.



      CASE : P_ZBANKCODE. "###

        WHEN '001'. P_ZBANKCODE_T = '##'.

        WHEN '002'. P_ZBANKCODE_T = '##'.

        WHEN '003'. P_ZBANKCODE_T = '##'.

        WHEN '004'. P_ZBANKCODE_T = '##'.

        WHEN '005'. P_ZBANKCODE_T = '###'.

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




FORM CREATE_OBJECT .

"1. DOCKING CONTAINER ##

  CREATE OBJECT GC_DOCKING

    EXPORTING

      REPID                       = SY-REPID

      DYNNR                       = SY-DYNNR

      EXTENSION                   = 2000.



"2. #### ## SPLITTER1

  CREATE OBJECT GC_SPLITTER1

    EXPORTING

      PARENT            = GC_DOCKING

      ROWS              = 2

      COLUMNS           = 1.



"3. #->CONTAINER1 ##->CONTAINER2 ##

  CALL METHOD GC_SPLITTER1->GET_CONTAINER

    EXPORTING

      ROW       = 1

      COLUMN    = 1

    RECEIVING

      CONTAINER = GC_CONTAINER1.



  CALL METHOD GC_SPLITTER1->GET_CONTAINER

    EXPORTING

      ROW       = 2

      COLUMN    = 1

    RECEIVING

      CONTAINER = GC_CONTAINER2.



"4. GC_CONTAINER1# ## SPLITTER2

  CREATE OBJECT GC_SPLITTER2

    EXPORTING

      PARENT            = GC_CONTAINER1

      ROWS              = 1

      COLUMNS           = 2.



"5. #->CONTAINER3 #->CONTAINER4 ##

  CALL METHOD GC_SPLITTER2->GET_CONTAINER

    EXPORTING

      ROW       = 1

      COLUMN    = 1

    RECEIVING

      CONTAINER = GC_CONTAINER3.

      .

  CALL METHOD GC_SPLITTER2->GET_CONTAINER

    EXPORTING

      ROW       = 1

      COLUMN    = 2

    RECEIVING

      CONTAINER = GC_CONTAINER4.



"6. CONTAINER2->GRID1 CONTAINER3->GRID2 CONTAINER4->GRID3 ###

  CREATE OBJECT GC_GRID1

    EXPORTING

      I_PARENT          = GC_CONTAINER2.



  CREATE OBJECT GC_GRID2

    EXPORTING

      I_PARENT          = GC_CONTAINER3.



  CREATE OBJECT GC_GRID3

    EXPORTING

      I_PARENT          = GC_CONTAINER4.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_FIELD

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_FIELD .

  PERFORM FIELD_GRID1.

  PERFORM FIELD_GRID2.

  PERFORM FIELD_GRID3.

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

  GS_LAYOUT-TOTALS_BEF = 'X'. "totals output before single records



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



  CLEAR : GS_SORT, GT_SORT1.

  GS_SORT-SPOS = 2.

  GS_SORT-FIELDNAME = 'ZPERNR'.

  GS_SORT-UP = 'X'.

  APPEND GS_SORT TO GT_SORT1.



  CLEAR : GS_SORT, GT_SORT2.

  GS_SORT-SPOS = 1.

  GS_SORT-FIELDNAME = 'ZPERNR'.

  GS_SORT-UP = 'X'.

  APPEND GS_SORT TO GT_SORT2.



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

  CALL METHOD GC_GRID1->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_VARIANT                    = GS_VARIANT

      I_SAVE                        = 'A'

      IS_LAYOUT                     = GS_LAYOUT

    CHANGING

      IT_OUTTAB                     = GT_EMP_OUT

      IT_FIELDCATALOG               = GT_FIELDCAT1

      IT_SORT                       = GT_SORT1.



  CALL METHOD GC_GRID2->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_VARIANT                    = GS_VARIANT

      I_SAVE                        = 'A'

      IS_LAYOUT                     = GS_LAYOUT

    CHANGING

      IT_OUTTAB                     = GT_TEST_OUT

      IT_FIELDCATALOG               = GT_FIELDCAT2

      IT_SORT                       = GT_SORT2.



  CALL METHOD GC_GRID3->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_VARIANT                    = GS_VARIANT

      I_SAVE                        = 'A'

      IS_LAYOUT                     = GS_LAYOUT

    CHANGING

      IT_OUTTAB                     = GT_SAL_OUT

      IT_FIELDCATALOG               = GT_FIELDCAT3

      IT_SORT                       = GT_SORT2.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_GRID1

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_GRID1 .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT1.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ICON'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-ICON = 'X'.

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

  GS_FIELDCAT-FIELDNAME = 'ZDEPCODE_T'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'DATBI'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'DATAB'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZDEPRANK_T'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'ZGENDER_T'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'ZEDATE'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'ZADDRESS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  IF P_CH1 = C_X.

    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 11.

    GS_FIELDCAT-FIELDNAME = 'ZQDATE'.

    GS_FIELDCAT-SCRTEXT_M = '####'.

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

*&      Form  FIELD_GRID2

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_GRID2 .

  CLEAR : GS_FIELDCAT , GT_FIELDCAT2.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-KEY = 'X'.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZDEPCODE_T'.

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

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'DATAB'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZRANK'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_GRID3

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_GRID3 .

  CLEAR : GS_FIELDCAT , GT_FIELDCAT3.

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

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'DATAB'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZSALARY'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-DO_SUM = 'X'. "##### ## ####

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'. "####

  GS_FIELDCAT-OUTPUTLEN = '16'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-NO_OUT = 'X'. "##### #### ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZBANKCODE_T'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'ZACCOUNT'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.

ENDFORM.