
*&---------------------------------------------------------------------*

*&  Include           ZEDR25_PRACTICE009_TOP

*&---------------------------------------------------------------------*

*=== TOP Include =====================================================






TABLES: zedt25_102, zedt25_103, zedt25_104, zedt25_106.



RANGES: r_fg FOR zedt25_102-zqflag.






*##/## ## ##




DATA: BEGIN OF gs_emp,

        zpernr    LIKE zedt25_102-zpernr,

        zpname    LIKE zedt25_103-zpname,

        zdepcode  LIKE zedt25_102-zdepcode,

        datbi     LIKE zedt25_102-datbi,

        datab     LIKE zedt25_102-datab,

        zdeprank  LIKE zedt25_104-zrank,

        zgender   LIKE zedt25_103-zgender,

        zedate    LIKE zedt25_102-zedate,

        zqdate    LIKE zedt25_102-zqdate,

        zqflag    LIKE zedt25_102-zqflag,

        zaddress  LIKE zedt25_103-zaddress,

      END OF gs_emp.

DATA: gt_emp LIKE TABLE OF gs_emp.






*## ALV ###




DATA: BEGIN OF gs_emp_alv,

        icon           TYPE c LENGTH 4,

        zpernr         LIKE zedt25_102-zpernr,

        zpname         LIKE zedt25_103-zpname,

        zdepcode_name  TYPE c LENGTH 10,

        datbi          LIKE zedt25_102-datbi,

        datab          LIKE zedt25_102-datab,

        zrank_name(8),

        zgender_name(4),

        zedate         LIKE zedt25_102-zedate,

        zqdate         LIKE zedt25_102-zqdate,

        zqflag         LIKE zedt25_102-zqflag,

        zaddress       LIKE zedt25_103-zaddress,

      END OF gs_emp_alv.



DATA: gt_emp_alv LIKE TABLE OF gs_emp_alv.






*## ####




DATA: BEGIN OF gs_pay.

        include structure
zedt25_106
.

DATA: END OF gs_pay.



DATA: gt_pay LIKE TABLE OF gs_pay.






*## #### ALV




DATA: BEGIN OF gs_pay_alv,

        zpernr     LIKE zedt25_106-zpernr,

        zyear      LIKE zedt25_106-zyear,

        datbi      LIKE zedt25_106-datbi,

        datab      LIKE zedt25_106-datab,

        zsalary    LIKE zedt25_106-zsalary,

        zwaers     TYPE waers,              "###

        zbank_name TYPE c LENGTH 10,

        zaccount   LIKE zedt25_106-zaccount,

      END OF gs_pay_alv.



DATA: gt_pay_alv LIKE TABLE OF gs_pay_alv.






*#### ##




DATA: BEGIN OF gs_eval,

        zpernr    LIKE zedt25_104-zpernr,

        zdepcode  LIKE zedt25_104-zdepcode,

        zyear     LIKE zedt25_104-zyear,

        datbi     LIKE zedt25_104-datbi,

        datab     LIKE zedt25_104-datab,

        zrank     LIKE zedt25_104-zrank,

      END OF gs_eval.

DATA: gt_eval LIKE TABLE OF gs_eval.






*#### ALV




DATA: BEGIN OF gs_eval_alv,

        zpernr        LIKE zedt25_104-zpernr,

        zdepcode_name TYPE c LENGTH 10,

        zyear         LIKE zedt25_104-zyear,

        datbi         LIKE zedt25_104-datbi,

        datab         LIKE zedt25_104-datab,

        zrank         LIKE zedt25_104-zrank,

      END OF gs_eval_alv.



DATA: gt_eval_alv LIKE TABLE OF gs_eval_alv.






*GUI/ALV ##




DATA: ok_code           TYPE sy-ucomm.

DATA: gc_docking        TYPE REF TO cl_gui_docking_container.

DATA: gc_splitter       TYPE REF TO cl_gui_splitter_container,

      gc_splitter2      TYPE REF TO cl_gui_splitter_container.



DATA: gc_container_top      TYPE REF TO cl_gui_container,

      gc_container_bottom   TYPE REF TO cl_gui_container,

      gc_container_topeval  TYPE REF TO cl_gui_container,

      gc_container_toppay   TYPE REF TO cl_gui_container.



DATA: gc_grid_topeval   TYPE REF TO cl_gui_alv_grid,

      gc_grid_toppay    TYPE REF TO cl_gui_alv_grid,

      gc_grid_bottom    TYPE REF TO cl_gui_alv_grid.






*######/####/##/##




DATA: gs_fieldcat TYPE lvc_s_fcat,

      gt_fieldcat1 TYPE lvc_t_fcat.

DATA: gt_fieldcat2 TYPE lvc_t_fcat.

DATA: gt_fieldcat3 TYPE lvc_t_fcat.



DATA: gs_layout   TYPE lvc_s_layo.



DATA: gs_sort     TYPE lvc_s_sort,

      gt_sort1    TYPE lvc_t_sort,

      gt_sort2    TYPE lvc_t_sort,

      gt_sort3    TYPE lvc_t_sort.



DATA: gs_variant  TYPE disvariant.