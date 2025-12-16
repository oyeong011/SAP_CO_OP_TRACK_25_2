
*&---------------------------------------------------------------------*

*& Report ZEDR16_PRACTICE003

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT zedr16_practice003.



TABLES : zedt16_100.

TABLES : zedt16_101.



DATA : BEGIN OF gs_order,

         zordno   LIKE zedt16_100-zordno, "####

         zidcode  LIKE zedt16_100-zidcode, "##ID

         zmatnr   LIKE zedt16_100-zmatnr, "####

         zmtart   LIKE zedt16_100-zmtart, "####

         zmatname LIKE zedt16_100-zmatname, "###

         zvolum   LIKE zedt16_100-zvolum, "##

         vrkme    LIKE zedt16_100-vrkme, "####

         znsamt   LIKE zedt16_100-znsamt, "####

         zslamt   LIKE zedt16_100-zslamt, "####

         zdcamt   LIKE zedt16_100-zdcamt, "####

         zdc_fg   LIKE zedt16_100-zdc_fg, "####

         zsale_fg LIKE zedt16_100-zsale_fg, "####

         zret_fg  LIKE zedt16_100-zret_fg, "####

         zjdate   LIKE zedt16_100-zjdate, "####

         zrdate   LIKE zedt16_100-zrdate, "####

       END OF gs_order.

DATA : gt_order LIKE TABLE OF gs_order.



DATA : BEGIN OF gs_deliver,

         zordno   LIKE zedt16_101-zordno, "####

         zidcode  LIKE zedt16_101-zidcode, "##ID

         zmatnr   LIKE zedt16_101-zmatnr, "####

         zmtart   LIKE zedt16_101-zmtart, "####

         zmatname LIKE zedt16_101-zmatname, "###

         zvolum   LIKE zedt16_101-zvolum, "##

         vrkme    LIKE zedt16_101-vrkme, "####

         zslamt   LIKE zedt16_101-zslamt, "####

         zdflag   LIKE zedt16_101-zdflag, "####

         zdgubun  LIKE zedt16_101-zdgubun, "####

         zddate   LIKE zedt16_101-zddate, "####

         zrdate   LIKE zedt16_101-zrdate, "####

         zflag    LIKE zedt16_101-zflag, "FLAG

       END OF gs_deliver.

DATA : gt_deliver LIKE TABLE OF gs_deliver.





DATA : BEGIN OF gs_write_order,

         zordno      LIKE zedt16_100-zordno, "#### 10

         zidcode     LIKE zedt16_100-zidcode, "##ID 10

         zmatnr      LIKE zedt16_100-zmatnr, "#### 10

         zmatname    LIKE zedt16_100-zmatname, "### 20

         zmtart_name TYPE c LENGTH 8, "#### 8

         zvolum      LIKE zedt16_100-zvolum, "## 3

         vrkme       LIKE zedt16_100-vrkme, "## 3

         znsamt      TYPE i, "#### 13

         zslamt      TYPE i, "#### 13

         zdcamt      TYPE i, "#### 13

         zsale_name  TYPE c LENGTH 4, " 4

         zjdate      TYPE c LENGTH 10, " 10

         zret_name   TYPE c LENGTH 10, " 10

         zrdate      TYPE c LENGTH 10, "#### 10

       END OF gs_write_order.

DATA : gt_write_order LIKE TABLE OF gs_write_order.





DATA : BEGIN OF gs_write_deliver,

         zordno       LIKE zedt16_101-zordno, "####

         zidcode      LIKE zedt16_101-zidcode, "##ID

         zmatnr       LIKE zedt16_101-zmatnr, "####

         zmatname     LIKE zedt16_101-zmatname, "###

         zmtart_name  TYPE c LENGTH 8, "####

         zvolum       LIKE zedt16_101-zvolum, "##

         vrkme        LIKE zedt16_101-vrkme, "##

         zslamt       TYPE i, "####

         zdflag_name  TYPE c LENGTH 8, "####

         zdgubun_name TYPE c LENGTH 6, "####

         zddate       TYPE c LENGTH 10, "####

         zrdate       TYPE c LENGTH 10, "####

         zflag        LIKE zedt16_101-zflag, "FLAG

       END OF gs_write_deliver.

DATA : gt_write_deliver LIKE TABLE OF gs_write_deliver.



" ## ## ### ## range table

RANGES : gr_zsale_fg FOR zedt16_100-zsale_fg.

RANGES : gr_zflag FOR zedt16_101-zflag.



CONSTANTS : c_mul_krw TYPE i VALUE '100'. " krw ###



DATA gv_char_date(10).



SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.

SELECT-OPTIONS : s_zordno FOR zedt16_100-zordno.

SELECT-OPTIONS : s_zid FOR zedt16_100-zidcode NO INTERVALS NO-EXTENSION.

SELECT-OPTIONS : s_zmatnr FOR zedt16_100-zmatnr.

SELECT-OPTIONS : s_zjdate FOR zedt16_100-zjdate MODIF ID m1.

SELECT-OPTIONS : s_zddate FOR zedt16_101-zddate MODIF ID m2.




*SELECT-OPTIONS : s_zjdate FOR gv_char_date MODIF ID m1.

*SELECT-OPTIONS : s_zddate FOR gv_char_date MODIF ID m2.




SELECTION-SCREEN END OF BLOCK b1.



SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME.

PARAMETERS : p_r1 RADIOBUTTON GROUP r1 DEFAULT 'X' USER-COMMAND uc1.

PARAMETERS : p_r2 RADIOBUTTON GROUP r1.

SELECTION-SCREEN END OF BLOCK b2.



SELECTION-SCREEN BEGIN OF BLOCK b3 WITH FRAME.

PARAMETERS : p_ch1 AS CHECKBOX DEFAULT 'X'.

SELECTION-SCREEN END OF BLOCK b3.



INITIALIZATION.

  PERFORM set_default_date.



AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    IF screen-group1 = 'M1'.

      IF p_r1 = 'X'.

        screen-active = '1'.

      ELSEIF p_r2 = 'X'.

        screen-active = '0'.

      ENDIF.

    ENDIF.



    IF screen-group1 = 'M2'.

      IF p_r1 = 'X'.

        screen-active = '0'.

      ELSEIF p_r2 = 'X'.

        screen-active = '1'.

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.



START-OF-SELECTION.

  PERFORM set_range_table.

  IF p_r1 = 'X'.

    PERFORM select_data_order.

    PERFORM modify_write_order_table.

  ELSEIF p_r2 = 'X'.

    PERFORM select_data_deliver.

    PERFORM modify_write_deliver_table.

  ENDIF.





  PERFORM write_table.




*  BREAK-POINT.






FORM set_default_date.



  DATA: lv_first_day TYPE d,

        lv_last_day  TYPE d,

        lv_next_mon  TYPE d.



  " #### # #




*  lv_first_day = sy-datum.




  lv_first_day = '20250901'.

  lv_first_day+6(2) = '01'.



  " #### # #

  lv_next_mon = lv_first_day.

  ADD 1 TO lv_next_mon+4(2).  " # +1

  IF lv_next_mon+4(2) > '12'.

    lv_next_mon+0(4) = lv_next_mon+0(4) + 1. " ## +1

    lv_next_mon+4(2) = '01'.

  ENDIF.



  " #### ### #

  lv_last_day = lv_next_mon - 1.





  s_zjdate-sign   = 'I'.

  s_zjdate-option = 'BT'.






*  WRITE lv_first_day  TO s_zjdate-low  USING EDIT MASK '____.__.__'.

*  WRITE lv_last_day  TO s_zjdate-high  USING EDIT MASK '____.__.__'.






  s_zjdate-low    = lv_first_day.

  s_zjdate-high   = lv_last_day.



  APPEND s_zjdate.





  s_zddate-sign   = 'I'.

  s_zddate-option = 'BT'.






*  WRITE lv_first_day  TO s_zddate-low  USING EDIT MASK '____.__.__'.

*  WRITE lv_last_day  TO s_zddate-high  USING EDIT MASK '____.__.__'.






  s_zddate-low    = lv_first_day.

  s_zddate-high   = lv_last_day.

  APPEND s_zddate.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SELECT_DATA_ORDER

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM select_data_order .

  SELECT * FROM zedt16_100

    INTO CORRESPONDING FIELDS OF TABLE gt_order

    WHERE zordno IN s_zordno

    AND zidcode IN s_zid

    AND zmatnr IN s_zmatnr

    AND zjdate IN s_zjdate

    AND zsale_fg IN gr_zsale_fg.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SELECT_DATA_DELIVER

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM select_data_deliver .

  SELECT * FROM zedt16_101

    INTO CORRESPONDING FIELDS OF TABLE gt_deliver

    WHERE zordno IN s_zordno

    AND zidcode IN s_zid

    AND zmatnr IN s_zmatnr

    AND zddate IN s_zddate

    AND zflag IN gr_zflag.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_RANGE_TABLE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM set_range_table .

  IF p_r1 = 'X'.

    gr_zsale_fg-sign = 'I'.

    gr_zsale_fg-option = 'BT'.



    IF p_ch1 = 'X'.

      gr_zsale_fg-low = '1'.

      gr_zsale_fg-high = '2'.

    ELSE.

      gr_zsale_fg-low = '1'.

      gr_zsale_fg-high = '1'.

    ENDIF.



    APPEND gr_zsale_fg.



  ELSEIF p_r2 = 'X'.

    gr_zflag-sign = 'I'.

    gr_zflag-option = 'EQ'.

    gr_zflag-low = ' '.

    APPEND gr_zflag.



    IF p_ch1 = 'X'.

      gr_zflag-low = 'X'.

      APPEND gr_zflag.

    ENDIF.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  WRITE_TABLE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*








FORM write_table .

  IF p_r1 = 'X'.



    IF p_ch1 = 'X'.



      WRITE :/ '------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'.

      WRITE :/ '|  ####  |     ID     |  ####  |        ###        | #### |## |## |  ####   |   ####  |  ####   | ## |  ####  |  ####  |  ####  | '.

      WRITE :/ '------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'.

    ELSE.

      WRITE :/ '----------------------------------------------------------------------------------------------------------------------------------------------------'.

      WRITE :/ '|  ####  |     ID     |  ####  |        ###        | #### |## |## |  ####   |   ####  |  ####   | ## |  ####  | '.

      WRITE :/ '----------------------------------------------------------------------------------------------------------------------------------------------------'.

    ENDIF.



    LOOP AT gt_write_order INTO gs_write_order.



      IF p_ch1 = 'X'.




*        WRITE :/ '###### - ####'.




        WRITE :/ '|', gs_write_order-zordno, '|', gs_write_order-zidcode, '|', gs_write_order-zmatnr, '|', gs_write_order-zmatname,

        '|', gs_write_order-zmtart_name, '|', gs_write_order-zvolum, '|', gs_write_order-vrkme,

        '|', gs_write_order-znsamt, '|', gs_write_order-zslamt, '|', gs_write_order-zdcamt,

        '|', gs_write_order-zsale_name, '|', gs_write_order-zjdate, '|', gs_write_order-zret_name,

        '|', gs_write_order-zrdate, '|' .

        WRITE :/ '------------------------------------------------------------------------------------------------------------------------------------------------------------------------------'.



      ELSE.




*        WRITE :/ '###### - #####'.




        WRITE :/ '|', gs_write_order-zordno, '|', gs_write_order-zidcode, '|', gs_write_order-zmatnr,'|', gs_write_order-zmatname,

        '|', gs_write_order-zmtart_name, '|', gs_write_order-zvolum, '|', gs_write_order-vrkme,

        '|', gs_write_order-znsamt, '|', gs_write_order-zslamt, '|', gs_write_order-zdcamt,

        '|', gs_write_order-zsale_name, '|', gs_write_order-zjdate, '|'.

        WRITE :/ '----------------------------------------------------------------------------------------------------------------------------------------------------'.



      ENDIF.

    ENDLOOP.



  ELSEIF p_r2 = 'X'.

    IF p_ch1 = 'X'.

      WRITE :/ '--------------------------------------------------------------------------------------------------------------------------------------------------'.

      WRITE :/ '|  ####  |     ID     |  ####  |        ###        | #### |## |## |  ####   | #### |  ##  |  ####  |  ####  |'.

      WRITE :/ '--------------------------------------------------------------------------------------------------------------------------------------------------'.

    ELSE.

      WRITE :/ '-------------------------------------------------------------------------------------------------------------------------------------'.

      WRITE :/ '|  ####  |     ID     |  ####  |        ###        | #### |## |## |  ####   | #### |  ##  |  ####  | '.

      WRITE :/ '-------------------------------------------------------------------------------------------------------------------------------------'.

    ENDIF.



    LOOP AT gt_write_deliver INTO gs_write_deliver.



      IF p_ch1 = 'X'.

        WRITE :/ '|', gs_write_deliver-zordno, '|', gs_write_deliver-zidcode, '|', gs_write_deliver-zmatnr, '|', gs_write_deliver-zmatname,

        '|', gs_write_deliver-zmtart_name, '|', gs_write_deliver-zvolum, '|', gs_write_deliver-vrkme,

       '|', gs_write_deliver-zslamt, '|', gs_write_deliver-zdflag_name, '|', gs_write_deliver-zdgubun_name, '|', gs_write_deliver-zddate,

        '|', gs_write_deliver-zrdate, '|' .

        WRITE :/ '--------------------------------------------------------------------------------------------------------------------------------------------------'.



      ELSE.



        WRITE :/ '|', gs_write_deliver-zordno, '|', gs_write_deliver-zidcode, '|', gs_write_deliver-zmatnr, '|', gs_write_deliver-zmatname,

      '|', gs_write_deliver-zmtart_name, '|', gs_write_deliver-zvolum, '|', gs_write_deliver-vrkme,

     '|', gs_write_deliver-zslamt, '|', gs_write_deliver-zdflag_name, '|', gs_write_deliver-zdgubun_name, '|', gs_write_deliver-zddate,

      '|'.



        WRITE :/ '-------------------------------------------------------------------------------------------------------------------------------------'.

      ENDIF.

    ENDLOOP.



  ENDIF.





ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  MODIFY_WRITE_TABLE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM modify_write_order_table .



  LOOP AT gt_order INTO gs_order.



    CLEAR gs_write_order.

    MOVE-CORRESPONDING gs_order TO gs_write_order.



    " ###### ## :

    " zmtart -> zmtart_name(####)

    " zsale_fg -> zsale_name(##),

    " zret_fg -> zret_name(####)

    " # x 100



    gs_write_order-znsamt = gs_order-znsamt * c_mul_krw.

    gs_write_order-zslamt = gs_order-zslamt * c_mul_krw.

    gs_write_order-zdcamt = gs_order-zdcamt * c_mul_krw.



    CASE gs_order-zmtart.

      WHEN '001'.

        gs_write_order-zmtart_name = '##'.

      WHEN '002'.

        gs_write_order-zmtart_name = '##'.

      WHEN '003'.

        gs_write_order-zmtart_name = '##'.

      WHEN '004'.

        gs_write_order-zmtart_name = '##'.

      WHEN '005'.

        gs_write_order-zmtart_name = '##'.

      WHEN '006'.

        gs_write_order-zmtart_name = '###'.

    ENDCASE.



    CASE gs_order-zsale_fg.

      WHEN '1'.

        gs_write_order-zsale_name = '##'.

      WHEN '2'.

        gs_write_order-zsale_name = '##'.

    ENDCASE.



    CASE gs_order-zret_fg.

      WHEN '1'.

        gs_write_order-zret_name = '####'.

      WHEN '2'.

        gs_write_order-zret_name = '####'.

      WHEN '3'.

        gs_write_order-zret_name = '####'.

    ENDCASE.



    IF gs_order-zrdate IS INITIAL.

      gs_write_order-zrdate = ''.

    ELSE.

      CONCATENATE gs_order-zrdate+0(4) '.' gs_order-zrdate+4(2) '.' gs_order-zrdate+6(2)

      INTO gs_write_order-zrdate.

    ENDIF.



    IF gs_order-zjdate IS INITIAL.

    ELSE.

      CONCATENATE gs_order-zjdate+0(4) '.' gs_order-zjdate+4(2) '.' gs_order-zjdate+6(2)

      INTO gs_write_order-zjdate.

    ENDIF.







    APPEND gs_write_order TO gt_write_order.

    CLEAR : gs_order.

  ENDLOOP.



ENDFORM.








*&---------------------------------------------------------------------*

*&      Form  MODIFY_WRITE_DELIVER_TABLE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM modify_write_deliver_table .

  LOOP AT gt_deliver INTO gs_deliver.



    CLEAR gs_write_deliver.

    MOVE-CORRESPONDING gs_deliver TO gs_write_deliver.



    " ###### ## :

    " zmtart -> zmtart_name(####)

    " zdflag -> zdflag_name(####),

    " zdgubun -> zdgubun_name(####)

    " # x 100



    gs_write_deliver-zslamt = gs_deliver-zslamt * c_mul_krw.





    CASE gs_deliver-zmtart.

      WHEN '001'.

        gs_write_deliver-zmtart_name = '##'.

      WHEN '002'.

        gs_write_deliver-zmtart_name = '##'.

      WHEN '003'.

        gs_write_deliver-zmtart_name = '##'.

      WHEN '004'.

        gs_write_deliver-zmtart_name = '##'.

      WHEN '005'.

        gs_write_deliver-zmtart_name = '##'.

      WHEN '006'.

        gs_write_deliver-zmtart_name = '###'.

    ENDCASE.



    CASE gs_deliver-zdflag.

      WHEN '1'.

        gs_write_deliver-zdflag_name = '####'.

      WHEN '2'.

        gs_write_deliver-zdflag_name = '###'.

      WHEN '3'.

        gs_write_deliver-zdflag_name = '####'.

    ENDCASE.



    CASE gs_deliver-zdgubun.

      WHEN '1'.

        gs_write_deliver-zdgubun_name = '###'.

      WHEN '2'.

        gs_write_deliver-zdgubun_name = '###'.

      WHEN '3'.

        gs_write_deliver-zdgubun_name = '###'.

      WHEN '4'.

        gs_write_deliver-zdgubun_name = '###'.

      WHEN '5'.

        gs_write_deliver-zdgubun_name = '###'.

      WHEN '6'.

        gs_write_deliver-zdgubun_name = '###'.

      WHEN '7'.

        gs_write_deliver-zdgubun_name = '###'.

    ENDCASE.



    IF gs_deliver-zrdate IS INITIAL.

      gs_write_deliver-zrdate = ''.

    ELSE.

      CONCATENATE gs_deliver-zrdate+0(4) '.' gs_deliver-zrdate+4(2) '.' gs_deliver-zrdate+6(2)

      INTO gs_write_deliver-zrdate.

    ENDIF.



    IF gs_deliver-zddate IS INITIAL.

    ELSE.

      CONCATENATE gs_deliver-zddate+0(4) '.' gs_deliver-zddate+4(2) '.' gs_deliver-zddate+6(2)

      INTO gs_write_deliver-zddate.

    ENDIF.



    APPEND gs_write_deliver TO gt_write_deliver.

    CLEAR : gs_deliver.

  ENDLOOP.

ENDFORM.