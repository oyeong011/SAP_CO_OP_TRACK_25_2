
*&---------------------------------------------------------------------*

*&  Include           ZEDR05_PRACTICE009_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SET_DATE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form SET_DATE .

  IF S_DATBI[] IS INITIAL.

    S_DATBI-LOW = SY-DATUM(6) && '01'.

    CALL FUNCTION 'LAST_DAY_OF_MONTHS'

      exporting

        DAY_IN            = S_DATBI-LOW

      importing

        LAST_DAY_OF_MONTH = S_DATBI-LOW.

  ENDIF.



  APPEND S_DATBI.

endform.




*&---------------------------------------------------------------------*

*&      Form  CHECK_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form CHECK_DATA .

  IF ( S_PERNR[] IS INITIAL AND S_DEP IS INITIAL ) OR S_DATBI IS INITIAL.

    MESSAGE I000.

    STOP.

  ENDIF.



  R_FG-SIGN = 'I'.

  R_FG-OPTION = 'EQ'.

  R_FG-LOW = ' '.

  APPEND R_FG.



  IF P_ZFLAG = 'X'.

    R_FG-LOW = 'X'.

    APPEND R_FG.

  ENDIF.



endform.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form GET_DATA .



  "####

  SELECT A~ZPERNR B~ZPNAME A~ZDEPRANK A~ZDEPCODE

         B~ZGENDER A~DATBI A~DATAB A~ZDEPRANK

         A~ZEDATE A~ZQDATE  A~ZQFLAG  B~ZADDRESS

  INTO CORRESPONDING FIELDS OF TABLE GT_EMP

  FROM ZEDT05_102 AS A

  INNER JOIN ZEDT05_103 AS B

  ON A~ZPERNR = B~ZPERNR

  WHERE A~ZPERNR IN S_PERNR

  AND A~ZDEPCODE IN S_DEP

  AND A~DATBI <= S_DATBI-LOW AND A~DATAB >= S_DATBI-LOW

  AND ZQFLAG IN R_FG.



  IF GT_EMP[] IS NOT INITIAL.

    SELECT *

    FROM ZEDT05_106

    INTO CORRESPONDING FIELDS OF TABLE GT_PAY

    FOR ALL ENTRIES IN GT_EMP

    WHERE ZPERNR = GT_EMP-ZPERNR

    AND DATBI <= S_DATBI-LOW AND DATAB >= S_DATBI-LOW

    AND ZYEAR = S_DATBI-LOW(4).



    SELECT *

    FROM ZEDT05_104

    INTO CORRESPONDING FIELDS OF TABLE GT_EVAL

    FOR ALL ENTRIES IN GT_EMP

    WHERE ZPERNR = GT_EMP-ZPERNR

    AND DATBI <= S_DATBI-LOW AND DATAB >= S_DATBI-LOW

    AND ZYEAR = S_DATBI-LOW(4)

    AND ZDEPCODE IN S_DEP.

  ENDIF.



endform.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form CREATE_OBJECT .



  create object GC_DOCKING

    exporting

      REPID                       = SY-REPID

      DYNNR                       = SY-DYNNR

      EXTENSION                   = 2000.



  create object GC_SPLITTER

    exporting

      PARENT            = GC_DOCKING

      ROWS              = 2

      COLUMNS           = 1.



"##

  call method GC_SPLITTER->GET_CONTAINER

    exporting

      ROW       = 1

      COLUMN    = 1

    receiving

      CONTAINER = GC_CONTAINER_TOP

      .

"##

  call method GC_SPLITTER->GET_CONTAINER

    exporting

      ROW       = 2

      COLUMN    = 1

    receiving

      CONTAINER = GC_CONTAINER_BOTTOM

      .

"## #### ##### ##

  create object GC_SPLITTER2

    exporting

      PARENT            = GC_CONTAINER_TOP

      ROWS              = 1

      COLUMNS           = 2.



" ## ##

  call method GC_SPLITTER2->GET_CONTAINER

    exporting

      ROW       = 1

      COLUMN    = 1

    receiving

      CONTAINER = GC_CONTAINER_TOPEVAL

      .



" ## ###

  call method GC_SPLITTER2->GET_CONTAINER

    exporting

      ROW       = 1

      COLUMN    = 2

    receiving

      CONTAINER = GC_CONTAINER_TOPPAY.





  create object GC_GRID_TOPEVAL

    exporting

      I_PARENT          = GC_CONTAINER_TOPEVAL.



  create object GC_GRID_TOPPAY

    exporting

      I_PARENT          = GC_CONTAINER_TOPPAY.



  create object GC_GRID_BOTTOM

    exporting

      I_PARENT          = GC_CONTAINER_BOTTOM.

endform.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form FIELD_CATALOG .

  PERFORM FIELD_CATALOG2.

  PERFORM FIELD_CATALOG3.

  PERFORM FIELD_CATALOG4.

endform.





FORM FIELD_CATALOG2 .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT_BOTTOM.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ICON'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-ICON = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_BOTTOM.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-KEY = 'X'.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_BOTTOM.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZPNAME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_BOTTOM.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZDEPCODE_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_BOTTOM.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'DATBI'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_BOTTOM.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'DATAB'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_BOTTOM.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZRANK_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_BOTTOM.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'ZGENDER_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_BOTTOM.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'ZEDATE'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_BOTTOM.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'ZADDRESS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_BOTTOM.



  IF P_ZFLAG = 'X'.

    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 11.

    GS_FIELDCAT-FIELDNAME = 'ZQDATE'.

    GS_FIELDCAT-SCRTEXT_M = '####'.

    GS_FIELDCAT-OUTPUTLEN = '10'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT_BOTTOM.



    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 12.

    GS_FIELDCAT-FIELDNAME = 'ZQFLAG'.

    GS_FIELDCAT-SCRTEXT_M = '####'.

    GS_FIELDCAT-OUTPUTLEN = '8'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT_BOTTOM.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG3

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG3 .

  CLEAR : GS_FIELDCAT , GT_FIELDCAT_TOPPAY.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-KEY = 'X'.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_TOPPAY.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZYEAR'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_TOPPAY.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'DATBI'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_TOPPAY.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'DATAB'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_TOPPAY.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZSALARY'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-DO_SUM = 'X'.

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-OUTPUTLEN = '16'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_TOPPAY.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-NO_OUT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_TOPPAY.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZBANK_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_TOPPAY.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'ZACCOUNT'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_TOPPAY.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG4

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG4 .

  CLEAR : GS_FIELDCAT , GT_FIELDCAT_TOPEVAL.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-KEY = 'X'.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_TOPEVAL.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZDEPCODE_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_TOPEVAL.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZYEAR'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_TOPEVAL.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'DATBI'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_TOPEVAL.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'DATAB'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_TOPEVAL.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZRANK'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT_TOPEVAL.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form ALV_LAYOUT .

  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.

  GS_LAYOUT-TOTALS_BEF = 'X'.

  CLEAR GS_VARIANT.

  GS_VARIANT-REPORT = SY-REPID.

  GS_VARIANT-USERNAME = SY-UNAME.

endform.




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

  GS_SORT-SPOS = 1.

  GS_SORT-FIELDNAME = 'ZPERNR'.

  GS_SORT-UP = 'X'.

  APPEND GS_SORT TO GT_SORT1.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALL_ALV

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form CALL_ALV .

  call method GC_GRID_TOPEVAL->SET_TABLE_FOR_FIRST_DISPLAY

    exporting

      IS_VARIANT                    = GS_VARIANT

      I_SAVE                        = 'A'

      IS_LAYOUT                     = GS_LAYOUT

    changing

      IT_OUTTAB                     = GT_EVAL_ALV

      IT_FIELDCATALOG               = GT_FIELDCAT_TOPEVAL

      IT_SORT                       = GT_SORT1

          .



  call method GC_GRID_TOPPAY->SET_TABLE_FOR_FIRST_DISPLAY

    exporting

      IS_VARIANT                    = GS_VARIANT

      I_SAVE                        = 'A'

      IS_LAYOUT                     = GS_LAYOUT

    changing

      IT_OUTTAB                     = GT_PAY_ALV

      IT_FIELDCATALOG               = GT_FIELDCAT_TOPPAY

      IT_SORT                       = GT_SORT1

          .







  call method GC_GRID_BOTTOM->SET_TABLE_FOR_FIRST_DISPLAY

    exporting

      IS_VARIANT                    = GS_VARIANT

      I_SAVE                        = 'A'

      IS_LAYOUT                     = GS_LAYOUT

    changing

      IT_OUTTAB                     = GT_EMP_ALV

      IT_FIELDCATALOG               = GT_FIELDCAT_BOTTOM

      IT_SORT                       = GT_SORT1.

endform.




*&---------------------------------------------------------------------*

*&      Form  CONVERT_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form CONVERT_DATA .

  DATA : LV_TYPENUM TYPE CHAR1.

  LOOP AT GT_EMP INTO GS_EMP.

    MOVE-CORRESPONDING GS_EMP TO GS_EMP_ALV.

    LV_TYPENUM = 1.

    PERFORM CONVERT_NAME USING GS_EMP-ZDEPCODE LV_TYPENUM CHANGING GS_EMP_ALV-ZDEPCODE_NAME.

    LV_TYPENUM = 2.

    PERFORM CONVERT_NAME USING GS_EMP-ZDEPRANK LV_TYPENUM CHANGING GS_EMP_ALV-ZRANK_NAME.

    LV_TYPENUM = 3.

    PERFORM CONVERT_NAME USING GS_EMP-ZGENDER LV_TYPENUM CHANGING GS_EMP_ALV-ZGENDER_NAME.







    IF GS_EMP_ALV-ZQFLAG = 'X'.

      GS_EMP_ALV-ICON = '@0A@'.

    ELSEIF GS_EMP_ALV-ZRANK_NAME = '##'.

      GS_EMP_ALV-ICON = '@09@'.

    ELSE.

      GS_EMP_ALV-ICON = '@08@'.

    ENDIF.



    APPEND GS_EMP_ALV TO GT_EMP_ALV.

    CLEAR : GS_EMP, GS_EMP_ALV.

  ENDLOOP.



  LOOP AT GT_EVAL INTO GS_EVAL.

    MOVE-CORRESPONDING GS_EVAL TO GS_EVAL_ALV.

    LV_TYPENUM = 1.

    PERFORM CONVERT_NAME USING GS_EVAL-ZDEPCODE LV_TYPENUM CHANGING GS_EVAL_ALV-ZDEPCODE_NAME.



    APPEND GS_EVAL_ALV TO GT_EVAL_ALV.

    CLEAR : GS_EVAL, GS_EVAL_ALV.

  ENDLOOP.





  LOOP AT GT_PAY INTO GS_PAY.

    MOVE-CORRESPONDING GS_PAY TO GS_PAY_ALV.

    LV_TYPENUM = 4.

    PERFORM CONVERT_NAME USING GS_PAY-ZBANKCODE LV_TYPENUM CHANGING GS_PAY_ALV-ZBANK_NAME.



    IF GS_PAY-ZBANKCODE BETWEEN '001' AND '010'.

      GS_PAY_ALV-ZWAERS = 'KRW'.

    ENDIF.

    APPEND GS_PAY_ALV TO GT_PAY_ALV.

    CLEAR : GS_PAY, GS_PAY_ALV.

  ENDLOOP.



endform.




*&---------------------------------------------------------------------*

*&      Form  CONVERT_NAME

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_EMP_ZDEPCODE  text

*      -->P_LV_TYPENUM  text

*      <--P_GS_EMP_ALV_ZDEPCODE_NAME  text

*----------------------------------------------------------------------*




form CONVERT_NAME  using    P_EMP_VAL

                            P_TYPENUM

                   changing P_ALV_VAL.

  CASE P_TYPENUM.

    WHEN '1'.

      CASE P_EMP_VAL.

         WHEN 'SS0001'.

           P_ALV_VAL = '###'.

         WHEN 'SS0002'.

           P_ALV_VAL = '###'.

         WHEN 'SS0003'.

           P_ALV_VAL = '###'.

         WHEN 'SS0004'.

           P_ALV_VAL = '###'.

         WHEN 'SS0005'.

           P_ALV_VAL = '###'.

         WHEN 'SS0006'.

           P_ALV_VAL = '###'.

      ENDCASE.

    WHEN '2'.

      CASE P_EMP_VAL.

         WHEN 'A'.

           P_ALV_VAL = '##'.

         WHEN 'B'.

           P_ALV_VAL = '##'.

         WHEN 'C'.

           P_ALV_VAL = '##'.

         WHEN 'D'.

           P_ALV_VAL = '##'.

         WHEN 'E'.

           P_ALV_VAL = '##'.

         WHEN 'F'.

           P_ALV_VAL = '##'.

         WHEN 'G'.

           P_ALV_VAL = '##'.

      ENDCASE.

    WHEN '3'.

      CASE P_EMP_VAL.

         WHEN 'F'.

           P_ALV_VAL = '##'.

         WHEN 'M'.

           P_ALV_VAL = '##'.

      ENDCASE.

    WHEN '4'.

      CASE P_EMP_VAL.

         WHEN '001'.

           P_ALV_VAL = '##'.

         WHEN '002'.

           P_ALV_VAL = '##'.

         WHEN '003'.

           P_ALV_VAL = '##'.

         WHEN '004'.

           P_ALV_VAL = '##'.

         WHEN '005'.

           P_ALV_VAL = '###'.

      ENDCASE.

    ENDCASE.

endform.