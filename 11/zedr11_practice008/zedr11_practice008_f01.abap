
*&---------------------------------------------------------------------*

*&  Include           ZEDR11_PRACTICE008_F01

*&---------------------------------------------------------------------*




FORM set_date.

  " [##] ## ## ## (## 1# ~ ##)

  IF s_zjdate[] IS INITIAL.

    s_zjdate-low    = sy-datum(6) && '01'.

    s_zjdate-high   = sy-datum(6) && '01'.

    s_zjdate-sign   = 'I'.

    s_zjdate-option = 'BT'.

    CALL FUNCTION 'LAST_DAY_OF_MONTHS'

      EXPORTING day_in = s_zjdate-high

      IMPORTING last_day_of_month = s_zjdate-high.

    APPEND s_zjdate.

  ENDIF.



  IF s_zddate[] IS INITIAL.

    s_zddate-low    = sy-datum(6) && '01'.

    s_zddate-high   = sy-datum(6) && '01'.

    s_zddate-sign   = 'I'.

    s_zddate-option = 'BT'.

    CALL FUNCTION 'LAST_DAY_OF_MONTHS'

      EXPORTING day_in = s_zddate-high

      IMPORTING last_day_of_month = s_zddate-high.

    APPEND s_zddate.

  ENDIF.

ENDFORM.



FORM set_screen.

  LOOP AT screen.

    IF screen-group1 = 'M2'.

      screen-active = COND #( WHEN p_r1 = 'X' THEN '0' ELSE '1' ).

    ELSEIF screen-group1 = 'M1'.

      screen-active = COND #( WHEN p_r1 = 'X' THEN '1' ELSE '0' ).

    ENDIF.

    MODIFY screen.

  ENDLOOP.

ENDFORM.



FORM check_data.

  " [##] #### ###(1)# DB##(0000000001)# ## ## (##)

  IF s_zordno[] IS NOT INITIAL.

    LOOP AT s_zordno.

      CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'

        EXPORTING input  = s_zordno-low

        IMPORTING output = s_zordno-low.



      IF s_zordno-high IS NOT INITIAL.

        CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'

          EXPORTING input  = s_zordno-high

          IMPORTING output = s_zordno-high.

      ENDIF.

      MODIFY s_zordno.

    ENDLOOP.

  ENDIF.



  " [##] ## ## ##

  IF p_r1 = c_x.

    IF s_zjdate IS INITIAL AND s_zordno IS INITIAL.

      MESSAGE i000 WITH '## ### #####'. STOP.

    ENDIF.

  ELSEIF p_r2 = c_x.

    IF s_zddate IS INITIAL AND s_zordno IS INITIAL.

      MESSAGE i000 WITH '## ### #####'. STOP.

    ENDIF.

  ENDIF.



  " [##] ### ### ## ## (##/## #)

  CLEAR: r_fg[], r_zg[].

  IF p_r1 = c_x.

    r_fg-sign = 'I'. r_fg-option = 'EQ'.

    r_fg-low  = '1'. APPEND r_fg.

    IF p_ch1 = c_x.

      r_fg-low = '2'. APPEND r_fg.

    ENDIF.

  ELSE.

    r_zg-sign = 'I'. r_zg-option = 'EQ'.

    r_zg-low  = ' '. APPEND r_zg.

    IF p_ch1 = c_x.

      r_zg-low = c_x. APPEND r_zg.

    ENDIF.

  ENDIF.

ENDFORM.



FORM progress_display USING p_text.

  CHECK p_text IS NOT INITIAL.

  CALL FUNCTION 'SAPGUI_PROGRESS_INDICATOR'

    EXPORTING text = p_text.

ENDFORM.



FORM select_r1.

  " [##] ##(ZJDATE) # ##(ZSALE_FG) ## ###

  SELECT * FROM zedt11_100

    INTO CORRESPONDING FIELDS OF TABLE gt_order

    WHERE zordno   IN s_zordno

      AND zidcode  IN s_zid

      AND zmatnr   IN s_zmatnr

      AND zjdate   IN s_zjdate

      AND zsale_fg IN r_fg.

ENDFORM.



FORM modify_r1.

  CLEAR: gs_order, gs_order_print.

  LOOP AT gt_order INTO gs_order.

    MOVE-CORRESPONDING gs_order TO gs_order_print.



    PERFORM zmtart_name USING gs_order-zmtart

                        CHANGING gs_order_print-zmat_name.



    IF gs_order-zsale_fg = '1'.

      gs_order_print-zsale_name = '##'.

      gs_order_print-icon       = '@08@'. "Green

    ELSEIF gs_order-zsale_fg = '2'.

      gs_order_print-zsale_name = '##'.

      gs_order_print-icon       = '@0A@'. "Red

    ENDIF.



    IF p_ch1 = c_x.

      PERFORM zret_name USING gs_order-zret_fg

                        CHANGING gs_order_print-zret_name.

    ENDIF.



    APPEND gs_order_print TO gt_order_print.

    CLEAR: gs_order, gs_order_print.

  ENDLOOP.

ENDFORM.



FORM select_r2.

  " [##] ##(ZDDATE) # ##(ZFLAG) ## ###

  SELECT * FROM zedt11_101

    INTO CORRESPONDING FIELDS OF TABLE gt_deli

    WHERE zordno IN s_zordno

      AND zidcode IN s_zid

      AND zmatnr  IN s_zmatnr

      AND zddate  IN s_zddate

      AND zflag   IN r_zg.

ENDFORM.



FORM modify_r2.

  CLEAR: gs_deli, gs_deli_print.

  LOOP AT gt_deli INTO gs_deli.

    MOVE-CORRESPONDING gs_deli TO gs_deli_print.



    PERFORM zmtart_name USING gs_deli-zmtart

                        CHANGING gs_deli_print-zmat_name.



    IF gs_deli-zdflag = '1'.

      gs_deli_print-zdflag_name = '####'.

    ELSEIF gs_deli-zdflag = '2'.

      gs_deli_print-zdflag_name = '####'.

    ENDIF.



    IF gs_deli-zflag = 'X'.

      gs_deli_print-icon = '@0A@'. "Red

    ELSE.

      gs_deli_print-icon = '@08@'. "Green

    ENDIF.



    PERFORM zdgubun_name USING gs_deli-zdgubun

                         CHANGING gs_deli_print-zdgubun_name.



    APPEND gs_deli_print TO gt_deli_print.

    CLEAR: gs_deli, gs_deli_print.

  ENDLOOP.

ENDFORM.



FORM create_object USING p_docking TYPE REF TO cl_gui_docking_container

                         p_grid    TYPE REF TO cl_gui_alv_grid.

  IF p_docking IS NOT INITIAL.

    EXIT.

  ENDIF.



  CREATE OBJECT p_docking

    EXPORTING repid     = sy-repid

              dynnr     = sy-dynnr

              extension = 2000.

  CREATE OBJECT p_grid

    EXPORTING i_parent = p_docking.

ENDFORM.



FORM field_catalog_0100.

  CLEAR: gs_fieldcat, gt_fieldcat.



  gs_fieldcat-col_pos = 1.  gs_fieldcat-fieldname = 'ICON'. gs_fieldcat-coltext = '##'. gs_fieldcat-icon = 'X'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR gs_fieldcat. gs_fieldcat-col_pos = 2.  gs_fieldcat-fieldname = 'ZORDNO'.    gs_fieldcat-scrtext_m = '####'.   APPEND gs_fieldcat TO gt_fieldcat.

  CLEAR gs_fieldcat. gs_fieldcat-col_pos = 3.  gs_fieldcat-fieldname = 'ZIDCODE'.   gs_fieldcat-scrtext_m = '##ID'.     APPEND gs_fieldcat TO gt_fieldcat.

  CLEAR gs_fieldcat. gs_fieldcat-col_pos = 4.  gs_fieldcat-fieldname = 'ZMATNR'.    gs_fieldcat-scrtext_m = '####'.   APPEND gs_fieldcat TO gt_fieldcat.

  CLEAR gs_fieldcat. gs_fieldcat-col_pos = 5.  gs_fieldcat-fieldname = 'ZMATNAME'.  gs_fieldcat-scrtext_m = '###'.     APPEND gs_fieldcat TO gt_fieldcat.

  CLEAR gs_fieldcat. gs_fieldcat-col_pos = 6.  gs_fieldcat-fieldname = 'ZMAT_NAME'. gs_fieldcat-scrtext_m = '####'.   APPEND gs_fieldcat TO gt_fieldcat.

  CLEAR gs_fieldcat. gs_fieldcat-col_pos = 7.  gs_fieldcat-fieldname = 'ZVOLUM'.    gs_fieldcat-scrtext_m = '##'. gs_fieldcat-qfieldname = 'VRKME'. APPEND gs_fieldcat TO gt_fieldcat.

  CLEAR gs_fieldcat. gs_fieldcat-col_pos = 8.  gs_fieldcat-fieldname = 'VRKME'.     gs_fieldcat-scrtext_m = '##'.       APPEND gs_fieldcat TO gt_fieldcat.

  CLEAR gs_fieldcat. gs_fieldcat-col_pos = 9.  gs_fieldcat-fieldname = 'ZNSAMT'.    gs_fieldcat-scrtext_m = '####'. gs_fieldcat-cfieldname = 'ZWAERS'. gs_fieldcat-do_sum = 'X'. APPEND gs_fieldcat TO gt_fieldcat.

  CLEAR gs_fieldcat. gs_fieldcat-col_pos = 10. gs_fieldcat-fieldname = 'ZSLAMT'.    gs_fieldcat-scrtext_m = '####'. gs_fieldcat-cfieldname = 'ZWAERS'. gs_fieldcat-do_sum = 'X'. APPEND gs_fieldcat TO gt_fieldcat.

  CLEAR gs_fieldcat. gs_fieldcat-col_pos = 11. gs_fieldcat-fieldname = 'ZDCAMT'.    gs_fieldcat-scrtext_m = '####'. gs_fieldcat-cfieldname = 'ZWAERS'. gs_fieldcat-do_sum = 'X'. APPEND gs_fieldcat TO gt_fieldcat.

  CLEAR gs_fieldcat. gs_fieldcat-col_pos = 12. gs_fieldcat-fieldname = 'ZWAERS'.    gs_fieldcat-scrtext_m = '##'. gs_fieldcat-emphasize = 'X'. APPEND gs_fieldcat TO gt_fieldcat.

  CLEAR gs_fieldcat. gs_fieldcat-col_pos = 13. gs_fieldcat-fieldname = 'ZSALE_NAME'.gs_fieldcat-scrtext_m = '####'. APPEND gs_fieldcat TO gt_fieldcat.

  CLEAR gs_fieldcat. gs_fieldcat-col_pos = 14. gs_fieldcat-fieldname = 'ZJDATE'.    gs_fieldcat-scrtext_m = '####'. gs_fieldcat-outputlen = 10. APPEND gs_fieldcat TO gt_fieldcat.



  IF p_ch1 = c_x.

    CLEAR gs_fieldcat. gs_fieldcat-col_pos = 15. gs_fieldcat-fieldname = 'ZRET_NAME'. gs_fieldcat-scrtext_m = '####'. APPEND gs_fieldcat TO gt_fieldcat.

    CLEAR gs_fieldcat. gs_fieldcat-col_pos = 16. gs_fieldcat-fieldname = 'ZRDATE'.    gs_fieldcat-scrtext_m = '####'. gs_fieldcat-outputlen = 10. APPEND gs_fieldcat TO gt_fieldcat.

  ENDIF.

ENDFORM.



FORM field_catalog_0200.

  CLEAR: gs_fieldcat, gt_fieldcat.



  gs_fieldcat-col_pos = 1.  gs_fieldcat-fieldname = 'ICON'. gs_fieldcat-coltext = '##'. gs_fieldcat-icon = 'X'. APPEND gs_fieldcat TO gt_fieldcat.

  CLEAR gs_fieldcat. gs_fieldcat-col_pos = 2.  gs_fieldcat-fieldname = 'ZORDNO'.       gs_fieldcat-scrtext_m = '####'. APPEND gs_fieldcat TO gt_fieldcat.

  CLEAR gs_fieldcat. gs_fieldcat-col_pos = 3.  gs_fieldcat-fieldname = 'ZIDCODE'.      gs_fieldcat-scrtext_m = '##ID'.   APPEND gs_fieldcat TO gt_fieldcat.

  CLEAR gs_fieldcat. gs_fieldcat-col_pos = 4.  gs_fieldcat-fieldname = 'ZMATNR'.       gs_fieldcat-scrtext_m = '####'. APPEND gs_fieldcat TO gt_fieldcat.

  CLEAR gs_fieldcat. gs_fieldcat-col_pos = 5.  gs_fieldcat-fieldname = 'ZMATNAME'.     gs_fieldcat-scrtext_m = '###'.   APPEND gs_fieldcat TO gt_fieldcat.

  CLEAR gs_fieldcat. gs_fieldcat-col_pos = 6.  gs_fieldcat-fieldname = 'ZMAT_NAME'.    gs_fieldcat-scrtext_m = '####'. APPEND gs_fieldcat TO gt_fieldcat.

  CLEAR gs_fieldcat. gs_fieldcat-col_pos = 7.  gs_fieldcat-fieldname = 'ZVOLUM'.       gs_fieldcat-scrtext_m = '##'. gs_fieldcat-qfieldname = 'VRKME'. APPEND gs_fieldcat TO gt_fieldcat.

  CLEAR gs_fieldcat. gs_fieldcat-col_pos = 8.  gs_fieldcat-fieldname = 'VRKME'.        gs_fieldcat-scrtext_m = '##'.   APPEND gs_fieldcat TO gt_fieldcat.

  CLEAR gs_fieldcat. gs_fieldcat-col_pos = 10. gs_fieldcat-fieldname = 'ZSLAMT'.       gs_fieldcat-scrtext_m = '####'. gs_fieldcat-cfieldname = 'ZWAERS'. gs_fieldcat-do_sum = 'X'. APPEND gs_fieldcat TO gt_fieldcat.

  CLEAR gs_fieldcat. gs_fieldcat-col_pos = 11. gs_fieldcat-fieldname = 'ZWAERS'.       gs_fieldcat-scrtext_m = '##'. gs_fieldcat-emphasize = 'X'. APPEND gs_fieldcat TO gt_fieldcat.

  CLEAR gs_fieldcat. gs_fieldcat-col_pos = 12. gs_fieldcat-fieldname = 'ZDFLAG_NAME'.  gs_fieldcat-scrtext_m = '####'. APPEND gs_fieldcat TO gt_fieldcat.

  CLEAR gs_fieldcat. gs_fieldcat-col_pos = 13. gs_fieldcat-fieldname = 'ZDGUBUN_NAME'. gs_fieldcat-scrtext_m = '####'. gs_fieldcat-emphasize = 'X'. APPEND gs_fieldcat TO gt_fieldcat.

  CLEAR gs_fieldcat. gs_fieldcat-col_pos = 14. gs_fieldcat-fieldname = 'ZDDATE'.       gs_fieldcat-scrtext_m = '####'. gs_fieldcat-outputlen = 10. APPEND gs_fieldcat TO gt_fieldcat.



  IF p_ch1 = c_x.

    CLEAR gs_fieldcat. gs_fieldcat-col_pos = 15. gs_fieldcat-fieldname = 'ZRDATE'. gs_fieldcat-scrtext_m = '####'. gs_fieldcat-outputlen = 10. APPEND gs_fieldcat TO gt_fieldcat.

    CLEAR gs_fieldcat. gs_fieldcat-col_pos = 16. gs_fieldcat-fieldname = 'ZFLAG'.  gs_fieldcat-scrtext_m = '####'. gs_fieldcat-outputlen = 8. gs_fieldcat-just = 'C'. gs_fieldcat-emphasize = 'X'. APPEND gs_fieldcat TO gt_fieldcat.

  ENDIF.

ENDFORM.



FORM alv_sort.

  CLEAR: gs_sort, gt_sort.

  gs_sort-spos      = 1.

  gs_sort-fieldname = 'ZIDCODE'.

  gs_sort-up        = 'X'.

  gs_sort-subtot    = 'X'.

  APPEND gs_sort TO gt_sort.

ENDFORM.



FORM layout_set.

  CLEAR gs_layout.  gs_layout-zebra = 'X'.

  CLEAR gs_variant. gs_variant-report = sy-repid. gs_variant-username = sy-uname.

ENDFORM.



FORM call_alv USING pt_itab    TYPE STANDARD TABLE

                    p_grid     TYPE REF TO cl_gui_alv_grid

                    ps_layout  TYPE lvc_s_layo

                    ps_variant LIKE disvariant.

  CALL METHOD p_grid->set_table_for_first_display

    EXPORTING

      is_variant      = ps_variant

      i_save          = c_a

      is_layout       = ps_layout

    CHANGING

      it_outtab       = pt_itab

      it_fieldcatalog = gt_fieldcat

      it_sort         = gt_sort.

ENDFORM.



FORM zmtart_name USING p_zmtart CHANGING p_name.

  CASE p_zmtart.

    WHEN '001'. p_name = '##'.

    WHEN '002'. p_name = '##'.

    WHEN '003'. p_name = '##'.

    WHEN '004'. p_name = '##'.

    WHEN '005'. p_name = '##'.

    WHEN '006'. p_name = '###'.

  ENDCASE.

ENDFORM.



FORM zret_name USING p_fg CHANGING p_name.

  CASE p_fg.

    WHEN '1'. p_name = '####'.

    WHEN '2'. p_name = '####'.

    WHEN '3'. p_name = '####'.

  ENDCASE.

ENDFORM.



FORM zdgubun_name USING p_zdgubun CHANGING p_name.

  CASE p_zdgubun.

    WHEN '1'. p_name = '##'.

    WHEN '2'. p_name = '###'.

    WHEN '3'. p_name = '###'.

    WHEN '4'. p_name = '###'.

    WHEN '5'. p_name = '###'.

    WHEN '6'. p_name = '###'.

    WHEN '7'. p_name = '###'.

  ENDCASE.

ENDFORM.