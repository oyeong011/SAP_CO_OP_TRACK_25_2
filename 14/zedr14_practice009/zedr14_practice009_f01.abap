
*&---------------------------------------------------------------------*

*&  Include           ZEDR14_PRACTICE009_F01

*&---------------------------------------------------------------------*

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

      REPID                       = SY-REPID

      DYNNR                       = SY-DYNNR

      EXTENSION                   = 2000.



  CREATE OBJECT GC_SPLITTER

    EXPORTING

      PARENT            = GC_DOCKING

      ROWS              = 2

      COLUMNS           = 1.



  CALL METHOD GC_SPLITTER->GET_CONTAINER

    EXPORTING

      ROW       = 2

      COLUMN    = 1

    RECEIVING

      CONTAINER = GC_CONTAINER1.

      .



  CALL METHOD GC_SPLITTER->GET_CONTAINER

    EXPORTING

      ROW       = 1

      COLUMN    = 1

    RECEIVING

      CONTAINER = GC_TOP_CONTAINER.



  CREATE OBJECT GC_SPLITTER_TOP

    EXPORTING

      parent  = GC_TOP_CONTAINER

      rows    = 1

      columns = 2.



  CALL METHOD GC_SPLITTER_TOP->GET_CONTAINER

    EXPORTING

      ROW       = 1

      COLUMN    = 1

    RECEIVING

      CONTAINER = GC_CONTAINER2.



  CALL METHOD GC_SPLITTER_TOP->GET_CONTAINER

    EXPORTING

      ROW       = 1

      COLUMN    = 2

    RECEIVING

      CONTAINER = GC_CONTAINER3.



  CREATE OBJECT GC_GRID1

    EXPORTING

      I_PARENT          = GC_CONTAINER1.



  CREATE OBJECT GC_GRID2

    EXPORTING

      I_PARENT          = GC_CONTAINER2.



  CREATE OBJECT GC_GRID3

    EXPORTING

      I_PARENT          = GC_CONTAINER3.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALL_METHOD

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM CALL_METHOD .



  CALL METHOD GC_GRID1->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_VARIANT                    = GS_VARIANT

      I_SAVE                        = 'A'

      IS_LAYOUT                     = GS_LAYOUT

    CHANGING

      IT_OUTTAB                     = GT_FINAL1

      IT_FIELDCATALOG               = GT_FIELDCAT1

      IT_SORT                       = GT_SORT.



  CALL METHOD GC_GRID2->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_VARIANT                    = GS_VARIANT

      I_SAVE                        = 'A'




*      I_DEFAULT                     = 'X'




      IS_LAYOUT                     = GS_LAYOUT

    CHANGING

      IT_OUTTAB                     = GT_FINAL2

      IT_FIELDCATALOG               = GT_FIELDCAT2

      IT_SORT                       = GT_SORT.



  CALL METHOD GC_GRID3->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_VARIANT                    = GS_VARIANT

      I_SAVE                        = 'A'




*      I_DEFAULT                     = 'X'




      IS_LAYOUT                     = GS_LAYOUT

    CHANGING

      IT_OUTTAB                     = GT_FINAL3

      IT_FIELDCATALOG               = GT_FIELDCAT3

      IT_SORT                       = GT_SORT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG .



  PERFORM CONTAINER1_FIELD.

  PERFORM CONTAINER2_FIELD.

  PERFORM CONTAINER3_FIELD.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM ALV_LAYOUT .



  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.

  GS_LAYOUT-TOTALS_BEF = 'X'.



  CLEAR GS_VARIANT.

  GS_VARIANT-REPORT = SY-REPID.

  GS_VARIANT-USERNAME = SY-UNAME.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_SORT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM ALV_SORT .



  CLEAR : GS_SORT, GT_SORT.

  GS_SORT-SPOS = 1.

  GS_SORT-FIELDNAME = 'ZPERNR'.

  GS_SORT-UP = 'X'.

  APPEND GS_SORT TO GT_SORT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CONTAINER1_FIELD

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM CONTAINER1_FIELD .



  CLEAR : GS_FIELDCAT, GT_FIELDCAT1.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZCOLOR'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-ICON = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-EMPHASIZE = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZPNAME'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZDEPNAME'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'DATBI'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'DATAB'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZDEPRANKNAME'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'ZGENDERNAME'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'ZEDATE'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'ZADDRESS'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'ZQDATE'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 12.

  GS_FIELDCAT-FIELDNAME = 'ZQFLAG'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CONTAINER2_FIELD

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM CONTAINER2_FIELD .



  CLEAR : GS_FIELDCAT, GT_FIELDCAT2.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-EMPHASIZE = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZDEPNAME'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZYEAR'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'DATBI'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'DATAB'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZRANK'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CONTAINER3_FIELD

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM CONTAINER3_FIELD .



  CLEAR : GS_FIELDCAT, GT_FIELDCAT3.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-EMPHASIZE = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZYEAR'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'DATBI'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'DATAB'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZSALARY'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-DO_SUM = 'X'.

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-OUTPUTLEN = '16'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-NO_OUT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZBANKNAME'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'ZACCOUNT'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_INITIAL

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM SET_INITIAL .



  CALL FUNCTION 'SLS_MISC_GET_LAST_DAY_OF_MONTH'   "#### ## ##

    EXPORTING

      DAY_IN = SY-DATUM

    IMPORTING

      LAST_DAY_OF_MONTH = P_ZDATE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM GET_DATA .



  RANGES : LR_ZQFLAG FOR ZEDT14_102-ZQFLAG.   "##### RANGES



  LR_ZQFLAG-SIGN = 'I'.

  LR_ZQFLAG-OPTION = 'EQ'.

  LR_ZQFLAG-LOW = ''.

  APPEND LR_ZQFLAG.

  IF P_CH1 = C_X.  "##### ## X

    LR_ZQFLAG-LOW = 'X'.

    APPEND LR_ZQFLAG.

  ENDIF.



  SELECT * INTO CORRESPONDING FIELDS OF TABLE GT_FINAL1

    FROM ZEDT14_102 AS A INNER JOIN ZEDT14_103 AS B

      ON A~ZPERNR = B~ZPERNR

    WHERE A~ZPERNR IN S_ZPERNR    "####

      AND A~ZDEPCODE IN S_ZDEPCO  "####

      AND ( A~DATBI <= P_ZDATE AND A~DATAB >= P_ZDATE ) "####

      AND A~ZQFLAG IN LR_ZQFLAG. "#####



  SELECT * INTO CORRESPONDING FIELDS OF TABLE GT_FINAL2

    FROM ZEDT14_102 AS A INNER JOIN ZEDT14_104 AS B

      ON A~ZPERNR = B~ZPERNR

    WHERE A~ZPERNR IN S_ZPERNR    "####

      AND A~ZDEPCODE IN S_ZDEPCO  "####

      AND ( B~DATBI <= P_ZDATE AND B~DATAB >= P_ZDATE ) "####

      AND A~ZQFLAG IN LR_ZQFLAG. "#####



  SELECT * INTO CORRESPONDING FIELDS OF TABLE GT_FINAL3

    FROM ZEDT14_102 AS A INNER JOIN ZEDT14_106 AS B

      ON A~ZPERNR = B~ZPERNR

    WHERE A~ZPERNR IN S_ZPERNR    "####

      AND A~ZDEPCODE IN S_ZDEPCO  "####

      AND ( B~DATBI <= P_ZDATE AND B~DATAB >= P_ZDATE ) "####

      AND A~ZQFLAG IN LR_ZQFLAG. "#####



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM MODIFY_DATA .



  LOOP AT GT_FINAL1 INTO GS_FINAL1.

    CASE GS_FINAL1-ZDEPCODE.    "### ### ##

      WHEN 'SS0001'. GS_FINAL1-ZDEPNAME = '###'.

      WHEN 'SS0002'. GS_FINAL1-ZDEPNAME = '###'.

      WHEN 'SS0003'. GS_FINAL1-ZDEPNAME = '###'.

      WHEN 'SS0004'. GS_FINAL1-ZDEPNAME = '###'.

      WHEN 'SS0005'. GS_FINAL1-ZDEPNAME = '###'.

      WHEN 'SS0006'. GS_FINAL1-ZDEPNAME = '###'.

    ENDCASE.



    CASE GS_FINAL1-ZDEPRANK.    "### ### ##

      WHEN 'A'. GS_FINAL1-ZDEPRANKNAME = '##'.

      WHEN 'B'. GS_FINAL1-ZDEPRANKNAME = '##'.

      WHEN 'C'. GS_FINAL1-ZDEPRANKNAME = '##'.

      WHEN 'D'. GS_FINAL1-ZDEPRANKNAME = '##'.

      WHEN 'E'. GS_FINAL1-ZDEPRANKNAME = '##'.

      WHEN 'F'. GS_FINAL1-ZDEPRANKNAME = '##'.

      WHEN 'G'. GS_FINAL1-ZDEPRANKNAME = '##'.

    ENDCASE.



    CASE GS_FINAL1-ZGENDER.    "## ### ##

      WHEN 'M'. GS_FINAL1-ZGENDERNAME = '##'.

      WHEN 'F'. GS_FINAL1-ZGENDERNAME = '##'.

    ENDCASE.



    IF GS_FINAL1-ZQFLAG = 'X'.  "###

      GS_FINAL1-ZCOLOR = '@0A@'.

    ELSEIF GS_FINAL1-ZDEPRANK = 'A'.

      GS_FINAL1-ZCOLOR = '@09@'.

    ELSE.

      GS_FINAL1-ZCOLOR = '@08@'.

    ENDIF.



    MODIFY GT_FINAL1 FROM GS_FINAL1.

  ENDLOOP.



  LOOP AT GT_FINAL2 INTO GS_FINAL2.

    CASE GS_FINAL2-ZDEPCODE.    "### ### ##

      WHEN 'SS0001'. GS_FINAL2-ZDEPNAME = '###'.

      WHEN 'SS0002'. GS_FINAL2-ZDEPNAME = '###'.

      WHEN 'SS0003'. GS_FINAL2-ZDEPNAME = '###'.

      WHEN 'SS0004'. GS_FINAL2-ZDEPNAME = '###'.

      WHEN 'SS0005'. GS_FINAL2-ZDEPNAME = '###'.

      WHEN 'SS0006'. GS_FINAL2-ZDEPNAME = '###'.

    ENDCASE.



    MODIFY GT_FINAL2 FROM GS_FINAL2.

  ENDLOOP.



  LOOP AT GT_FINAL3 INTO GS_FINAL3.

    CASE GS_FINAL3-ZBANKCODE.    "### ### ##

      WHEN '001'. GS_FINAL3-ZBANKNAME = '##'.

      WHEN '002'. GS_FINAL3-ZBANKNAME = '##'.

      WHEN '003'. GS_FINAL3-ZBANKNAME = '##'.

      WHEN '004'. GS_FINAL3-ZBANKNAME = '##'.

      WHEN '005'. GS_FINAL3-ZBANKNAME = '###'.

    ENDCASE.



    IF GS_FINAL3-ZBANKCODE BETWEEN '001' AND '005'.   "## ##

      GS_FINAL3-ZWAERS = 'KRW'.

    ENDIF.



    MODIFY GT_FINAL3 FROM GS_FINAL3.

  ENDLOOP.



ENDFORM.