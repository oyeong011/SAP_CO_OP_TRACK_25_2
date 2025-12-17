
*&---------------------------------------------------------------------*

*&  Include           ZEDR07_PRACTICE009_TOP

*&---------------------------------------------------------------------*






TABLES : zedt07_102, zedt07_103, zedt07_104, zedt07_106.



CONSTANTS : c_x TYPE char1 VALUE 'X'.

CONSTANTS : c_a TYPE char1 VALUE 'A'.



RANGES : r_fg FOR zedt07_102-zqflag.



DATA : BEGIN OF gs_emp,

  zpernr LIKE zedt07_102-zpernr, "####

  zpname LIKE zedt07_103-zpname, "##

  zdepcode LIKE zedt07_102-zdepcode, "####

  datbi LIKE zedt07_102-datbi, "####

  datab LIKE zedt07_102-datab, "####

  zdeprank LIKE zedt07_104-zrank, "##

  zgender LIKE zedt07_103-zgender, "##

  zedate LIKE zedt07_102-zedate, "####

  zqdate LIKE zedt07_102-zqdate, "####

  zqflag LIKE zedt07_102-zqflag, "####

  zaddress LIKE zedt07_103-zaddress, "##

  END OF gs_emp.



DATA : gt_emp LIKE TABLE OF gs_emp.



DATA : BEGIN OF gs_emp_print, "###

  icon TYPE c LENGTH 4,

  zpernr LIKE zedt07_102-zpernr, "####

  zpname LIKE zedt07_103-zpname, "##

  zdepcode_name TYPE c LENGTH 10, "##

  datbi LIKE zedt07_102-datbi, "###

  datab LIKE zedt07_102-datab, "###

  zrank_name TYPE c LENGTH 8, "##

  zgender_name TYPE c LENGTH 4, "##

  zedate LIKE zedt07_102-zedate, "###

  zqdate LIKE zedt07_102-zqdate, "###

  zqflag LIKE zedt07_102-zqflag, "####

  zaddress LIKE zedt07_103-zaddress, "##

  END OF gs_emp_print.



DATA : gt_emp_print LIKE TABLE OF gs_emp_print.



DATA : BEGIN OF gs_sal,

  zpernr LIKE zedt07_106-zpernr, "####

  zyear LIKE zedt07_106-zyear, "####

  datbi LIKE zedt07_106-datbi,  "###

  datab LIKE zedt07_106-datab, "###

  zsalary LIKE zedt07_106-zsalary, "###

  zbankcode LIKE zedt07_106-zbankcode, "####

  zaccount LIKE zedt07_106-zaccount, "####

  END OF gs_sal.



DATA : gt_sal LIKE TABLE OF gs_sal.



DATA : BEGIN OF gs_sal_print,

  zpernr LIKE zedt07_106-zpernr, "####

  zyear LIKE zedt07_106-zyear, "####

  datbi LIKE zedt07_106-datbi, "###

  datab LIKE zedt07_106-datab, "###

  zsalary LIKE zedt07_106-zsalary, "###

  zwaers TYPE waers, "##

  zbank_name TYPE c LENGTH 10, "####

  zaccount LIKE zedt07_106-zaccount, "####

  END OF gs_sal_print.



DATA : gt_sal_print LIKE TABLE OF gs_sal_print.



DATA : BEGIN OF gs_assess,

  zpernr LIKE zedt07_104-zpernr, "####

  zdepcode LIKE zedt07_104-zdepcode, "####

  zyear LIKE zedt07_104-zyear, "####

  datbi LIKE zedt07_104-datbi, "###

  datab LIKE zedt07_104-datab, "###

  zrank LIKE zedt07_104-zrank, "##

  END OF gs_assess.



DATA : gt_assess LIKE TABLE OF gs_assess.



DATA : BEGIN OF gs_assess_print,

  zpernr LIKE zedt07_104-zpernr,

  zdepcode_name TYPE c LENGTH 10,

  zyear LIKE zedt07_104-zyear,

  datbi LIKE zedt07_104-datbi,

  datab LIKE zedt07_104-datab,

  zrank LIKE zedt07_104-zrank,

  END OF gs_assess_print.



DATA : gt_assess_print LIKE TABLE OF gs_assess_print.



DATA : ok_code TYPE sy-ucomm.



DATA : gc_docking TYPE REF TO cl_gui_docking_container.



DATA : gc_splitter TYPE REF TO cl_gui_splitter_container.

DATA : gc_splitter2 TYPE REF TO cl_gui_splitter_container.



DATA : gc_container1 TYPE REF TO cl_gui_container.

DATA : gc_container2 TYPE REF TO cl_gui_container.

DATA : gc_container3 TYPE REF TO cl_gui_container.

DATA : gc_container4 TYPE REF TO cl_gui_container.



DATA : gc_grid1 TYPE REF TO cl_gui_alv_grid.

DATA : gc_grid2 TYPE REF TO cl_gui_alv_grid.

DATA : gc_grid3 TYPE REF TO cl_gui_alv_grid.



DATA : gs_fieldcat TYPE lvc_s_fcat.





DATA : gt_fieldcat1 TYPE lvc_t_fcat,

       gt_fieldcat2 TYPE lvc_t_fcat,

       gt_fieldcat3 TYPE lvc_t_fcat.



DATA : gs_layout TYPE lvc_s_layo.



DATA : gs_sort TYPE lvc_s_sort.

DATA : gt_sort1 TYPE lvc_t_sort,

       gt_sort2 TYPE lvc_t_sort,

       gt_sort3 TYPE lvc_t_sort.



DATA : gs_variant TYPE disvariant.