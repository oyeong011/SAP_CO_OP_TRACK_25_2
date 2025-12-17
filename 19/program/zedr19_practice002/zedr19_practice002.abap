
*&---------------------------------------------------------------------*

*& Report ZEDR19_PRACTICE002

*&---------------------------------------------------------------------*

*&  ZEDT19_0001 / 0002 / 0004 # ####

*&  #### / #### / ## ### ##

*&---------------------------------------------------------------------*




REPORT ZEDR19_PRACTICE002.



CONSTANTS: c_rate TYPE i VALUE 100.   "## ##



"--------------------------------------------------------------------"

" ### ## ##

"--------------------------------------------------------------------"

TYPES: BEGIN OF ty_result,

         zcode   TYPE zedt19_0001-zcode,

         zname   TYPE zedt19_0001-zkname,

         lv_stop TYPE c LENGTH 10,    "#### ##

         lv_major TYPE c LENGTH 10,   "#### ##

         lv_tel  TYPE c LENGTH 20,    "####

       END OF ty_result.



" ### ## ##

TYPES: BEGIN OF ty_sum,

         zgender TYPE zedt19_0001-zgender,

         amount  TYPE zedt19_004-zsum,

       END OF ty_sum.



" ## ## ### / #####

DATA: gt_sum TYPE SORTED TABLE OF ty_sum WITH UNIQUE KEY zgender,

      gs_sum TYPE ty_sum.



" ### ## ## ###

DATA: gt_result TYPE STANDARD TABLE OF ty_result WITH DEFAULT KEY,

      gs_result TYPE ty_result.



" ## ### ##

DATA: lv_tel    TYPE c LENGTH 20,

      lv_female TYPE zedt19_004-zsum,

      lv_major  TYPE c LENGTH 20,

      lv_stop   TYPE c LENGTH 20,

      lv_male   TYPE zedt19_004-zsum.



" ## ### ### ### ### ###

DATA: gt_zedt001 TYPE STANDARD TABLE OF zedt19_0001 WITH DEFAULT KEY,

      gt_zedt002 TYPE STANDARD TABLE OF zedt19_002  WITH DEFAULT KEY,

      gt_zedt004 TYPE STANDARD TABLE OF zedt19_004  WITH DEFAULT KEY.



DATA: gs_zedt001 TYPE zedt19_0001,

      gs_zedt002 TYPE zedt19_002,

      gs_zedt004 TYPE zedt19_004.



"--------------------------------------------------------------------"

" 1. ### ##

"--------------------------------------------------------------------"

" ## ####

SELECT * FROM zedt19_0001 INTO CORRESPONDING FIELDS OF TABLE gt_zedt001.

" ## ##

SELECT * FROM zedt19_002  INTO CORRESPONDING FIELDS OF TABLE gt_zedt002.

" ##/## ##

SELECT * FROM zedt19_004  INTO CORRESPONDING FIELDS OF TABLE gt_zedt004.



"--------------------------------------------------------------------"

" 2. ### ## # ## ### ###

"--------------------------------------------------------------------"

SORT gt_zedt001 BY zcode.

SORT gt_zedt002 BY zcode.

SORT gt_zedt004 BY zcode zgrade DESCENDING.



" ## #### # ## ## ##(## ## ##)# ##

DELETE ADJACENT DUPLICATES FROM gt_zedt004 COMPARING zcode.



CLEAR: gs_zedt001, gs_result.



"--------------------------------------------------------------------"

" 3. ### ##/####/####/#### ##

"--------------------------------------------------------------------"

LOOP AT gt_zedt004 INTO gs_zedt004.



  CLEAR: gs_zedt001, gs_zedt002, lv_major, lv_tel, lv_stop.



  " ## ### ##

  IF gs_zedt004-zgrade IS INITIAL.

    CONTINUE.

  ENDIF.



  " ## #### / #### ##

  READ TABLE gt_zedt001 INTO gs_zedt001

       WITH KEY zcode = gs_zedt004-zcode.

  READ TABLE gt_zedt002 INTO gs_zedt002

       WITH KEY zcode = gs_zedt004-zcode.



  " #### ## (## ## ### #### ### ## ##)

  IF sy-subrc = 0 AND

     gs_zedt002-zmajor IS NOT INITIAL AND

     gs_zedt002-zmajor <> gs_zedt004-zmajor.

    lv_major = '####'.

  ENDIF.



  " D ## F ## #### + #### ##

  IF gs_zedt004-zgrade = 'D' OR gs_zedt004-zgrade = 'F'.

    lv_stop = '####'.

    lv_tel  = gs_zedt001-ztel.

  ELSE.

    lv_stop = ' '.

    lv_tel  = ' '.

  ENDIF.



  " ## ## ##

  CLEAR gs_result.

  gs_result-zcode   = gs_zedt001-zcode.

  gs_result-zname   = gs_zedt001-zkname.

  gs_result-lv_stop = lv_stop.

  gs_result-lv_major = lv_major.

  gs_result-lv_tel  = lv_tel.

  APPEND gs_result TO gt_result.



  " ### ## ##

  CLEAR gs_sum.

  gs_sum-zgender = gs_zedt001-zgender.

  gs_sum-amount  = gs_zedt004-zsum.

  COLLECT gs_sum INTO gt_sum.



ENDLOOP.



"--------------------------------------------------------------------"

" 4. #/# ## ##

"--------------------------------------------------------------------"

CLEAR: lv_male, lv_female, gs_sum.



READ TABLE gt_sum INTO gs_sum WITH KEY zgender = 'M'.

IF sy-subrc = 0.

  lv_male = gs_sum-amount * c_rate.

ENDIF.



CLEAR gs_sum.

READ TABLE gt_sum INTO gs_sum WITH KEY zgender = 'F'.

IF sy-subrc = 0.

  lv_female = gs_sum-amount * c_rate.

ENDIF.



"--------------------------------------------------------------------"

" 5. ##

"--------------------------------------------------------------------"

LOOP AT gt_result INTO gs_result.



  AT FIRST.

    WRITE: / '---------------------------------------------------------------------------------------'.

    WRITE: / '|  ####  |         ##         |   ####  |     ####         |    ##    |'.

    WRITE: / '---------------------------------------------------------------------------------------'.

  ENDAT.



  WRITE: / '|', gs_result-zcode,

         '|', gs_result-zname,

         '|', gs_result-lv_major,

         ' |', gs_result-lv_tel,

         '|', gs_result-lv_stop,

         '|'.

  WRITE: / '---------------------------------------------------------------------------------------'.



ENDLOOP.



WRITE: / '### ## :', lv_male   DECIMALS 0.

WRITE: / '### ## :', lv_female DECIMALS 0.