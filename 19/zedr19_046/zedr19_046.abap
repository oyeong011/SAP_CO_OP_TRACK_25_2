
*&---------------------------------------------------------------------*

*& Report ZEDR19_PRACTICE006

*&---------------------------------------------------------------------*




REPORT ZEDR19_PRACTICE006 MESSAGE-ID ZMED19.



TABLES : ZEDT19_102, ZEDT19_103, ZEDT19_104, ZEDT19_105, ZEDT19_106.



"========================================================

" ##/###

"========================================================

CONSTANTS : C_X TYPE CHAR1 VALUE 'X'.

RANGES    : R_FLAG FOR ZEDT19_102-ZQFLAG.           "##/## ### RANGE (## 5)



"========================================================

" ##

"========================================================

TYPES : TY_DEPT  TYPE C LENGTH 20,

        TY_YEAR  TYPE C LENGTH 4,

        TY_MONTH TYPE C LENGTH 2.



"========================================================

" ## ##

"========================================================

DATA : lv_year   TYPE c LENGTH 4,

       lv_month  TYPE c LENGTH 2,

       l_text TYPE c LENGTH 20,

       first_day TYPE d,

       last_day  TYPE d,

       gv_year(4),

       gv_mon  TYPE n LENGTH 2,

       gv_check TYPE char1.



"========================================================

" ######/### ### (#### ##, ## 3)

"========================================================

"#### JOIN ##

TYPES: BEGIN OF ty_pernr,

         zpernr     TYPE zedt19_102-zpernr,

         zpname     TYPE zedt19_103-zpname,

         zdepcode   TYPE zedt19_102-zdepcode,

         zdeprank   TYPE zedt19_102-zdeprank,

         zedate     TYPE zedt19_102-zedate,

         zqflag     TYPE zedt19_102-zqflag,

         zgender    TYPE zedt19_103-zgender,

         zaddress   TYPE zedt19_103-zaddress,

         zbankcode  TYPE zedt19_106-zbankcode,

         zaccount   TYPE zedt19_106-zaccount,

       END OF ty_pernr.



DATA : gs_pernr TYPE ty_pernr,

       gt_pernr TYPE STANDARD TABLE OF ty_pernr WITH EMPTY KEY.



"#### ALV# (###/## ##)

TYPES: BEGIN OF ty_pernr_alv,

         zpernr         TYPE zedt19_102-zpernr,

         zpname         TYPE zedt19_103-zpname,

         zdepcode       TYPE zedt19_102-zdepcode,

         zdepcode_name  TYPE c LENGTH 10,

         zdeprank_name  TYPE c LENGTH 6,

         zedate         TYPE zedt19_102-zedate,

         zqflag_name    TYPE c LENGTH 4,

         zgender_name   TYPE c LENGTH 4,

         zaddress       TYPE zedt19_103-zaddress,

         zbankcode      TYPE zedt19_106-zbankcode,

         zbank_name     TYPE c LENGTH 10,

         zaccount       TYPE zedt19_106-zaccount,

       END OF ty_pernr_alv.



DATA : gs_pernr_alv TYPE ty_pernr_alv,

       gt_pernr_alv TYPE STANDARD TABLE OF ty_pernr_alv WITH EMPTY KEY.



"#### ##

TYPES: BEGIN OF ty_salary,

         zpernr   TYPE zedt19_102-zpernr,

         zqdate   TYPE zedt19_102-zqdate,

         zqflag   TYPE zedt19_102-zqflag,

         zsalary  TYPE zedt19_106-zsalary,      "##(CURR)

         zpay     TYPE zedt19_106-zsalary,      "##(CURR)

         zrank    TYPE zedt19_104-zrank,        "####

       END OF ty_salary.



DATA : gs_salary TYPE ty_salary,

       gt_salary TYPE STANDARD TABLE OF ty_salary WITH EMPTY KEY.



"#### ##/ALV

TYPES: BEGIN OF ty_assess,

         zpernr   TYPE zedt19_102-zpernr,

         zpname   TYPE zedt19_103-zpname,

         zdepcode TYPE zedt19_102-zdepcode,

         zdeprank TYPE zedt19_102-zdeprank,

         zedate   TYPE zedt19_102-zedate,

         zsalary  TYPE zedt19_106-zsalary,

         zrank    TYPE zedt19_104-zrank,

       END OF ty_assess.



DATA : gs_assess TYPE ty_assess,

       gt_assess TYPE STANDARD TABLE OF ty_assess WITH EMPTY KEY.



TYPES: BEGIN OF ty_assess_alv,

         zpernr         TYPE zedt19_102-zpernr,

         zpname         TYPE zedt19_103-zpname,

         zdepcode       TYPE zedt19_102-zdepcode,

         zdepcode_name  TYPE c LENGTH 10,

         zdeprank_name  TYPE c LENGTH 6,

         zedate         TYPE zedt19_102-zedate,

         zsalary        TYPE zedt19_106-zsalary,

         zrank          TYPE zedt19_104-zrank,

         zmon           TYPE zedt19_105-zmon01, "# ###

       END OF ty_assess_alv.



DATA : gs_assess_alv TYPE ty_assess_alv,

       gt_assess_alv TYPE STANDARD TABLE OF ty_assess_alv WITH EMPTY KEY.



"========================================================

" ALV (######/####/##) - ##12

"========================================================

TYPE-POOLS: slis.

DATA : gs_fieldcat TYPE slis_fieldcat_alv,

       gt_fieldcat TYPE slis_t_fieldcat_alv,

       gs_layout   TYPE slis_layout_alv,

       gs_sort     TYPE slis_sortinfo_alv,

       gt_sort     TYPE slis_t_sortinfo_alv.



"========================================================

" #### - ## 13

"========================================================

" ####

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.

  SELECT-OPTIONS : s_zpernr FOR zedt19_102-zpernr MODIF ID m1.

  SELECT-OPTIONS : s_date   FOR zedt19_102-zedate  MODIF ID m1. "##(#### ### ##)

  PARAMETERS     : p_dept   TYPE ZEDT19_102-ZDEPCODE MODIF ID M1.

  SELECT-OPTIONS : s_dept   FOR zedt19_102-zdepcode NO-DISPLAY MODIF ID m1. "## Range (####)

SELECTION-SCREEN END OF BLOCK b1.



" ####

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME.

  SELECT-OPTIONS : s_zper FOR zedt19_102-zpernr MODIF ID m2.

  PARAMETERS     : p_year LIKE zedt19_105-zyear DEFAULT sy-datum+0(4) MODIF ID m2,

                   p_mon  TYPE TY_MONTH  DEFAULT sy-datum+4(2) MODIF ID m2.

SELECTION-SCREEN END OF BLOCK b2.



" ####

SELECTION-SCREEN BEGIN OF BLOCK b3 WITH FRAME.

  SELECT-OPTIONS : s_zperr FOR zedt19_102-zpernr MODIF ID m3.

  PARAMETERS     : p_year3 LIKE zedt19_105-zyear DEFAULT sy-datum+0(4) MODIF ID m3,

                   p_mon3  TYPE TY_MONTH DEFAULT sy-datum+4(2) MODIF ID m3.

SELECTION-SCREEN END OF BLOCK b3.



" #####

SELECTION-SCREEN BEGIN OF BLOCK b4 WITH FRAME.

  PARAMETERS : p_r1 RADIOBUTTON GROUP r1 DEFAULT 'X' USER-COMMAND uc1, "####

               p_r2 RADIOBUTTON GROUP r1,                               "####

               p_r3 RADIOBUTTON GROUP r1.                               "####

SELECTION-SCREEN END OF BLOCK b4.



" #### ####

SELECTION-SCREEN BEGIN OF BLOCK b5 WITH FRAME.

  PARAMETERS : p_ch1 AS CHECKBOX DEFAULT 'X' MODIF ID m1. "####

SELECTION-SCREEN END OF BLOCK b5.

"========================================================

" INITIALIZATION : ## ##

"========================================================

INITIALIZATION.

  lv_year  = sy-datum+0(4).

  lv_month = sy-datum+4(2).



  first_day = sy-datum(6) && '01'.

  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

    EXPORTING day_in = first_day

    IMPORTING last_day_of_month = last_day.



  s_date = VALUE #( sign = 'I' option = 'BT' low = first_day high = last_day ).

  APPEND s_date.



"========================================================

" ## ## ## (##/##) - ## 11(### ##), 13

"========================================================

AT SELECTION-SCREEN OUTPUT.

  LOOP AT screen.

    IF screen-group1 = 'M1'.

      screen-active = COND #( WHEN p_r1 = c_x THEN 1 ELSE 0 ).

    ELSEIF screen-group1 = 'M2'.

      screen-active = COND #( WHEN p_r2 = c_x THEN 1 ELSE 0 ).

      IF p_r2 = c_x AND ( screen-name = 'P_YEAR' OR screen-name = 'P_MON' ).

        screen-required = '1'.

      ENDIF.

    ELSEIF screen-group1 = 'M3'.

      screen-active = COND #( WHEN p_r3 = c_x THEN 1 ELSE 0 ).

      IF p_r3 = c_x AND ( screen-name = 'P_YEAR3' OR screen-name = 'P_MON3' ).

        screen-required = '1'.

      ENDIF.

    ENDIF.

    MODIFY screen.

  ENDLOOP.



"========================================================

" ## ## (## ###) - ## 11

"========================================================

AT SELECTION-SCREEN.

  IF p_r1 = c_x AND s_date[] IS INITIAL.

    MESSAGE e000(zmed19) WITH '### #####.'.

  ENDIF.

  IF p_r2 = c_x AND ( p_year IS INITIAL OR p_mon IS INITIAL ).

    MESSAGE e000(zmed19) WITH '### ## ## #####.'.

  ENDIF.

  IF p_r3 = c_x AND ( p_year3 IS INITIAL OR p_mon3 IS INITIAL ).

    MESSAGE e000(zmed19) WITH '### ## ## #####.'.

  ENDIF.



"========================================================

" MAIN

"========================================================

START-OF-SELECTION.

  PERFORM set_globals.



  CASE c_x.

    WHEN p_r1.

      PERFORM build_flag_range.                   "R_FLAG ## (## 5)

      PERFORM select_data_r1.

      IF gt_pernr IS INITIAL.

        MESSAGE i001(zmed19) WITH '#### ####.'.

        EXIT.                                     "## 10: EXIT 1#

      ENDIF.

      PERFORM modify_data_r1.

      PERFORM alv_display_r1.



    WHEN p_r2.

      PERFORM select_data_r2.

      IF gt_salary IS INITIAL.

        MESSAGE i001(zmed19) WITH '## ### ####.'.

        STOP.                                     "## 10: STOP 1#

      ENDIF.

      PERFORM modify_data_r2.



    WHEN p_r3.

      PERFORM select_data_r3.

      IF gt_assess IS INITIAL.

        MESSAGE i001(zmed19) WITH '## #### ####.'.

        CHECK 1 = 0.                               "## 10: CHECK 1#

      ENDIF.

      PERFORM modify_data_r3.

      PERFORM alv_display_r3.

  ENDCASE.



"========================================================

" ## ##

"========================================================

FORM set_globals.

  CLEAR : gv_year, gv_mon, gv_check.

  gv_year = CONV #( sy-datum+0(4) ).

  gv_mon  = sy-datum+4(2).

ENDFORM.



"========================================================

" R_FLAG ## (##/##)

"========================================================

FORM build_flag_range.

  CLEAR r_flag.

  APPEND VALUE #( sign = 'I' option = 'EQ' low = space ) TO r_flag.

  IF p_ch1 IS INITIAL.

    APPEND VALUE #( sign = 'I' option = 'EQ' low = c_x ) TO r_flag.

  ENDIF.

ENDFORM.



"========================================================

" [R1] #### ## (JOIN # 4, ## 4)

"========================================================

FORM select_data_r1.

  DATA(lv_base) = s_date-high.



  IF s_zpernr[] IS INITIAL AND s_dept[] IS INITIAL.

    SELECT a~zpernr, b~zpname, a~zdepcode, a~zdeprank, a~zedate, a~zqflag,

           b~zgender, b~zaddress AS zaddress, c~zbankcode, c~zaccount

      INTO CORRESPONDING FIELDS OF TABLE @gt_pernr

      FROM zedt19_102 AS a

      INNER JOIN zedt19_103 AS b ON a~zpernr = b~zpernr

      INNER JOIN zedt19_106 AS c ON a~zpernr = c~zpernr

      WHERE a~datbi <= @lv_base

        AND a~datab >  @lv_base

        AND a~zqflag IN @r_flag.

  ELSEIF s_zpernr[] IS INITIAL.

    SELECT a~zpernr, b~zpname, a~zdepcode, a~zdeprank, a~zedate, a~zqflag,

           b~zgender, b~zaddress AS zaddress, c~zbankcode, c~zaccount

      INTO CORRESPONDING FIELDS OF TABLE @gt_pernr

      FROM zedt19_102 AS a

      INNER JOIN zedt19_103 AS b ON a~zpernr = b~zpernr

      INNER JOIN zedt19_106 AS c ON a~zpernr = c~zpernr

      WHERE a~zdepcode IN @s_dept

        AND a~datbi <= @lv_base

        AND a~datab >  @lv_base

        AND a~zqflag IN @r_flag.

  ELSEIF s_dept[] IS INITIAL.

    SELECT a~zpernr, b~zpname, a~zdepcode, a~zdeprank, a~zedate, a~zqflag,

           b~zgender, b~zaddress AS zaddress, c~zbankcode, c~zaccount

      INTO CORRESPONDING FIELDS OF TABLE @gt_pernr

      FROM zedt19_102 AS a

      INNER JOIN zedt19_103 AS b ON a~zpernr = b~zpernr

      INNER JOIN zedt19_106 AS c ON a~zpernr = c~zpernr

      WHERE a~zpernr IN @s_zpernr

        AND a~datbi <= @lv_base

        AND a~datab >  @lv_base

        AND a~zqflag IN @r_flag.

  ELSE.

    SELECT a~zpernr, b~zpname, a~zdepcode, a~zdeprank, a~zedate, a~zqflag,

           b~zgender, b~zaddress AS zaddress, c~zbankcode, c~zaccount

      INTO CORRESPONDING FIELDS OF TABLE @gt_pernr

      FROM zedt19_102 AS a

      INNER JOIN zedt19_103 AS b ON a~zpernr = b~zpernr

      INNER JOIN zedt19_106 AS c ON a~zpernr = c~zpernr

      WHERE a~zpernr  IN @s_zpernr

        AND a~zdepcode IN @s_dept

        AND a~datbi <= @lv_base

        AND a~datab >  @lv_base

        AND a~zqflag IN @r_flag.

  ENDIF.

ENDFORM.



"========================================================

" [R1] ## ##

"========================================================

FORM modify_data_r1.

  LOOP AT gt_pernr INTO gs_pernr.

    CLEAR gs_pernr_alv.

    MOVE-CORRESPONDING gs_pernr TO gs_pernr_alv.



    PERFORM make_depcode USING    gs_pernr_alv-zdepcode

                         CHANGING gs_pernr_alv-zdepcode_name.

    PERFORM make_rank    USING    gs_pernr-zdeprank

                         CHANGING gs_pernr_alv-zdeprank_name.



    IF gs_pernr-zqflag = c_x.

      gs_pernr_alv-zqflag_name = '##'.

      CONTINUE.  "##### CONTINUE 1#

    ELSE.

      gs_pernr_alv-zqflag_name = '##'.

    ENDIF.



    IF gs_pernr-zgender = 'M'.

      gs_pernr_alv-zgender_name = '##'.

    ELSEIF gs_pernr-zgender = 'F'.

      gs_pernr_alv-zgender_name = '##'.

    ENDIF.



    PERFORM make_bankcode USING    gs_pernr-zbankcode

                          CHANGING gs_pernr_alv-zbank_name.



    APPEND gs_pernr_alv TO gt_pernr_alv.

  ENDLOOP.

ENDFORM.



"========================================================

" [R1] ALV ##

"========================================================

FORM alv_display_r1.

  PERFORM field_catalog_r1.

  PERFORM set_layout.

  PERFORM set_sort.

  PERFORM call_alv USING gt_pernr_alv.

ENDFORM.



"========================================================

" [R2] #### ## ## (##/##/## ##)

"========================================================

FORM select_data_r2.

  DATA: lv_first TYPE d,

        lv_last  TYPE d.



  CONCATENATE p_year p_mon '01' INTO lv_first.

  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

    EXPORTING day_in            = lv_first

    IMPORTING last_day_of_month = lv_last.



  IF s_zper[] IS INITIAL.

    SELECT a~zpernr a~zqdate a~zqflag c~zsalary b~zrank

      INTO CORRESPONDING FIELDS OF TABLE gt_salary

      FROM zedt19_102 AS a

      INNER JOIN zedt19_104 AS b ON a~zpernr = b~zpernr

      INNER JOIN zedt19_106 AS c ON a~zpernr = c~zpernr

      WHERE b~zyear = p_year

        AND c~zyear = p_year

        AND ( a~zqflag <> c_x OR a~zqdate > lv_last ).

  ELSE.

    SELECT a~zpernr a~zqdate a~zqflag c~zsalary b~zrank

      INTO CORRESPONDING FIELDS OF TABLE gt_salary

      FROM zedt19_102 AS a

      INNER JOIN zedt19_104 AS b ON a~zpernr = b~zpernr

      INNER JOIN zedt19_106 AS c ON a~zpernr = c~zpernr

      WHERE a~zpernr IN s_zper

        AND b~zyear  = p_year

        AND c~zyear  = p_year

        AND ( a~zqflag <> c_x OR a~zqdate > lv_last ).

  ENDIF.

ENDFORM.





"========================================================

" [R2] ## ##/####

"========================================================

FORM modify_data_r2.

  DATA lv_date6(6).

  CONCATENATE p_year p_mon INTO lv_date6.



  LOOP AT gt_salary INTO gs_salary.

    IF gs_salary-zqflag = c_x AND gs_salary-zqdate IS NOT INITIAL AND

       substring( val = gs_salary-zqdate off = 0 len = 6 ) <= lv_date6.

      CONTINUE.

    ENDIF.



    gs_salary-zpay = gs_salary-zsalary / CONV zedt19_106-zsalary( 12 ).

    IF gs_salary-zrank = 'A'.

      gs_salary-zpay = gs_salary-zpay + '500.00'.           "5##

    ENDIF.

    CHECK gs_salary-zpay <> 0.



    PERFORM update_pay USING     p_year p_mon

                                 gs_salary-zpernr

                                 gs_salary-zpay

                       CHANGING  gv_check.

    IF gv_check = c_x.

      MESSAGE i002(zmed19) WITH '#### ##'.

      STOP.   "## # # 1#### ## # ##

    ENDIF.

  ENDLOOP.



  MESSAGE i003(zmed19) WITH '### #######.'.

ENDFORM.



"========================================================

" [R2] UPDATE_PAY (CASE# # ##, #### ##)

"========================================================

FORM update_pay USING    pv_year  TYPE zedt19_105-zyear

                         pv_mon   TYPE TY_MONTH

                         p_zpernr TYPE zedt19_105-zpernr

                         p_zpay   TYPE zedt19_105-zmon01

                CHANGING pv_check TYPE char1.



  DATA lv_subrc TYPE sy-subrc.

  CLEAR pv_check.



  CASE pv_mon.

  WHEN '01'.

    UPDATE zedt19_105

       SET zmon01 = @p_zpay,

           aedate = @sy-datum,

           aezeit  = @sy-uzeit,

           aename = @sy-uname

     WHERE zpernr = @p_zpernr

       AND zyear  = @pv_year.



  WHEN '02'.

    UPDATE zedt19_105

       SET zmon02 = @p_zpay,

           aedate = @sy-datum,

           aezeit  = @sy-uzeit,

           aename = @sy-uname

     WHERE zpernr = @p_zpernr

       AND zyear  = @pv_year.



  WHEN '03'.

    UPDATE zedt19_105

       SET zmon03 = @p_zpay,

           aedate = @sy-datum,

           aezeit  = @sy-uzeit,

           aename = @sy-uname

     WHERE zpernr = @p_zpernr

       AND zyear  = @pv_year.



  WHEN '04'.

    UPDATE zedt19_105

       SET zmon04 = @p_zpay,

           aedate = @sy-datum,

           aezeit  = @sy-uzeit,

           aename = @sy-uname

     WHERE zpernr = @p_zpernr

       AND zyear  = @pv_year.



  WHEN '05'.

    UPDATE zedt19_105

       SET zmon05 = @p_zpay,

           aedate = @sy-datum,

           aezeit  = @sy-uzeit,

           aename = @sy-uname

     WHERE zpernr = @p_zpernr

       AND zyear  = @pv_year.



  WHEN '06'.

    UPDATE zedt19_105

       SET zmon06 = @p_zpay,

           aedate = @sy-datum,

           aezeit  = @sy-uzeit,

           aename = @sy-uname

     WHERE zpernr = @p_zpernr

       AND zyear  = @pv_year.



  WHEN '07'.

    UPDATE zedt19_105

       SET zmon07 = @p_zpay,

           aedate = @sy-datum,

           aezeit  = @sy-uzeit,

           aename = @sy-uname

     WHERE zpernr = @p_zpernr

       AND zyear  = @pv_year.



  WHEN '08'.

    UPDATE zedt19_105

       SET zmon08 = @p_zpay,

           aedate = @sy-datum,

           aezeit  = @sy-uzeit,

           aename = @sy-uname

     WHERE zpernr = @p_zpernr

       AND zyear  = @pv_year.



  WHEN '09'.

    UPDATE zedt19_105

       SET zmon09 = @p_zpay,

           aedate = @sy-datum,

           aezeit  = @sy-uzeit,

           aename = @sy-uname

     WHERE zpernr = @p_zpernr

       AND zyear  = @pv_year.



  WHEN '10'.

    UPDATE zedt19_105

       SET zmon10 = @p_zpay,

           aedate = @sy-datum,

           aezeit  = @sy-uzeit,

           aename = @sy-uname

     WHERE zpernr = @p_zpernr

       AND zyear  = @pv_year.



  WHEN '11'.

    UPDATE zedt19_105

       SET zmon11 = @p_zpay,

           aedate = @sy-datum,

           aezeit  = @sy-uzeit,

           aename = @sy-uname

     WHERE zpernr = @p_zpernr

       AND zyear  = @pv_year.



  WHEN '12'.

    UPDATE zedt19_105

       SET zmon12 = @p_zpay,

           aedate = @sy-datum,

           aezeit  = @sy-uzeit,

           aename = @sy-uname

     WHERE zpernr = @p_zpernr

       AND zyear  = @pv_year.

ENDCASE.





  lv_subrc = sy-subrc.

  IF lv_subrc <> 0.

    pv_check = c_x.

  ENDIF.

ENDFORM.



"========================================================

" [R3] #### ## (JOIN # 4)

"========================================================

FORM select_data_r3.

  IF s_zperr[] IS INITIAL.

    SELECT a~zpernr, b~zpname, a~zdepcode, a~zdeprank, a~zedate,

           d~zsalary, c~zrank

      INTO CORRESPONDING FIELDS OF TABLE @gt_assess

      FROM zedt19_102 AS a

      INNER JOIN zedt19_103 AS b ON a~zpernr = b~zpernr

      INNER JOIN zedt19_104 AS c ON a~zpernr = c~zpernr

      INNER JOIN zedt19_106 AS d ON a~zpernr = d~zpernr

      WHERE c~zyear = @p_year3

        AND d~zyear = @p_year3.

  ELSE.

    SELECT a~zpernr, b~zpname, a~zdepcode, a~zdeprank, a~zedate,

           d~zsalary, c~zrank

      INTO CORRESPONDING FIELDS OF TABLE @gt_assess

      FROM zedt19_102 AS a

      INNER JOIN zedt19_103 AS b ON a~zpernr = b~zpernr

      INNER JOIN zedt19_104 AS c ON a~zpernr = c~zpernr

      INNER JOIN zedt19_106 AS d ON a~zpernr = d~zpernr

      WHERE a~zpernr IN @s_zperr

        AND c~zyear = @p_year3

        AND d~zyear = @p_year3.

  ENDIF.

ENDFORM.



"========================================================

" [R3] ##/### ##

"========================================================

FORM modify_data_r3.

  LOOP AT gt_assess INTO gs_assess.

    CLEAR gs_assess_alv.

    MOVE-CORRESPONDING gs_assess TO gs_assess_alv.



    PERFORM get_pay USING    p_year3 p_mon3 gs_assess_alv-zpernr

                    CHANGING gs_assess_alv-zmon.



    IF gs_assess_alv-zmon = 0.

      CONTINUE.

    ENDIF.



    PERFORM make_depcode USING    gs_assess_alv-zdepcode

                         CHANGING gs_assess_alv-zdepcode_name.

    PERFORM make_rank    USING    gs_assess-zdeprank

                         CHANGING gs_assess_alv-zdeprank_name.



    APPEND gs_assess_alv TO gt_assess_alv.

  ENDLOOP.

ENDFORM.



"========================================================

" [R3] ALV ##

"========================================================

FORM alv_display_r3.

  PERFORM field_catalog_r3.

  PERFORM set_layout.

  PERFORM set_sort.

  PERFORM call_alv USING gt_assess_alv.

ENDFORM.



"========================================================

" GET_PAY : ## ## ## (CASE# 12##)

"========================================================

FORM get_pay USING    pv_year  TYPE zedt19_105-zyear

                      pv_mon   TYPE ty_month

                      p_zpernr TYPE zedt19_105-zpernr

             CHANGING p_zmon   TYPE zedt19_105-zmon01.



  CASE pv_mon.

    WHEN '01'.

      SELECT SINGLE zmon01 INTO @p_zmon FROM zedt19_105

        WHERE zpernr = @p_zpernr AND zyear = @pv_year.

    WHEN '02'.

      SELECT SINGLE zmon02 INTO @p_zmon FROM zedt19_105

        WHERE zpernr = @p_zpernr AND zyear = @pv_year.

    WHEN '03'.

      SELECT SINGLE zmon03 INTO @p_zmon FROM zedt19_105

        WHERE zpernr = @p_zpernr AND zyear = @pv_year.

    WHEN '04'.

      SELECT SINGLE zmon04 INTO @p_zmon FROM zedt19_105

        WHERE zpernr = @p_zpernr AND zyear = @pv_year.

    WHEN '05'.

      SELECT SINGLE zmon05 INTO @p_zmon FROM zedt19_105

        WHERE zpernr = @p_zpernr AND zyear = @pv_year.

    WHEN '06'.

      SELECT SINGLE zmon06 INTO @p_zmon FROM zedt19_105

        WHERE zpernr = @p_zpernr AND zyear = @pv_year.

    WHEN '07'.

      SELECT SINGLE zmon07 INTO @p_zmon FROM zedt19_105

        WHERE zpernr = @p_zpernr AND zyear = @pv_year.

    WHEN '08'.

      SELECT SINGLE zmon08 INTO @p_zmon FROM zedt19_105

        WHERE zpernr = @p_zpernr AND zyear = @pv_year.

    WHEN '09'.

      SELECT SINGLE zmon09 INTO @p_zmon FROM zedt19_105

        WHERE zpernr = @p_zpernr AND zyear = @pv_year.

    WHEN '10'.

      SELECT SINGLE zmon10 INTO @p_zmon FROM zedt19_105

        WHERE zpernr = @p_zpernr AND zyear = @pv_year.

    WHEN '11'.

      SELECT SINGLE zmon11 INTO @p_zmon FROM zedt19_105

        WHERE zpernr = @p_zpernr AND zyear = @pv_year.

    WHEN '12'.

      SELECT SINGLE zmon12 INTO @p_zmon FROM zedt19_105

        WHERE zpernr = @p_zpernr AND zyear = @pv_year.

  ENDCASE.



ENDFORM.



"========================================================

" ##/##/## ### ## (USING/CHANGING ##, ## 7)

"========================================================

FORM make_depcode USING    p_zdepcode

                  CHANGING p_name.

  CASE p_zdepcode.

    WHEN 'SS0001'. p_name = '###'.

    WHEN 'SS0002'. p_name = '###'.

    WHEN 'SS0003'. p_name = '###'.

    WHEN 'SS0004'. p_name = '###'.

    WHEN 'SS0005'. p_name = '###'.

    WHEN 'SS0006'. p_name = '###'.

  ENDCASE.

ENDFORM.



FORM make_rank USING    p_rank

               CHANGING p_rank_name.

  CASE p_rank.

    WHEN 'A'. p_rank_name = '##'.

    WHEN 'B'. p_rank_name = '##'.

    WHEN 'C'. p_rank_name = '##'.

    WHEN 'D'. p_rank_name = '##'.

    WHEN 'E'. p_rank_name = '##'.

    WHEN 'F'. p_rank_name = '##'.

    WHEN 'G'. p_rank_name = '##'.

  ENDCASE.

ENDFORM.



FORM make_bankcode USING    p_bankcode

                   CHANGING p_bankname.

  CASE p_bankcode.

    WHEN '001'. p_bankname = '##'.

    WHEN '002'. p_bankname = '##'.

    WHEN '003'. p_bankname = '##'.

    WHEN '004'. p_bankname = '##'.

    WHEN '005'. p_bankname = '###'.

  ENDCASE.

ENDFORM.



"========================================================

" ALV: ######/####/##/## (## 12)

"========================================================

FORM field_catalog_r1.

  CLEAR gt_fieldcat.

  PERFORM add_fcat USING 1  'ZPERNR'        '####'  'X'  0  ''    ''.

  PERFORM add_fcat USING 2  'ZPNAME'        '####'  ''   0  ''    ''.

  PERFORM add_fcat USING 3  'ZDEPCODE'      '####'  ''   0  ''    ''.

  PERFORM add_fcat USING 4  'ZDEPCODE_NAME' '###'    ''   0  ''    ''.

  PERFORM add_fcat USING 5  'ZDEPRANK_NAME' '###'    ''   0  ''    ''.

  PERFORM add_fcat USING 6  'ZEDATE'        '###'    ''  10  ''    ''.

  PERFORM add_fcat USING 7  'ZQFLAG_NAME'   '####'  ''   0  ''    ''.

  PERFORM add_fcat USING 8  'ZGENDER_NAME'  '##'      ''   0  ''    ''.

  PERFORM add_fcat USING 9  'ZADDRESS'      '##'      ''   0  ''    ''.

  PERFORM add_fcat USING 10 'ZBANKCODE'     '####'  ''   0  ''    ''.

  PERFORM add_fcat USING 11 'ZBANK_NAME'    '###'    ''   0  ''    ''.

  PERFORM add_fcat USING 12 'ZACCOUNT'      '####'  ''   0  ''    ''.

ENDFORM.



FORM field_catalog_r3.

  CLEAR gt_fieldcat.

  PERFORM add_fcat USING 1 'ZPERNR'        '####'  'X' 0  ''   ''.

  PERFORM add_fcat USING 2 'ZPNAME'        '####'  ''  0  ''   ''.

  PERFORM add_fcat USING 3 'ZDEPCODE'      '####'  ''  0  ''   ''.

  PERFORM add_fcat USING 4 'ZDEPCODE_NAME' '###'    ''  0  ''   ''.

  PERFORM add_fcat USING 5 'ZDEPRANK_NAME' '###'    ''  0  ''   ''.

  PERFORM add_fcat USING 6 'ZEDATE'        '###'    '' 10 ''   ''.

  PERFORM add_fcat USING 7 'ZSALARY'       '####'  '' 20 'KRW' 'X'.

  PERFORM add_fcat USING 8 'ZRANK'         '####'  ''  0  ''   ''.



  CONCATENATE p_mon3 '####' INTO l_text.



  PERFORM add_fcat USING 9 'ZMON' l_text '' 20 'KRW' 'X'.

ENDFORM.



FORM add_fcat USING iv_pos iv_fname iv_text iv_key iv_len iv_curr iv_sum.

  CLEAR gs_fieldcat.

  gs_fieldcat-col_pos   = iv_pos.

  gs_fieldcat-fieldname = iv_fname.

  gs_fieldcat-seltext_m = iv_text.

  gs_fieldcat-key       = iv_key.

  IF iv_len IS NOT INITIAL.

    gs_fieldcat-outputlen = iv_len.

  ENDIF.

  IF iv_curr IS NOT INITIAL.

    gs_fieldcat-currency = iv_curr.

  ENDIF.

  IF iv_sum = c_x.

    gs_fieldcat-do_sum = c_x.

  ENDIF.

  APPEND gs_fieldcat TO gt_fieldcat.

ENDFORM.



FORM set_layout.

  CLEAR gs_layout.

  gs_layout-zebra = c_x.

ENDFORM.



FORM set_sort.

  CLEAR gt_sort.

  CLEAR gs_sort.

  gs_sort-spos      = 1.

  gs_sort-fieldname = 'ZPERNR'.

  gs_sort-up        = c_x.

  APPEND gs_sort TO gt_sort.

ENDFORM.



FORM call_alv USING pt_alv TYPE STANDARD TABLE.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

    EXPORTING

      it_fieldcat = gt_fieldcat

      is_layout   = gs_layout

      it_sort     = gt_sort

    TABLES

      t_outtab    = pt_alv.

ENDFORM.