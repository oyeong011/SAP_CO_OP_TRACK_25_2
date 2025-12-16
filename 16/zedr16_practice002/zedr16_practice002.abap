
*&---------------------------------------------------------------------*

*& Report ZEDR16_PRACTICE002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT zedr16_practice002.



" ## ###

TYPES: BEGIN OF ty_out,

         zcode       TYPE zedt16_001-zcode,

         zkname      TYPE zedt16_001-zkname,

         transfer_tx TYPE c LENGTH 8,

         ztel_show   TYPE zedt16_001-ztel,

         remark      TYPE c LENGTH 10,

       END OF ty_out.



DATA: gt_out TYPE STANDARD TABLE OF ty_out WITH EMPTY KEY,

      gs_out TYPE ty_out.



DATA : BEGIN OF gs_sum,

         zgender TYPE zedt16_001-zgender,

         zsum    TYPE zedt16_004-zsum,

       END OF gs_sum.



DATA gt_sum LIKE TABLE OF gs_sum.





DATA gt_zedt001 TYPE TABLE OF zedt16_001.

DATA gs_zedt001 TYPE zedt16_001.



DATA gt_zedt002 TYPE TABLE OF zedt16_002.

DATA gs_zedt002 TYPE zedt16_002.



DATA gt_zedt004 TYPE TABLE OF zedt16_004.

DATA gs_zedt004 TYPE zedt16_004.



"## ##(### ## 1## ## ##)

DATA: gt_rep TYPE STANDARD TABLE OF zedt16_004 WITH EMPTY KEY,

      gs_rep TYPE zedt16_004.



"#/# ### ##

DATA: gv_sum_m TYPE p DECIMALS 2,

      gv_sum_f TYPE p DECIMALS 2.



" Loop ### ### ## ##

DATA: ls_probe TYPE zedt16_004.

DATA: ls_tmp   TYPE zedt16_004.





SELECT * FROM zedt16_001

  INTO CORRESPONDING FIELDS OF TABLE gt_zedt001.



SELECT * FROM zedt16_002

  INTO CORRESPONDING FIELDS OF TABLE gt_zedt002.



SELECT * FROM zedt16_004

  INTO CORRESPONDING FIELDS OF TABLE gt_zedt004.







" zpernr, zgrade# ## # zpernr ## ## ## gt_rep# ##

gt_rep = gt_zedt004.

SORT gt_rep BY zpernr zgrade DESCENDING.

DELETE ADJACENT DUPLICATES FROM gt_rep COMPARING zpernr.



" MODIFY# LOOP

LOOP AT gt_rep INTO gs_rep.



  CLEAR gs_out.



  CLEAR gs_zedt001.



  CLEAR gs_sum.



  " zedt16_001 READ

  READ TABLE gt_zedt001 INTO gs_zedt001

       WITH KEY zpernr = gs_rep-zpernr.

  CHECK sy-subrc = 0.



  CLEAR gs_zedt002.



  " zedt16_002 READ

  READ TABLE gt_zedt002 INTO gs_zedt002

       WITH KEY zpernr = gs_rep-zpernr.



  CHECK sy-subrc = 0.



  " ####, ##### ## ##

  CLEAR ls_probe.

  ls_probe-zpernr = gs_rep-zpernr.

  ls_probe-zmajor = gs_rep-zmajor.





  CLEAR ls_tmp.

  MOVE-CORRESPONDING gs_zedt002 TO ls_tmp.





  READ TABLE gt_zedt004

    WITH KEY zpernr = ls_tmp-zpernr

    INTO ls_tmp

    COMPARING zmajor.






*   zmajor# ### #### ##




  IF sy-subrc = 2.

    gs_out-transfer_tx = '####'.

  ENDIF.



  " #### ##

  IF gs_rep-zgrade >= 'D'.

    gs_out-remark = '####'.

    gs_out-ztel_show = gs_zedt001-ztel.

  ENDIF.






*  " #, # ### ##

*  IF gs_zedt001-zgender = 'M'.

*    gv_sum_m = gv_sum_m + gs_rep-zsum.

*  ELSEIF gs_zedt001-zgender = 'F'.

*    gv_sum_f = gv_sum_f + gs_rep-zsum.

*  ENDIF.






  CLEAR gs_sum.



  gs_sum-zgender = gs_zedt001-zgender.

  gs_sum-zsum = gs_rep-zsum.



  COLLECT gs_sum INTO gt_sum.



  " ## ## ### ##

  gs_out-zcode  = gs_rep-zcode.

  gs_out-zkname = gs_zedt001-zkname.

  APPEND gs_out TO gt_out.



ENDLOOP.





LOOP AT gt_out INTO gs_out.

  AT FIRST.

    WRITE :/ '---------------------------------------------------------------------------'.

    WRITE :/ '|  ####  |     ##     |   ####  |     ####     |    ##    |'.

    WRITE :/ '---------------------------------------------------------------------------'.

  ENDAT.



  WRITE :/ '|', gs_out-zcode,

           '|', gs_out-zkname,

           '  |', gs_out-transfer_tx,

           '   |', gs_out-ztel_show,

           '|', gs_out-remark,

           '|'.

  WRITE :/ '---------------------------------------------------------------------------'.

ENDLOOP.





READ TABLE gt_sum WITH KEY zgender = 'M' INTO gs_sum.



IF sy-subrc = 0.

  gv_sum_m = gs_sum-zsum.

ENDIF.



CLEAR gs_sum.





READ TABLE gt_sum WITH KEY zgender = 'F' INTO gs_sum.



IF sy-subrc = 0.

  gv_sum_f = gs_sum-zsum.

ENDIF.



WRITE: / '###### : ', gv_sum_m CURRENCY 'KRW'.

WRITE: / '###### : ', gv_sum_f CURRENCY 'KRW'.