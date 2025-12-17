
*&---------------------------------------------------------------------*

*& Include ZEDR11_PRACTICE009_TOP

*&---------------------------------------------------------------------*




" [##] ## #### ZEDT07 #### ##

TABLES : zedt07_102, zedt07_103, zedt07_104, zedt07_106.



CONSTANTS : c_x    TYPE char1 VALUE 'X',

            c_save TYPE char1 VALUE 'A'.



RANGES : r_stat FOR zedt07_102-zqflag.



" 1. ## ### (Master)

DATA : BEGIN OF gs_emp_m,

         zpernr   LIKE zedt07_102-zpernr,

         zpname   LIKE zedt07_103-zpname,

         zdepcode LIKE zedt07_102-zdepcode,

         datbi    LIKE zedt07_102-datbi,

         datab    LIKE zedt07_102-datab,

         zdeprank LIKE zedt07_104-zrank,

         zgender  LIKE zedt07_103-zgender,

         zedate   LIKE zedt07_102-zedate,

         zqdate   LIKE zedt07_102-zqdate,

         zqflag   LIKE zedt07_102-zqflag,

         zaddress LIKE zedt07_103-zaddress,

       END OF gs_emp_m.

DATA : gt_emp_m LIKE TABLE OF gs_emp_m.



" 2. ## ###

DATA : BEGIN OF gs_emp_out,

         icon     TYPE icon_d,

         zpernr   LIKE zedt07_102-zpernr,

         zpname   LIKE zedt07_103-zpname,

         dep_txt  TYPE c LENGTH 20,

         datbi    LIKE zedt07_102-datbi,

         datab    LIKE zedt07_102-datab,

         rank_txt TYPE c LENGTH 20,

         gen_txt  TYPE c LENGTH 10,

         zedate   LIKE zedt07_102-zedate,

         zqdate   LIKE zedt07_102-zqdate,

         zqflag   LIKE zedt07_102-zqflag,

         zaddress LIKE zedt07_103-zaddress,

       END OF gs_emp_out.

DATA : gt_emp_out LIKE TABLE OF gs_emp_out.



" 3. ## ## (Pay)

DATA : BEGIN OF gs_pay,

         zpernr    LIKE zedt07_106-zpernr,

         zyear     LIKE zedt07_106-zyear,

         datbi     LIKE zedt07_106-datbi,

         datab     LIKE zedt07_106-datab,

         zsalary   LIKE zedt07_106-zsalary,

         zbankcode LIKE zedt07_106-zbankcode,

         zaccount  LIKE zedt07_106-zaccount,

       END OF gs_pay.

DATA : gt_pay LIKE TABLE OF gs_pay.



" 4. ## ###

DATA : BEGIN OF gs_pay_out,

         zpernr   LIKE zedt07_106-zpernr,

         zyear    LIKE zedt07_106-zyear,

         datbi    LIKE zedt07_106-datbi,

         datab    LIKE zedt07_106-datab,

         zsalary  LIKE zedt07_106-zsalary,

         waers    TYPE waers,

         bank_txt TYPE c LENGTH 20,

         zaccount LIKE zedt07_106-zaccount,

       END OF gs_pay_out.

DATA : gt_pay_out LIKE TABLE OF gs_pay_out.



" 5. ## ## (Score)

DATA : BEGIN OF gs_score,

         zpernr   LIKE zedt07_104-zpernr,

         zdepcode LIKE zedt07_104-zdepcode,

         zyear    LIKE zedt07_104-zyear,

         datbi    LIKE zedt07_104-datbi,

         datab    LIKE zedt07_104-datab,

         zrank    LIKE zedt07_104-zrank,

       END OF gs_score.

DATA : gt_score LIKE TABLE OF gs_score.



" 6. ## ###

DATA : BEGIN OF gs_score_out,

         zpernr  LIKE zedt07_104-zpernr,

         dep_txt TYPE c LENGTH 20,

         zyear   LIKE zedt07_104-zyear,

         datbi   LIKE zedt07_104-datbi,

         datab   LIKE zedt07_104-datab,

         zrank   LIKE zedt07_104-zrank,

       END OF gs_score_out.

DATA : gt_score_out LIKE TABLE OF gs_score_out.



" ALV Objects

DATA : ok_code TYPE sy-ucomm.



DATA : go_dock       TYPE REF TO cl_gui_docking_container,

       go_split_vert TYPE REF TO cl_gui_splitter_container,

       go_split_hori TYPE REF TO cl_gui_splitter_container.



DATA : go_c_top   TYPE REF TO cl_gui_container,

       go_c_bot   TYPE REF TO cl_gui_container,

       go_c_bot_l TYPE REF TO cl_gui_container,

       go_c_bot_r TYPE REF TO cl_gui_container.



DATA : go_alv_top   TYPE REF TO cl_gui_alv_grid,

       go_alv_bot_l TYPE REF TO cl_gui_alv_grid,

       go_alv_bot_r TYPE REF TO cl_gui_alv_grid.



DATA : gs_fcat    TYPE lvc_s_fcat,

       gt_fcat_t  TYPE lvc_t_fcat,

       gt_fcat_bl TYPE lvc_t_fcat,

       gt_fcat_br TYPE lvc_t_fcat,

       gs_layout  TYPE lvc_s_layo,

       gs_sort    TYPE lvc_s_sort,

       gt_sort    TYPE lvc_t_sort,

       gs_variant TYPE disvariant.