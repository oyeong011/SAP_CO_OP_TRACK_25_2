
*&---------------------------------------------------------------------*

*&  Include  ZEDR21_PRACTICE009_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&  Include           ZEDR00_PRACTICE009_F01

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

  CLEAR : S_DATE, S_DATE[].



  IF S_DATE[] IS INITIAL.

    S_DATE-LOW = SY-DATUM(6) && '01'.

    S_DATE-SIGN = 'I'.

    S_DATE-OPTION = 'EQ'.



    CALL FUNCTION 'LAST_DAY_OF_MONTHS'

      EXPORTING

        DAY_IN            = S_DATE-LOW

      IMPORTING

        LAST_DAY_OF_MONTH = S_DATE-LOW.



    APPEND S_DATE.

  ENDIF.

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

  IF S_DATE IS INITIAL.

    MESSAGE I000.

    STOP.

  ELSE.

    IF ( S_ZDEP IS INITIAL ) AND ( S_ZEMP IS INITIAL ).

      MESSAGE I000.

      STOP.

    ENDIF.

  ENDIF.



  "#### #### ##

  CLEAR : R_FG, R_FG[].



  R_FG-SIGN = 'I'.

  R_FG-OPTION = 'EQ'.

  R_FG-LOW = ' '.

  APPEND R_FG.



  IF P_CH1 = C_X.

    R_FG-LOW = 'X'.

    APPEND R_FG.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  PROGRESS_DISPLAY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_0024   text

*----------------------------------------------------------------------*




FORM PROGRESS_DISPLAY  USING P_TEXT.

  CHECK P_TEXT <> ''.



  CALL FUNCTION 'SAPGUI_PROGRESS_INDICATOR'

    EXPORTING

      TEXT = P_TEXT.

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

   "#### ####.

  SELECT a~zpernr a~zdeprank a~zdepcode a~datbi a~datab a~zedate a~zqdate a~zqflag

         b~zpname b~zgender b~zaddress



  INTO CORRESPONDING FIELDS OF TABLE gt_employee



  FROM zedt07_102 AS a

  INNER JOIN zedt07_103 AS b

  ON a~zpernr = b~zpernr

  WHERE a~zpernr IN s_zemp

  AND a~zdepcode IN s_zdep

  AND ( datbi <= s_date-low AND datab >=  s_date-low )

  AND zqflag IN r_fg.





  IF GT_EMPLOYEE[] IS NOT INITIAL. "gt_emp[]# #### #### ### -> # select## # ##### ####

    "## ####

    SELECT * FROM zedt07_106

    INTO CORRESPONDING FIELDS OF TABLE GT_SALARY

    FOR ALL ENTRIES IN GT_EMPLOYEE "## ## ####

    WHERE zpernr = GT_EMPLOYEE-zpernr

    AND zyear = s_date-low+0(4) "### ###

    AND ( datbi <= s_date-low AND datab >= s_date-low ).



    "## ####

    SELECT * FROM zedt07_104

    INTO CORRESPONDING FIELDS OF TABLE gt_assess

    FOR ALL ENTRIES IN GT_EMPLOYEE

    WHERE zpernr = GT_EMPLOYEE-zpernr

    AND zdepcode = GT_EMPLOYEE-zdepcode

    AND zyear = s_date-low+0(4)

    AND ( datbi <= s_date-low AND datab >= s_date-low ).



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



  CLEAR : GS_EMPLOYEE, GS_EMPLOYEE_INFO.

  CLEAR : GS_SALARY, GS_SALARY_INFO.

  CLEAR : GS_ASSESS, GS_ASSESS_INFO.



  "####

  LOOP AT GT_EMPLOYEE INTO GS_EMPLOYEE.

    MOVE-CORRESPONDING GS_EMPLOYEE TO GS_EMPLOYEE_INFO.



    PERFORM GET_TEXT USING 'ZDEPCODE' GS_EMPLOYEE-ZDEPCODE "### ####

                          CHANGING GS_EMPLOYEE_INFO-ZDEPCODE_NAME.



    PERFORM GET_TEXT USING 'ZDEPRANK' GS_EMPLOYEE-ZDEPRANK "## ####

                       CHANGING GS_EMPLOYEE_INFO-ZRANK_NAME.



    IF GS_EMPLOYEE-ZGENDER = 'M'.

      GS_EMPLOYEE_INFO-ZGENDER_NAME = '##'.

    ELSEIF GS_EMPLOYEE-ZGENDER = 'F'.

      GS_EMPLOYEE_INFO-ZGENDER_NAME = '##'.

    ENDIF.



    IF GS_EMPLOYEE-ZQFLAG = 'X'.

      GS_EMPLOYEE_INFO-ICON = '@0A@'.

    ELSE.

      IF GS_EMPLOYEE-ZDEPRANK = 'A'.

        GS_EMPLOYEE_INFO-ICON = '@09@'.

      ELSE.

        GS_EMPLOYEE_INFO-ICON = '@08@'.

      ENDIF.

    ENDIF.



    APPEND GS_EMPLOYEE_INFO TO GT_EMPLOYEE_INFO.

    CLEAR : GS_EMPLOYEE, GS_EMPLOYEE_INFO.

  ENDLOOP.



  "## ####

  LOOP AT GT_SALARY INTO GS_SALARY.

    MOVE-CORRESPONDING GS_SALARY TO GS_SALARY_INFO.



    PERFORM ZBANKS_NAME USING GS_SALARY-ZBANKCODE "###

                        CHANGING GS_SALARY_INFO-ZBANK_NAME.



    IF GS_SALARY-ZBANKCODE BETWEEN '001' AND '010'.

      GS_SALARY_INFO-ZWAERS = 'KRW'.

    ENDIF.



    APPEND GS_SALARY_INFO TO GT_SALARY_INFO.

    CLEAR : GS_SALARY, GS_SALARY_INFO.

  ENDLOOP.



  "####

  LOOP AT GT_ASSESS INTO GS_ASSESS.

    MOVE-CORRESPONDING GS_ASSESS TO GS_ASSESS_INFO.



    PERFORM GET_TEXT USING 'ZDEPCODE' GS_ASSESS-ZDEPCODE "### ####

                          CHANGING GS_ASSESS_INFO-ZDEPCODE_NAME.



    APPEND GS_ASSESS_INFO TO GT_ASSESS_INFO.

    CLEAR : GS_ASSESS, GS_ASSESS_INFO.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ZDEPCODE_NAME

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_EMP_ZDEPCODE  text

*      <--P_GS_EMP_ALV_ZDEPCODE_NAME  text

*----------------------------------------------------------------------*




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

*&      Form  CONTAINER2_FIELD

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




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

*&      Form  LAYOUT_SET

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM LAYOUT_SET .

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

      I_SAVE                        = C_A




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

      IT_OUTTAB                     = GT_ASSESS_INFO

      IT_FIELDCATALOG               = GT_FIELDCAT3

      IT_SORT                       = GT_SORT1




*      IT_FILTER                     =

*    EXCEPTIONS

*      INVALID_PARAMETER_COMBINATION = 1

*      PROGRAM_ERROR                 = 2

*      TOO_MANY_LINES                = 3

*      OTHERS                        = 4




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

      I_SAVE                        = C_A




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

      IT_OUTTAB                     = GT_SALARY_INFO

      IT_FIELDCATALOG               = GT_FIELDCAT2

      IT_SORT                       = GT_SORT1




*      IT_FILTER                     =

*    EXCEPTIONS

*      INVALID_PARAMETER_COMBINATION = 1

*      PROGRAM_ERROR                 = 2

*      TOO_MANY_LINES                = 3

*      OTHERS                        = 4




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

      I_SAVE                        = C_A




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

      IT_OUTTAB                     = GT_EMPLOYEE_INFO

      IT_FIELDCATALOG               = GT_FIELDCAT1

      IT_SORT                       = GT_SORT1




*      IT_FILTER                     =

*    EXCEPTIONS

*      INVALID_PARAMETER_COMBINATION = 1

*      PROGRAM_ERROR                 = 2

*      TOO_MANY_LINES                = 3

*      OTHERS                        = 4




        .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.

ENDFORM.





FORM GET_TEXT  USING    p_domain TYPE c

                        p_code TYPE c

               CHANGING p_name TYPE c.



  CASE p_domain.

    WHEN 'ZDEPCODE'.

      CASE p_code.

        WHEN 'SS0001'.

          p_name = '###'.

        WHEN 'SS0002'.

          p_name = '###'.

        WHEN 'SS0003'.

          p_name = '###'.

        WHEN 'SS0004'.

          p_name = '###'.

        WHEN 'SS0005'.

          p_name = '###'.

        WHEN 'SS0006'.

          p_name = '###'.

      ENDCASE.





    WHEN 'ZDEPRANK'.

      CASE p_code.

        WHEN 'A'.

          p_name = '##'.

        WHEN 'B'.

          p_name = '##'.

        WHEN 'C'.

          p_name = '##'.

        WHEN 'D'.

          p_name = '##'.

        WHEN 'E'.

          p_name = '##'.

        WHEN 'F'.

          p_name = '##'.

        WHEN 'G'.

          p_name = '##'.

      ENDCASE.



    WHEN 'ZBANKCODE'.

      CASE p_code.

        WHEN '001'.

          p_name = '####'.

        WHEN '002'.

          p_name = '####'.

        WHEN '003'.

          p_name = '####'.

        WHEN '004'.

          p_name = '####'.

        WHEN '005'.

          p_name = '#####'.

      ENDCASE.

  ENDCASE.

ENDFORM.