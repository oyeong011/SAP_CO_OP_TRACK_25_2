
*&---------------------------------------------------------------------*

*& Report ZEDR05_PRACTICE003_1

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR05_PRACTICE003_1 LINE-SIZE 200.




*&---------------------------------------------------------------------*

*& Report ZEDR05_PRACTICE003_IMPROVED

*&---------------------------------------------------------------------*

*& ##/## ## ## ####

*& - ####: ZEDT05_100

*& - ####: ZEDT05_101

*&---------------------------------------------------------------------*



*&---------------------------------------------------------------------*

*& ## ## (Constants)

*&---------------------------------------------------------------------*




CONSTANTS:

  gc_return_flag   TYPE c VALUE 'X',           " ## ###

  gc_currency      TYPE c LENGTH 3 VALUE 'KRW', " ####

  gc_type_order    TYPE c LENGTH 10 VALUE 'ORDER',    " ####

  gc_type_delivery TYPE c LENGTH 10 VALUE 'DELIVERY', " ####

  gc_sign_include  TYPE c VALUE 'I',           " SIGN: Include

  gc_option_between TYPE c LENGTH 2 VALUE 'BT'. " OPTION: Between






*&---------------------------------------------------------------------*

*& ### ##

*&---------------------------------------------------------------------*




TABLES: zedt05_100, zedt05_101.






*&---------------------------------------------------------------------*

*& ## ## (Types)

*&---------------------------------------------------------------------*




" #### ### ###

TYPES: BEGIN OF ty_order_output,

         zordno       TYPE zedt05_100-zordno,     " ####

         zidcode      TYPE zedt05_100-zidcode,    " ##ID

         zmatnr       TYPE zedt05_100-zmatnr,     " ####

         zmatname     TYPE zedt05_100-zmatname,   " ###

         zmtart       TYPE zedt05_100-zmtart,     " ######

         zmtart_txt   TYPE string,                " #####

         zvolum       TYPE zedt05_100-zvolum,     " ##

         vrkme        TYPE zedt05_100-vrkme,      " ##

         znsamt       TYPE zedt05_100-znsamt,     " ####

         zslamt       TYPE zedt05_100-zslamt,     " ####

         zdcamt       TYPE zedt05_100-zdcamt,     " ####

         zsale_fg     TYPE zedt05_100-zsale_fg,   " ######

         zsale_fg_txt TYPE string,                " #####

         zjdate       TYPE zedt05_100-zjdate,     " ####

         zret_fg      TYPE zedt05_100-zret_fg,    " ######

         zret_fg_txt  TYPE string,                " #####

         zrdate       TYPE zedt05_100-zrdate,     " ####

       END OF ty_order_output.



" #### ### ###

TYPES: BEGIN OF ty_delivery_output,

         zordno      TYPE zedt05_100-zordno,      " ####

         zidcode     TYPE zedt05_100-zidcode,     " ##ID

         zmatnr      TYPE zedt05_100-zmatnr,      " ####

         zmatname    TYPE zedt05_100-zmatname,    " ###

         zmtart      TYPE zedt05_100-zmtart,      " ######

         zmtart_txt  TYPE string,                 " #####

         zvolum      TYPE zedt05_100-zvolum,      " ##

         vrkme       TYPE zedt05_100-vrkme,       " ##

         zslamt      TYPE zedt05_100-zslamt,      " ####

         zdflag      TYPE zedt05_101-zdflag,      " ######

         zdflag_txt  TYPE string,                 " #####

         zdgubun     TYPE zedt05_101-zdgubun,     " ######

         zdgubun_txt TYPE string,                 " #####

         zddate      TYPE zedt05_101-zddate,      " ####

         zrdate      TYPE zedt05_101-zrdate,      " ####

         zflag       TYPE zedt05_101-zflag,       " ####

       END OF ty_delivery_output.






*&---------------------------------------------------------------------*

*& ## ## (Global Data)

*&---------------------------------------------------------------------*




DATA:

  " ## #### ### ###

  gt_order_data    TYPE TABLE OF zedt05_100,    " ## #####

  gt_delivery_data TYPE TABLE OF zedt05_101,    " ## #####

  gs_order_data    TYPE zedt05_100,             " ## ###

  gs_delivery_data TYPE zedt05_101,             " ## ###



  " ### ### ###

  gt_order_output    TYPE TABLE OF ty_order_output,    " ## #####

  gt_delivery_output TYPE TABLE OF ty_delivery_output, " ## #####

  gs_order_output    TYPE ty_order_output,             " ## ## ###

  gs_delivery_output TYPE ty_delivery_output.          " ## ## ###






*&---------------------------------------------------------------------*

*& #### (Selection Screen)

*&---------------------------------------------------------------------*




" Block 1: ## ##

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.

  SELECT-OPTIONS: s_zordno FOR zedt05_100-zordno.              " ####

  SELECT-OPTIONS: s_idcode FOR zedt05_100-zidcode              " ##ID

                  NO INTERVALS NO-EXTENSION.

  SELECT-OPTIONS: s_zmatnr FOR zedt05_100-zmatnr.              " ####

  SELECT-OPTIONS: s_zjdate FOR zedt05_100-zjdate MODIF ID g1.  " ####

  SELECT-OPTIONS: s_zddate FOR zedt05_101-zddate MODIF ID g2.  " ####

SELECTION-SCREEN END OF BLOCK b1.



" Block 2: ## ##

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.

  PARAMETERS: p_order RADIOBUTTON GROUP r1 DEFAULT 'X' USER-COMMAND cmd. " ####

  PARAMETERS: p_deliv RADIOBUTTON GROUP r1.                              " ####

SELECTION-SCREEN END OF BLOCK b2.



" Block 3: ##

SELECTION-SCREEN BEGIN OF BLOCK b3 WITH FRAME TITLE TEXT-003.

  PARAMETERS: p_return AS CHECKBOX DEFAULT 'X'.  " ######

SELECTION-SCREEN END OF BLOCK b3.






*&---------------------------------------------------------------------*

*& ### (Initialization)

*&---------------------------------------------------------------------*




INITIALIZATION.

  " ## ### ## (### ### 01.01 ~ ### ##)

  PERFORM set_default_dates.






*&---------------------------------------------------------------------*

*& #### ## ## (At Selection-Screen Output)

*&---------------------------------------------------------------------*




AT SELECTION-SCREEN OUTPUT.

  " ###### ## ## ## ### ##

  PERFORM control_screen_fields.






*&---------------------------------------------------------------------*

*& ## ## ## (Start-of-Selection)

*&---------------------------------------------------------------------*




START-OF-SELECTION.

  " ## # ## ## ##

  PERFORM main_process.






*&---------------------------------------------------------------------*

*& Form set_default_dates

*&---------------------------------------------------------------------*

*  ## ### ##

*  - ###: ### ### 01.01

*  - ###: #### ### #

*----------------------------------------------------------------------*




FORM set_default_dates.

  DATA: lv_year(4)  TYPE c,

        lv_first    TYPE sy-datum,

        lv_last     TYPE sy-datum.



  " ## ## ##

  lv_year = sy-datum(4).



  " ### ## (YYYY.MM.01)

  CONCATENATE lv_year sy-datum+4(2) '01' INTO lv_first.



  " ### ## ##

  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

    EXPORTING

      day_in            = sy-datum

    IMPORTING

      last_day_of_month = lv_last.



  " #### ### ##

  s_zjdate-sign   = gc_sign_include.

  s_zjdate-option = gc_option_between.

  s_zjdate-low    = lv_first.

  s_zjdate-high   = lv_last.

  APPEND s_zjdate.



  " #### ### ##

  s_zddate-sign   = gc_sign_include.

  s_zddate-option = gc_option_between.

  s_zddate-low    = lv_first.

  s_zddate-high   = lv_last.

  APPEND s_zddate.

ENDFORM.






*&---------------------------------------------------------------------*

*& Form control_screen_fields

*&---------------------------------------------------------------------*

*  ###### ## ## ## ### ##

*  - ####: #### ### ###

*  - ####: #### ### ###

*----------------------------------------------------------------------*




FORM control_screen_fields.



  LOOP AT SCREEN.

    " #### ## #

    IF p_order = 'X'.

      IF screen-group1 = 'G1'.

        screen-active = 1.  " #### ###

      ELSEIF screen-group1 = 'G2'.

        screen-active = 0.  " #### ####

      ENDIF.



    " #### ## #

    ELSEIF p_deliv = 'X'.

      IF screen-group1 = 'G1'.

        screen-active = 0.  " #### ####

      ELSEIF screen-group1 = 'G2'.

        screen-active = 1.  " #### ###

      ENDIF.

    ENDIF.



    MODIFY SCREEN.

  ENDLOOP.

ENDFORM.






*&---------------------------------------------------------------------*

*& Form main_process

*&---------------------------------------------------------------------*

*  ## ## ##

*  1. ### ##

*  2. ## ###

*  3. ### ### ##

*  4. ## ##

*----------------------------------------------------------------------*




FORM main_process.

  DATA: lv_process_type TYPE c LENGTH 10.



  " ## ## ##

  IF p_order = 'X'.

    lv_process_type = gc_type_order.

  ELSEIF p_deliv = 'X'.

    lv_process_type = gc_type_delivery.

  ENDIF.



  " 1. ### ##

  PERFORM select_data USING lv_process_type.



  " 2. ## ### (#### ## #)

  IF p_return IS INITIAL.

    PERFORM filter_return_data USING lv_process_type.

  ENDIF.



  " 3. ### ### ##

  PERFORM convert_to_output USING lv_process_type.



  " 4. ## ##

  PERFORM display_report USING lv_process_type.

ENDFORM.






*&---------------------------------------------------------------------*

*& Form select_data

*&---------------------------------------------------------------------*

*  ###### ##

*  ##: iv_type - #### (ORDER/DELIVERY)

*----------------------------------------------------------------------*




FORM select_data USING iv_type TYPE c.

  CASE iv_type.

    " #### ##

    WHEN gc_type_order.

      SELECT *

        FROM zedt05_100

        INTO TABLE gt_order_data

       WHERE zordno IN s_zordno

         AND zidcode IN s_idcode

         AND zmatnr IN s_zmatnr

         AND zjdate IN s_zjdate.



    " #### ##

    WHEN gc_type_delivery.

      SELECT *

        FROM zedt05_101

        INTO TABLE gt_delivery_data

       WHERE zordno IN s_zordno

         AND zidcode IN s_idcode

         AND zmatnr IN s_zmatnr

         AND zddate IN s_zddate.

  ENDCASE.

ENDFORM.






*&---------------------------------------------------------------------*

*& Form filter_return_data

*&---------------------------------------------------------------------*

*  ## ### ###

*  ###### ## ## # ### ##

*  ##: iv_type - ####

*----------------------------------------------------------------------*




FORM filter_return_data USING iv_type TYPE c.

  CASE iv_type.

    " ####: ZRET_FG = 'X'# ### ##

    WHEN gc_type_order.

      DELETE gt_order_data WHERE zret_fg = gc_return_flag.



    " ####: ZFLAG = 'X'# ### ##

    WHEN gc_type_delivery.

      DELETE gt_delivery_data WHERE zflag = gc_return_flag.

  ENDCASE.

ENDFORM.






*&---------------------------------------------------------------------*

*& Form convert_to_output

*&---------------------------------------------------------------------*

*  ### #### ##

*  ##: iv_type - ####

*----------------------------------------------------------------------*




FORM convert_to_output USING iv_type TYPE c.

  CASE iv_type.

    " #### ##

    WHEN gc_type_order.

      LOOP AT gt_order_data INTO gs_order_data.

        CLEAR gs_order_output.

        MOVE-CORRESPONDING gs_order_data TO gs_order_output.



        " #### ##### ##

        PERFORM convert_product_type USING gs_order_output-zmtart

                                  CHANGING gs_order_output-zmtart_txt.

        PERFORM convert_sale_type USING gs_order_output-zsale_fg

                               CHANGING gs_order_output-zsale_fg_txt.

        PERFORM convert_return_type USING gs_order_output-zret_fg

                                 CHANGING gs_order_output-zret_fg_txt.



        APPEND gs_order_output TO gt_order_output.

      ENDLOOP.



    " #### ##

    WHEN gc_type_delivery.

      LOOP AT gt_delivery_data INTO gs_delivery_data.

        CLEAR gs_delivery_output.

        MOVE-CORRESPONDING gs_delivery_data TO gs_delivery_output.



        " #### ##### ##

        PERFORM convert_product_type USING gs_delivery_output-zmtart

                                  CHANGING gs_delivery_output-zmtart_txt.

        PERFORM convert_delivery_status USING gs_delivery_output-zdflag

                                      CHANGING gs_delivery_output-zdflag_txt.

        PERFORM convert_region USING gs_delivery_output-zdgubun

                            CHANGING gs_delivery_output-zdgubun_txt.



        APPEND gs_delivery_output TO gt_delivery_output.

      ENDLOOP.

  ENDCASE.

ENDFORM.






*&---------------------------------------------------------------------*

*& Form convert_product_type

*&---------------------------------------------------------------------*

*  #### ## -> ### ##

*----------------------------------------------------------------------*




FORM convert_product_type USING iv_code TYPE c

                       CHANGING cv_text TYPE string.

  CASE iv_code.

    WHEN '001'. cv_text = '##'.

    WHEN '002'. cv_text = '##'.

    WHEN '003'. cv_text = '##'.

    WHEN '004'. cv_text = '##'.

    WHEN '005'. cv_text = '##'.

    WHEN '006'. cv_text = '###'.

    WHEN OTHERS. cv_text = ''.

  ENDCASE.

ENDFORM.






*&---------------------------------------------------------------------*

*& Form convert_sale_type

*&---------------------------------------------------------------------*

*  #### ## -> ### ##

*----------------------------------------------------------------------*




FORM convert_sale_type USING iv_code TYPE c

                    CHANGING cv_text TYPE string.

  CASE iv_code.

    WHEN '1'. cv_text = '##'.

    WHEN '2'. cv_text = '##'.

    WHEN OTHERS. cv_text = ''.

  ENDCASE.

ENDFORM.






*&---------------------------------------------------------------------*

*& Form convert_return_type

*&---------------------------------------------------------------------*

*  #### ## -> ### ##

*----------------------------------------------------------------------*




FORM convert_return_type USING iv_code TYPE c

                      CHANGING cv_text TYPE string.

  CASE iv_code.

    WHEN '1'. cv_text = '####'.

    WHEN '2'. cv_text = '####'.

    WHEN '3'. cv_text = '####'.

    WHEN OTHERS. cv_text = ''.

  ENDCASE.

ENDFORM.






*&---------------------------------------------------------------------*

*& Form convert_delivery_status

*&---------------------------------------------------------------------*

*  #### ## -> ### ##

*----------------------------------------------------------------------*




FORM convert_delivery_status USING iv_code TYPE c

                          CHANGING cv_text TYPE string.

  CASE iv_code.

    WHEN '1'. cv_text = '####'.

    WHEN '2'. cv_text = '###'.

    WHEN '3'. cv_text = '####'.

    WHEN OTHERS. cv_text = ''.

  ENDCASE.

ENDFORM.






*&---------------------------------------------------------------------*

*& Form convert_region

*&---------------------------------------------------------------------*

*  #### ## -> ### ##

*----------------------------------------------------------------------*




FORM convert_region USING iv_code TYPE c

                 CHANGING cv_text TYPE string.

  CASE iv_code.

    WHEN '1'. cv_text = '###'.

    WHEN '2'. cv_text = '###'.

    WHEN '3'. cv_text = '###'.

    WHEN '4'. cv_text = '###'.

    WHEN '5'. cv_text = '###'.

    WHEN '6'. cv_text = '###'.

    WHEN '7'. cv_text = '###'.

    WHEN OTHERS. cv_text = ''.

  ENDCASE.

ENDFORM.






*&---------------------------------------------------------------------*

*& Form display_report

*&---------------------------------------------------------------------*

*  ### ##

*  ##: iv_type - ####

*----------------------------------------------------------------------*




FORM display_report USING iv_type TYPE c.

  " ## ##

  PERFORM display_header USING iv_type.



  " ### ##

  CASE iv_type.

    WHEN gc_type_order.

      LOOP AT gt_order_output INTO gs_order_output.

        PERFORM display_order_line USING gs_order_output.

      ENDLOOP.



    WHEN gc_type_delivery.

      LOOP AT gt_delivery_output INTO gs_delivery_output.

        PERFORM display_delivery_line USING gs_delivery_output.

      ENDLOOP.

  ENDCASE.



  " ### ###

  PERFORM draw_separator_line USING iv_type.

ENDFORM.






*&---------------------------------------------------------------------*

*& Form display_header

*&---------------------------------------------------------------------*

*  ## ##

*----------------------------------------------------------------------*




FORM display_header USING iv_type TYPE c.

  " ###

  PERFORM draw_separator_line USING iv_type.



  " ## ##

  WRITE: / '|' NO-GAP,

           2  '####' NO-GAP,

           12 '|' NO-GAP,

           14 'ID' NO-GAP,

           24 '|' NO-GAP,

           26 '####' NO-GAP,

           36 '|' NO-GAP,

           38 '###' NO-GAP,

           48 '|' NO-GAP,

           50 '####' NO-GAP,

           60 '|' NO-GAP,

           62 '##' NO-GAP,

           68 '|' NO-GAP,

           70 '##' NO-GAP,

           76 '|' NO-GAP.



  " ### ##

  CASE iv_type.

    WHEN gc_type_order.

      PERFORM display_order_header.

    WHEN gc_type_delivery.

      PERFORM display_delivery_header.

  ENDCASE.



  " ###

  PERFORM draw_separator_line USING iv_type.

ENDFORM.






*&---------------------------------------------------------------------*

*& Form display_order_header

*&---------------------------------------------------------------------*

*  #### ## ##

*----------------------------------------------------------------------*




FORM display_order_header.

  WRITE: 78 '####' NO-GAP,

         93 '|' NO-GAP,

         95 '####' NO-GAP,

        110 '|' NO-GAP,

        112 '####' NO-GAP,

        127 '|' NO-GAP,

        129 '##' NO-GAP,

        137 '|' NO-GAP,

        139 '####' NO-GAP,

        150 '|' NO-GAP.



  " #### ## # ## ##

  IF p_return = 'X'.

    WRITE: 152 '####' NO-GAP,

           162 '|' NO-GAP,

           164 '####' NO-GAP,

           175 '|' NO-GAP.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*& Form display_delivery_header

*&---------------------------------------------------------------------*

*  #### ## ##

*----------------------------------------------------------------------*




FORM display_delivery_header.

  WRITE: 78 '####' NO-GAP,

         93 '|' NO-GAP,

         95 '####' NO-GAP,

        105 '|' NO-GAP,

        107 '##' NO-GAP,

        117 '|' NO-GAP,

        119 '####' NO-GAP,

        130 '|' NO-GAP.



  " #### ## # ## ##

  IF p_return = 'X'.

    WRITE: 132 '####' NO-GAP,

           142 '|' NO-GAP.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*& Form display_order_line

*&---------------------------------------------------------------------*

*  #### ### ## ##

*----------------------------------------------------------------------*




FORM display_order_line USING is_data TYPE ty_order_output.

  DATA: lv_znsamt_str(20) TYPE c,

        lv_zslamt_str(20) TYPE c,

        lv_zdcamt_str(20) TYPE c.



  " ## ###

  PERFORM format_amount USING is_data-znsamt CHANGING lv_znsamt_str.

  PERFORM format_amount USING is_data-zslamt CHANGING lv_zslamt_str.

  PERFORM format_amount USING is_data-zdcamt CHANGING lv_zdcamt_str.



  " ###

  PERFORM draw_separator_line USING gc_type_order.



  " ## ##

  WRITE: / '|' NO-GAP,

           2  is_data-zordno NO-GAP,

           12 '|' NO-GAP,

           14 is_data-zidcode NO-GAP,

           24 '|' NO-GAP,

           26 is_data-zmatnr NO-GAP,

           36 '|' NO-GAP,

           38 is_data-zmatname NO-GAP,

           48 '|' NO-GAP,

           50 is_data-zmtart_txt NO-GAP,

           60 '|' NO-GAP,

           62 is_data-zvolum NO-GAP,

           68 '|' NO-GAP,

           70 is_data-vrkme NO-GAP,

           76 '|' NO-GAP,

           78 lv_znsamt_str NO-GAP,

           93 '|' NO-GAP,

           95 lv_zslamt_str NO-GAP,

          110 '|' NO-GAP,

          112 lv_zdcamt_str NO-GAP,

          127 '|' NO-GAP,

          129 is_data-zsale_fg_txt NO-GAP,

          137 '|' NO-GAP,

          139 is_data-zjdate NO-GAP,

          150 '|' NO-GAP.



  " #### (###### ## ## ##)

  IF p_return = 'X'.

    IF is_data-zret_fg IS NOT INITIAL.

      WRITE: 152 is_data-zret_fg_txt NO-GAP,

             162 '|' NO-GAP,

             164 is_data-zrdate NO-GAP,

             175 '|' NO-GAP.

    ELSE.

      WRITE: 152 '' NO-GAP,

             162 '|' NO-GAP,

             164 '' NO-GAP,

             175 '|' NO-GAP.

    ENDIF.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*& Form display_delivery_line

*&---------------------------------------------------------------------*

*  #### ### ## ##

*----------------------------------------------------------------------*




FORM display_delivery_line USING is_data TYPE ty_delivery_output.

  DATA: lv_zslamt_str(20) TYPE c.



  " ## ###

  PERFORM format_amount USING is_data-zslamt CHANGING lv_zslamt_str.



  " ###

  PERFORM draw_separator_line USING gc_type_delivery.



  " ## ##

  WRITE: / '|' NO-GAP,

           2  is_data-zordno NO-GAP,

           12 '|' NO-GAP,

           14 is_data-zidcode NO-GAP,

           24 '|' NO-GAP,

           26 is_data-zmatnr NO-GAP,

           36 '|' NO-GAP,

           38 is_data-zmatname NO-GAP,

           48 '|' NO-GAP,

           50 is_data-zmtart_txt NO-GAP,

           60 '|' NO-GAP,

           62 is_data-zvolum NO-GAP,

           68 '|' NO-GAP,

           70 is_data-vrkme NO-GAP,

           76 '|' NO-GAP,

           78 lv_zslamt_str NO-GAP,

           93 '|' NO-GAP,

           95 is_data-zdflag_txt NO-GAP,

          105 '|' NO-GAP,

          107 is_data-zdgubun_txt NO-GAP,

          117 '|' NO-GAP,

          119 is_data-zddate NO-GAP,

          130 '|' NO-GAP.



  " #### (###### ## ## ##)

  IF p_return = 'X'.

    IF is_data-zflag IS NOT INITIAL.

      WRITE: 132 is_data-zrdate NO-GAP,

             142 '|' NO-GAP.

    ELSE.

      WRITE: 132 '' NO-GAP,

             142 '|' NO-GAP.

    ENDIF.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*& Form format_amount

*&---------------------------------------------------------------------*

*  ## ### (### ## + KRW)

*  ##: iv_amount - ##

*  ##: cv_formatted - #### ###

*----------------------------------------------------------------------*




FORM format_amount USING iv_amount TYPE p

                CHANGING cv_formatted TYPE c.

  " ### KRW ## #### ##

  WRITE iv_amount TO cv_formatted CURRENCY gc_currency NO-SIGN DECIMALS 0.

  " ## ##

  CONDENSE cv_formatted NO-GAPS.

ENDFORM.






*&---------------------------------------------------------------------*

*& Form draw_separator_line

*&---------------------------------------------------------------------*

*  ### ###

*  ##: iv_type - #### (## ## ##)

*----------------------------------------------------------------------*




FORM draw_separator_line USING iv_type TYPE c.

  DATA: lv_line   TYPE string,

        lv_dash   TYPE c VALUE '-',

        lv_length TYPE i.



  " ### ## ## ##

  PERFORM calculate_line_length USING iv_type

                             CHANGING lv_length.



  " ### ##

  DO lv_length TIMES.

    CONCATENATE lv_line lv_dash INTO lv_line.

  ENDDO.



  " ##

  WRITE: / lv_line.

ENDFORM.






*&---------------------------------------------------------------------*

*& Form calculate_line_length

*&---------------------------------------------------------------------*

*  ## ## ##

*  - #### ## ### ## #### ##

*----------------------------------------------------------------------*




FORM calculate_line_length USING iv_type TYPE c

                        CHANGING cv_length TYPE i.

  CASE iv_type.

    " ####

    WHEN gc_type_order.

      IF p_return = 'X'.

        cv_length = 175.  " ## ## ##

      ELSE.

        cv_length = 150.  " ## ## ##

      ENDIF.



    " ####

    WHEN gc_type_delivery.

      IF p_return = 'X'.

        cv_length = 142.  " ## ## ##

      ELSE.

        cv_length = 130.  " ## ## ##

      ENDIF.

  ENDCASE.

ENDFORM.