
*&---------------------------------------------------------------------*

*&  Include           ZEDR022_PRACTICE009_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SET_DATE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_DATE .

  S_DATE-SIGN   = 'I'.

  S_DATE-OPTION = 'EQ'.

  S_DATE-LOW = SY-DATUM(6) && '01'.

  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

    EXPORTING

      DAY_IN                  = S_DATE-LOW

    IMPORTING

      LAST_DAY_OF_MONTH       = S_DATE-LOW.

  APPEND S_DATE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_DATA .

  IF S_DATE IS INITIAL."## ### ## ####### ##

    MESSAGE I001."#### #### ## ### ##

    STOP.

  ELSE.

    IF ( S_DEPT IS INITIAL ) AND ( S_ZPER IS INITIAL ). "#### ## #### # # ### ## ##

      MESSAGE I001. "## ### ##

      STOP.

    ENDIF.

  ENDIF.



  CLEAR : R_FG, R_FG[]. "## ###, ### ## ### ###



  R_FG-SIGN = 'I'.

  R_FG-OPTION = 'EQ'.

  R_FG-LOW = ' '.

  APPEND R_FG.



  IF P_CH1 = C_X."### ## ###

    R_FG-LOW = 'X'.

    APPEND R_FG.

  ENDIF.



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

SELECT A~ZPERNR      "####

         B~ZPNAME      "##

         A~ZDEPRANK    "####

         A~ZDEPCODE    "####

         B~ZGENDER     "##

         A~DATBI       "####

         A~DATAB       "####

         A~ZEDATE      "####

         A~ZQDATE      "####

         A~ZQFLAG      "####

         B~ZADDRESS    "##

  INTO CORRESPONDING FIELDS OF TABLE GT_EMPL

    FROM ZEDT22_102 AS A

    INNER JOIN ZEDT22_103 AS B

      ON A~ZPERNR = B~ZPERNR

    WHERE A~ZPERNR IN S_ZPER              "#### ##

      AND A~ZDEPCODE IN S_DEPT          "#### ##

      AND A~DATBI <= S_DATE-LOW           "#### <= ###

      AND A~DATAB >= S_DATE-LOW           "#### >= ###

      AND A~ZQFLAG IN R_FG.                "#### ##



  " ### ##### ### ### ## # ##

  IF GT_EMPL[] IS INITIAL.

    MESSAGE I001.

    STOP.

  ENDIF.



  " 2. #### ### ##

  SELECT *

    FROM ZEDT22_106

    INTO CORRESPONDING FIELDS OF TABLE GT_CONTR

    FOR ALL ENTRIES IN GT_EMPL

    WHERE ZPERNR = GT_EMPL-ZPERNR          "#### ##

      AND ZYEAR = S_DATE-LOW(4)         "#### ##

      AND DATBI <= S_DATE-LOW             "#### <= ###

      AND DATAB >= S_DATE-LOW.            "#### >= ###



  " 3. #### ### ##

  SELECT *

  FROM ZEDT22_104

  INTO CORRESPONDING FIELDS OF TABLE GT_EVAL

  FOR ALL ENTRIES IN GT_EMPL

  WHERE ZPERNR = GT_EMPL-ZPERNR "#### ##

    AND ZDEPCODE = GT_EMPL-ZDEPCODE"#### ##

    AND ZYEAR = S_DATE-LOW(4)"#### ##

    AND DATBI <= S_DATE-LOW"#### <= ###

    AND DATAB >= S_DATE-LOW."#### >= ###



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

  CLEAR : GS_EMPL, GS_CONTR, GS_EVAL.

  CLEAR : GS_EMPL_ALV, GS_CONTR_ALV, GT_EVAL_ALV.



  "#### ### ####

  LOOP AT GT_EMPL INTO GS_EMPL.

    MOVE-CORRESPONDING GS_EMPL TO GS_EMPL_ALV.

    "### ####

    PERFORM ZDEPCODE_NAME USING GS_EMPL-ZDEPCODE

          CHANGING GS_EMPL_ALV-ZDEPCODE_NAME.

    "### ####

    PERFORM ZRANK_NAME USING GS_EMPL-ZDEPRANK

          CHANGING GS_EMPL_ALV-ZRANK_NAME.



    IF GS_EMPL-ZGENDER = 'M'.

      GS_EMPL_ALV-ZGENDER_NAME = '##'.

    ELSEIF GS_EMPL-ZGENDER = 'F'.

      GS_EMPL_ALV-ZGENDER_NAME = '##'.

    ENDIF.



    IF GS_EMPL-ZQFLAG = 'X'."###

      GS_EMPL_ALV-ICON = '@0A@'. "##

    ELSE.

      IF GS_EMPL-ZDEPRANK = 'A'.

        GS_EMPL_ALV-ICON = '@09@'. "##(##-##)

     ELSE.

      GS_EMPL_ALV-ICON = '@08@'. "##(##)

    ENDIF.

    ENDIF.



  APPEND GS_EMPL_ALV TO GT_EMPL_ALV.

  CLEAR : GS_EMPL, GS_EMPL_ALV.

  ENDLOOP.



  "## ##

  LOOP AT GT_CONTR INTO GS_CONTR.

    MOVE-CORRESPONDING GS_CONTR TO GS_CONTR_ALV.



  "### ####

    PERFORM ZBANKS_NAME USING GS_CONTR-ZBANKCODE

                        CHANGING GS_CONTR_ALV-ZBANK_NAME.



  "## ##(001~010 ## ### krw)

    IF GS_CONTR-ZBANKCODE BETWEEN '001' AND '010'.

      GS_CONTR_ALV-ZWAERS = 'KRW'.

    ENDIF.



    APPEND GS_CONTR_ALV TO GT_CONTR_ALV.

    CLEAR : GS_CONTR, GS_CONTR_ALV.

  ENDLOOP.



  "####

  LOOP AT GT_EVAL INTO GS_EVAL.

    MOVE-CORRESPONDING GS_EVAL TO GS_EVAL_ALV.



    "### ####

    PERFORM ZDEPCODE_NAME USING GS_EVAL-ZDEPCODE

                          CHANGING GS_EVAL_ALV-ZDEPCODE_NAME.



    APPEND GS_EVAL_ALV TO GT_EVAL_ALV.

    CLEAR : GS_EVAL, GS_EVAL_ALV.

  ENDLOOP.



ENDFORM.



FORM ZDEPCODE_NAME  USING P_ZDEPCODE

                    CHANGING P_NAME.

  CASE P_ZDEPCODE.

    WHEN 'SS0001'.

      P_NAME = '###'.

    WHEN 'SS0002'.

      P_NAME = '###'.

    WHEN 'SS0003'.

      P_NAME = '###'.

    WHEN 'SS0004'.

      P_NAME = '###'.

    WHEN 'SS0005'.

      P_NAME = '###'.

    WHEN 'SS0006'.

      P_NAME = '###'.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ZRANK_NAME

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_EMP_ZDEPRANK  text

*      <--P_GS_EMP_ALV_ZRANK_NAME  text

*----------------------------------------------------------------------*




FORM ZRANK_NAME  USING P_ZRANK

                 CHANGING P_NAME.

  CASE P_ZRANK.

    WHEN 'A'.

      P_NAME = '##'.

    WHEN 'B'.

      P_NAME = '##'.

    WHEN 'C'.

      P_NAME = '##'.

    WHEN 'D'.

      P_NAME = '##'.

    WHEN 'E'.

      P_NAME = '##'.

    WHEN 'F'.

      P_NAME = '##'.

    WHEN 'G'.

      P_NAME = '##'.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ZBANKS_NAME

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_CONTACT_ZBANKCODE  text

*      <--P_GS_CONTACT_ALV_ZBANK_NAME  text

*----------------------------------------------------------------------*




FORM ZBANKS_NAME  USING P_ZBANK

                  CHANGING P_NAME.

  CASE P_ZBANK.

    WHEN '001'.

      P_NAME = '####'.

    WHEN '002'.

      P_NAME = '####'.

    WHEN '003'.

      P_NAME = '####'.

    WHEN '004'.

      P_NAME = '####'.

    WHEN '005'.

      P_NAME = '#####'.

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

      ROW       = 1

      COLUMN    = 1

    RECEIVING

      CONTAINER = GC_CONTAINER1.



  CALL METHOD GC_SPLITTER->GET_CONTAINER

    EXPORTING

      ROW       = 2

      COLUMN    = 1

    RECEIVING

      CONTAINER = GC_CONTAINER2.



  CREATE OBJECT GC_SPLITTER2

    EXPORTING



    PARENT            = GC_CONTAINER1

    ROWS              = 1

    COLUMNS           = 2.



  CALL METHOD GC_SPLITTER2->GET_CONTAINER

    EXPORTING

      ROW       = 1

      COLUMN    = 1

   RECEIVING

      CONTAINER = GC_CONTAINER3.



  CALL METHOD GC_SPLITTER2->GET_CONTAINER

    EXPORTING

      ROW       = 1

      COLUMN    = 2

    RECEIVING

      CONTAINER = GC_CONTAINER4.



  CREATE OBJECT GC_GRID1

    EXPORTING

      I_PARENT          = GC_CONTAINER3.



  CREATE OBJECT GC_GRID2

    EXPORTING

      I_PARENT          = GC_CONTAINER4.



  CREATE OBJECT GC_GRID3

    EXPORTING

      I_PARENT          = GC_CONTAINER2.



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

  PERFORM CONTAINER2_FIELD.

  PERFORM CONTAINER3_FIELD.

  PERFORM CONTAINER4_FIELD.

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

  GS_SORT-SPOS = 1.

  GS_SORT-FIELDNAME = 'ZPERNR'.

  GS_SORT-UP = 'X'.

  APPEND GS_SORT TO GT_SORT1.



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



  CLEAR GS_VARIANT.

  GS_VARIANT-REPORT = SY-REPID.

  GS_VARIANT-USERNAME = SY-UNAME.

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




*      I_BUFFER_ACTIVE               =

*      I_BYPASSING_BUFFER            =

*      I_CONSISTENCY_CHECK           =

*      I_STRUCTURE_NAME              =




      IS_VARIANT                    = GS_VARIANT

      I_SAVE                        = 'A'




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

      IT_OUTTAB                     = GT_EVAL_ALV

      IT_FIELDCATALOG               = GT_FIELDCAT3

      IT_SORT                       = GT_SORT1




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

  CALL METHOD GC_GRID2->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING




*      I_BUFFER_ACTIVE               =

*      I_BYPASSING_BUFFER            =

*      I_CONSISTENCY_CHECK           =

*      I_STRUCTURE_NAME              =




      IS_VARIANT                    = GS_VARIANT

      I_SAVE                        = 'A'




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

      IT_OUTTAB                     = GT_CONTR_ALV

      IT_FIELDCATALOG               = GT_FIELDCAT2

      IT_SORT                       = GT_SORT1




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

  CALL METHOD GC_GRID3->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING




*      I_BUFFER_ACTIVE               =

*      I_BYPASSING_BUFFER            =

*      I_CONSISTENCY_CHECK           =

*      I_STRUCTURE_NAME              =




      IS_VARIANT                    = GS_VARIANT

      I_SAVE                        = 'A'




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

      IT_OUTTAB                     = GT_EMPL_ALV

      IT_FIELDCATALOG               = GT_FIELDCAT1

      IT_SORT                       = GT_SORT1




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

FORM CONTAINER2_FIELD .

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

  GS_FIELDCAT-FIELDNAME = 'ZDEPCODE_NAME'.

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

  GS_FIELDCAT-FIELDNAME = 'ZRANK_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'ZGENDER_NAME'.

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



  IF P_CH1 = C_X.

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

*&      Form  CONTAINER3_FIELD

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CONTAINER3_FIELD .

  CLEAR : GS_FIELDCAT , GT_FIELDCAT2.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-KEY = 'X'.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

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

  GS_FIELDCAT-DO_SUM = 'X'.

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-OUTPUTLEN = '16'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-NO_OUT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZBANK_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'ZACCOUNT'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CONTAINER4_FIELD

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CONTAINER4_FIELD .

  CLEAR : GS_FIELDCAT , GT_FIELDCAT3.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-KEY = 'X'.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZDEPCODE_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZYEAR'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'DATBI'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'DATAB'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZRANK'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.

ENDFORM.