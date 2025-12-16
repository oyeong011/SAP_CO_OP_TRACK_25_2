
*&---------------------------------------------------------------------*

*&  Include           ZEDR07_PRACTICE008_TOP

*&---------------------------------------------------------------------*






TABLES : zedt07_100, zedt07_101.



CONSTANTS : c_x TYPE char1 VALUE 'X'.

CONSTANTS : c_a TYPE char1 VALUE 'A'.

RANGES : r_fg FOR zedt07_100-zsale_fg.

RANGES : r_zg FOR zedt07_101-zflag.



DATA : BEGIN OF gs_order, "####

  zordno LIKE zedt07_100-zordno, "####

  zidcode LIKE zedt07_100-zidcode, "## ID

  zmatnr LIKE zedt07_100-zmatnr, "## ##

  zmtart LIKE zedt07_100-zmtart, "## ##

  zmatname LIKE zedt07_100-zmatname, "###

  zvolum LIKE zedt07_100-zvolum, "##

  vrkme LIKE zedt07_100-vrkme, "####

  znsamt LIKE zedt07_100-znsamt, "####

  zslamt LIKE zedt07_100-zslamt, "####

  zdcamt LIKE zedt07_100-zdcamt, "####

  zwaers LIKE zedt07_100-zwaers, "##

  zdc_fg LIKE zedt07_100-zdc_fg, "####

  zsale_fg LIKE zedt07_100-zsale_fg, "####

  zret_fg LIKE zedt07_100-zret_fg, "####

  zjdate LIKE zedt07_100-zjdate, "####

  zrdate LIKE zedt07_100-zrdate, "####

  END OF gs_order.



DATA : gt_order LIKE TABLE OF gs_order.



DATA : BEGIN OF gs_order_print,

  icon TYPE c LENGTH 4,

  zordno LIKE zedt07_100-zordno, "####

  zidcode LIKE zedt07_100-zidcode, "## ID

  zmatnr LIKE zedt07_100-zmatnr, "## ##

  zmatname LIKE zedt07_100-zmatname, "## ###

  zmat_name TYPE c LENGTH 8, "## ###

  zvolum LIKE zedt07_100-zvolum, "##

  vrkme LIKE zedt07_100-vrkme, "####

  znsamt LIKE zedt07_100-znsamt, "####

  zslamt LIKE zedt07_100-zslamt, "####

  zdcamt LIKE zedt07_100-zdcamt, "####

  zwaers LIKE zedt07_100-zwaers, "##

  zsale_name  TYPE c LENGTH 4, "####

  zjdate LIKE zedt07_100-zjdate, "####

  zret_name TYPE c LENGTH 10, "####

  zrdate LIKE zedt07_100-zrdate, "####

END OF gs_order_print.

DATA : gt_order_print LIKE TABLE OF gs_order_print.



DATA : BEGIN OF gs_deli, "####

  zordno LIKE zedt07_101-zordno, "####

  zidcode LIKE zedt07_101-zidcode, "## ID

  zmatnr LIKE zedt07_101-zmatnr, "## ##

  zmtart LIKE zedt07_101-zmtart, "## ##

  zmatname LIKE zedt07_101-zmatname, "###

  zvolum LIKE zedt07_101-zvolum, "##

  vrkme LIKE zedt07_101-vrkme, "####

  zslamt LIKE zedt07_101-zslamt, "####

  zwaers LIKE zedt07_100-zwaers, "##

  zdflag LIKE zedt07_101-zdflag, "####

  zdgubun LIKE zedt07_101-zdgubun, "####

  zddate LIKE zedt07_101-zddate, "####

  zrdate LIKE zedt07_101-zrdate, "####

  zflag LIKE zedt07_101-zflag,

END OF gs_deli.

DATA gt_deli LIKE TABLE OF gs_deli.



DATA : BEGIN OF gs_deli_print,

  icon TYPE c LENGTH 4,

  zordno LIKE zedt07_101-zordno, "####

  zidcode LIKE zedt07_101-zidcode, "## ID

  zmatnr LIKE zedt07_101-zmatnr, "## ##

  zmatname LIKE zedt07_101-zmatname, "###

  zmat_name TYPE c LENGTH 8, "## ###

  zvolum LIKE zedt07_101-zvolum, "##

  vrkme LIKE zedt07_101-vrkme, "####

  zslamt LIKE zedt07_101-zslamt, "####

  zwaers LIKE zedt07_100-zwaers, "##

  zdflag_name TYPE c LENGTH 8, "####

  zdgubun_name TYPE c LENGTH 6, "####

  zddate LIKE zedt07_101-zddate, "####

  zrdate LIKE zedt07_101-zrdate, "####

  zflag LIKE zedt07_101-zflag,

END OF gs_deli_print.

DATA gt_deli_print LIKE TABLE OF gs_deli_print.



DATA : ok_code TYPE sy-ucomm.



DATA : gc_docking TYPE REF TO cl_gui_docking_container.



DATA : gc_grid_100 TYPE REF TO cl_gui_alv_grid.

DATA : gc_grid_200 TYPE REF TO cl_gui_alv_grid.



DATA : gs_fieldcat TYPE lvc_s_fcat,

      gt_fieldcat TYPE lvc_t_fcat.



DATA : gs_layout TYPE lvc_s_layo.



DATA : gs_sort TYPE lvc_s_sort,

      gt_sort TYPE lvc_t_sort.



DATA : gs_variant TYPE disvariant.