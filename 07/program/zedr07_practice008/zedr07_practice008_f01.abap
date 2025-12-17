
*&---------------------------------------------------------------------*

*&  Include           ZEDR07_PRACTICE008_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SET_DATE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_DATE . "## & #### ###

  IF s_zjdate[] IS INITIAL.

    s_zjdate-low = sy-datum(6) && '01'.

    s_zjdate-high = sy-datum(6) && '01'.

    s_zjdate-sign = 'I'.

    s_zjdate-option = 'BT'.



    CALL FUNCTION 'LAST_DAY_OF_MONTHS'

      EXPORTING

        day_in = s_zjdate-high

      IMPORTING

        last_day_of_month = s_zjdate-high.



    APPEND s_zjdate.

  ENDIF.



  IF s_zddate[] IS INITIAL.

    s_zddate-low = sy-datum(6) && '01'.

    s_zddate-high = sy-datum(6) && '01'.

    s_zddate-sign = 'I'.

    s_zddate-option = 'BT'.



    CALL FUNCTION 'LAST_DAY_OF_MONTHS'

      EXPORTING

        day_in = s_zddate-high

      IMPORTING

        last_day_of_month = s_zddate-high.



    APPEND s_zddate.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_SCREEN

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_SCREEN .

  LOOP AT SCREEN.

    IF screen-group1 = 'M2'.

      IF p_r1 = 'X'.

        screen-active = '0'.

      ELSEIF p_r2 = 'X'.

        screen-active = '1'.

      ENDIF.



    ELSEIF screen-group1 = 'M1'.

      IF p_r1 = 'X'.

        screen-active = '1'.

      ELSEIF p_r2 = 'X'.

        screen-active = '0'.

      ENDIF.

    ENDIF.



    MODIFY SCREEN.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_DATA .

  "## ##

  IF p_r1 = C_X.

    IF s_zjdate IS INITIAL.

      IF s_zordno IS INITIAL.

        MESSAGE I000.

        STOP.

      ENDIF.

    ENDIF.

  ELSEIF p_r2 = C_X.

    IF s_zddate IS INITIAL.

      IF s_zordno IS INITIAL.

        MESSAGE I000.

        STOP.

      ENDIF.

    ENDIF.

  ENDIF.



  "## ##

  IF p_r1 = c_x.

    r_fg-sign = 'I'.

    r_fg-option = 'EQ'.

    r_fg-low = '1'.

    APPEND r_fg.



    IF p_ch1 = c_x.

      r_fg-low = '2'.

      APPEND r_fg.

    ENDIF.



  ELSEIF p_r2 = c_x.

    r_zg-sign = 'I'.

    r_zg-option = 'EQ'.

    r_zg-low = ' '.

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

*       text

*----------------------------------------------------------------------*

*      -->P_0029   text

*----------------------------------------------------------------------*




FORM PROGRESS_DISPLAY  USING  p_text.

  CHECK p_text <> ''.



  CALL FUNCTION 'SAPGUI_PROGRESS_INDICATOR'

    EXPORTING

      text = p_text.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SELECT_R1

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SELECT_R1 .

  SELECT * FROM zedt07_100

    INTO CORRESPONDING FIELDS OF TABLE gt_order

    WHERE zordno IN s_zordno

    and zidcode in s_zid

    and zmatnr in s_zmatnr

    and zjdate in s_zjdate

    and zsale_fg in r_fg.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_R1

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_R1 .

  CLEAR : gs_order, gs_order_print.



  LOOP AT gt_order INTO gs_order.

    MOVE-CORRESPONDING gs_order TO gs_order_print.



    PERFORM get_text_by_code USING 'ZMTART' gs_order-zmtart

          CHANGING gs_order_print-zmat_name. "## ## ###



    IF gs_order-zsale_fg = '1'. "####

      gs_order_print-zsale_name = '##'.

      gs_order_print-icon = '@08@'.

    ELSEIF gs_order-zsale_fg = '2'.

      gs_order_print-zsale_name = '##'.

      gs_order_print-icon = '@0A@'.

    ENDIF.



    IF p_ch1 = c_x.

      PERFORM get_text_by_code USING 'ZRET_FG' gs_order-zret_fg

            CHANGING gs_order_print-zret_name. "## ## ###

    ENDIF.



    APPEND gs_order_print TO gt_order_print.

    CLEAR : gs_order, gs_order_print.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SELECT_R2

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SELECT_R2 .

  SELECT * FROM zedt07_101

    INTO CORRESPONDING FIELDS OF TABLE gt_deli

    WHERE zordno IN s_zordno

    AND zidcode IN s_zid

    AND zmatnr IN s_zmatnr

    AND zddate IN s_zddate

    AND zflag IN r_zg.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_R2

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_R2 .

  CLEAR : gs_deli, gs_deli_print.



  LOOP AT gt_deli INTO gs_deli.

    MOVE-CORRESPONDING gs_deli TO gs_deli_print.



    PERFORM get_text_by_code USING 'ZMTART' gs_deli-zmtart "## ## ###

          CHANGING gs_deli_print-zmat_name.



    IF gs_deli-zdflag = '1'.

      gs_deli_print-zdflag_name = '####'.

    ELSEIF gs_deli-zdflag = '2'.

      gs_deli_print-zdflag_name = '####'.

    ENDIF.



    IF gs_deli-zflag = 'X'.

      gs_deli_print-icon = '@0A@'.

    ELSE.

      gs_deli_print-icon = '@08@'.

    ENDIF.



    PERFORM get_text_by_code USING 'ZDGUBUN' gs_deli-zdgubun

          CHANGING gs_deli_print-zdgubun_name. "## ## ###



    APPEND gs_deli_print TO gt_deli_print. "###



    CLEAR : gs_deli, gs_deli_print.

  ENDLOOP.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  GET_TEXT_BY_CODE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_0276   text

*      -->P_GS_ORDER_ZMTART  text

*      <--P_GS_ORDER_PRINT_ZMAT_NAME  text

*----------------------------------------------------------------------*




FORM GET_TEXT_BY_CODE  USING    p_domain TYPE c

                                p_code TYPE c

                       CHANGING p_name TYPE c.



  CASE p_domain.

    WHEN 'ZMTART'.

      CASE p_code.

        WHEN '001'.

          p_name = '##'.

        WHEN '002'.

          p_name = '##'.

        WHEN '003'.

          p_name = '##'.

        WHEN '004'.

          p_name = '##'.

        WHEN '005'.

          p_name = '##'.

        WHEN '006'.

          p_name = '###'.

      ENDCASE.



    WHEN 'ZRET_FG'.

      CASE p_code.

        WHEN '1'.

          p_name = '####'.

        WHEN '2'.

          p_name = '####'.

        WHEN '3'.

          p_name = '####'.

      ENDCASE.



    WHEN 'ZDGUBUN'.

      CASE p_code.

        WHEN '1'.

          p_name = '##'.

        WHEN '2'.

          p_name = '###'.

        WHEN '3'.

          p_name = '###'.

        WHEN '4'.

          p_name = '###'.

        WHEN '5'.

          p_name = '###'.

        WHEN '6'.

          p_name = '###'.

        WHEN '7'.

          p_name = '###'.

      ENDCASE.

    ENDCASE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GC_DOCKING  text

*      -->P_GC_GRID_100  text

*----------------------------------------------------------------------*




FORM CREATE_OBJECT  USING    P_DOCKING TYPE REF TO cl_gui_docking_container

                             P_GRID TYPE REF TO cl_gui_alv_grid.



  CREATE OBJECT P_DOCKING

    EXPORTING




*      PARENT                      =




      REPID                       = sy-repid

      DYNNR                       = sy-dynnr




*      SIDE                        = DOCK_AT_LEFT




      EXTENSION                   = 2000




*      STYLE                       =

*      LIFETIME                    = lifetime_default

*      CAPTION                     =

*      METRIC                      = 0

*      RATIO                       =

*      NO_AUTODEF_PROGID_DYNNR     =

*      NAME                        =

*    EXCEPTIONS

*      CNTL_ERROR                  = 1

*      CNTL_SYSTEM_ERROR           = 2

*      CREATE_ERROR                = 3

*      LIFETIME_ERROR              = 4

*      LIFETIME_DYNPRO_DYNPRO_LINK = 5

*      others                      = 6




      .



CREATE OBJECT P_GRID

  EXPORTING




*    I_SHELLSTYLE      = 0

*    I_LIFETIME        =




    I_PARENT          = p_docking




*    I_APPL_EVENTS     = space

*    I_PARENTDBG       =

*    I_APPLOGPARENT    =

*    I_GRAPHICSPARENT  =

*    I_NAME            =

*    I_FCAT_COMPLETE   = SPACE

*  EXCEPTIONS

*    ERROR_CNTL_CREATE = 1

*    ERROR_CNTL_INIT   = 2

*    ERROR_CNTL_LINK   = 3

*    ERROR_DP_CREATE   = 4

*    others            = 5




    .





ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CAT_0100

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CAT_0100 .

  CLEAR : gs_fieldcat, gt_fieldcat.

  gs_fieldcat-col_pos = 1.

  gs_fieldcat-fieldname = 'ICON'.

  gs_fieldcat-coltext = '##'.

  gs_fieldcat-icon = 'X'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 2.

  gs_fieldcat-fieldname = 'ZORDNO'.

  gs_fieldcat-scrtext_m = '####'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 3.

  gs_fieldcat-fieldname = 'ZIDCODE'.

  gs_fieldcat-scrtext_m = '##ID'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 4.

  gs_fieldcat-fieldname = 'ZMATNR'.

  gs_fieldcat-scrtext_m = '####'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 5.

  gs_fieldcat-fieldname = 'ZMATNAME'.

  gs_fieldcat-scrtext_m = '###'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 6.

  gs_fieldcat-fieldname = 'ZMAT_NAME'.

  gs_fieldcat-scrtext_m = '####'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 7.

  gs_fieldcat-fieldname = 'ZVOLUM'.

  gs_fieldcat-scrtext_m = '##'.

  gs_fieldcat-qfieldname = 'VRKME'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 8.

  gs_fieldcat-fieldname = 'VRKME'.

  gs_fieldcat-scrtext_m = '##'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 9.

  gs_fieldcat-fieldname = 'ZNSAMT'.

  gs_fieldcat-scrtext_m = '####'.

  gs_fieldcat-cfieldname = 'ZWAERS'.

  gs_fieldcat-do_sum = 'X'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 10.

  gs_fieldcat-fieldname = 'ZSLAMT'.

  gs_fieldcat-scrtext_m = '####'.

  gs_fieldcat-cfieldname = 'ZWAERS'.

  gs_fieldcat-do_sum = 'X'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 11.

  gs_fieldcat-fieldname = 'ZDCAMT'.

  gs_fieldcat-scrtext_m = '####'.

  gs_fieldcat-cfieldname = 'ZWAERS'.

  gs_fieldcat-do_sum = 'X'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 12.

  gs_fieldcat-fieldname = 'ZWAERS'.

  gs_fieldcat-scrtext_m = '##'.

  gs_fieldcat-emphasize = 'X'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 13.

  gs_fieldcat-fieldname = 'ZSALE_NAME'.

  gs_fieldcat-scrtext_m = '####'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 14.

  gs_fieldcat-fieldname = 'ZJDATE'.

  gs_fieldcat-scrtext_m = '####'.

  gs_fieldcat-outputlen = '10'.

  APPEND gs_fieldcat TO gt_fieldcat.



  IF p_ch1 = c_x.

    CLEAR : gs_fieldcat.

    gs_fieldcat-col_pos = 15.

    gs_fieldcat-fieldname = 'ZRET_NAME'.

    gs_fieldcat-scrtext_m = '####'.

    APPEND gs_fieldcat TO gt_fieldcat.



    CLEAR : gs_fieldcat.

    gs_fieldcat-col_pos = 16.

    gs_fieldcat-fieldname = 'ZRDATE'.

    gs_fieldcat-scrtext_m = '####'.

    gs_fieldcat-outputlen = '10'.

    APPEND gs_fieldcat TO gt_fieldcat.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_SORT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_SORT .

  CLEAR : gs_sort, gt_sort.



  gs_sort-spos = 1.

  gs_sort-fieldname = 'ZIDCODE'.

  gs_sort-up = 'X'.

  gs_sort-subtot = 'X'.

  APPEND gs_sort TO gt_sort.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  LAYOUT_SET

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM LAYOUT_SET .

  CLEAR gs_layout.



  gs_layout-zebra = 'X'.



  CLEAR gs_variant.

  gs_variant-report = sy-repid.

  gs_variant-username = sy-uname.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALL_ALV

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GT_ORDER_PRINT[]  text

*      -->P_GC_GRID_100  text

*      -->P_GS_LAYOUT  text

*      -->P_GS_VARIANT  text

*----------------------------------------------------------------------*




FORM CALL_ALV  USING    P_itab TYPE STANDARD TABLE

                        P_GRID TYPE REF TO cl_gui_alv_grid

                        P_LAYOUT TYPE lvc_s_layo

                        P_VARIANT TYPE disvariant.



  CALL METHOD p_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING




*      I_BUFFER_ACTIVE               =

*      I_BYPASSING_BUFFER            =

*      I_CONSISTENCY_CHECK           =

*      I_STRUCTURE_NAME              =




      IS_VARIANT                    = p_variant

      I_SAVE                        = c_a




*      I_DEFAULT                     = 'X'




      IS_LAYOUT                     = p_layout




*      IS_PRINT                      =

*      IT_SPECIAL_GROUPS             =

*      IT_TOOLBAR_EXCLUDING          =

*      IT_HYPERLINK                  =

*      IT_ALV_GRAPHICS               =

*      IT_EXCEPT_QINFO               =

*      IR_SALV_ADAPTER               =




    CHANGING

      IT_OUTTAB                     = p_itab

      IT_FIELDCATALOG               = gt_fieldcat

      IT_SORT                       = gt_sort




*      IT_FILTER                     =

*    EXCEPTIONS

*      INVALID_PARAMETER_COMBINATION = 1

*      PROGRAM_ERROR                 = 2

*      TOO_MANY_LINES                = 3

*      others                        = 4




          .



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CAT_0200

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CAT_0200 .

  CLEAR : gs_fieldcat, gt_fieldcat.

  gs_fieldcat-col_pos = 1.

  gs_fieldcat-fieldname = 'ICON'.

  gs_fieldcat-coltext = '##'.

  gs_fieldcat-icon = 'X'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 2.

  gs_fieldcat-fieldname = 'ZORDNO'.

  gs_fieldcat-scrtext_m = '####'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 3.

  gs_fieldcat-fieldname = 'ZIDCODE'.

  gs_fieldcat-scrtext_m = '##ID'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 4.

  gs_fieldcat-fieldname = 'ZMATNR'.

  gs_fieldcat-scrtext_m = '####'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 5.

  gs_fieldcat-fieldname = 'ZMATNAME'.

  gs_fieldcat-scrtext_m = '###'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 6.

  gs_fieldcat-fieldname = 'ZMAT_NAME'.

  gs_fieldcat-scrtext_m = '####'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 7.

  gs_fieldcat-fieldname = 'ZVOLUM'.

  gs_fieldcat-scrtext_m = '##'.

  gs_fieldcat-qfieldname = 'VRKME'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 8.

  gs_fieldcat-fieldname = 'VRKME'.

  gs_fieldcat-scrtext_m = '##'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 10.

  gs_fieldcat-fieldname = 'ZSLAMT'.

  gs_fieldcat-scrtext_m = '####'.

  gs_fieldcat-cfieldname = 'ZWAERS'.

  gs_fieldcat-do_sum = 'X'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 11.

  gs_fieldcat-fieldname = 'ZWAERS'.

  gs_fieldcat-scrtext_m = '##'.

  gs_fieldcat-emphasize = 'X'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 12.

  gs_fieldcat-fieldname = 'ZDFLAG_NAME'.

  gs_fieldcat-scrtext_m = '####'.

  gs_fieldcat-currency = 'KRW'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 13.

  gs_fieldcat-fieldname = 'ZDGUBUN_NAME'.

  gs_fieldcat-scrtext_m = '####'.

  gs_fieldcat-emphasize = 'X'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 14.

  gs_fieldcat-fieldname = 'ZDDATE'.

  gs_fieldcat-scrtext_m = '####'.

  gs_fieldcat-outputlen = '10'.

  APPEND gs_fieldcat TO gt_fieldcat.



  IF p_ch1 = c_x.

    CLEAR : gs_fieldcat.

    gs_fieldcat-col_pos = 15.

    gs_fieldcat-fieldname = 'ZRDATE'.

    gs_fieldcat-scrtext_m = '####'.

    gs_fieldcat-outputlen = '10'.

    APPEND gs_fieldcat TO gt_fieldcat.



    CLEAR : gs_fieldcat.

    gs_fieldcat-col_pos = 16.

    gs_fieldcat-fieldname = 'ZFLAG'.

    gs_fieldcat-scrtext_m = '####'.

    gs_fieldcat-outputlen = '8'.

    gs_fieldcat-just = 'C'.

    gs_fieldcat-emphasize = 'X'.

    APPEND gs_fieldcat TO gt_fieldcat.

  ENDIF.

ENDFORM.