
*&---------------------------------------------------------------------*

*& Report ZEDR07_PRACTICE007

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR07_PRACTICE007.



TABLES : zedt07_101, zedt07_102, zedt07_103, zedt07_104, zedt07_105, zedt07_106.



" ## ### ###

DATA : BEGIN OF gs_emp,

  zpernr TYPE zedt07_102-zpernr, "####

  zpname TYPE zedt07_103-zpname, "####

  zdepcode TYPE zedt07_102-zdepcode, "####

  zdepname TYPE char20, "###

  zdeprank TYPE zedt07_102-zdeprank, "####

  zrankname TYPE char20, "###

  zedate TYPE zedt07_102-zedate, "###

  zqdate TYPE zedt07_102-zqdate, "###

  zqflag TYPE zedt07_102-zqflag, "####

  zqflag_t TYPE char4, "####(##)

  zgender TYPE zedt07_103-zgender, "##

  zaddress TYPE zedt07_103-zaddress, "##

  zbankcode TYPE zedt07_106-zbankcode, "####

  zbankname TYPE char20, "###

  zaccount TYPE zedt07_106-zaccount, "####

  END OF gs_emp.



"## ### ###

DATA : BEGIN OF gs_sal,

  zpernr TYPE zedt07_102-zpernr, "####

  zpname TYPE zedt07_103-zpname, "####

  zdepcode TYPE zedt07_102-zdepcode, "####

  zdepname TYPE char20, "###

  zdeprank TYPE zedt07_102-zdeprank, "####

  zrankname TYPE char20, "###

  zedate TYPE zedt07_102-zedate, "###

  zqdate TYPE zedt07_102-zqdate, "###

  zqflag TYPE zedt07_102-zqflag, "####

  zsalary TYPE zedt07_106-zsalary, "####

  zpay_amt TYPE zedt07_106-zsalary, "###

  zrank TYPE zedt07_104-zrank, "####

  zmon01 TYPE zedt07_105-zmon01,

  zmon02 TYPE zedt07_105-zmon02,

  zmon03 TYPE zedt07_105-zmon03,

  zmon04 TYPE zedt07_105-zmon04,

  zmon05 TYPE zedt07_105-zmon05,

  zmon06 TYPE zedt07_105-zmon06,

  zmon07 TYPE zedt07_105-zmon07,

  zmon08 TYPE zedt07_105-zmon08,

  zmon09 TYPE zedt07_105-zmon09,

  zmon10 TYPE zedt07_105-zmon10,

  zmon11 TYPE zedt07_105-zmon11,

  zmon12 TYPE zedt07_105-zmon12,

  END OF gs_sal.



"## ### ###

DATA: BEGIN OF gs_eval,

  zpernr    TYPE zedt07_102-zpernr,      "####

  zpname    TYPE zedt07_103-zpname,      "####

  zdepcode  TYPE zedt07_102-zdepcode,    "####

  zdepname  TYPE char20,                 "###

  zdeprank  TYPE zedt07_102-zdeprank,    "####

  zrankname TYPE char20,                 "###

  zqflag    TYPE zedt07_102-zqflag,      "####

  zqflag_t  TYPE char10,                 "####(##)

  zrank     TYPE zedt07_104-zrank,       "####

  zsalary   TYPE zedt07_106-zsalary,     "####



  "----- 12## ### ## (ALV ## ### ## ### ##) -----

  zmon01 TYPE zedt07_105-zmon01,

  zmon02 TYPE zedt07_105-zmon02,

  zmon03 TYPE zedt07_105-zmon03,

  zmon04 TYPE zedt07_105-zmon04,

  zmon05 TYPE zedt07_105-zmon05,

  zmon06 TYPE zedt07_105-zmon06,

  zmon07 TYPE zedt07_105-zmon07,

  zmon08 TYPE zedt07_105-zmon08,

  zmon09 TYPE zedt07_105-zmon09,

  zmon10 TYPE zedt07_105-zmon10,

  zmon11 TYPE zedt07_105-zmon11,

  zmon12 TYPE zedt07_105-zmon12,

END OF gs_eval.



CONSTANTS : c_check TYPE c VALUE 'X',

  c_male TYPE c VALUE 'M',

  c_female TYPE c VALUE 'F',

  c_rank_a TYPE c VALUE 'A',

  c_bonus TYPE p DECIMALS 2 VALUE '50000.00',

  c_quit TYPE c VALUE 'X',

  c_active TYPE char10 VALUE '##',

  c_quit_t TYPE char10 VALUE '##',

  c_zero TYPE p DECIMALS 2 VALUE 0.



DATA : gt_emp LIKE TABLE OF gs_emp,

       gt_sal LIKE TABLE OF gs_sal,

       gt_eval LIKE TABLE OF gs_eval.






*ALV ##




DATA : gt_fcat TYPE slis_t_fieldcat_alv,

      gs_fcat TYPE slis_fieldcat_alv,

      gt_sort TYPE slis_t_sortinfo_alv,

      gs_sort TYPE slis_sortinfo_alv,

      gs_layout TYPE slis_layout_alv.






*RANGES




RANGES : r_date FOR zedt07_102-datab,

         r_pernr FOR zedt07_102-zpernr,

         r_year FOR zedt07_104-zyear.






*SCREEN




SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.

  SELECT-OPTIONS s_pernr FOR zedt07_102-zpernr MODIF ID all.

  SELECT-OPTIONS s_date FOR zedt07_102-datab MODIF ID m1.

  SELECT-OPTIONS s_dept FOR zedt07_102-zdepcode MODIF ID m1.

  PARAMETERS : p_year TYPE zedt07_104-zyear MODIF ID m2,

               p_month TYPE numc2 MODIF ID m2.

SELECTION-SCREEN END OF BLOCK b1.



SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME.

  PARAMETERS : p_rad1 RADIOBUTTON GROUP rb1 DEFAULT 'X' USER-COMMAND uc1,

               p_rad2 RADIOBUTTON GROUP rb1,

               p_rad3 RADIOBUTTON GROUP rb1.

SELECTION-SCREEN END OF BLOCK b2.



SELECTION-SCREEN BEGIN OF BLOCK b3 WITH FRAME.

  PARAMETERS : p_ch1 AS CHECKBOX DEFAULT 'X' MODIF ID m1.

SELECTION-SCREEN END OF BLOCK b3.



INITIALIZATION.

  PERFORM get_last_day.



AT SELECTION-SCREEN OUTPUT.

  PERFORM set_screen.



AT SELECTION-SCREEN.

  PERFORM check_input.



START-OF-SELECTION.

  PERFORM main_process.



END-OF-SELECTION.






*---------------------------------------------------------------------*

* FORM GET_LAST_DAY

*---------------------------------------------------------------------*




FORM GET_LAST_DAY .

  p_year = sy-datum(4).

  p_month = sy-datum+4(2).



  s_date-sign = 'I'.

  s_date-option = 'BT'.

  s_date-low = sy-datum(4) && '0101'.



  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

    EXPORTING

      day_in = sy-datum

    IMPORTING

      last_day_of_month = s_date-high.



  APPEND s_date.

ENDFORM.






*---------------------------------------------------------------------*

* FORM SET_SCREEN

*---------------------------------------------------------------------*




FORM SET_SCREEN .

  LOOP AT SCREEN.

    CASE screen-group1.

      WHEN 'M1'.

        screen-active = COND #( WHEN p_rad1 = c_check THEN 1 ELSE 0 ).

      WHEN 'M2'.

        screen-active = COND #( WHEN p_rad2 = c_check OR p_rad3 = c_check THEN 1 ELSE 0 ).

      WHEN 'ALL'.

        screen-active = 1.

    ENDCASE.

    MODIFY SCREEN.

  ENDLOOP.

ENDFORM.






*---------------------------------------------------------------------*

* FORM CHECK_INPUT

*---------------------------------------------------------------------*




FORM CHECK_INPUT .

  IF p_rad1 = c_check.

    IF s_date[] IS INITIAL.

      MESSAGE '##### ######' TYPE 'E'.

    ENDIF.

  ELSEIF p_rad2 = c_check.

    IF p_year IS INITIAL OR p_month IS INITIAL.

      MESSAGE '### ## ## ######' TYPE 'E'.

    ENDIF.

    IF p_month < 1 OR p_month > 12.

      MESSAGE '## 1~12 #### ###.' TYPE 'E'.

    ENDIF.

  ELSEIF p_rad3 = c_check.

    IF p_year IS INITIAL.

      MESSAGE '##### ######' TYPE 'E'.

    ENDIF.

  ENDIF.

ENDFORM.






*---------------------------------------------------------------------*

* FORM MAIN_PROCESS

*---------------------------------------------------------------------*




FORM MAIN_PROCESS .

  IF p_rad1 = c_check.

    PERFORM get_emp_info.

    PERFORM display_emp.

  ELSEIF p_rad2 = c_check.

    PERFORM get_pay_info.

    PERFORM display_pay.

  ELSEIF p_rad3 = c_check.

    PERFORM get_eval_info.

    PERFORM display_eval.

  ENDIF.

ENDFORM.






*---------------------------------------------------------------------*

* FORM GET_EMP_INFO

*---------------------------------------------------------------------*




FORM GET_EMP_INFO .

  SELECT

    a~zpernr, a~zdeprank, a~zdepcode, a~zedate, a~zqdate, a~zqflag,

    b~zgender, b~zpname, b~zaddress,

    c~zbankcode, c~zaccount

    FROM zedt07_102 AS a

    LEFT OUTER JOIN zedt07_103 AS b ON a~zpernr = b~zpernr

    LEFT OUTER JOIN zedt07_106 AS c ON a~zpernr = c~zpernr

    WHERE a~zpernr IN @s_pernr

      AND a~zedate IN @s_date

    INTO CORRESPONDING FIELDS OF TABLE @gt_emp.



  IF p_ch1 = c_check.

    DELETE gt_emp WHERE zqflag = c_quit AND zqdate IS NOT INITIAL.

  ELSE.

    DELETE gt_emp WHERE zqflag = c_quit AND zqdate <= s_date-high.

  ENDIF.



  PERFORM convert_ko.

ENDFORM.






*---------------------------------------------------------------------*

* FORM CONVERT_KO

*---------------------------------------------------------------------*




FORM CONVERT_KO .

  LOOP AT gt_emp INTO gs_emp.

    CASE gs_emp-zgender.

      WHEN c_male. gs_emp-zgender = '##'.

      WHEN c_female. gs_emp-zgender = '##'.

    ENDCASE.



    gs_emp-zqflag_t = COND #( WHEN gs_emp-zqflag IS NOT INITIAL THEN c_quit_t ELSE c_active ).



    CASE gs_emp-zdepcode.

      WHEN 'SS0001'. gs_emp-zdepname = '###'.

      WHEN 'SS0002'. gs_emp-zdepname = '###'.

      WHEN 'SS0003'. gs_emp-zdepname = '###'.

      WHEN 'SS0004'. gs_emp-zdepname = '###'.

      WHEN 'SS0005'. gs_emp-zdepname = '###'.

      WHEN 'SS0006'. gs_emp-zdepname = '###'.

    ENDCASE.



    CASE gs_emp-zdeprank.

      WHEN 'A'. gs_emp-zrankname = '##'.

      WHEN 'B'. gs_emp-zrankname = '##'.

      WHEN 'C'. gs_emp-zrankname = '##'.

      WHEN 'D'. gs_emp-zrankname = '##'.

      WHEN 'E'. gs_emp-zrankname = '##'.

      WHEN 'F'. gs_emp-zrankname = '##'.

      WHEN 'G'. gs_emp-zrankname = '##'.

    ENDCASE.



    CASE gs_emp-zbankcode.

      WHEN '001'. gs_emp-zbankname = '##'.

      WHEN '002'. gs_emp-zbankname = '##'.

      WHEN '003'. gs_emp-zbankname = '##'.

      WHEN '004'. gs_emp-zbankname = '##'.

      WHEN '005'. gs_emp-zbankname = '###'.

    ENDCASE.



    MODIFY gt_emp FROM gs_emp.

  ENDLOOP.

ENDFORM.






*---------------------------------------------------------------------*

* FORM DISPLAY_EMP

*---------------------------------------------------------------------*




FORM DISPLAY_EMP .

  PERFORM set_fieldcat_emp.

  PERFORM set_sort_emp.



  gs_layout-zebra = 'X'.

  gs_layout-colwidth_optimize = 'X'.



  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

    EXPORTING

      i_callback_program = sy-repid

      is_layout = gs_layout

      it_fieldcat = gt_fcat

      it_sort = gt_sort

    TABLES

      t_outtab = gt_emp.

ENDFORM.






*---------------------------------------------------------------------*

* FORM SET_FIELDCAT_EMP

*---------------------------------------------------------------------*




FORM SET_FIELDCAT_EMP .

  CLEAR gt_fcat.



  PERFORM add_fcat USING 'ZPERNR' '####' '10'.

  PERFORM add_fcat USING 'ZPNAME' '####' '15'.

  PERFORM add_fcat USING 'ZDEPCODE' '####' '10'.

  PERFORM add_fcat USING 'ZDEPNAME' '###' '10'.

  PERFORM add_fcat USING 'ZRANKNAME' '###' '10'.

  PERFORM add_fcat USING 'ZEDATE' '###' '10'.

  PERFORM add_fcat USING 'ZQFLAG_T' '####' '10'.

  PERFORM add_fcat USING 'ZGENDER' '##' '10'.

  PERFORM add_fcat USING 'ZADDRESS' '##' '20'.

  PERFORM add_fcat USING 'ZBANKCODE' '####' '10'.

  PERFORM add_fcat USING 'ZBANKNAME' '###' '10'.

  PERFORM add_fcat USING 'ZACCOUNT' '####' '20'.

ENDFORM.






*---------------------------------------------------------------------*

* FORM ADD_FCAT

*---------------------------------------------------------------------*




FORM ADD_FCAT USING p_fieldname TYPE char30 p_text TYPE char50 p_outputlen TYPE char10.

  CLEAR gs_fcat.

  gs_fcat-fieldname = p_fieldname.

  gs_fcat-seltext_m = p_text.

  gs_fcat-outputlen = p_outputlen.

  APPEND gs_fcat TO gt_fcat.

ENDFORM.






*---------------------------------------------------------------------*

* FORM SET_SORT_EMP

*---------------------------------------------------------------------*




FORM SET_SORT_EMP .

  CLEAR gt_sort.

  gs_sort-fieldname = 'ZPERNR'. gs_sort-up = 'X'. APPEND gs_sort TO gt_sort.

  gs_sort-fieldname = 'ZDEPCODE'. gs_sort-up = 'X'. APPEND gs_sort TO gt_sort.

ENDFORM.






*---------------------------------------------------------------------*

* FORM GET_PAY_INFO

*---------------------------------------------------------------------*




FORM GET_PAY_INFO .



  DATA : lv_last_day TYPE d,

         lv_dayin TYPE d,

         lv_amt TYPE p DECIMALS 2,

         lv_flag TYPE c VALUE 'X',

         ls_mon TYPE zedt07_105.



  CONCATENATE p_year p_month '01' INTO lv_dayin.



  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

    EXPORTING day_in = lv_dayin

    IMPORTING last_day_of_month = lv_last_day.



  CLEAR gt_sal.



  SELECT

    a~zpernr, a~zdepcode, a~zdeprank, a~zedate, a~zqflag, a~zqdate,

    b~zpname, c~zsalary, d~zrank

    FROM zedt07_102 AS a

    INNER JOIN zedt07_103 AS b ON a~zpernr = b~zpernr

    LEFT JOIN zedt07_106 AS c ON a~zpernr = c~zpernr

    LEFT JOIN zedt07_104 AS d ON a~zpernr = d~zpernr AND d~zyear = @p_year

    WHERE a~zpernr IN @s_pernr

    INTO CORRESPONDING FIELDS OF TABLE @gt_sal.



  DELETE gt_sal WHERE zedate > lv_last_day.

  DELETE gt_sal WHERE zqflag = c_quit AND zqdate <= lv_last_day.



  LOOP AT gt_sal INTO gs_sal.



    lv_amt = ( gs_sal-zsalary * 100 ) / 12.

    IF gs_sal-zrank = 'A'.

      lv_amt = lv_amt + 50000.

    ENDIF.



    SELECT SINGLE * FROM zedt07_105 INTO @ls_mon

      WHERE zpernr = @gs_sal-zpernr AND zyear = @p_year.



    IF sy-subrc <> 0.

      CLEAR ls_mon.

      ls_mon-zpernr = gs_sal-zpernr.

      ls_mon-zyear = p_year.

    ENDIF.



    DATA(lv_fieldname) = |ZMON{ p_month }|.

    FIELD-SYMBOLS <fs_mon> TYPE any.



    ASSIGN COMPONENT lv_fieldname OF STRUCTURE ls_mon TO <fs_mon>.

    IF sy-subrc = 0.

      <fs_mon> = lv_amt.

    ENDIF.



    ASSIGN COMPONENT lv_fieldname OF STRUCTURE gs_sal TO <fs_mon>.

    IF sy-subrc = 0.

      <fs_mon> = lv_amt.

    ENDIF.



    gs_sal-zsalary = gs_sal-zsalary * 100.



    MODIFY gt_sal FROM gs_sal.

    MODIFY zedt07_105 FROM ls_mon.



    IF sy-subrc <> 0.

      lv_flag = space.

      EXIT.

    ENDIF.

  ENDLOOP.



  IF lv_flag = 'X'.

    COMMIT WORK.

    MESSAGE '### #######.' TYPE 'S'.

  ELSE.

    ROLLBACK WORK.

    MESSAGE '#### ##' TYPE 'E'.

  ENDIF.



  PERFORM convert_ko_pay.



ENDFORM.






*---------------------------------------------------------------------*

* FORM CONVERT_KO_PAY

*---------------------------------------------------------------------*




FORM CONVERT_KO_PAY .

  LOOP AT gt_sal INTO gs_sal.

    CASE gs_sal-zdepcode.

      WHEN 'SS0001'. gs_sal-zdepname = '###'.

      WHEN 'SS0002'. gs_sal-zdepname = '###'.

      WHEN 'SS0003'. gs_sal-zdepname = '###'.

      WHEN 'SS0004'. gs_sal-zdepname = '###'.

      WHEN 'SS0005'. gs_sal-zdepname = '###'.

      WHEN 'SS0006'. gs_sal-zdepname = '###'.

    ENDCASE.



    CASE gs_sal-zdeprank.

      WHEN 'A'. gs_sal-zrankname = '##'.

      WHEN 'B'. gs_sal-zrankname = '##'.

      WHEN 'C'. gs_sal-zrankname = '##'.

      WHEN 'D'. gs_sal-zrankname = '##'.

      WHEN 'E'. gs_sal-zrankname = '##'.

      WHEN 'F'. gs_sal-zrankname = '##'.

      WHEN 'G'. gs_sal-zrankname = '##'.

    ENDCASE.



    MODIFY gt_sal FROM gs_sal.

  ENDLOOP.

ENDFORM.






*---------------------------------------------------------------------*

* FORM DISPLAY_PAY (ALV)

*---------------------------------------------------------------------*




FORM DISPLAY_PAY .

  PERFORM set_fieldcat_pay_info.



  gs_layout-zebra = 'X'.

  gs_layout-colwidth_optimize = 'X'.



  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

    EXPORTING

      i_callback_program = sy-repid

      is_layout = gs_layout

      it_fieldcat = gt_fcat

    TABLES

      t_outtab = gt_sal.

ENDFORM.






*---------------------------------------------------------------------*

* FORM SET_FIELDCAT_PAY_INFO

*---------------------------------------------------------------------*




FORM SET_FIELDCAT_PAY_INFO .



  CLEAR gt_fcat.



  PERFORM add_fcat USING 'ZPERNR'  '####' '10'.

  PERFORM add_fcat USING 'ZPNAME'  '####' '10'.

  PERFORM add_fcat USING 'ZDEPCODE' '####' '10'.

  PERFORM add_fcat USING 'ZDEPNAME' '###' '10'.

  PERFORM add_fcat USING 'ZRANKNAME' '###' '10'.

  PERFORM add_fcat USING 'ZEDATE' '###' '10'.



  CLEAR gs_fcat.

  gs_fcat-fieldname = 'ZSALARY'.

  gs_fcat-seltext_m = '####'.

  gs_fcat-outputlen = 20.

  gs_fcat-decimals_out = 0.

  gs_fcat-do_sum = 'X'.

  APPEND gs_fcat TO gt_fcat.



  PERFORM add_fcat USING 'ZRANK' '####' '10'.



  DATA(lv_fieldname) = |ZMON{ p_month }|.

  DATA(lv_label)     = |{ p_month }# ###|.



  FIELD-SYMBOLS <fs_fcat> LIKE LINE OF gt_fcat.

  APPEND INITIAL LINE TO gt_fcat ASSIGNING <fs_fcat>.



  <fs_fcat>-fieldname = lv_fieldname.

  <fs_fcat>-seltext_m = lv_label.

  <fs_fcat>-outputlen = 20.

  <fs_fcat>-do_sum = 'X'.

  <fs_fcat>-decimals_out = 0.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_EVAL_INFO

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM get_eval_info .



  TYPES: BEGIN OF ty_join,

           zpernr   TYPE zedt07_102-zpernr,

           zdepcode TYPE zedt07_102-zdepcode,

           zdeprank TYPE zedt07_102-zdeprank,

           zedate   TYPE zedt07_102-zedate,

           zqdate   TYPE zedt07_102-zqdate,

           zqflag   TYPE zedt07_102-zqflag,

           zpname   TYPE zedt07_103-zpname,

           zsalary  TYPE zedt07_106-zsalary,

           zrank    TYPE zedt07_104-zrank,

         END OF ty_join.



  DATA: lt_join    TYPE STANDARD TABLE OF ty_join,

        ls_join    TYPE ty_join,

        ls_mon     TYPE zedt07_105,

        lv_mon_amt TYPE p DECIMALS 2,

        lv_month   TYPE char02.



  CLEAR gt_eval.

  lv_month = p_month.



  "----------------------------------------------------------

  " 1) #### + ## + ### + #### JOIN

  "----------------------------------------------------------

  SELECT

    a~zpernr,

    a~zdepcode,

    a~zdeprank,

    a~zedate,

    a~zqdate,

    a~zqflag,

    b~zpname,

    c~zsalary,

    d~zrank

    FROM zedt07_102 AS a

      INNER JOIN zedt07_103 AS b

        ON a~zpernr = b~zpernr

      LEFT JOIN zedt07_106 AS c

        ON a~zpernr = c~zpernr

      LEFT JOIN zedt07_104 AS d

        ON a~zpernr = d~zpernr

       AND d~zyear = @p_year

    INTO TABLE @lt_join

    WHERE a~zpernr   IN @s_pernr

      AND a~zdepcode IN @s_dept.



  LOOP AT lt_join INTO ls_join.



    " ### ## # ### ##

    IF p_ch1 = c_check AND ls_join-zqflag = c_quit.

      CONTINUE.

    ENDIF.



    "----------------------------------------------------------

    " 2) ### ##

    "----------------------------------------------------------

    CLEAR ls_mon.



SELECT SINGLE

    zmon01,

    zmon02,

    zmon03,

    zmon04,

    zmon05,

    zmon06,

    zmon07,

    zmon08,

    zmon09,

    zmon10,

    zmon11,

    zmon12

  FROM zedt07_105

  WHERE zpernr = @ls_join-zpernr

    AND zyear  = @p_year

  INTO CORRESPONDING FIELDS OF @ls_mon.



IF sy-subrc <> 0.

  CONTINUE.

ENDIF.



    " ## # ## ##

    CASE lv_month.

      WHEN '01'. lv_mon_amt = ls_mon-zmon01.

      WHEN '02'. lv_mon_amt = ls_mon-zmon02.

      WHEN '03'. lv_mon_amt = ls_mon-zmon03.

      WHEN '04'. lv_mon_amt = ls_mon-zmon04.

      WHEN '05'. lv_mon_amt = ls_mon-zmon05.

      WHEN '06'. lv_mon_amt = ls_mon-zmon06.

      WHEN '07'. lv_mon_amt = ls_mon-zmon07.

      WHEN '08'. lv_mon_amt = ls_mon-zmon08.

      WHEN '09'. lv_mon_amt = ls_mon-zmon09.

      WHEN '10'. lv_mon_amt = ls_mon-zmon10.

      WHEN '11'. lv_mon_amt = ls_mon-zmon11.

      WHEN '12'. lv_mon_amt = ls_mon-zmon12.

      WHEN OTHERS. lv_mon_amt = 0.

    ENDCASE.



    " ## 0 ## ##

    IF lv_mon_amt = 0.

      CONTINUE.

    ENDIF.



    "----------------------------------------------------------

    " 3) ## ## ###

    "----------------------------------------------------------

    CLEAR gs_eval.



    gs_eval-zpernr   = ls_join-zpernr.

    gs_eval-zpname   = ls_join-zpname.

    gs_eval-zdepcode = ls_join-zdepcode.

    gs_eval-zdeprank = ls_join-zdeprank.

    gs_eval-zrank    = ls_join-zrank.



    " ### ##

    CASE gs_eval-zdeprank.

      WHEN 'A'. gs_eval-zrankname = '##'.

      WHEN 'B'. gs_eval-zrankname = '##'.

      WHEN 'C'. gs_eval-zrankname = '##'.

      WHEN 'D'. gs_eval-zrankname = '##'.

      WHEN 'E'. gs_eval-zrankname = '##'.

      WHEN 'F'. gs_eval-zrankname = '##'.

      WHEN 'G'. gs_eval-zrankname = '##'.

      WHEN OTHERS. gs_eval-zrankname = ''.

    ENDCASE.



    " ### ##

    CASE gs_eval-zdepcode.

      WHEN 'SS0001'. gs_eval-zdepname = '###'.

      WHEN 'SS0002'. gs_eval-zdepname = '###'.

      WHEN 'SS0003'. gs_eval-zdepname = '###'.

      WHEN 'SS0004'. gs_eval-zdepname = '###'.

      WHEN 'SS0005'. gs_eval-zdepname = '###'.

      WHEN 'SS0006'. gs_eval-zdepname = '###'.

      WHEN OTHERS.   gs_eval-zdepname = ''.

    ENDCASE.



    " ##/## ##

    gs_eval-zqflag = ls_join-zqflag.

    IF ls_join-zqflag = c_quit.

      gs_eval-zqflag_t = c_quit_t.

    ELSE.

      gs_eval-zqflag_t = c_active.

    ENDIF.



    " # ## * 100 (## ## ##)

    gs_eval-zsalary = lv_mon_amt * 100.



     gs_eval-zmon01 = ls_mon-zmon01.

    gs_eval-zmon02 = ls_mon-zmon02.

    gs_eval-zmon03 = ls_mon-zmon03.

    gs_eval-zmon04 = ls_mon-zmon04.

    gs_eval-zmon05 = ls_mon-zmon05.

    gs_eval-zmon06 = ls_mon-zmon06.

    gs_eval-zmon07 = ls_mon-zmon07.

    gs_eval-zmon08 = ls_mon-zmon08.

    gs_eval-zmon09 = ls_mon-zmon09.

    gs_eval-zmon10 = ls_mon-zmon10.

    gs_eval-zmon11 = ls_mon-zmon11.

    gs_eval-zmon12 = ls_mon-zmon12.



    APPEND gs_eval TO gt_eval.



  ENDLOOP.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  DISPLAY_EVAL

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM display_eval .



  CLEAR gt_fcat.



"===========================

" ## KEY ##

"===========================

CLEAR gs_fcat.

gs_fcat-fieldname = 'ZPERNR'.

gs_fcat-seltext_m = '####'.

gs_fcat-outputlen = 10.

gs_fcat-key = 'X'.

APPEND gs_fcat TO gt_fcat.



CLEAR gs_fcat.

gs_fcat-fieldname = 'ZPNAME'.

gs_fcat-seltext_m = '####'.

gs_fcat-outputlen = 10.

gs_fcat-key = 'X'.

APPEND gs_fcat TO gt_fcat.



"===========================

" ## / ##

"===========================

PERFORM add_fcat USING 'ZDEPNAME'  '###'    '10'.

PERFORM add_fcat USING 'ZRANKNAME' '###'    '10'.



"===========================

" ## ##

"===========================

PERFORM add_fcat USING 'ZQFLAG_T' '####' '10'.



"===========================

" ####

"===========================

PERFORM add_fcat USING 'ZRANK' '####' '10'.



"===========================

" ##(#)  SUM ##

"===========================

CLEAR gs_fcat.

gs_fcat-fieldname    = 'ZSALARY'.

gs_fcat-seltext_m    = '##(#)'.

gs_fcat-outputlen    = 20.

gs_fcat-decimals_out = 0.

gs_fcat-do_sum       = 'X'.

APPEND gs_fcat TO gt_fcat.



"===========================

" ## # ### ## (ZMON01~ZMON12)

"===========================

DATA: lv_field TYPE char30,

      lv_text  TYPE char50.



lv_field = |ZMON{ p_month }|.

  lv_text  = |{ p_month }# ###|.



CLEAR gs_fcat.

gs_fcat-fieldname    = lv_field.

gs_fcat-seltext_m    = lv_text.

gs_fcat-outputlen    = 20.

gs_fcat-decimals_out = 0.

gs_fcat-do_sum       = 'X'.

APPEND gs_fcat TO gt_fcat.



"===========================

" ALV ####

"===========================

CLEAR gs_layout.

gs_layout-colwidth_optimize = 'X'.

gs_layout-zebra             = 'X'.

gs_layout-totals_text       = '##'.



"===========================

" ALV ##

"===========================

CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

  EXPORTING

    i_callback_program = sy-repid

    is_layout          = gs_layout

    it_fieldcat        = gt_fcat

    it_sort            = gt_sort

  TABLES

    t_outtab           = gt_eval

  EXCEPTIONS

    program_error      = 1

    others             = 2.



ENDFORM.








*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ##### ######