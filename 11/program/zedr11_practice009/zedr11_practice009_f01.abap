
*&---------------------------------------------------------------------*

*& Include ZEDR11_PRACTICE009_F01

*&---------------------------------------------------------------------*






FORM init_dates.

  IF s_date[] IS INITIAL.

    s_date-low    = sy-datum(6) && '01'.

    s_date-sign   = 'I'.

    s_date-option = 'EQ'.



    CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

      EXPORTING

        day_in            = s_date-low

      IMPORTING

        last_day_of_month = s_date-low.

    APPEND s_date.

  ENDIF.

ENDFORM.



FORM check_input.

  " [##] ## ### ## ## (1 -> 0000000001)

  IF s_emp[] IS NOT INITIAL.

    LOOP AT s_emp.

      IF s_emp-low IS NOT INITIAL.

        CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'

          EXPORTING input = s_emp-low IMPORTING output = s_emp-low.

      ENDIF.

      IF s_emp-high IS NOT INITIAL.

        CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'

          EXPORTING input = s_emp-high IMPORTING output = s_emp-high.

      ENDIF.

      MODIFY s_emp.

    ENDLOOP.

  ENDIF.



  " ### ### ### ## ### ## ## ##

  " IF s_date IS INITIAL.

  "   MESSAGE i000 WITH '##### #####.'. STOP.

  " ENDIF.



  CLEAR : r_stat, r_stat[].

  r_stat-sign   = 'I'.

  r_stat-option = 'EQ'.

  r_stat-low    = space.

  APPEND r_stat.



  IF p_ret = c_x.

    r_stat-low = 'X'.

    APPEND r_stat.

  ENDIF.

ENDFORM.



FORM select_data.

  " 1. ## ## ## (ZEDT07_... ### ##)

  SELECT a~zpernr a~zdeprank a~zdepcode a~datbi a~datab a~zedate a~zqdate a~zqflag

         b~zpname b~zgender b~zaddress

    INTO CORRESPONDING FIELDS OF TABLE gt_emp_m

    FROM zedt07_102 AS a

    LEFT OUTER JOIN zedt07_103 AS b ON a~zpernr = b~zpernr

    WHERE a~zpernr IN s_emp.

    " [##] ### ### ## ### ### ## ## ##

    " AND a~zdepcode IN s_dep

    " AND ( datab <= s_date-low AND datbi >= s_date-low )

    " AND zqflag IN r_stat.



  IF gt_emp_m[] IS NOT INITIAL.

    " 2. ## ## ## (ZEDT07_106)

    SELECT * FROM zedt07_106

      INTO CORRESPONDING FIELDS OF TABLE gt_pay

      FOR ALL ENTRIES IN gt_emp_m

      WHERE zpernr = gt_emp_m-zpernr.



    " 3. ## ## ## (ZEDT07_104)

    SELECT * FROM zedt07_104

      INTO CORRESPONDING FIELDS OF TABLE gt_score

      FOR ALL ENTRIES IN gt_emp_m

      WHERE zpernr   = gt_emp_m-zpernr

        AND zdepcode = gt_emp_m-zdepcode.

  ENDIF.

ENDFORM.



FORM process_data.

  CLEAR : gs_emp_m, gs_emp_out, gs_pay, gs_pay_out, gs_score, gs_score_out.



  " 1. Main Data

  LOOP AT gt_emp_m INTO gs_emp_m.

    MOVE-CORRESPONDING gs_emp_m TO gs_emp_out.

    PERFORM get_desc USING 'ZDEPCODE' gs_emp_m-zdepcode CHANGING gs_emp_out-dep_txt.

    PERFORM get_desc USING 'ZDEPRANK' gs_emp_m-zdeprank CHANGING gs_emp_out-rank_txt.



    gs_emp_out-gen_txt = COND #( WHEN gs_emp_m-zgender = 'M' THEN '##'

                                 WHEN gs_emp_m-zgender = 'F' THEN '##'

                                 ELSE gs_emp_m-zgender ).



    IF gs_emp_m-zqflag = 'X'.

      gs_emp_out-icon = '@0A@'.

    ELSE.

      gs_emp_out-icon = COND #( WHEN gs_emp_m-zdeprank = 'A' THEN '@09@' ELSE '@08@' ).

    ENDIF.

    APPEND gs_emp_out TO gt_emp_out.

  ENDLOOP.



  " 2. Pay Data

  LOOP AT gt_pay INTO gs_pay.

    MOVE-CORRESPONDING gs_pay TO gs_pay_out.

    PERFORM get_desc USING 'ZBANKCODE' gs_pay-zbankcode CHANGING gs_pay_out-bank_txt.

    IF gs_pay-zbankcode BETWEEN '001' AND '010'.

      gs_pay_out-waers = 'KRW'.

    ENDIF.

    APPEND gs_pay_out TO gt_pay_out.

  ENDLOOP.



  " 3. Score Data

  LOOP AT gt_score INTO gs_score.

    MOVE-CORRESPONDING gs_score TO gs_score_out.

    PERFORM get_desc USING 'ZDEPCODE' gs_score-zdepcode CHANGING gs_score_out-dep_txt.

    APPEND gs_score_out TO gt_score_out.

  ENDLOOP.

ENDFORM.



FORM get_desc USING p_type p_code CHANGING p_name.

  CASE p_type.

    WHEN 'ZDEPCODE'.

      CASE p_code.

        WHEN 'SS0001'. p_name = '###'.

        WHEN 'SS0002'. p_name = '###'.

        WHEN 'SS0003'. p_name = '###'.

        WHEN 'SS0004'. p_name = '###'.

        WHEN 'SS0005'. p_name = '###'.

        WHEN 'SS0006'. p_name = '###'.

      ENDCASE.

    WHEN 'ZDEPRANK'.

      CASE p_code.

        WHEN 'A'. p_name = '##'.

        WHEN 'B'. p_name = '##'.

        WHEN 'C'. p_name = '##'.

        WHEN 'D'. p_name = '##'.

        WHEN 'E'. p_name = '##'.

        WHEN 'F'. p_name = '##'.

        WHEN 'G'. p_name = '##'.

      ENDCASE.

    WHEN 'ZBANKCODE'.

      CASE p_code.

        WHEN '001'. p_name = '####'.

        WHEN '002'. p_name = '####'.

        WHEN '003'. p_name = '####'.

        WHEN '004'. p_name = '####'.

        WHEN '005'. p_name = '#####'.

      ENDCASE.

  ENDCASE.

ENDFORM.



FORM show_progress USING p_text.

  CALL FUNCTION 'SAPGUI_PROGRESS_INDICATOR' EXPORTING text = p_text.

ENDFORM.



FORM create_object.

  IF go_dock IS NOT INITIAL.

    EXIT.

  ENDIF.



  CREATE OBJECT go_dock

    EXPORTING repid = sy-repid dynnr = sy-dynnr extension = 2000.



  CREATE OBJECT go_split_vert

    EXPORTING parent = go_dock rows = 2 columns = 1.



  go_c_top = go_split_vert->get_container( row = 1 column = 1 ).

  go_c_bot = go_split_vert->get_container( row = 2 column = 1 ).



  CREATE OBJECT go_split_hori

    EXPORTING parent = go_c_bot rows = 1 columns = 2.



  go_c_bot_l = go_split_hori->get_container( row = 1 column = 1 ).

  go_c_bot_r = go_split_hori->get_container( row = 1 column = 2 ).



  CREATE OBJECT go_alv_top   EXPORTING i_parent = go_c_top.

  CREATE OBJECT go_alv_bot_l EXPORTING i_parent = go_c_bot_l.

  CREATE OBJECT go_alv_bot_r EXPORTING i_parent = go_c_bot_r.

ENDFORM.



FORM set_field_cat.

  DEFINE _add_fcat.

    clear gs_fcat.

    gs_fcat-col_pos   = &1.

    gs_fcat-fieldname = &2.

    gs_fcat-coltext   = &3.

    gs_fcat-outputlen = &4.

    gs_fcat-key       = &5.

    gs_fcat-icon      = &6.

    gs_fcat-do_sum    = &7.

    gs_fcat-no_out    = &8.



    " [##] #### '0' ## ## (1 -> 0000000001)

    IF &2 EQ 'ZPERNR'.

      gs_fcat-convexit = ' '.

    ENDIF.



    append gs_fcat to &9.

  END-OF-DEFINITION.



  " 1. Top Grid

  _add_fcat 1  'ICON'      '##'      4   ''   'X' '' '' gt_fcat_t.

  _add_fcat 2  'ZPERNR'    '####'  10  'X'  ''  '' '' gt_fcat_t.

  _add_fcat 3  'ZPNAME'    '##'      10  ''   ''  '' '' gt_fcat_t.

  _add_fcat 4  'DEP_TXT'   '##'      15  ''   ''  '' '' gt_fcat_t.

  _add_fcat 5  'DATBI'     '###'    10  ''   ''  '' '' gt_fcat_t.

  _add_fcat 6  'DATAB'     '###'    10  ''   ''  '' '' gt_fcat_t.

  _add_fcat 7  'RANK_TXT'  '##'      10  ''   ''  '' '' gt_fcat_t.

  _add_fcat 8  'GEN_TXT'   '##'      6   ''   ''  '' '' gt_fcat_t.

  _add_fcat 9  'ZEDATE'    '###'    10  ''   ''  '' '' gt_fcat_t.

  _add_fcat 10 'ZADDRESS'  '##'      20  ''   ''  '' '' gt_fcat_t.



  IF p_ret = c_x.

    _add_fcat 11 'ZQDATE' '###' 10 '' '' '' '' gt_fcat_t.

    _add_fcat 12 'ZQFLAG' '##'   4  '' '' '' '' gt_fcat_t.

  ENDIF.



  " 2. Bot-Right

  _add_fcat 1  'ZPERNR'   '####'  10  'X' '' ''  ''  gt_fcat_br.

  _add_fcat 2  'ZYEAR'    '##'      6   ''  '' ''  ''  gt_fcat_br.

  _add_fcat 3  'DATBI'    '###'    10  ''  '' ''  ''  gt_fcat_br.

  _add_fcat 4  'DATAB'    '###'    10  ''  '' ''  ''  gt_fcat_br.

  _add_fcat 5  'ZSALARY'  '###'    16  ''  '' 'X' ''  gt_fcat_br.

  _add_fcat 6  'WAERS'    '##'      5   ''  '' ''  'X' gt_fcat_br.

  _add_fcat 7  'BANK_TXT' '###'    15  ''  '' ''  ''  gt_fcat_br.

  _add_fcat 8  'ZACCOUNT' '####'  20  ''  '' ''  ''  gt_fcat_br.



  " 3. Bot-Left

  _add_fcat 1  'ZPERNR'   '####'  10  'X' '' ''  ''  gt_fcat_bl.

  _add_fcat 2  'DEP_TXT'  '##'      15  ''  '' ''  ''  gt_fcat_bl.

  _add_fcat 3  'ZYEAR'    '##'      6   ''  '' ''  ''  gt_fcat_bl.

  _add_fcat 4  'DATBI'    '###'    10  ''  '' ''  ''  gt_fcat_bl.

  _add_fcat 5  'DATAB'    '###'    10  ''  '' ''  ''  gt_fcat_bl.

  _add_fcat 6  'ZRANK'    '##'      5   ''  '' ''  ''  gt_fcat_bl.

ENDFORM.



FORM set_layout.

  gs_layout-zebra      = 'X'.

  gs_layout-totals_bef = 'X'.

  gs_variant-report    = sy-repid.

ENDFORM.



FORM set_sort.

  CLEAR : gs_sort, gt_sort.

  gs_sort-spos      = 1.

  gs_sort-fieldname = 'ZPERNR'.

  gs_sort-up        = 'X'.

  APPEND gs_sort TO gt_sort.

ENDFORM.



FORM display_alv.

  CALL METHOD go_alv_top->set_table_for_first_display

    EXPORTING is_layout = gs_layout is_variant = gs_variant i_save = 'A'

    CHANGING  it_outtab = gt_emp_out it_fieldcatalog = gt_fcat_t it_sort = gt_sort.



  CALL METHOD go_alv_bot_l->set_table_for_first_display

    EXPORTING is_layout = gs_layout is_variant = gs_variant i_save = 'A'

    CHANGING  it_outtab = gt_score_out it_fieldcatalog = gt_fcat_bl it_sort = gt_sort.



  CALL METHOD go_alv_bot_r->set_table_for_first_display

    EXPORTING is_layout = gs_layout is_variant = gs_variant i_save = 'A'

    CHANGING  it_outtab = gt_pay_out it_fieldcatalog = gt_fcat_br it_sort = gt_sort.

ENDFORM.