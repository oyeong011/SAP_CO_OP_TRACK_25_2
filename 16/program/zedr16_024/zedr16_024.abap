
*&---------------------------------------------------------------------*

*& Report ZEDR16_024

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT zedr16_024.




*

*TABLES : zedt16_001.

*

*DATA : BEGIN OF gs_student.

*    INCLUDE TYPE zedt16_001.

*DATA : END OF gs_student.

*DATA : gt_student LIKE TABLE OF gs_student.

*

**RANGES s_zcode FOR zedt16_001-zcode.

*

*SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.

*SELECT-OPTIONS : s_zcode FOR zedt16_001-zcode.

*SELECTION-SCREEN END OF BLOCK b1.

*

*

*

*INITIALIZATION.

*  s_zcode-low = 'ssu-01'.

*  s_zcode-high = 'ssu-99'.

*  APPEND s_zcode.

*

*AT SELECTION-SCREEN OUTPUT.

*  LOOP AT SCREEN.

*    IF screen-group1 = 'SC1'.

*      screen-input = 0.

*    ENDIF.

*    MODIFY SCREEN.

*  ENDLOOP.

*

*START-OF-SELECTION.

*  PERFORM get_data.

**  PERFORM modify_data.

*

*END-OF-SELECTION.

*  PERFORM alv_display.

**&---------------------------------------------------------------------*

**&      Form  GET_DATA

**&---------------------------------------------------------------------*

**       text

**----------------------------------------------------------------------*

**  -->  p1        text

**  <--  p2        text

**----------------------------------------------------------------------*

*FORM get_data .

*  SELECT * FROM zedt16_001

*    INTO CORRESPONDING FIELDS OF TABLE gt_student

*  WHERE zcode IN s_zcode.

*ENDFORM.

**&---------------------------------------------------------------------*

**&      Form  ALV_DISPLAY

**&---------------------------------------------------------------------*

**       text

**----------------------------------------------------------------------*

**  -->  p1        text

**  <--  p2        text

**----------------------------------------------------------------------*

*FORM alv_display .

*  CALL FUNCTION 'REUSE_ALV_LIST_DISPLAY'

*    EXPORTING

**     I_INTERFACE_CHECK              = ' '

**     I_BYPASSING_BUFFER             =

**     I_BUFFER_ACTIVE  = ' '

**     I_CALLBACK_PROGRAM             = ' '

**     I_CALLBACK_PF_STATUS_SET       = ' '

**     I_CALLBACK_USER_COMMAND        = ' '

*      i_structure_name = 'ZEDT16_001'

**     IS_LAYOUT        =

**     IT_FIELDCAT      =

**     IT_EXCLUDING     =

**     IT_SPECIAL_GROUPS              =

**     IT_SORT          =

**     IT_FILTER        =

**     IS_SEL_HIDE      =

**     I_DEFAULT        = 'X'

**     I_SAVE           = ' '

**     IS_VARIANT       =

**     IT_EVENTS        =

**     IT_EVENT_EXIT    =

**     IS_PRINT         =

**     IS_REPREP_ID     =

**     I_SCREEN_START_COLUMN          = 0

**     I_SCREEN_START_LINE            = 0

**     I_SCREEN_END_COLUMN            = 0

**     I_SCREEN_END_LINE              = 0

**     IR_SALV_LIST_ADAPTER           =

**     IT_EXCEPT_QINFO  =

**     I_SUPPRESS_EMPTY_DATA          = ABAP_FALSE

** IMPORTING

**     E_EXIT_CAUSED_BY_CALLER        =

**     ES_EXIT_CAUSED_BY_USER         =

*    TABLES

*      t_outtab         = gt_student.

** EXCEPTIONS

**   PROGRAM_ERROR                  = 1

**   OTHERS                         = 2

*  .

*  IF sy-subrc <> 0.

** Implement suitable error handling here

*  ENDIF.

*

*ENDFORM.






TYPES: BEGIN OF slis_fieldcat_main.

    INCLUDE TYPE slis_fieldcat_main0.

    INCLUDE TYPE slis_fieldcat_main1.

TYPES: END OF slis_fieldcat_main.



TYPES: BEGIN OF slis_fieldcat_alv_spec,

         key_sel(1)  TYPE c,

         no_sum(1)   TYPE c,

         sp_group(4) TYPE c,

         reprep(1)   TYPE c,

         input(1)    TYPE c,

         edit(1)     TYPE c,

         hotspot(1)  TYPE c,

       END OF slis_fieldcat_alv_spec.



TYPES: BEGIN OF slis_fieldcat_alv.

    INCLUDE TYPE slis_fieldcat_main.

    INCLUDE TYPE slis_fieldcat_alv_spec.

TYPES: END OF slis_fieldcat_alv.



TYPES: BEGIN OF slis_fieldcat_alv1.

    INCLUDE TYPE slis_fieldcat_main1.

TYPES: END OF slis_fieldcat_alv1.



TYPES: slis_t_fieldcat_alv TYPE slis_fieldcat_alv OCCURS 1.



TABLES : zedt16_001.



DATA: gs_student TYPE zedt16_001.

DATA: gt_student LIKE TABLE OF gs_student.



DATA : gs_fieldcat TYPE slis_fieldcat_alv.

DATA : gt_fieldcat TYPE slis_t_fieldcat_alv.



SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.

SELECT-OPTIONS : s_zcode FOR zedt16_001-zcode.

PARAMETERS : p_zpernr LIKE zedt16_001-zpernr.

PARAMETERS : p_zgen LIKE zedt16_001-zgender MODIF ID sc1.

SELECTION-SCREEN END OF BLOCK b1.











INITIALIZATION.

  s_zcode-low = 'ssu-01'.

  s_zcode-high = 'ssu-99'.

  APPEND s_zcode.



AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    IF screen-group1 = 'SC1'.

      screen-input = 0.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.



START-OF-SELECTION.

  PERFORM get_data.




*  PERFORM modify_data.






END-OF-SELECTION.

  PERFORM alv_display.



FORM get_data .

  SELECT * FROM zedt16_001

    INTO CORRESPONDING FIELDS OF TABLE gt_student

  WHERE zcode IN s_zcode.

ENDFORM.





FORM alv_display .



  PERFORM field_catalog.

  PERFORM call_alv.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM field_catalog .



  CLEAR : gs_fieldcat, gt_fieldcat.

  gs_fieldcat-col_pos = 1.

  gs_fieldcat-fieldname = 'ZCODE'.

  gs_fieldcat-seltext_m = '####'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 2.

  gs_fieldcat-fieldname = 'ZPERNR'.

  gs_fieldcat-seltext_m = '####'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.

  gs_fieldcat-col_pos = 3.

  gs_fieldcat-fieldname = 'ZKNAME'.

  gs_fieldcat-seltext_m = '##'.

  APPEND gs_fieldcat TO gt_fieldcat.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALL_ALV

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM call_alv .

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

    EXPORTING

      it_fieldcat = gt_fieldcat

    TABLES

      t_outtab    = gt_student.

ENDFORM.