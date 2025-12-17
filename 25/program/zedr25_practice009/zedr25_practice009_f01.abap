
*&---------------------------------------------------------------------*

*&  Include           ZEDR25_PRACTICE009_F01

*&---------------------------------------------------------------------*

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

   IF s_date[] IS INITIAL.

  s_date-low = sy-datum(6) && '01'.

  CALL FUNCTION 'LAST_DAY_OF_MONTHS'

    EXPORTING

      day_in = s_date-low

    IMPORTING

      last_day_of_month = s_date-low.

  s_date-sign = 'I'.

  s_date-option = 'EQ'.

  APPEND s_date.

ENDIF.



  CLEAR r_fg. REFRESH r_fg.

r_fg-sign   = 'I'. r_fg-option = 'EQ'. r_fg-low = ' '. APPEND r_fg.

IF p_ch1 = 'X'.

  r_fg-low = 'X'. APPEND r_fg.

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

   DATA lv_cnt TYPE i.

  DESCRIBE TABLE s_date LINES lv_cnt.

  IF lv_cnt = 0 OR lv_cnt > 1.

    MESSAGE '#### ## ### #####.' TYPE 'E'.

  ENDIF.




*  IF s_date IS INITIAL.

*  MESSAGE '#### #####.' TYPE 'E'.

*ENDIF.

*IF s_zdep IS INITIAL AND s_zemp IS INITIAL.

*  MESSAGE '## ## #### # ### #####.' TYPE 'E'.

*ENDIF.






ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*






FORM get_data .

  DATA: lv_keydate TYPE sy-datum,

        lv_year    TYPE n LENGTH 4.



  CLEAR r_fg. REFRESH r_fg.

  r_fg-sign = 'I'. r_fg-option = 'EQ'. r_fg-low = ' '. APPEND r_fg. "##

  IF p_ch1 = 'X'.

    r_fg-low = 'X'. APPEND r_fg.                                     "##

  ENDIF.



  DATA: lt_emp LIKE TABLE OF gs_emp.



  CLEAR: gt_emp, gt_pay, gt_eval, lt_emp.

  REFRESH: gt_emp, gt_pay, gt_eval, lt_emp.



  lv_keydate = s_date-low.

  lv_year    = s_date-low+0(4).



  IF s_zdep[] IS INITIAL.

    SELECT a~zpernr  b~zpname  a~zdepcode  a~datbi  a~datab  a~zdeprank

           b~zgender a~zedate  a~zqdate    a~zqflag b~zaddress

      INTO CORRESPONDING FIELDS OF TABLE lt_emp

      FROM zedt25_102 AS a

      INNER JOIN zedt25_103 AS b ON b~zpernr = a~zpernr

     WHERE a~zpernr IN s_zemp

       AND a~datbi <= lv_keydate

       AND a~datab >= lv_keydate

       AND a~zqflag IN r_fg.

  ELSE.

    SELECT a~zpernr  b~zpname  a~zdepcode  a~datbi  a~datab  a~zdeprank

           b~zgender a~zedate  a~zqdate    a~zqflag b~zaddress

      INTO CORRESPONDING FIELDS OF TABLE lt_emp

      FROM zedt25_102 AS a

      INNER JOIN zedt25_103 AS b ON b~zpernr = a~zpernr

     WHERE a~zpernr  IN s_zemp

       AND a~zdepcode IN s_zdep

       AND a~datbi <= lv_keydate

       AND a~datab >= lv_keydate

       AND a~zqflag IN r_fg.

  ENDIF.



  IF p_ch1 = 'X'.

    IF s_zdep[] IS INITIAL.

      SELECT a~zpernr  b~zpname  a~zdepcode  a~datbi  a~datab  a~zdeprank

             b~zgender a~zedate  a~zqdate    a~zqflag b~zaddress

        APPENDING CORRESPONDING FIELDS OF TABLE lt_emp

        FROM zedt25_102 AS a

        INNER JOIN zedt25_103 AS b ON b~zpernr = a~zpernr

       WHERE a~zpernr IN s_zemp

         AND a~zqflag  = 'X'.

    ELSE.

      SELECT a~zpernr  b~zpname  a~zdepcode  a~datbi  a~datab  a~zdeprank

             b~zgender a~zedate  a~zqdate    a~zqflag b~zaddress

        APPENDING CORRESPONDING FIELDS OF TABLE lt_emp

        FROM zedt25_102 AS a

        INNER JOIN zedt25_103 AS b ON b~zpernr = a~zpernr

       WHERE a~zpernr  IN s_zemp

         AND a~zdepcode IN s_zdep

         AND a~zqflag  = 'X'.

    ENDIF.

  ENDIF.



  IF p_ch1 = 'X'.

    SORT lt_emp BY zpernr zqflag DESCENDING datab DESCENDING datbi DESCENDING.

  ELSE.

    SORT lt_emp BY zpernr datab DESCENDING datbi DESCENDING.

  ENDIF.

  DELETE ADJACENT DUPLICATES FROM lt_emp COMPARING zpernr.

  gt_emp = lt_emp.



  IF gt_emp IS INITIAL. RETURN. ENDIF.



  IF p_ch1 = 'X'.

    "## ##: ### (#### ## # ### ### ##)

    SELECT *

      INTO CORRESPONDING FIELDS OF TABLE gt_pay

      FROM zedt25_106

      FOR ALL ENTRIES IN gt_emp

     WHERE zpernr = gt_emp-zpernr

       AND zyear  = lv_year.

  ELSE.

    "###: ### ###

    SELECT *

      INTO CORRESPONDING FIELDS OF TABLE gt_pay

      FROM zedt25_106

      FOR ALL ENTRIES IN gt_emp

     WHERE zpernr = gt_emp-zpernr

       AND zyear  = lv_year

       AND datbi  <= lv_keydate

       AND datab  >= lv_keydate.

  ENDIF.



  SELECT zpernr zdepcode zyear datbi datab zrank

    INTO TABLE gt_eval

    FROM zedt25_104

    FOR ALL ENTRIES IN gt_emp

   WHERE zpernr   = gt_emp-zpernr

     AND zdepcode = gt_emp-zdepcode

     AND zyear    = lv_year

     AND datbi    <= lv_keydate

     AND datab    >= lv_keydate.

ENDFORM.








*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CREATE_OBJECT .

  " 1) Docking Container

  IF gc_docking IS INITIAL.

    CREATE OBJECT gc_docking

      EXPORTING

        repid     = sy-repid

        dynnr     = '0100'

        side      = cl_gui_docking_container=>dock_at_left

        extension = 1300.

  ENDIF.



  " 2) #/# ## (2# 1#)

  IF gc_splitter IS INITIAL.

    CREATE OBJECT gc_splitter

      EXPORTING

        parent  = gc_docking

        rows    = 2

        columns = 1.



    gc_container_top    = gc_splitter->get_container( row = 1 column = 1 ).

    gc_container_bottom = gc_splitter->get_container( row = 2 column = 1 ).



    CALL METHOD gc_splitter->set_row_height

      EXPORTING

        id     = 1

        height = 50.

  ENDIF.



  " 3) ## #/# ## (1# 2#)

  IF gc_splitter2 IS INITIAL.

    CREATE OBJECT gc_splitter2

      EXPORTING

        parent  = gc_container_top

        rows    = 1

        columns = 2.



    gc_container_topeval = gc_splitter2->get_container( row = 1 column = 1 ).

    gc_container_toppay  = gc_splitter2->get_container( row = 1 column = 2 ).



    CALL METHOD gc_splitter2->set_column_width

      EXPORTING

        id    = 1

        width = 50.

  ENDIF.



  " 4) # ### ALV Grid ##

  IF gc_grid_topeval IS INITIAL.

    CREATE OBJECT gc_grid_topeval

      EXPORTING i_parent = gc_container_topeval.

  ENDIF.



  IF gc_grid_toppay IS INITIAL.

    CREATE OBJECT gc_grid_toppay

      EXPORTING i_parent = gc_container_toppay.

  ENDIF.



  IF gc_grid_bottom IS INITIAL.

    CREATE OBJECT gc_grid_bottom

      EXPORTING i_parent = gc_container_bottom.

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

  PERFORM FIELD_CATALOG_B.

  PERFORM FIELD_CATALOG_L.

  PERFORM FIELD_CATALOG_R.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG_B : ####

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG_B .

  CLEAR: GS_FIELDCAT, GT_FIELDCAT1.

  REFRESH GT_FIELDCAT1.



  " ICON

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 1.

  GS_FIELDCAT-FIELDNAME = 'ICON'.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-ICON      = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 2.

  GS_FIELDCAT-KEY       = 'X'.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 3.

  GS_FIELDCAT-FIELDNAME = 'ZPNAME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 4.

  GS_FIELDCAT-FIELDNAME = 'ZDEPCODE_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 5.

  GS_FIELDCAT-FIELDNAME = 'DATBI'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 6.

  GS_FIELDCAT-FIELDNAME = 'DATAB'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 7.

  GS_FIELDCAT-FIELDNAME = 'ZRANK_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 8.

  GS_FIELDCAT-FIELDNAME = 'ZGENDER_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 9.

  GS_FIELDCAT-FIELDNAME = 'ZEDATE'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 10.

  GS_FIELDCAT-FIELDNAME = 'ZADDRESS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  " ## ## ##

  IF P_CH1 = 'X'.

    CLEAR GS_FIELDCAT.

    GS_FIELDCAT-COL_POS   = 11.

    GS_FIELDCAT-FIELDNAME = 'ZQDATE'.

    GS_FIELDCAT-SCRTEXT_M = '####'.

    GS_FIELDCAT-OUTPUTLEN = '10'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT1.



    CLEAR GS_FIELDCAT.

    GS_FIELDCAT-COL_POS   = 12.

    GS_FIELDCAT-FIELDNAME = 'ZQFLAG'.

    GS_FIELDCAT-SCRTEXT_M = '####'.

    GS_FIELDCAT-OUTPUTLEN = '8'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT1.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG_L : ##

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG_L .

  CLEAR: GS_FIELDCAT, GT_FIELDCAT2.

  REFRESH GT_FIELDCAT2.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 1.

  GS_FIELDCAT-KEY       = 'X'.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 2.

  GS_FIELDCAT-FIELDNAME = 'ZDEPCODE_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 3.

  GS_FIELDCAT-FIELDNAME = 'ZYEAR'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 4.

  GS_FIELDCAT-FIELDNAME = 'DATBI'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 5.

  GS_FIELDCAT-FIELDNAME = 'DATAB'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 6.

  GS_FIELDCAT-FIELDNAME = 'ZRANK'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.





ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG_R : ##

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG_R .

  CLEAR: GS_FIELDCAT, GT_FIELDCAT3.

  REFRESH GT_FIELDCAT3.



  CLEAR GS_FIELDCAT.



   GS_FIELDCAT-COL_POS   = 1.

  GS_FIELDCAT-KEY       = 'X'.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 2.

  GS_FIELDCAT-FIELDNAME = 'ZYEAR'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 3.

  GS_FIELDCAT-FIELDNAME = 'DATBI'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 4.

  GS_FIELDCAT-FIELDNAME = 'DATAB'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 5.

  GS_FIELDCAT-FIELDNAME = 'ZSALARY'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-DO_SUM    = 'X'.

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'.  " ## ##

  GS_FIELDCAT-OUTPUTLEN = '16'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 6.

  GS_FIELDCAT-FIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-NO_OUT    = 'X'.        " #### ####

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 7.

  GS_FIELDCAT-FIELDNAME = 'ZBANK_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 8.

  GS_FIELDCAT-FIELDNAME = 'ZACCOUNT'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.





ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM modify_data .

  DATA: ls_emp       LIKE LINE OF gt_emp,

        ls_emp_alv   LIKE LINE OF gt_emp_alv,

        ls_eval      LIKE LINE OF gt_eval,

        ls_eval_alv  LIKE LINE OF gt_eval_alv,

        ls_pay       LIKE LINE OF gt_pay,

        ls_pay_alv   LIKE LINE OF gt_pay_alv,

        lv_depname   TYPE c LENGTH 10,

        lv_rankname  TYPE c LENGTH 8.



  " ##: ## ## ## (##, ## ####)

  SORT gt_eval BY zpernr datab DESCENDING datbi DESCENDING.



  "##(##) ALV

  CLEAR gt_emp_alv.

  LOOP AT gt_emp INTO ls_emp.

    CLEAR ls_emp_alv.

    MOVE-CORRESPONDING ls_emp TO ls_emp_alv.



    " ###(## ##)

    CONCATENATE '##' ls_emp-zdepcode INTO ls_emp_alv-zdepcode_name.



    " ## ##

    IF ls_emp-zgender = 'M'.

      ls_emp_alv-zgender_name = '##'.

    ELSEIF ls_emp-zgender = 'F'.

      ls_emp_alv-zgender_name = '##'.

    ELSE.

      ls_emp_alv-zgender_name = '##'.

    ENDIF.



    " ###: ##(102)# ZDEPRANK ##

    CASE ls_emp-zdeprank.

  WHEN 'A'. ls_emp_alv-zrank_name = '##'.

  WHEN 'B'. ls_emp_alv-zrank_name = '##'.

  WHEN 'C'. ls_emp_alv-zrank_name = '##'.

  WHEN 'D'. ls_emp_alv-zrank_name = '##'.

  WHEN 'E'. ls_emp_alv-zrank_name = '##'.

  WHEN 'F'. ls_emp_alv-zrank_name = '##'.

  WHEN 'G'. ls_emp_alv-zrank_name = '##'.

  WHEN OTHERS. CONCATENATE '##' ls_emp-zdeprank INTO ls_emp_alv-zrank_name.

ENDCASE.





    " ## ###

    IF ls_emp-zqflag = 'X'.        ls_emp_alv-icon = '@0A@'.  "##

    ELSEIF ls_emp-zdeprank = 'A'.  ls_emp_alv-icon = '@09@'.  "##

    ELSE.                          ls_emp_alv-icon = '@08@'.  "##

    ENDIF.





    APPEND ls_emp_alv TO gt_emp_alv.

  ENDLOOP.



  "##-#(##) ALV

  CLEAR gt_pay_alv.

  FIELD-SYMBOLS <l_bank> TYPE any.

  LOOP AT gt_pay INTO ls_pay.

    CLEAR ls_pay_alv.

    MOVE-CORRESPONDING ls_pay TO ls_pay_alv.



    " #### ### ##(ZBANKCODE ## ZBANK)

    ASSIGN COMPONENT 'ZBANKCODE' OF STRUCTURE ls_pay TO <l_bank>.

    IF sy-subrc <> 0.

      ASSIGN COMPONENT 'ZBANK' OF STRUCTURE ls_pay TO <l_bank>.

    ENDIF.



    IF <l_bank> IS ASSIGNED.

      IF <l_bank> GE '001' AND <l_bank> LE '010'.

        ls_pay_alv-zwaers = 'KRW'.

      ELSE.

        ls_pay_alv-zwaers = 'KRW'. " ##

      ENDIF.

      CONCATENATE '##' <l_bank> INTO ls_pay_alv-zbank_name.

    ELSE.

      ls_pay_alv-zwaers     = 'KRW'.

      ls_pay_alv-zbank_name = ''.

    ENDIF.



    APPEND ls_pay_alv TO gt_pay_alv.

  ENDLOOP.



  "##-#(##) ALV

  CLEAR gt_eval_alv.

  LOOP AT gt_eval INTO ls_eval.

    CLEAR ls_eval_alv.

    ls_eval_alv-zpernr = ls_eval-zpernr.

    ls_eval_alv-zyear  = ls_eval-zyear.

    ls_eval_alv-datab  = ls_eval-datab.

    ls_eval_alv-datbi  = ls_eval-datbi.

    ls_eval_alv-zrank  = ls_eval-zrank.

    CONCATENATE '##' ls_eval-zdepcode INTO ls_eval_alv-zdepcode_name.

    APPEND ls_eval_alv TO gt_eval_alv.

  ENDLOOP.

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

  CLEAR: gt_sort1, gt_sort2, gt_sort3, gs_sort.



  " ##(##)

  gs_sort-spos = 1. gs_sort-fieldname = 'ZPERNR'. gs_sort-up = 'X'.

  APPEND gs_sort TO gt_sort1. CLEAR gs_sort.



  " ##-#(##)

  gs_sort-spos = 1. gs_sort-fieldname = 'ZPERNR'. gs_sort-up = 'X'.

  APPEND gs_sort TO gt_sort2. CLEAR gs_sort.



  " ##-#(##)

  gs_sort-spos = 1. gs_sort-fieldname = 'ZPERNR'. gs_sort-up = 'X'.

  APPEND gs_sort TO gt_sort3. CLEAR gs_sort.



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

  CLEAR gs_layout.

  gs_layout-zebra      = 'X'.

  gs_layout-cwidth_opt = 'X'.

  gs_layout-sel_mode   = 'A'.

  gs_layout-totals_bef = 'X'.



  CLEAR gs_variant.

  gs_variant-report   = sy-repid.

  gs_variant-username = sy-uname.





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



  " ##-#: ##

  IF gc_grid_topeval IS BOUND.

    CALL METHOD gc_grid_topeval->set_table_for_first_display

      EXPORTING is_layout       = gs_layout

      CHANGING  it_outtab       = gt_eval_alv

               it_fieldcatalog  = gt_fieldcat2

               it_sort          = gt_sort2.

  ENDIF.



  " ##-#: ##

  IF gc_grid_toppay IS BOUND.

    CALL METHOD gc_grid_toppay->set_table_for_first_display

      EXPORTING is_layout       = gs_layout

      CHANGING  it_outtab       = gt_pay_alv

               it_fieldcatalog  = gt_fieldcat3

               it_sort          = gt_sort3.

  ENDIF.



  " ##: ##

  IF gc_grid_bottom IS BOUND.

    CALL METHOD gc_grid_bottom->set_table_for_first_display

      EXPORTING is_layout       = gs_layout

      CHANGING  it_outtab       = gt_emp_alv

               it_fieldcatalog  = gt_fieldcat1

               it_sort          = gt_sort1.

  ENDIF.





ENDFORM.