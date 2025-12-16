
*&---------------------------------------------------------------------*

*&  Include           ZEDR25_PRACTICE008_F01

*&---------------------------------------------------------------------*



*&---------------------------------------------------------------------*

*&      Form  SET_INIT

*&---------------------------------------------------------------------*




FORM set_init.

  gs_variant-report   = sy-repid.

  gs_variant-username = sy-uname.



  PERFORM set_default_dates.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SET_DATE

*&---------------------------------------------------------------------*




FORM set_default_dates.

  " ####

  IF s_zjdate[] IS INITIAL.

    s_zjdate-sign   = 'I'.

    s_zjdate-option = 'BT'.

    s_zjdate-low    = sy-datum(6) && '01'.

    s_zjdate-high   = sy-datum(6) && '01'.



    CALL FUNCTION 'LAST_DAY_OF_MONTHS'

      EXPORTING

        day_in            = s_zjdate-high

      IMPORTING

        last_day_of_month = s_zjdate-high.



    APPEND s_zjdate.

  ENDIF.



  " ####

  IF s_zddate[] IS INITIAL.

    s_zddate-sign   = 'I'.

    s_zddate-option = 'BT'.

    s_zddate-low    = sy-datum(6) && '01'.

    s_zddate-high   = sy-datum(6) && '01'.



    CALL FUNCTION 'LAST_DAY_OF_MONTHS'

      EXPORTING

        day_in            = s_zddate-high

      IMPORTING

        last_day_of_month = s_zddate-high.



    APPEND s_zddate.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SET_SCREEN

*&---------------------------------------------------------------------*




FORM set_screen.

  LOOP AT SCREEN.

    IF screen-group1 = 'M2'.

      IF p_r1 = c_x.

        screen-active = '0'.

      ELSEIF p_r2 = c_x.

        screen-active = '1'.

      ENDIF.

    ENDIF.



    IF screen-group1 = 'M1'.

      IF p_r1 = c_x.

        screen-active = '1'.

      ELSEIF p_r2 = c_x.

        screen-active = '0'.

      ENDIF.

    ENDIF.



    MODIFY SCREEN.

  ENDLOOP.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CHECK_DATA

*&---------------------------------------------------------------------*




FORM check_data.

  " ## ## ##

  IF p_r1 = c_x.

    IF s_zjdate[] IS INITIAL AND s_zordno[] IS INITIAL.

      MESSAGE i000 WITH '#### ## ##### #####.'.

      STOP.

    ENDIF.

  ELSEIF p_r2 = c_x.

    IF s_zddate[] IS INITIAL AND s_zordno[] IS INITIAL.

      MESSAGE i000 WITH '#### ## ##### #####.'.

      STOP.

    ENDIF.

  ENDIF.



  " RANGES ###

  REFRESH: r_fg, r_zg.



  " ##/## ##

  IF p_r1 = c_x.

    r_fg-sign   = 'I'.

    r_fg-option = 'EQ'.

    r_fg-low    = '1'.

    APPEND r_fg.



    IF p_ch1 = c_x.

      r_fg-low = '2'.

      APPEND r_fg.

    ENDIF.

  ENDIF.



  " ## ## ##

  IF p_r2 = c_x.

    r_zg-sign   = 'I'.

    r_zg-option = 'EQ'.

    r_zg-low    = space.

    APPEND r_zg.



    IF p_ch1 = c_x.

      r_zg-low = c_x.

      APPEND r_zg.

    ENDIF.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  PROGRESS_DISPLAY

*&---------------------------------------------------------------------*




FORM progress_display USING p_text TYPE string.

  CHECK p_text IS NOT INITIAL.

  CALL FUNCTION 'SAPGUI_PROGRESS_INDICATOR'

    EXPORTING

      text = p_text.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SELECT_DATA_R1

*&---------------------------------------------------------------------*




FORM select_data_r1.




*  SELECT *

*    FROM zedt25_100

*    INTO CORRESPONDING FIELDS OF TABLE gt_order

*    WHERE zordno  IN s_zordno

*      AND zidcode = s_zcode

*      AND zmatnr  IN s_zmatnr

*      AND zjdate  IN s_zjdate

*      AND zsale_fg IN r_fg.




  REFRESH gt_order.

 IF s_zordno[] IS INITIAL.   "#### ## # ## ## ##

    IF s_zcode IS INITIAL.

      IF s_zmatnr[] IS INITIAL.

        SELECT *

          FROM zedt25_100

          INTO CORRESPONDING FIELDS OF TABLE gt_order

         WHERE zjdate   IN s_zjdate

           AND zsale_fg IN r_fg.

      ELSE.

        SELECT *

          FROM zedt25_100

          INTO CORRESPONDING FIELDS OF TABLE gt_order

         WHERE zjdate   IN s_zjdate

           AND zmatnr   IN s_zmatnr

           AND zsale_fg IN r_fg.

      ENDIF.

    ELSE.

      IF s_zmatnr[] IS INITIAL.

        SELECT *

          FROM zedt25_100

          INTO CORRESPONDING FIELDS OF TABLE gt_order

         WHERE zjdate   IN s_zjdate

           AND zidcode  =  s_zcode

           AND zsale_fg IN r_fg.

      ELSE.

        SELECT *

          FROM zedt25_100

          INTO CORRESPONDING FIELDS OF TABLE gt_order

         WHERE zjdate   IN s_zjdate

           AND zidcode  =  s_zcode

           AND zmatnr   IN s_zmatnr

           AND zsale_fg IN r_fg.

      ENDIF.

    ENDIF.



  ELSE.                        "#### ## # ## ## ##!

    IF s_zcode IS INITIAL.

      IF s_zmatnr[] IS INITIAL.

        SELECT *

          FROM zedt25_100

          INTO CORRESPONDING FIELDS OF TABLE gt_order

         WHERE zordno   IN s_zordno

           AND zsale_fg IN r_fg.

      ELSE.

        SELECT *

          FROM zedt25_100

          INTO CORRESPONDING FIELDS OF TABLE gt_order

         WHERE zordno   IN s_zordno

           AND zmatnr   IN s_zmatnr

           AND zsale_fg IN r_fg.

      ENDIF.

    ELSE.

      IF s_zmatnr[] IS INITIAL.

        SELECT *

          FROM zedt25_100

          INTO CORRESPONDING FIELDS OF TABLE gt_order

         WHERE zordno   IN s_zordno

           AND zidcode  =  s_zcode

           AND zsale_fg IN r_fg.

      ELSE.

        SELECT *

          FROM zedt25_100

          INTO CORRESPONDING FIELDS OF TABLE gt_order

         WHERE zordno   IN s_zordno

           AND zidcode  =  s_zcode

           AND zmatnr   IN s_zmatnr

           AND zsale_fg IN r_fg.

      ENDIF.

    ENDIF.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA_R1

*&---------------------------------------------------------------------*




FORM modify_data_r1.

  DATA: ls_order LIKE gs_order,

        ls_out   LIKE gs_0100.



  REFRESH gt_0100.



  LOOP AT gt_order INTO ls_order.

    CLEAR ls_out.

    MOVE-CORRESPONDING ls_order TO ls_out.



    " ## ###

    PERFORM zmtart_name USING ls_order-zmtart CHANGING ls_out-zmat_name.



    " ##/##

    IF ls_order-zsale_fg = '1'.

      ls_out-zsale_name = '##'.

      ls_out-icon       = '@08@'.

    ELSEIF ls_order-zsale_fg = '2'.

      ls_out-zsale_name = '##'.

      ls_out-icon       = '@0A@'.

    ENDIF.



    " ## ##

    IF p_ch1 = c_x.

      PERFORM zret_name USING ls_order-zret_fg CHANGING ls_out-zret_name.

    ENDIF.



    APPEND ls_out TO gt_0100.

  ENDLOOP.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  SELECT_DATA_R2

*&---------------------------------------------------------------------*




FORM select_data_r2.




* SELECT *

*    FROM zedt25_101

*    INTO CORRESPONDING FIELDS OF TABLE gt_delivery

*    WHERE zordno  IN s_zordno

*      AND zidcode = s_zcode

*      AND zmatnr  IN s_zmatnr

*      AND zddate  IN s_zddate

*      AND zflag   IN r_zg.






   REFRESH gt_delivery.



  IF s_zordno[] IS INITIAL.   "#### ## # #### ## ##

    IF s_zcode IS INITIAL.

      IF s_zmatnr[] IS INITIAL.

        SELECT *

          FROM zedt25_101

          INTO CORRESPONDING FIELDS OF TABLE gt_delivery

         WHERE zddate IN s_zddate

           AND zflag  IN r_zg.

      ELSE.

        SELECT *

          FROM zedt25_101

          INTO CORRESPONDING FIELDS OF TABLE gt_delivery

         WHERE zddate IN s_zddate

           AND zmatnr IN s_zmatnr

           AND zflag  IN r_zg.

      ENDIF.

    ELSE.

      IF s_zmatnr[] IS INITIAL.

        SELECT *

          FROM zedt25_101

          INTO CORRESPONDING FIELDS OF TABLE gt_delivery

         WHERE zddate IN s_zddate

           AND zidcode = s_zcode

           AND zflag   IN r_zg.

      ELSE.

        SELECT *

          FROM zedt25_101

          INTO CORRESPONDING FIELDS OF TABLE gt_delivery

         WHERE zddate IN s_zddate

           AND zidcode = s_zcode

           AND zmatnr  IN s_zmatnr

           AND zflag   IN r_zg.

      ENDIF.

    ENDIF.



  ELSE.                        "#### ## # ## ## ##!

    IF s_zcode IS INITIAL.

      IF s_zmatnr[] IS INITIAL.

        SELECT *

          FROM zedt25_101

          INTO CORRESPONDING FIELDS OF TABLE gt_delivery

         WHERE zordno IN s_zordno

           AND zflag  IN r_zg.

      ELSE.

        SELECT *

          FROM zedt25_101

          INTO CORRESPONDING FIELDS OF TABLE gt_delivery

         WHERE zordno IN s_zordno

           AND zmatnr IN s_zmatnr

           AND zflag  IN r_zg.

      ENDIF.

    ELSE.

      IF s_zmatnr[] IS INITIAL.

        SELECT *

          FROM zedt25_101

          INTO CORRESPONDING FIELDS OF TABLE gt_delivery

         WHERE zordno IN s_zordno

           AND zidcode = s_zcode

           AND zflag   IN r_zg.

      ELSE.

        SELECT *

          FROM zedt25_101

          INTO CORRESPONDING FIELDS OF TABLE gt_delivery

         WHERE zordno IN s_zordno

           AND zidcode = s_zcode

           AND zmatnr  IN s_zmatnr

           AND zflag   IN r_zg.

      ENDIF.

    ENDIF.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA_R2

*&---------------------------------------------------------------------*




FORM modify_data_r2.

  DATA: ls_delv LIKE gs_delivery,

        ls_out  LIKE gs_0200.



  REFRESH gt_0200.



  LOOP AT gt_delivery INTO ls_delv.

    CLEAR ls_out.

    MOVE-CORRESPONDING ls_delv TO ls_out.



    " ## ###

    PERFORM zmtart_name USING ls_delv-zmtart CHANGING ls_out-zmat_name.



    " ## ##

    IF ls_delv-zdflag = '1'.

      ls_out-zdflag_name = '####'.

    ELSEIF ls_delv-zdflag = '2'.

      ls_out-zdflag_name = '####'.

    ELSE.

      ls_out-zdflag_name = '###'.

    ENDIF.



    " ## ###

    PERFORM zdgubun_name USING ls_delv-zdgubun CHANGING ls_out-zdgubun_name.



    " ###

    IF ls_delv-zflag = c_x.

      ls_out-icon = '@0A@'.

    ELSE.

      ls_out-icon = '@08@'.

    ENDIF.



    APPEND ls_out TO gt_0200.

  ENDLOOP.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*




FORM create_object USING p_dock TYPE REF TO cl_gui_docking_container

                         p_grid TYPE REF TO cl_gui_alv_grid.



  " ## #### ##

  CREATE OBJECT p_dock

    EXPORTING

      repid     = sy-repid

      dynnr     = sy-dynnr

      side      = cl_gui_docking_container=>dock_at_left

      extension = 2000.



  " ALV ### ##

  CREATE OBJECT p_grid

    EXPORTING

      i_parent = p_dock.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG_0100

*&---------------------------------------------------------------------*




FORM FIELD_CATALOG_0100 .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ICON'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-ICON = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZORDNO'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZIDCODE'.

  GS_FIELDCAT-SCRTEXT_M = '##ID'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZMATNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZMATNAME'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZMAT_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZVOLUM'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-QFIELDNAME = 'VRKME'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'VRKME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'ZNSAMT'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-DO_SUM = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'ZSLAMT'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-DO_SUM = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'ZDCAMT'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-DO_SUM = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 12.

  GS_FIELDCAT-FIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-EMPHASIZE = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 13.

  GS_FIELDCAT-FIELDNAME = 'ZSALE_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 14.

  GS_FIELDCAT-FIELDNAME = 'ZJDATE'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  IF P_CH1 = C_X.

    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 15.

    GS_FIELDCAT-FIELDNAME = 'ZRET_NAME'.

    GS_FIELDCAT-SCRTEXT_M = '####'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.



    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 16.

    GS_FIELDCAT-FIELDNAME = 'ZRDATE'.

    GS_FIELDCAT-SCRTEXT_M = '####'.

    GS_FIELDCAT-OUTPUTLEN = '10'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG_0200

*&---------------------------------------------------------------------*




FORM FIELD_CATALOG_0200 .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ICON'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-ICON = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZORDNO'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZIDCODE'.

  GS_FIELDCAT-SCRTEXT_M = '##ID'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZMATNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZMATNAME'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZMAT_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZVOLUM'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-QFIELDNAME = 'VRKME'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'VRKME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'ZSLAMT'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-DO_SUM = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-EMPHASIZE = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 12.

  GS_FIELDCAT-FIELDNAME = 'ZDFLAG_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-CURRENCY = 'KRW'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 13.

  GS_FIELDCAT-FIELDNAME = 'ZDGUBUN_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-EMPHASIZE = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 14.

  GS_FIELDCAT-FIELDNAME = 'ZDDATE'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  IF P_CH1 = C_X.

    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 15.

    GS_FIELDCAT-FIELDNAME = 'ZRDATE'.

    GS_FIELDCAT-SCRTEXT_M = '####'.

    GS_FIELDCAT-OUTPUTLEN = '10'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.



    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 16.

    GS_FIELDCAT-FIELDNAME = 'ZFLAG'.

    GS_FIELDCAT-SCRTEXT_M = '####'.

    GS_FIELDCAT-OUTPUTLEN = '8'.

    GS_FIELDCAT-JUST = 'C'.

    GS_FIELDCAT-EMPHASIZE = 'X'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

  ENDIF.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ALV_SORT

*&---------------------------------------------------------------------*




FORM ALV_SORT .

  CLEAR : GS_SORT, GT_SORT.

  GS_SORT-SPOS = 1.

  GS_SORT-FIELDNAME = 'ZIDCODE'.

  GS_SORT-UP = 'X'.

  GS_SORT-SUBTOT = 'X'.

  APPEND GS_SORT TO GT_SORT.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  LAYOUT_SET

*&---------------------------------------------------------------------*




FORM LAYOUT_SET .

  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.



  CLEAR GS_VARIANT.

  GS_VARIANT-REPORT = SY-REPID.

  GS_VARIANT-USERNAME = SY-UNAME.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CALL_ALV

*&---------------------------------------------------------------------*




FORM CALL_ALV  USING PT_ITAB TYPE STANDARD TABLE

                     P_GRID  TYPE REF TO CL_GUI_ALV_GRID

                     PS_LAYOUT TYPE LVC_S_LAYO

                     PS_VARIANT LIKE DISVARIANT.



  CALL METHOD P_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_VARIANT                    = PS_VARIANT

      I_SAVE                        = C_A

      IS_LAYOUT                     = PS_LAYOUT

    CHANGING

      IT_OUTTAB                     = PT_ITAB

      IT_FIELDCATALOG               = GT_FIELDCAT

      IT_SORT                       = GT_SORT

        .



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ZMTART_NAME

*&---------------------------------------------------------------------*




FORM ZMTART_NAME  USING P_ZMTART

                  CHANGING P_NAME.

  CASE P_ZMTART.

    WHEN '001'.

      P_NAME = '##'.

    WHEN '002'.

      P_NAME = '##'.

    WHEN '003'.

      P_NAME = '##'.

    WHEN '004'.

      P_NAME = '##'.

    WHEN '005'.

      P_NAME = '##'.

    WHEN '006'.

      P_NAME = '###'.

  ENDCASE.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ZRET_NAME

*&---------------------------------------------------------------------*




FORM ZRET_NAME  USING P_FG

                CHANGING P_NAME.

  CASE P_FG.

    WHEN '1'.

      P_NAME = '####'.

    WHEN '2'.

      P_NAME = '####'.

    WHEN '3'.

      P_NAME = '####'.

  ENDCASE.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  ZDGUBUN_NAME

*&---------------------------------------------------------------------*




FORM ZDGUBUN_NAME  USING P_ZDGUBUN

                   CHANGING P_NAME.

  CASE P_ZDGUBUN.

    WHEN '1'.

      P_NAME = '##'.

    WHEN '2'.

      P_NAME = '###'.

    WHEN '3'.

      P_NAME = '###'.

    WHEN '4'.

      P_NAME = '###'.

    WHEN '5'.

      P_NAME = '###'.

    WHEN '6'.

      P_NAME = '###'.

    WHEN '7'.

      P_NAME = '###'.

  ENDCASE.

ENDFORM.