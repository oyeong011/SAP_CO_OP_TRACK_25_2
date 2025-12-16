
*&---------------------------------------------------------------------*

*&  Include           ZMM06_002_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  CONTROL_SCREEN

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CONTROL_SCREEN .



  LOOP AT SCREEN.

    IF P_CREATE = 'X'.

      IF SCREEN-GROUP1 = 'M1'.

        SCREEN-ACTIVE = 1.

      ELSEIF SCREEN-GROUP1 = 'M2'.

        SCREEN-ACTIVE = 0.

      ENDIF.

    ELSEIF P_FIND = 'X'.

      IF SCREEN-GROUP1 = 'M2'.

        SCREEN-ACTIVE = 1.

      ELSEIF SCREEN-GROUP1 = 'M1'.

        SCREEN-ACTIVE = 0.

      ENDIF.

    ENDIF.



    MODIFY SCREEN.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_INPUT_VAILDATION

*&---------------------------------------------------------------------*

*       ## #### ## ### ## (## #### ##### ##)

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_INPUT_VAILDATION .

  DATA : LV_LIFNR TYPE ZEDT06_EKKO-LIFNR.

  DATA : LV_BUKRS TYPE ZEDT06_EKKO-BUKRS.

  DATA : LV_LFB1_DB TYPE ZEDT06_LFB1.



  IF SY-UCOMM = 'UC1'.

    RETURN.

  ENDIF.



  " ## NULL ##

  IF P_CREATE = 'X'.

    IF P_LIFNR1 IS INITIAL.

      MESSAGE '#### ######.' TYPE 'E'.

    ENDIF.



    IF P_BUKRS IS INITIAL.

      MESSAGE '##### ######.' TYPE 'E'.

    ENDIF.



    IF P_BEDAT IS INITIAL.

      MESSAGE '#### ######.' TYPE 'E'.

    ENDIF.



    LV_LIFNR = P_LIFNR1.

    LV_BUKRS = P_BUKRS.



  ELSEIF P_FIND = 'X'.

    IF P_LIFNR2 IS INITIAL.

      MESSAGE '###### ######.' TYPE 'E'.

    ENDIF.



    IF P_BUKRS IS INITIAL.

      MESSAGE '##### ######.' TYPE 'E'.

    ENDIF.



    IF P_EBELN IS INITIAL.

      MESSAGE 'PO### ######.' TYPE 'E'.

    ENDIF.



    LV_LIFNR = P_LIFNR2.

    LV_BUKRS = P_BUKRS.

  ENDIF.



  " ## #### ##### ##.

  SELECT SINGLE * FROM ZEDT06_LFB1 INTO LV_LFB1_DB

    WHERE LIFNR = LV_LIFNR

    AND BUKRS = LV_BUKRS.



  IF LV_LFB1_DB IS INITIAL.

    MESSAGE '#### ## ###(##)###. ## ######.' TYPE 'E'.

  ENDIF.



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



  CREATE OBJECT GC_GRID

    EXPORTING

      I_PARENT          = GC_DOCKING.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_FIELDCAT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_FIELDCAT .



  " ####

  CLEAR : GS_FIELDCAT,GT_FIELDCAT.

  GS_FIELDCAT-COL_POS     = 1.

  GS_FIELDCAT-FIELDNAME = 'SEL'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-CHECKBOX = 'X'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " ## -> ####.

  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS     = 2.

 GS_FIELDCAT-FIELDNAME = 'EBELP'.

 GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " ####

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS     = 3.

  GS_FIELDCAT-FIELDNAME = 'MATNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-EDIT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " ###

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS     = 4.

  GS_FIELDCAT-FIELDNAME = 'MAKTX'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " PO ##

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS     = 5.

  GS_FIELDCAT-FIELDNAME = 'MENGE'.

  GS_FIELDCAT-SCRTEXT_M = 'PO##'.

  GS_FIELDCAT-QFIELDNAME  = 'MEINS'.

  GS_FIELDCAT-REF_TABLE   = 'ZEDT06_EKPO'.

  GS_FIELDCAT-REF_FIELD   = 'MENGE'.

  GS_FIELDCAT-EDIT        = 'X'.

  GS_FIELDCAT-OUTPUTLEN = 15.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " ##

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS     = 6.

  GS_FIELDCAT-FIELDNAME = 'BPRME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " ##

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS     = 7.

  GS_FIELDCAT-FIELDNAME   = 'MEINS'.

  GS_FIELDCAT-SCRTEXT_M   = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " ##

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS     = 8.

  GS_FIELDCAT-FIELDNAME = 'WAERS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " ####

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS     = 9.

  GS_FIELDCAT-FIELDNAME   = 'MWSKZ'.

  GS_FIELDCAT-SCRTEXT_M   = '####'.

  GS_FIELDCAT-REF_TABLE   = 'ZEDT06_LFM1'.

  GS_FIELDCAT-REF_FIELD   = 'MWSKZ'.

  GS_FIELDCAT-OUTPUTLEN   = 8.

  GS_FIELDCAT-EDIT        = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " ###

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS     = 10.

  GS_FIELDCAT-FIELDNAME   = 'PRDAT'.

  GS_FIELDCAT-COLTEXT     = '###'.

  GS_FIELDCAT-REF_TABLE   = 'ZEDT06_EKPO'.

  GS_FIELDCAT-REF_FIELD   = 'PRDAT'.

  GS_FIELDCAT-OUTPUTLEN   = 12.

  GS_FIELDCAT-EDIT        = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " ###

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS     = 11.

  GS_FIELDCAT-FIELDNAME = 'WERKS'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  GS_FIELDCAT-REF_TABLE   = 'ZEDT06_EKPO'.

  GS_FIELDCAT-REF_FIELD   = 'WERKS'.

  GS_FIELDCAT-EDIT        = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " ####

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS     = 12.

  GS_FIELDCAT-FIELDNAME = 'LGORT'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-REF_TABLE   = 'ZEDT06_EKPO'.

  GS_FIELDCAT-REF_FIELD   = 'LGORT'.

  GS_FIELDCAT-EDIT        = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



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

  GS_LAYOUT-ZEBRA = 'X'.



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

  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING




*      I_BUFFER_ACTIVE               =

*      I_BYPASSING_BUFFER            =

*      I_CONSISTENCY_CHECK           =

*      I_STRUCTURE_NAME              =

*      IS_VARIANT                    =

*      I_SAVE                        =

*      I_DEFAULT                     = 'X'




      IS_LAYOUT                     = GS_LAYOUT




*      IS_PRINT                      =

*      IT_SPECIAL_GROUPS             =

*      IT_TOOLBAR_EXCLUDING          =

*      IT_HYPERLINK                  =

*      IT_ALV_GRAPHICS               =

*      IT_EXCEPT_QINFO               =

*      IR_SALV_ADAPTER               =




    CHANGING

      IT_OUTTAB                     = GT_PO_ALV

      IT_FIELDCATALOG               = GT_FIELDCAT




*      IT_SORT                       =

*      IT_FILTER                     =

*    EXCEPTIONS

*      INVALID_PARAMETER_COMBINATION = 1

*      PROGRAM_ERROR                 = 2

*      TOO_MANY_LINES                = 3

*      others                        = 4




          .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.





ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  REFRESH

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM REFRESH .



  DATA : LS_STABLE TYPE LVC_S_STBL.



  CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY

    EXPORTING

      IS_STABLE      = LS_STABLE




*      I_SOFT_REFRESH =

*    EXCEPTIONS

*      FINISHED       = 1

*      others         = 2




          .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.





ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CLASS_EVENT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CLASS_EVENT .



  CREATE OBJECT GO_EVENT.



  SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED FOR GC_GRID.







CALL METHOD GC_GRID->REGISTER_EDIT_EVENT

  EXPORTING

    I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED.



ENDFORM.