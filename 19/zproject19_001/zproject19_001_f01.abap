
*&---------------------------------------------------------------------*

*&  Include           ZPROJECT19_001_F01

*&---------------------------------------------------------------------*

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

    CASE screen-group1.

      WHEN 'M1'. "#####

        IF p_rad1 = 'X'. "####

          screen-active = 0.

        ELSE.

          screen-active = 1.

        ENDIF.



      WHEN 'M2'. "#####

        IF p_rad1 = 'X'. "####

          screen-active = 1.

        ELSE.

          screen-active = 0.

        ENDIF.



      WHEN 'ALL'. "####

        screen-active = 1. "## ##



    ENDCASE.

    MODIFY SCREEN.

  ENDLOOP.

ENDFORM.








*&---------------------------------------------------------------------*

*&      Form  ADD_DATA

*&---------------------------------------------------------------------*






FORM save_vendor_row USING is_row TYPE ty_004.



  DATA: ls_001 TYPE zpdt19_001,

        ls_002 TYPE zpdt19_002,

        ls_003 TYPE zpdt19_003.





  "===== Move matching fields =====

  MOVE-CORRESPONDING is_row TO ls_001.

  MOVE-CORRESPONDING is_row TO ls_002.

  MOVE-CORRESPONDING is_row TO ls_003.



  "===== ## =====

  MODIFY zpdt19_001 FROM ls_001.

  IF sy-subrc <> 0.

    INSERT zpdt19_001 FROM ls_001.

  ENDIF.



  MODIFY zpdt19_002 FROM ls_002.

  IF sy-subrc <> 0.

    INSERT zpdt19_002 FROM ls_002.

  ENDIF.



  MODIFY zpdt19_003 FROM ls_003.

  IF sy-subrc <> 0.

    INSERT zpdt19_003 FROM ls_003.

  ENDIF.



ENDFORM.










*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM get_data .



  CLEAR: gt_001, gt_002, gt_003.

  REFRESH: gt_001, gt_002, gt_003.



  " 1) #####

  SELECT *

    FROM zpdt19_001

    INTO TABLE @gt_001

    WHERE lifnr = @p_lifnr.



  " 2) #######

  SELECT *

    FROM zpdt19_002

    INTO TABLE @gt_002

    WHERE lifnr = @p_lifnr

      AND bukrs = @p_bukrs.



  " 3) #######

  SELECT *

    FROM zpdt19_003

    INTO TABLE @gt_003

    WHERE lifnr = @p_lifnr.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CREATE_OBJECT .

  CREATE OBJECT GC_DOCKING

    EXPORTING

      REPID                       = SY-REPID

      DYNNR                       = SY-DYNNR

      EXTENSION                   = 2000.



  CREATE OBJECT GC_SPLITTER

    EXPORTING

      PARENT            = GC_DOCKING

      ROWS              = 2

      COLUMNS           = 1.



  CALL METHOD GC_SPLITTER->GET_CONTAINER

    EXPORTING

      ROW       = 1

      COLUMN    = 1

    RECEIVING

      CONTAINER = GC_CONTAINER1.



  CALL METHOD GC_SPLITTER->GET_CONTAINER

    EXPORTING

      ROW       = 2

      COLUMN    = 1

    RECEIVING

      CONTAINER = GC_CONTAINER2.



  CREATE OBJECT GC_SPLITTER2

    EXPORTING

      PARENT            = GC_CONTAINER1

      ROWS              = 1

      COLUMNS           = 2.



  CALL METHOD GC_SPLITTER2->GET_CONTAINER

    EXPORTING

      ROW       = 1

      COLUMN    = 1

    RECEIVING

      CONTAINER = GC_CONTAINER3.



  CALL METHOD GC_SPLITTER2->GET_CONTAINER

    EXPORTING

      ROW       = 1

      COLUMN    = 2

    RECEIVING

      CONTAINER = GC_CONTAINER4.



  CREATE OBJECT GC_GRID1

    EXPORTING

      I_PARENT          = GC_CONTAINER3.



  CREATE OBJECT GC_GRID2

    EXPORTING

      I_PARENT          = GC_CONTAINER4.



  CREATE OBJECT GC_GRID3

    EXPORTING

      I_PARENT          = GC_CONTAINER2.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG .

  PERFORM CONTAINER2_FIELD.

  PERFORM CONTAINER3_FIELD.

  PERFORM CONTAINER4_FIELD.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_LAYOUT .



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALL_ALV

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CALL_ALV .

  PERFORM ALV_DISPLAY.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_DISPLAY .

  CALL METHOD GC_GRID1->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_VARIANT                    = GS_VARIANT

      I_SAVE                        = C_A

      IS_LAYOUT                     = GS_LAYOUT



    CHANGING

      IT_OUTTAB                     = GT_001

      IT_FIELDCATALOG               = GT_FIELDCAT1

      IT_SORT                       = GT_SORT1.



  CALL METHOD GC_GRID2->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_VARIANT                    = GS_VARIANT

      I_SAVE                        = C_A

      IS_LAYOUT                     = GS_LAYOUT



    CHANGING

      IT_OUTTAB                     = GT_002

      IT_FIELDCATALOG               = GT_FIELDCAT2

      IT_SORT                       = GT_SORT1.



  CALL METHOD GC_GRID3->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_VARIANT                    = GS_VARIANT

      I_SAVE                        = C_A

      IS_LAYOUT                     = GS_LAYOUT



    CHANGING

      IT_OUTTAB                     = GT_003

      IT_FIELDCATALOG               = GT_FIELDCAT3

      IT_SORT                       = GT_SORT1.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CONTAINER2_FIELD

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CONTAINER2_FIELD .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT1.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'LIFNR'.

  GS_FIELDCAT-COLTEXT = '#####'.

  GS_FIELDCAT-ICON = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'NAME1'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'LAND1'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZKTOKK'.

  GS_FIELDCAT-SCRTEXT_M = '#####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'STCD1'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'STCD2'.

  GS_FIELDCAT-SCRTEXT_M = '#####'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'STRAS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CONTAINER3_FIELD

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CONTAINER3_FIELD .

  CLEAR : GS_FIELDCAT , GT_FIELDCAT2.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-KEY = 'X'.

  GS_FIELDCAT-FIELDNAME = 'LIFNR'.

  GS_FIELDCAT-SCRTEXT_M = '#####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'BUKRS'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'LOEVM'.

  GS_FIELDCAT-SCRTEXT_M = '#####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZAKONT'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZTERM'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CONTAINER4_FIELD

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CONTAINER4_FIELD .

  CLEAR : GS_FIELDCAT , GT_FIELDCAT3.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-KEY = 'X'.

  GS_FIELDCAT-FIELDNAME = 'LIFNR'.

  GS_FIELDCAT-SCRTEXT_M = '#####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'EKORG'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'EKGRP'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'LOEVM'.

  GS_FIELDCAT-SCRTEXT_M = '#####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'WAERS'.

  GS_FIELDCAT-SCRTEXT_M = '######'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZMWSKZ'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_NEXT_LIFNR

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      <--P_LS_001_LIFNR  text

*----------------------------------------------------------------------*




FORM get_next_lifnr  CHANGING cv_lifnr TYPE lifnr.



  SELECT MAX( lifnr ) INTO @DATA(lv_max)

  FROM zpdt19_001.



  IF lv_max IS INITIAL.

    cv_lifnr = '1000000000'.

  ELSE.

    cv_lifnr = lv_max + 1.

  ENDIF.



  gv_num = cv_lifnr.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_STATUS

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM set_status .



  DATA lt_ex TYPE ui_functions.



  IF p_rad1 = c_x.          "## ##

    SET PF-STATUS 'SELSTAT'.

  ELSE.                    "## ## # ADD ###

    SET PF-STATUS 'SELSTAT2'.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT2

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CREATE_OBJECT2 .

  CREATE OBJECT GC_DOCKING

    EXPORTING

        REPID = SY-REPID

        DYNNR = SY-DYNNR

        EXTENSION = 2000.



  CREATE OBJECT GC_GRID4

    EXPORTING

      I_PARENT = GC_DOCKING.



  CREATE OBJECT GC_GRID3

    EXPORTING

      I_PARENT = GC_DOCKING.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG2

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG2 .

  CLEAR : GS_FIELDCAT , GT_FIELDCAT4.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-KEY = 'X'.

  GS_FIELDCAT-FIELDNAME = 'LIFNR'.

  GS_FIELDCAT-SCRTEXT_M = '#####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT4.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'BUKRS'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT4.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZKTOKK'.

  GS_FIELDCAT-SCRTEXT_M = '#####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT4.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'NAME1'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT4.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'LAND1'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT4.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'STCD1'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT4.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'STCD2'.

  GS_FIELDCAT-EDIT = 'X'.

  GS_FIELDCAT-SCRTEXT_M = '#####'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT4.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'STRAS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT4.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'EKORG'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT4.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'EKGRP'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT4.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'WAERS'.

  GS_FIELDCAT-SCRTEXT_M = '######'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT4.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 12.

  GS_FIELDCAT-FIELDNAME = 'ZMWSKZ'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-EDIT = 'X'.

  GS_FIELDCAT-F4AVAILABL = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT4.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 13.

  GS_FIELDCAT-FIELDNAME = 'ZAKONT'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-EDIT = 'X'.

  GS_FIELDCAT-F4AVAILABL = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT4.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 14.

  GS_FIELDCAT-FIELDNAME = 'ZTERM'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-EDIT = 'X'.

  GS_FIELDCAT-F4AVAILABL = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT4.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALL_ALV2

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CALL_ALV2 .

  PERFORM ALV_DISPLAY2.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY2

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_DISPLAY2 .

  CALL METHOD GC_GRID4->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_LAYOUT = GS_LAYOUT

    CHANGING

      IT_OUTTAB = GT_004

      IT_FIELDCATALOG = GT_FIELDCAT4

      IT_SORT = GT_SORT1.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA2

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA2 .

  CLEAR : gs_004.



  PERFORM get_next_lifnr CHANGING gs_004-lifnr.

  gs_004-lifnr = gv_num.

  gs_004-bukrs = p_bukrs.

  gs_004-zktokk = p_ktokk.

  APPEND gs_004 TO gt_004.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT2

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_LAYOUT2 .

  FIELD-SYMBOLS <fs> TYPE lvc_s_fcat.

  LOOP AT GT_FIELDCAT4 ASSIGNING <fs>.

  IF p_ktokk = '3000'. "####

    IF <fs>-FIELDNAME = 'STCD2'. "#####

      <fs>-NO_OUT = 'X'.

    ELSEIF <fs>-FIELDNAME = 'STRAS'. "##

      <fs>-NO_OUT = 'X'.

    ENDIF.

  ELSEIF p_ktokk = '2000'. "####

    IF <fs>-FIELDNAME = 'STCD1'. "####

      <fs>-NO_OUT = 'X'.

    ELSEIF <fs>-FIELDNAME = 'STCD2'. "#####

      <fs>-NO_OUT = 'X'.

    ENDIF.

  ENDIF.

  ENDLOOP.

ENDFORM.



FORM save_data .



  " ALV #### ##

  IF gc_grid4 IS BOUND.

    CALL METHOD gc_grid4->check_changed_data.

  ENDIF.



  LOOP AT gt_004 INTO gs_004.

    PERFORM save_vendor_row USING gs_004.

  ENDLOOP.



  COMMIT WORK.



  MESSAGE '### ## ##' TYPE 'S'.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHANGE_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM change_data .



  " 1) ALV #### ##

  IF gc_grid1 IS BOUND.

    CALL METHOD gc_grid1->check_changed_data.

  ENDIF.



  " 2) ## ## #### DB ####

  LOOP AT gt_001 INTO gs_001.



    "===== ZPDT19_001 #### =====

    UPDATE zpdt19_001

      SET name1 = @gs_001-name1,

          land1 = @gs_001-land1,

          stcd1 = @gs_001-stcd1,

          stcd2 = @gs_001-stcd2,

          stras = @gs_001-stras

      WHERE lifnr = @gs_001-lifnr.



  ENDLOOP.



  COMMIT WORK.



  MESSAGE '### #### ##### #######.' TYPE 'S'.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  HANDLE_F4

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_E_FIELDNAME  text

*      -->P_ES_ROW_NO  text

*      -->P_ER_EVENT_DATA  text

*----------------------------------------------------------------------*




FORM handle_f4 USING p_field TYPE lvc_fname

                     p_row   TYPE lvc_s_roid

                     p_event TYPE REF TO cl_alv_event_data.



  gv_f4_field = p_field.

  gv_f4_rowid = p_row-row_id.



  CASE gv_f4_field.

    WHEN 'ZMWSKZ'.

      PERFORM f4_domain USING 'ZMWSKZ19'.

      PERFORM apply_f4_value.

      p_event->m_event_handled = abap_true.



    WHEN 'ZAKONT'.

      PERFORM f4_domain USING 'ZAKONT19'.

      PERFORM apply_f4_value.

      p_event->m_event_handled = abap_true.



    WHEN 'ZTERM'.

      PERFORM f4_domain USING 'ZTERM19'.

      PERFORM apply_f4_value.

      p_event->m_event_handled = abap_true.

  ENDCASE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  F4_DOMAIN

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_1222   text

*----------------------------------------------------------------------*




FORM f4_domain USING p_domain TYPE domname.



  DATA: lt_dd07v TYPE STANDARD TABLE OF dd07v,

        ls_dd07v TYPE dd07v,

        lt_value TYPE TABLE OF ty_f4,

        ls_value TYPE ty_f4,

        lt_return TYPE TABLE OF ddshretval.



  "Domain# Fixed Value ##

  CALL FUNCTION 'DD_DOMVALUES_GET'

    EXPORTING

      domname   = p_domain

      text      = 'X'

    TABLES

      dd07v_tab = lt_dd07v

    EXCEPTIONS

      not_found = 1

      OTHERS    = 2.



  LOOP AT lt_dd07v INTO ls_dd07v

      WHERE domvalue_l IS NOT INITIAL.



    ls_value-value = ls_dd07v-domvalue_l.

    ls_value-text  = ls_dd07v-ddtext.

    APPEND ls_value TO lt_value.

  ENDLOOP.



  "F4 ## ###

  CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'

    EXPORTING

      retfield  = 'VALUE'

      value_org = 'S'

    TABLES

      value_tab = lt_value

      return_tab = lt_return.



  "### ### ##

  READ TABLE lt_return INTO DATA(ls_return) INDEX 1.

  IF sy-subrc = 0.

    gv_f4_value = ls_return-fieldval.

  ENDIF.



ENDFORM.



FORM apply_f4_value .



  IF gv_f4_value IS INITIAL.

    RETURN.

  ENDIF.



  " Row ## ### ##

  IF gv_f4_rowid IS INITIAL.

    RETURN.

  ENDIF.



  READ TABLE gt_004 INTO DATA(ls_row) INDEX gv_f4_rowid.

  IF sy-subrc = 0.



    CASE gv_f4_field.

      WHEN 'ZMWSKZ'.

        ls_row-zmwskz = gv_f4_value.



      WHEN 'ZAKONT'.

        ls_row-zakont = gv_f4_value.



      WHEN 'ZTERM'.

        ls_row-zterm = gv_f4_value.

    ENDCASE.



    MODIFY gt_004 FROM ls_row INDEX gv_f4_rowid.



  ENDIF.



      CALL METHOD gc_grid4->refresh_table_display.



  CLEAR gv_f4_value.

  CLEAR gv_f4_rowid.



ENDFORM.



FORM set_handler.



  IF gr_handler IS INITIAL.

    CREATE OBJECT gr_handler.

  ENDIF.



  " GRID4 ### ##

  IF gc_grid4 IS BOUND.

    SET HANDLER gr_handler->on_f4 FOR gc_grid4.

  ENDIF.



ENDFORM.



FORM register_f4.



  CLEAR gt_f4.

  INSERT VALUE #( fieldname = 'ZMWSKZ' register = 'X' ) INTO TABLE gt_f4.

  INSERT VALUE #( fieldname = 'ZAKONT' register = 'X' ) INTO TABLE gt_f4.

  INSERT VALUE #( fieldname = 'ZTERM'  register = 'X' ) INTO TABLE gt_f4.



  IF gc_grid4 IS BOUND.

    CALL METHOD gc_grid4->register_f4_for_fields

      EXPORTING it_f4 = gt_f4.

  ENDIF.



ENDFORM.