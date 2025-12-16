
*&---------------------------------------------------------------------*

*&  Include           ZMM11_001_F01

*&---------------------------------------------------------------------*






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



FORM CREATE_DATA .

  CLEAR gs_001.



  IF gv_ktokk = '2000'.

    "2000(##)### ####, ##### ## ##

    IF gv_lifnr IS INITIAL or gv_name1 IS INITIAL or gv_land1 IS INITIAL or

       gv_stras IS INITIAL.

       MESSAGE '#### # #### #####' TYPE 'E'.

    ENDIF.



  ELSEIF gv_ktokk = '3000'.

    "3000(##/##)### ####, ##### ###

    IF gv_lifnr IS INITIAL or gv_name1 IS INITIAL or gv_land1 IS INITIAL or

       gv_stcd1 IS INITIAL or gv_stcd2 IS INITIAL or gv_stras IS INITIAL.

       MESSAGE '#### # #### #####' TYPE 'E'.

    ENDIF.



  ELSE.

    "##### ###### ###.

    IF gv_lifnr IS INITIAL or gv_name1 IS INITIAL or gv_land1 IS INITIAL or

       gv_stcd2 IS INITIAL or gv_stras IS INITIAL.

       MESSAGE '#### # #### #####' TYPE 'E'.

    ENDIF.

  ENDIF.



  "ZPRO11_001# ##

  gs_001-lifnr = gv_lifnr.

  gs_001-name1 = gv_name1.

  gs_001-land1 = gv_land1.

  gs_001-ktokk = gv_ktokk.

  gs_001-stcd1 = gv_stcd1.

  gs_001-stcd2 = gv_stcd2.

  gs_001-stras = gv_stras.



  APPEND gs_001 TO gt_001.

  MODIFY zpro11_001 FROM gs_001.

  IF sy-subrc <> 0.

    INSERT zpro11_001 FROM gs_001.

  ENDIF.



  "ZPRO11_002# ##

  gs_002-lifnr = gv_lifnr.

  gs_002-bukrs = gv_bukrs.

  gs_002-akont = gv_akont.

  gs_002-zterm = gv_zterm.



  APPEND gs_002 TO gt_002.

  MODIFY zpro11_002 FROM gs_002.

  IF sy-subrc <> 0.

    INSERT zpro11_002 FROM gs_002.

  ENDIF.



  "ZPRO11_003# ##

  gs_003-lifnr = gv_lifnr.

  gs_003-ekorg = gv_ekorg.

  gs_003-ekgrp = gv_ekgrp.

  gs_003-waers = gv_waers.

  gs_003-mwskz = gv_mwskz.



  APPEND gs_003 TO gt_003.

  MODIFY zpro11_003 FROM gs_003.

  IF sy-subrc <> 0.

    INSERT zpro11_003 FROM gs_003.

  ENDIF.



  MESSAGE '## ##' TYPE 'S'.

  LEAVE TO SCREEN 0.

ENDFORM.



FORM AUTO_CALCULATE_MAX_LIFNR .

  DATA : lv_max TYPE zpro11_001-lifnr.



  " #### ##

  SELECT MAX( lifnr ) INTO lv_max FROM zpro11_001.



  IF lv_max IS INITIAL.

    gv_lifnr = '1000000000'.

  ELSE.

    gv_lifnr = lv_max + 1.

  ENDIF.

ENDFORM.



FORM VERIFY_KTOKK .

  IF p_rad1 = 'X'.

    " ###### Domain.csv# #### ZKTOKK11# ##

    SELECT SINGLE domvalue_l

    FROM dd07v

    INTO @DATA(lv_dummy)

    WHERE domname    = 'ZKTOKK11'

      AND domvalue_l = @p_ktokk.



    IF sy-subrc <> 0.

      MESSAGE '###### ### Fixed Value# ## #####.' TYPE 'I'.

      LEAVE SCREEN.

    ENDIF.

  ENDIF.

ENDFORM.



MODULE SET_ALV OUTPUT.

  IF gc_docking IS INITIAL.

    PERFORM create_object.

    PERFORM fieldcat.

    PERFORM alv_layout.

    PERFORM alv_sort.

    PERFORM class_event.

    PERFORM alv_display.

  ELSE.

    PERFORM refresh.

  ENDIF.

ENDMODULE.



FORM CREATE_OBJECT .

  CREATE OBJECT GC_DOCKING

    EXPORTING

      REPID     = sy-repid

      DYNNR     = sy-dynnr

      EXTENSION = 2000.



  CREATE OBJECT GC_GRID

    EXPORTING

      I_PARENT = gc_docking.

ENDFORM.



FORM FIELDCAT .

  CLEAR : gs_fieldcat, gt_fieldcat.

  gs_fieldcat-col_pos = 1.

  gs_fieldcat-coltext = '#####'.

  gs_fieldcat-fieldname = 'LIFNR'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 2.

  gs_fieldcat-coltext = '####'.

  gs_fieldcat-fieldname = 'NAME1'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 3.

  gs_fieldcat-coltext = '####'.

  gs_fieldcat-fieldname = 'BUKRS'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 4.

  gs_fieldcat-coltext = '#####'.

  gs_fieldcat-fieldname = 'STCD2'.

  gs_fieldcat-edit = 'X'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 5.

  gs_fieldcat-coltext = '##'.

  gs_fieldcat-fieldname = 'LAND1'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 6.

  gs_fieldcat-coltext = '##'.

  gs_fieldcat-fieldname = 'STRAS'.

  APPEND gs_fieldcat TO gt_fieldcat.

ENDFORM.



FORM ALV_LAYOUT .

  CLEAR : gs_variant.

  gs_variant-report = sy-repid.

  gs_variant-username = sy-uname.

ENDFORM.



FORM ALV_SORT .

ENDFORM.



FORM CLASS_EVENT .

  CREATE OBJECT go_event.

  SET HANDLER go_event->handler_data_changed FOR gc_grid.



  CALL METHOD GC_GRID->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = cl_gui_alv_grid=>mc_evt_modified.

ENDFORM.



FORM ALV_DISPLAY .

  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_VARIANT    = gs_variant

      I_SAVE        = 'A'

      IS_LAYOUT     = gs_layout

    CHANGING

      IT_OUTTAB     = gt_search

      IT_FIELDCATALOG = gt_fieldcat

      IT_SORT       = gt_sort.

ENDFORM.



FORM REFRESH .

  DATA : ls_stable TYPE lvc_s_stbl.

  ls_stable-row = 'X'.

  ls_stable-col = 'X'.

  CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY

    EXPORTING

      IS_STABLE = ls_stable.

ENDFORM.



FORM GET_DATA .

  " Join #### ##

  SELECT a~lifnr a~name1 a~stcd2 a~stras a~land1 b~bukrs

  INTO CORRESPONDING FIELDS OF TABLE gt_search

  FROM zpro11_001 AS a

  INNER JOIN zpro11_002 AS b

    ON a~lifnr = b~lifnr.




*  WHERE a~lifnr = p_lifnr

*    AND b~bukrs = p_bukrs.




ENDFORM.



FORM ALV_HANDLER_DATA_CHANGED USING P_DATA_CHANGED TYPE REF TO cl_alv_changed_data_protocol

                                    P_ONF4

                                    P_ONF4_BEFORE

                                    P_ONF4_AFTER

                                    P_UCOMM.



  DATA : ls_modi TYPE lvc_s_modi.

  CLEAR : ls_modi.



  LOOP AT p_data_changed->mt_good_cells INTO ls_modi.

    IF ls_modi-fieldname = 'STCD2'.

      READ TABLE gt_search INTO gs_search INDEX ls_modi-row_id.

      MODIFY gt_search FROM gs_search INDEX ls_modi-row_id.

      CLEAR gs_search.

    ENDIF.

  ENDLOOP.



  PERFORM refresh.

ENDFORM.



FORM SAVE_DATA .

  DATA : gs_save LIKE zpro11_001.

  DATA : gt_save LIKE TABLE OF gs_save.



  LOOP AT gt_search INTO gs_search.

    CLEAR gs_save.

    " ## ## ### ##

    SELECT SINGLE * FROM zpro11_001 INTO gs_save

      WHERE lifnr = gs_search-lifnr.



    MOVE-CORRESPONDING gs_search TO gs_save.

    APPEND gs_save TO gt_save.

  ENDLOOP.



  MODIFY zpro11_001 FROM TABLE gt_save.



  IF sy-subrc = 0.

    MESSAGE '####' TYPE 'I'.

  ELSE.

    MESSAGE '####' TYPE 'I'.

  ENDIF.

ENDFORM.