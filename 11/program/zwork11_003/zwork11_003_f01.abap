
*&---------------------------------------------------------------------*

*&  Include           ZWORK11_002_F01

*&---------------------------------------------------------------------*



*&---------------------------------------------------------------------*

*&      FORM SET_INIT

*&---------------------------------------------------------------------*




FORM set_init.

  "### ## #### ### ##

ENDFORM.






*&---------------------------------------------------------------------*

*&      FORM READ_DATA

*&---------------------------------------------------------------------*




FORM read_data.



  "1) #### ## ##

  IF pa_date IS INITIAL.

    MESSAGE '## #### ######.' TYPE 'E'.

  ENDIF.



  "2) ## ## ### (ZTCURR11-GDATU# ## ##)

  DATA lv_gdatu TYPE ztcurr11-gdatu.

  lv_gdatu = pa_date.   "SY-DATUM(## DATS) -> CHAR8 ## ##



  "3) ## ### ## ### ##

  SELECT *

    FROM ztcurr11

    INTO CORRESPONDING FIELDS OF TABLE gt_output

    WHERE gdatu = lv_gdatu.



  IF gt_output IS INITIAL.

    MESSAGE '## ### ## #### ####.' TYPE 'E'.

  ENDIF.



  "4) ALV ### ###/### ###

  PERFORM modify_data.



ENDFORM.






*&---------------------------------------------------------------------*

*&      FORM CREATE_OBJECT

*&---------------------------------------------------------------------*




FORM create_object.



  "### #### ## (### 100# CON1# ##)

  CREATE OBJECT gc_custom

    EXPORTING

      container_name = 'CON1'.



  "ALV GRID ## ##

  CREATE OBJECT gc_grid

    EXPORTING

      i_parent = gc_custom.



ENDFORM.






*&---------------------------------------------------------------------*

*&      FORM FIELD_CATALOG

*&---------------------------------------------------------------------*




FORM field_catalog.



  CLEAR: gs_fc, gt_fc.



  "1. ####

  gs_fc-col_pos   = 1.

  gs_fc-fieldname = 'KURST'.

  gs_fc-coltext   = '####'.

  APPEND gs_fc TO gt_fc.



  "2. ####

  CLEAR gs_fc.

  gs_fc-col_pos   = 2.

  gs_fc-fieldname = 'FCURR'.

  gs_fc-coltext   = '####'.

  APPEND gs_fc TO gt_fc.



  "3. ####

  CLEAR gs_fc.

  gs_fc-col_pos   = 3.

  gs_fc-fieldname = 'TCURR'.

  gs_fc-coltext   = '####'.

  APPEND gs_fc TO gt_fc.



  "4. ####

  CLEAR gs_fc.

  gs_fc-col_pos   = 4.

  gs_fc-fieldname = 'GDATU'.

  gs_fc-coltext   = '####'.

  APPEND gs_fc TO gt_fc.



  "5. ##

  CLEAR gs_fc.

  gs_fc-col_pos   = 5.

  gs_fc-fieldname = 'UKURS'.

  gs_fc-coltext   = '##'.

  gs_fc-outputlen = 15.

  APPEND gs_fc TO gt_fc.



  "6. ########

  CLEAR gs_fc.

  gs_fc-col_pos   = 6.

  gs_fc-fieldname = 'FFACT'.

  gs_fc-coltext   = '########'.

  APPEND gs_fc TO gt_fc.



  "7. ########

  CLEAR gs_fc.

  gs_fc-col_pos   = 7.

  gs_fc-fieldname = 'TFACT'.

  gs_fc-coltext   = '########'.

  APPEND gs_fc TO gt_fc.



  "8. ### (#### ## ##)

  CLEAR gs_fc.

  gs_fc-col_pos   = 8.

  gs_fc-fieldname = 'WRITER'.

  gs_fc-coltext   = '###'.

  gs_fc-outputlen = 12.

  APPEND gs_fc TO gt_fc.



  "9. ### (#### ## ##)

  CLEAR gs_fc.

  gs_fc-col_pos   = 9.

  gs_fc-fieldname = 'EDATE'.

  gs_fc-coltext   = '###'.

  gs_fc-outputlen = 10.

  APPEND gs_fc TO gt_fc.



ENDFORM.






*&---------------------------------------------------------------------*

*&      FORM CALL_ALV

*&---------------------------------------------------------------------*




FORM call_alv.



  CALL METHOD gc_grid->set_table_for_first_display

    CHANGING

      it_outtab       = gt_output

      it_fieldcatalog = gt_fc.



ENDFORM.






*&---------------------------------------------------------------------*

*&      FORM REFRESH

*&---------------------------------------------------------------------*




FORM refresh.



  DATA ls_stable TYPE lvc_s_stbl.



  ls_stable-row = 'X'.

  ls_stable-col = 'X'.



  CALL METHOD gc_grid->refresh_table_display

    EXPORTING

      is_stable = ls_stable.



ENDFORM.






*&---------------------------------------------------------------------*

*&      FORM MODIFY_DATA

*&---------------------------------------------------------------------*




FORM modify_data.



  LOOP AT gt_output INTO gs_output.

    gs_output-writer = sy-uname.   "#### ## ###

    gs_output-edate  = sy-datum.   "PDF ####

    MODIFY gt_output FROM gs_output.

  ENDLOOP.



ENDFORM.