
*&---------------------------------------------------------------------*

*& Report ZEDR022_017

*&---------------------------------------------------------------------*

*& ###### ####

*& ###: ###

*& ###: 2025.01.01

*&---------------------------------------------------------------------*




REPORT zedr022_017.






*----------------------------------------------------------------------*

* 1. DOMAIN, ELEMENT# #### TABLE ##

*----------------------------------------------------------------------*




TABLES: zedt22_102,  " #### ###

        zedt22_103,  " ####-####

        zedt22_104,  " ####

        zedt22_105,  " ####

        zedt22_106.  " ####






*----------------------------------------------------------------------*

* CONSTANTS ## (#### 8 - CONSTANTS 1### ##)

*----------------------------------------------------------------------*




CONSTANTS: gc_retire    TYPE c VALUE 'X',                    " #####

           gc_eval_a    TYPE c VALUE 'A',                    " #### A

           gc_bonus     TYPE p DECIMALS 2 VALUE '50000.00',  " A## ###

           gc_months    TYPE i VALUE 12,                     " # 12##

           gc_male      TYPE c VALUE 'M',                    " ##

           gc_female    TYPE c VALUE 'F',                    " ##

           gc_currency  TYPE c LENGTH 3 VALUE 'KRW'.         " ##






*----------------------------------------------------------------------*

* TYPE ## - #### ## ### #### ## TYPE ##

*----------------------------------------------------------------------*

* #### TYPE




TYPES: BEGIN OF ty_employee,

         zpernr    TYPE zedt22_102-zpernr,      " ####

         zdepcode  TYPE zedt22_102-zdepcode,    " ####

         zdepname  TYPE char20,                  " ###(##)

         zpname    TYPE zedt22_103-zpname,      " ####

         zgender   TYPE zedt22_103-zgender,     " ##

         zgender_t TYPE char10,                  " ##(##)

         zaddress  TYPE zedt22_103-zaddress,    " ##

         zdeprank  TYPE zedt22_102-zdeprank,    " ####

         zrank_t   TYPE char10,                  " ###(##)

         zedate    TYPE zedt22_102-zedate,      " ####

         zqdate    TYPE zedt22_102-zqdate,      " ####

         zqflag    TYPE zedt22_102-zqflag,      " #####

         zstatus   TYPE char10,                  " ####(##/##)

         zyear     TYPE zedt22_104-zyear,       " ##

         zrank     TYPE zedt22_104-zrank,       " ####

         zsalary   TYPE zedt22_106-zsalary,     " ####

         zbankcode TYPE zedt22_106-zbankcode,   " ####

         zbank_t   TYPE char10,                  " ###(##)

         zaccount  TYPE zedt22_106-zaccount,    " ####

       END OF ty_employee.






* #### TYPE




TYPES: BEGIN OF ty_salary,

         zpernr    TYPE zedt22_105-zpernr,      " ####

         zpname    TYPE zedt22_103-zpname,      " ####

         zdepcode  TYPE zedt22_102-zdepcode,    " ####

         zdepname  TYPE char20,                  " ###

         zdeprank  TYPE zedt22_102-zdeprank,    " ####

         zrank_t   TYPE char10,                  " ###

         zedate    TYPE zedt22_102-zedate,      " ####

         zqdate    TYPE zedt22_102-zqdate,      " ####

         zsalary   TYPE zedt22_106-zsalary,     " ####

         zrank     TYPE zedt22_104-zrank,       " ####

         monthly   TYPE p DECIMALS 2,           " ###

       END OF ty_salary.






* #### TYPE




TYPES: BEGIN OF ty_evaluation,

         zpernr    TYPE zedt22_105-zpernr,      " ####

         zpname    TYPE zedt22_103-zpname,      " ####

         zdepcode  TYPE zedt22_102-zdepcode,    " ####

         zdepname  TYPE char20,                  " ###

         zdeprank  TYPE zedt22_102-zdeprank,    " ####

         zrank_t   TYPE char10,                  " ###

         zedate    TYPE zedt22_102-zedate,      " ####

         zsalary   TYPE zedt22_106-zsalary,     " ####

         zrank     TYPE zedt22_104-zrank,       " ####

         monthly   TYPE p DECIMALS 2,           " ###(###)

         zstatus   TYPE char10,                  " ####

       END OF ty_evaluation.






*----------------------------------------------------------------------*

* ### ### ## (#### 3 - #### ## ###)

*----------------------------------------------------------------------*




DATA: gt_employee     TYPE TABLE OF ty_employee,

      gs_employee     TYPE ty_employee,

      gt_salary       TYPE TABLE OF ty_salary,

      gs_salary       TYPE ty_salary,

      gt_evaluation   TYPE TABLE OF ty_evaluation,

      gs_evaluation   TYPE ty_evaluation,

      gt_alv_emp      TYPE TABLE OF ty_employee,     " ALV### ITAB

      gt_alv_eval     TYPE TABLE OF ty_evaluation.   " ALV### ITAB






* ### ### ###




DATA: gs_zedt22_102   TYPE zedt22_102,

      gs_zedt22_103   TYPE zedt22_103,

      gs_zedt22_104   TYPE zedt22_104,

      gs_zedt22_105   TYPE zedt22_105,

      gs_zedt22_106   TYPE zedt22_106.






*----------------------------------------------------------------------*

* RANGE ## ## (#### 5 - ##### 1### ##)

*----------------------------------------------------------------------*




RANGES: r_date FOR zedt22_102-datbi,

        r_pernr FOR zedt22_102-zpernr.






*----------------------------------------------------------------------*

* ALV ## ## (#### 12 - ######, LAYOUT, SORT ##)

*----------------------------------------------------------------------*




TYPE-POOLS: slis.



DATA: gt_fieldcat TYPE slis_t_fieldcat_alv,

      gs_fieldcat TYPE slis_fieldcat_alv,

      gs_layout   TYPE slis_layout_alv,

      gt_sort     TYPE slis_t_sortinfo_alv,

      gs_sort     TYPE slis_sortinfo_alv,

      gs_variant  TYPE disvariant.






*----------------------------------------------------------------------*

* ## ##

*----------------------------------------------------------------------*




DATA: gv_success TYPE i,

      gv_fail    TYPE i,

      gv_message TYPE string.



DATA: lv_text1 TYPE string VALUE '####',

      lv_text2 TYPE string VALUE '####'.






*----------------------------------------------------------------------*

* Selection Screen ##

*----------------------------------------------------------------------*

*---------------------------------------------------------------------*

* Selection Screen ##

*---------------------------------------------------------------------*






" ####

" # ## 1: ###### ####

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.

SELECT-OPTIONS: s_pernr FOR zedt22_102-zpernr.  "####

"SELECT-OPTIONS: s_date FOR zedt22_102-zedate.   "##

PARAMETERS: p_frdate TYPE zedt22_102-zedate,  " ###

            p_todate TYPE zedt22_102-zedate.  " ###

PARAMETERS: s_dept TYPE zedt22_102-zdepcode.    "##

SELECTION-SCREEN END OF BLOCK b1.



" ####

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.

PARAMETERS: p_year  TYPE zedt22_104-zyear,  " ##

            p_month TYPE n LENGTH 2.        " #

SELECTION-SCREEN END OF BLOCK b2.



" ####

SELECTION-SCREEN BEGIN OF BLOCK b3 WITH FRAME TITLE TEXT-003.

PARAMETERS: p_year2  TYPE zedt22_104-zyear, " ##

            p_month2 TYPE n LENGTH 2.       " #

SELECTION-SCREEN END OF BLOCK b3.



" (#####)

SELECTION-SCREEN BEGIN OF BLOCK b4 WITH FRAME TITLE TEXT-004.

PARAMETERS: p_emp  RADIOBUTTON GROUP rad1 DEFAULT 'X',  " ####

            p_pay  RADIOBUTTON GROUP rad1,              " ####

            p_eval RADIOBUTTON GROUP rad1.              " ####

SELECTION-SCREEN END OF BLOCK b4.



SELECTION-SCREEN BEGIN OF BLOCK b5 WITH FRAME TITLE TEXT-005.

PARAMETERS: p_active AS CHECKBOX USER-COMMAND actv.     " ####

SELECTION-SCREEN END OF BLOCK b5.








*----------------------------------------------------------------------*

* INITIALIZATION - ## ### ##

*----------------------------------------------------------------------*




INITIALIZATION.

  lv_text1 = '####'.

  lv_text2 = '####'.






*----------------------------------------------------------------------*

* START-OF-SELECTION - ## ##

*----------------------------------------------------------------------*




AT SELECTION-SCREEN OUTPUT.



  LOOP AT SCREEN.



    " #### ##

    IF screen-group1 = 'EMP'.

      IF p_emp = 'X'.

        screen-active = 1.

      ELSE.

        screen-active = 0.

      ENDIF.

      MODIFY SCREEN.

    ENDIF.



    " #### ##

    IF screen-group1 = 'PAY'.

      IF p_pay = 'X'.

        screen-active = 1.

      ELSE.

        screen-active = 0.

      ENDIF.

      MODIFY SCREEN.

    ENDIF.



    " #### ##

    IF screen-group1 = 'EVA'.

      IF p_eval = 'X'.

        screen-active = 1.

      ELSE.

        screen-active = 0.

      ENDIF.

      MODIFY SCREEN.

    ENDIF.



    " #### (##### ##)

    IF screen-group1 = 'ACT'.

      IF p_emp = 'X'.

        screen-active = 1.

      ELSE.

        screen-active = 0.

      ENDIF.

      MODIFY SCREEN.

    ENDIF.



  ENDLOOP.








*---------------------------------------------------------------------*

* START-OF-SELECTION

*---------------------------------------------------------------------*




START-OF-SELECTION.



  CASE 'X'.

    WHEN p_emp.

      PERFORM get_employee_data.

    WHEN p_pay.

      PERFORM process_salary_payment.

    WHEN p_eval.

      PERFORM get_evaluation_data.

  ENDCASE.






*&---------------------------------------------------------------------*

*& Form GET_EMPLOYEE_DATA

*&---------------------------------------------------------------------*

*& #### ## (#### 13-1)

*& - #### ## (DATBI/DATAB)

*& - #### #### ##

*& - #### '##', # ## '##' ##

*&---------------------------------------------------------------------*




FORM get_employee_data.



  CLEAR: gt_employee, gt_alv_emp.



  " RANGE ## ## (#### 5 - ##### ##)

  REFRESH: r_date.

  r_date-sign = 'I'.

  r_date-option = 'BT'.

  r_date-low = p_frdate.

  r_date-high = p_todate.

  APPEND r_date.



  " JOIN# ### ### ## (#### 4 - ## 4# ### JOIN)

  SELECT a~zpernr

         a~zdepcode

         a~zdeprank

         a~zedate

         a~zqdate

         a~zqflag

         a~datbi

         a~datab

         b~zpname

         b~zgender

         b~zaddress

         c~zyear

         c~zrank

         d~zsalary

         d~zbankcode

         d~zaccount

    INTO CORRESPONDING FIELDS OF TABLE gt_employee

    FROM zedt22_102 AS a

    INNER JOIN zedt22_103 AS b

      ON a~zpernr = b~zpernr

    LEFT OUTER JOIN zedt22_104 AS c

      ON a~zpernr = c~zpernr

      AND a~zdepcode = c~zdepcode

      AND c~zyear = p_year

    LEFT OUTER JOIN zedt22_106 AS d

      ON a~zpernr = d~zpernr

      AND d~zyear = p_year

    WHERE a~zdepcode = s_dept

      " #### 13-1-4: #### ## (#### #### # ##)

      AND a~datab <= p_todate

      AND a~datbi >= p_frdate.



  " ### ## # #### (#### 11)

  IF sy-subrc NE 0.

    MESSAGE '### #### ####.' TYPE 'I'.

    STOP.  " STOP ## (#### 10)

  ENDIF.



  " ## ## ## # #### ###

  LOOP AT gt_employee INTO gs_employee.



    " #### 13-1-3: #### #### ##

    IF p_active = 'X' AND gs_employee-zqflag = gc_retire.

      CONTINUE.  " CONTINUE ## (#### 10)

    ENDIF.



    " #### 13-1-3: #### ##

    IF gs_employee-zqflag = gc_retire.

      gs_employee-zstatus = '##'.

    ELSE.

      gs_employee-zstatus = '##'.

    ENDIF.



    " #### 13-1-6: ## ## ##

    CASE gs_employee-zgender.

      WHEN gc_male.

        gs_employee-zgender_t = '##'.

      WHEN gc_female.

        gs_employee-zgender_t = '##'.

      WHEN OTHERS.

        gs_employee-zgender_t = ''.

    ENDCASE.



    " #### 13-1-5: ### ## (USING/CHANGING ##)

    PERFORM get_rank_name USING gs_employee-zdeprank

                          CHANGING gs_employee-zrank_t.



    " #### 13-1-7: ### ## ##

    PERFORM get_dept_name USING gs_employee-zdepcode

                          CHANGING gs_employee-zdepname.



    " #### 13-1-7: ### ## ##

    PERFORM get_bank_name USING gs_employee-zbankcode

                          CHANGING gs_employee-zbank_t.



    " ALV# #### ##

    APPEND gs_employee TO gt_alv_emp.



  ENDLOOP.



  " ### ##

  IF gt_alv_emp IS INITIAL.

    MESSAGE '## ### ## #### ####.' TYPE 'I'.

    EXIT.  " EXIT ## (#### 10)

  ENDIF.



ENDFORM.






*&---------------------------------------------------------------------*

*& Form PROCESS_SALARY_PAYMENT

*&---------------------------------------------------------------------*

*& #### ## (#### 13-2)

*& - ### ##

*& - ##### ## ### ##

*& - A### 5## ##

*& - CASE### ## ####

*&---------------------------------------------------------------------*




FORM process_salary_payment.



  DATA: lv_amount      TYPE p DECIMALS 2,

        lv_field_name  TYPE string,

        lv_count       TYPE i.



  CLEAR: gt_salary, gv_success, gv_fail.



  " #### ## ## (4# ### JOIN)

  SELECT a~zpernr

         a~zdepcode

         a~zdeprank

         a~zedate

         a~zqdate

         b~zpname

         c~zrank

         d~zsalary

    INTO CORRESPONDING FIELDS OF TABLE gt_salary

    FROM zedt22_102 AS a

    INNER JOIN zedt22_103 AS b

      ON a~zpernr = b~zpernr

    INNER JOIN zedt22_104 AS c  " ##### ## (#### 13-2-4)

      ON a~zpernr = c~zpernr

      AND a~zdepcode = c~zdepcode

      AND c~zyear = p_year

    INNER JOIN zedt22_106 AS d

      ON a~zpernr = d~zpernr

      AND d~zyear = p_year

    WHERE a~zdepcode = s_dept

      AND a~zqflag NE gc_retire.  " ### ## (#### 13-2-3)



  IF sy-subrc NE 0.

    MESSAGE '## ### ####.' TYPE 'I'.

    RETURN.

  ENDIF.



  " #### ##

  LOOP AT gt_salary INTO gs_salary.



    " ### ## (#### 13-2-3)

    IF NOT gs_salary-zqdate IS INITIAL.

      DATA: lv_quit_month TYPE n LENGTH 2.

      lv_quit_month = gs_salary-zqdate+4(2).

      IF lv_quit_month <= p_month.

        CONTINUE.

      ENDIF.

    ENDIF.



    " ## ## (#### 13-2-5: ##/12)

    lv_amount = gs_salary-zsalary / gc_months.



    " A## ### (#### 13-2-5: A### 5## ##)

    IF gs_salary-zrank = gc_eval_a.

      lv_amount = lv_amount + gc_bonus.

    ENDIF.



    " ### 0# ## ## (#### 13-2-9)

    CHECK lv_amount > 0.  " CHECK ## (#### 10)



    " ## ### ##

    CLEAR: gs_zedt22_105.

    SELECT SINGLE * FROM zedt22_105

      INTO gs_zedt22_105

      WHERE zpernr = gs_salary-zpernr

        AND zyear = p_year.



    IF sy-subrc NE 0.

      " ## ##

      gs_zedt22_105-zpernr = gs_salary-zpernr.

      gs_zedt22_105-zyear = p_year.

      gs_zedt22_105-crname = sy-uname.

      gs_zedt22_105-crdate = sy-datum.

      gs_zedt22_105-crzeit = sy-uzeit.

    ENDIF.



    " CASE### ## ## #### (#### 13-2-2)

    CASE p_month.

      WHEN '01'.

        gs_zedt22_105-zmon01 = lv_amount.

      WHEN '02'.

        gs_zedt22_105-zmon02 = lv_amount.

      WHEN '03'.

        gs_zedt22_105-zmon03 = lv_amount.

      WHEN '04'.

        gs_zedt22_105-zmon04 = lv_amount.

      WHEN '05'.

        gs_zedt22_105-zmon05 = lv_amount.

      WHEN '06'.

        gs_zedt22_105-zmon06 = lv_amount.

      WHEN '07'.

        gs_zedt22_105-zmon07 = lv_amount.

      WHEN '08'.

        gs_zedt22_105-zmon08 = lv_amount.

      WHEN '09'.

        gs_zedt22_105-zmon09 = lv_amount.

      WHEN '10'.

        gs_zedt22_105-zmon10 = lv_amount.

      WHEN '11'.

        gs_zedt22_105-zmon11 = lv_amount.

      WHEN '12'.

        gs_zedt22_105-zmon12 = lv_amount.

    ENDCASE.



    " #### #### (#### 13-2-5)

    gs_zedt22_105-aename = sy-uname.

    gs_zedt22_105-aedate = sy-datum.

    gs_zedt22_105-aezeit = sy-uzeit.



    " DB ####

    MODIFY zedt22_105 FROM gs_zedt22_105.



    IF sy-subrc = 0.

      gv_success = gv_success + 1.

    ELSE.

      " ## # #### ## (#### 13-2-7)

      ROLLBACK WORK.

      MESSAGE '#### ##' TYPE 'E'.

    ENDIF.



  ENDLOOP.



  " ## ## (#### 13-2-8)

  IF gv_success > 0.

    COMMIT WORK.

    MESSAGE '### #######.' TYPE 'S'.

  ELSE.

    MESSAGE '## ### #### ####.' TYPE 'I'.

  ENDIF.



ENDFORM.






*&---------------------------------------------------------------------*

*& Form GET_EVALUATION_DATA

*&---------------------------------------------------------------------*

*& #### ### ## (#### 13-3)

*& - 0# ##

*& - ##/### ## ##

*& - #### ## # ### ##

*&---------------------------------------------------------------------*




FORM get_evaluation_data.



  DATA: lv_amount TYPE p DECIMALS 2.



  CLEAR: gt_evaluation, gt_alv_eval.



  " #### ### ##

  SELECT a~zpernr

         b~zpname

         a~zdepcode

         a~zdeprank

         a~zedate

         a~zqdate

         c~zrank

         d~zsalary

    INTO CORRESPONDING FIELDS OF TABLE gt_evaluation

    FROM zedt22_102 AS a

    INNER JOIN zedt22_103 AS b

      ON a~zpernr = b~zpernr

    INNER JOIN zedt22_104 AS c

      ON a~zpernr = c~zpernr

      AND a~zdepcode = c~zdepcode

      AND c~zyear = p_year

    INNER JOIN zedt22_106 AS d

      ON a~zpernr = d~zpernr

      AND d~zyear = p_year

    WHERE a~zdepcode = s_dept.



  IF sy-subrc NE 0.

    MESSAGE '### #### ####.' TYPE 'I'.

    STOP.

  ENDIF.



  " ## ### ## # ##

  LOOP AT gt_evaluation INTO gs_evaluation.



    " ## ### ##

    CLEAR: gs_zedt22_105.

    SELECT SINGLE * FROM zedt22_105

      INTO gs_zedt22_105

      WHERE zpernr = gs_evaluation-zpernr

        AND zyear = p_year.



    IF sy-subrc = 0.

      " ## # ## #### (#### 13-3-7)

      CASE p_month.

        WHEN '01'.

          gs_evaluation-monthly = gs_zedt22_105-zmon01.

        WHEN '02'.

          gs_evaluation-monthly = gs_zedt22_105-zmon02.

        WHEN '03'.

          gs_evaluation-monthly = gs_zedt22_105-zmon03.

        WHEN '04'.

          gs_evaluation-monthly = gs_zedt22_105-zmon04.

        WHEN '05'.

          gs_evaluation-monthly = gs_zedt22_105-zmon05.

        WHEN '06'.

          gs_evaluation-monthly = gs_zedt22_105-zmon06.

        WHEN '07'.

          gs_evaluation-monthly = gs_zedt22_105-zmon07.

        WHEN '08'.

          gs_evaluation-monthly = gs_zedt22_105-zmon08.

        WHEN '09'.

          gs_evaluation-monthly = gs_zedt22_105-zmon09.

        WHEN '10'.

          gs_evaluation-monthly = gs_zedt22_105-zmon10.

        WHEN '11'.

          gs_evaluation-monthly = gs_zedt22_105-zmon11.

        WHEN '12'.

          gs_evaluation-monthly = gs_zedt22_105-zmon12.

      ENDCASE.

    ENDIF.



    " ### 0# ## ## (#### 13-3-2)

    IF gs_evaluation-monthly = 0.

      CONTINUE.

    ENDIF.



    " ### ## (#### 13-3-3)

    PERFORM get_rank_name USING gs_evaluation-zdeprank

                          CHANGING gs_evaluation-zrank_t.



    " ### ## (#### 13-3-4)

    PERFORM get_dept_name USING gs_evaluation-zdepcode

                          CHANGING gs_evaluation-zdepname.



    " ### ## (#### 13-3-5)

    IF gs_evaluation-zedate IS NOT INITIAL AND

       gs_evaluation-zedate <= sy-datum.

      gs_evaluation-zstatus = '##'.

    ELSE.

      gs_evaluation-zstatus = '##'.

    ENDIF.



    APPEND gs_evaluation TO gt_alv_eval.



  ENDLOOP.



  IF gt_alv_eval IS INITIAL.

    MESSAGE '### #### ####.' TYPE 'I'.

  ENDIF.



ENDFORM.








*&---------------------------------------------------------------------*

*& Form GET_RANK_NAME

*&---------------------------------------------------------------------*

*& ### ## (#### 7 - USING/CHANGING ##)

*&---------------------------------------------------------------------*




FORM get_rank_name USING p_rank TYPE any

                   CHANGING p_rank_name TYPE any.



  CASE p_rank.

    WHEN 'A'.

      p_rank_name = '##'.

    WHEN 'B'.

      p_rank_name = '##'.

    WHEN 'C'.

      p_rank_name = '##'.

    WHEN 'D'.

      p_rank_name = '##'.

    WHEN 'E'.

      p_rank_name = '##'.

    WHEN 'F'.

      p_rank_name = '##'.

    WHEN 'G'.

      p_rank_name = '##'.

    WHEN OTHERS.

      p_rank_name = ''.

  ENDCASE.



ENDFORM.






*&---------------------------------------------------------------------*

*& Form GET_DEPT_NAME

*&---------------------------------------------------------------------*

*& ### ##

*&---------------------------------------------------------------------*




FORM get_dept_name USING p_dept TYPE any

                   CHANGING p_dept_name TYPE any.



  CASE p_dept.

    WHEN 'SS0001'.

      p_dept_name = '###'.

    WHEN 'SS0002'.

      p_dept_name = '###'.

    WHEN 'SS0003'.

      p_dept_name = '###'.

    WHEN 'SS0004'.

      p_dept_name = '###'.

    WHEN 'SS0005'.

      p_dept_name = '###'.

    WHEN 'SS0006'.

      p_dept_name = '###'.

    WHEN OTHERS.

      p_dept_name = ''.

  ENDCASE.



ENDFORM.






*&---------------------------------------------------------------------*

*& Form GET_BANK_NAME

*&---------------------------------------------------------------------*

*& ### ##

*&---------------------------------------------------------------------*




FORM get_bank_name USING p_bank TYPE any

                   CHANGING p_bank_name TYPE any.



  CASE p_bank.

    WHEN '001'.

      p_bank_name = '##'.

    WHEN '002'.

      p_bank_name = '##'.

    WHEN '003'.

      p_bank_name = '##'.

    WHEN '004'.

      p_bank_name = '##'.

    WHEN '005'.

      p_bank_name = '###'.

    WHEN OTHERS.

      p_bank_name = ''.

  ENDCASE.



ENDFORM.






*&---------------------------------------------------------------------*

*& Form DISPLAY_EMPLOYEE_ALV

*&---------------------------------------------------------------------*

*& #### ALV ## (#### 12)

*&---------------------------------------------------------------------*




FORM display_employee_alv.



  " Field Catalog ##

  PERFORM set_employee_fieldcat.



  " Layout ##

  PERFORM set_layout.



  " Sort ##

  PERFORM set_employee_sort.



  " ALV Display

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

    EXPORTING

      i_callback_program = sy-repid

      is_layout          = gs_layout

      it_fieldcat        = gt_fieldcat

      it_sort            = gt_sort

      i_save             = 'A'

      is_variant         = gs_variant

    TABLES

      t_outtab           = gt_alv_emp

    EXCEPTIONS

      program_error      = 1

      OTHERS             = 2.



  IF sy-subrc <> 0.

    MESSAGE '## ##' TYPE 'E'.

  ENDIF.



ENDFORM.






*&---------------------------------------------------------------------*

*& Form SET_EMPLOYEE_FIELDCAT

*&---------------------------------------------------------------------*

*& #### ## #### ##

*&---------------------------------------------------------------------*




FORM set_employee_fieldcat.



  CLEAR: gt_fieldcat.



  " ## #### ##

  PERFORM append_fieldcat USING:

    'ZPERNR'    '####'    'C' '10' ' ' ' ',

    'ZPNAME'    '####'    'C' '10' ' ' ' ',

    'ZDEPCODE'  '####'    'C' '10' ' ' ' ',

    'ZDEPNAME'  '###'      'C' '15' ' ' ' ',

    'ZRANK_T'   '###'      'C' '10' ' ' ' ',

    'ZGENDER_T' '##'        'C' '5'  ' ' ' ',

    'ZADDRESS'  '##'        'C' '20' ' ' ' ',

    'ZEDATE'    '####'    'D' '10' ' ' ' ',

    'ZQDATE'    '####'    'D' '10' ' ' ' ',

    'ZSTATUS'   '####'    'C' '10' ' ' ' ',

    'ZSALARY'   '##'        'P' '15' 'X' 'KRW',

    'ZBANK_T'   '###'      'C' '10' ' ' ' ',

    'ZACCOUNT'  '####'    'C' '20' ' ' ' '.



ENDFORM.






*&---------------------------------------------------------------------*

*& Form DISPLAY_EVALUATION_ALV

*&---------------------------------------------------------------------*

*& #### ALV ##

*&---------------------------------------------------------------------*




FORM display_evaluation_alv.



  " Field Catalog ##

  PERFORM set_evaluation_fieldcat.



  " Layout ##

  PERFORM set_layout.



  " Sort ##

  PERFORM set_evaluation_sort.



  " ALV Display

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

    EXPORTING

      i_callback_program = sy-repid

      is_layout          = gs_layout

      it_fieldcat        = gt_fieldcat

      it_sort            = gt_sort

      i_save             = 'A'

      is_variant         = gs_variant

    TABLES

      t_outtab           = gt_alv_eval

    EXCEPTIONS

      program_error      = 1

      OTHERS             = 2.



  IF sy-subrc <> 0.

    MESSAGE '## ##' TYPE 'E'.

  ENDIF.



ENDFORM.






*&---------------------------------------------------------------------*

*& Form SET_EVALUATION_FIELDCAT

*&---------------------------------------------------------------------*

*& #### ## #### ##

*&---------------------------------------------------------------------*




FORM set_evaluation_fieldcat.



  CLEAR: gt_fieldcat.



  DATA: lv_month_text TYPE string.

  CONCATENATE p_month '####' INTO lv_month_text.



  " ## #### ## (#### 13-3-8: SUM# ##)

  PERFORM append_fieldcat USING:

    'ZPERNR'    '####'      'C' '10' ' ' ' ',

    'ZPNAME'    '####'      'C' '10' ' ' ' ',

    'ZDEPCODE'  '####'      'C' '10' ' ' ' ',

    'ZDEPNAME'  '###'        'C' '15' ' ' ' ',

    'ZRANK_T'   '###'        'C' '10' ' ' ' ',

    'ZEDATE'    '####'      'D' '10' ' ' ' ',

    'ZSALARY'   '####(#)'  'P' '15' 'X' 'KRW',  " #### 13-3-6: ####

    'ZRANK'     '####'      'C' '5'  ' ' ' ',

    'MONTHLY'   lv_month_text   'P' '15' 'X' 'KRW',  " #### 13-3-7: ### ##

    'ZSTATUS'   '####'      'C' '10' ' ' ' '.



ENDFORM.






*&---------------------------------------------------------------------*

*& Form APPEND_FIELDCAT

*&---------------------------------------------------------------------*

*& ## #### ##

*&---------------------------------------------------------------------*




FORM append_fieldcat USING p_fieldname TYPE any

                           p_seltext   TYPE any

                           p_datatype  TYPE any

                           p_width     TYPE any

                           p_sum       TYPE any

                           p_currency  TYPE any.



  CLEAR gs_fieldcat.

  gs_fieldcat-fieldname = p_fieldname.

  gs_fieldcat-seltext_m = p_seltext.

  gs_fieldcat-seltext_l = p_seltext.

  gs_fieldcat-seltext_s = p_seltext.

  gs_fieldcat-datatype  = p_datatype.

  gs_fieldcat-outputlen = p_width.



  " SUM ## (#### 13-3-8)

  IF p_sum = 'X'.

    gs_fieldcat-do_sum = 'X'.

  ENDIF.



  " ## ## (#### 13-3-6: ## ### ##)

  IF p_currency = 'KRW'.

    gs_fieldcat-currency = 'KRW'.

  ENDIF.



  APPEND gs_fieldcat TO gt_fieldcat.



ENDFORM.






*&---------------------------------------------------------------------*

*& Form SET_LAYOUT

*&---------------------------------------------------------------------*

*& Layout ## (#### 12)

*&---------------------------------------------------------------------*




FORM set_layout.



  CLEAR: gs_layout.

  gs_layout-zebra             = 'X'.      " ###

  gs_layout-colwidth_optimize = 'X'.      " ## ## ###

  gs_layout-cell_merge        = 'X'.      " # ##

  gs_layout-get_selinfos      = 'X'.      " ####

  gs_layout-f2code            = 'PICK'.   " F2 ##



ENDFORM.






*&---------------------------------------------------------------------*

*& Form SET_EMPLOYEE_SORT

*&---------------------------------------------------------------------*

*& #### ## ## (#### 12)

*&---------------------------------------------------------------------*




FORM set_employee_sort.



  CLEAR: gt_sort.



  " 1# ##: ####

  gs_sort-spos      = 1.

  gs_sort-fieldname = 'ZDEPCODE'.

  gs_sort-tabname   = 'GT_ALV_EMP'.

  gs_sort-up        = 'X'.

  APPEND gs_sort TO gt_sort.



  " 2# ##: ####

  CLEAR gs_sort.

  gs_sort-spos      = 2.

  gs_sort-fieldname = 'ZPERNR'.

  gs_sort-tabname   = 'GT_ALV_EMP'.

  gs_sort-up        = 'X'.

  APPEND gs_sort TO gt_sort.



ENDFORM.






*&---------------------------------------------------------------------*

*& Form SET_EVALUATION_SORT

*&---------------------------------------------------------------------*

*& #### ## ## - ### ## ##

*&---------------------------------------------------------------------*




FORM set_evaluation_sort.



  CLEAR: gt_sort.



  " 1# ##: #### (## ##)

  gs_sort-spos      = 1.

  gs_sort-fieldname = 'ZDEPCODE'.

  gs_sort-tabname   = 'GT_ALV_EVAL'.

  gs_sort-up        = 'X'.

  gs_sort-subtot    = 'X'.          " ### ## (#### 13-3)

  APPEND gs_sort TO gt_sort.



  " 2# ##: ####

  CLEAR gs_sort.

  gs_sort-spos      = 2.

  gs_sort-fieldname = 'ZPERNR'.

  gs_sort-tabname   = 'GT_ALV_EVAL'.

  gs_sort-up        = 'X'.

  APPEND gs_sort TO gt_sort.



ENDFORM.






*----------------------------------------------------------------------*

* #### ## ##

*----------------------------------------------------------------------*

* 1. s_date (## ##)

*    - #### #### ####(DATAB~DATBI)# ##

*    - #### #### ## ## ### ##

*    - #: 2025.01.01~2025.01.31 ## # 2025.02.01 ## ### ##

*

* 2. s_dept (####)

*    - SELECT-OPTIONS# ## ## ## ##

*    - IN #### WHERE### ###

*

* 3. p_active (#### ####)

*    - ## #: ZQFLAG = 'X'(##) # ## ##

*    - ### #: ## ## ## (##/## ##)

*

* 4. p_year, p_month (##, #)

*    - #### # #### # ##

*    - ###### ## ## ##

*    - ### ### ## ##

*

* 5. ##### (p_emp, p_pay, p_eval)

*    - p_emp: #### ## # ALV ##

*    - p_pay: #### ## (DB ####)

*    - p_eval: #### (### ## ##)

*----------------------------------------------------------------------*





*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ### #### ####.