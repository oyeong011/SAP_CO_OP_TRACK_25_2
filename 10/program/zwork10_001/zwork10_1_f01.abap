
*&---------------------------------------------------------------------*

*&  Include           ZWORK10_1_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  PRESS_FUNCTION_KEY

*&---------------------------------------------------------------------*

*       ## ####

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FUNCTION_KEY .

  CASE SSCRFIELDS-UCOMM.

    WHEN 'ONLI'.

      " EXCUTE ## ### ###.

      EXIT.

    WHEN 'FC01'. " function key 1 ###

      " ##. ## ####

      DATA: LV_TEMPLATE_FILE_NAME TYPE STRING,

            LV_TEMPLATE_FULL_PATH TYPE STRING,

            LV_TEMPLATE_PATH      TYPE STRING,

            LS_WWWDATA            TYPE WWWDATATAB,

            " DOWNLOAD_WEB_OBJECT ### ## # ##.

            LS_DESTINATION        LIKE RLGRAP-FILENAME.



      LV_TEMPLATE_FILE_NAME = C_TEMPLATE_FILE_NAME.



      LV_TEMPLATE_PATH = C_TEMPLATE_PATH.

      " FILE ### #### #

      " ###. https://playabap.tistory.com/43

      CALL METHOD CL_GUI_FRONTEND_SERVICES=>FILE_SAVE_DIALOG

        EXPORTING




*         WINDOW_TITLE      =

*         DEFAULT_EXTENSION = C_TEMPLATE_FILE_EXT




          DEFAULT_FILE_NAME = C_TEMPLATE_FILE_NAME




*         WITH_ENCODING     =

*         FILE_FILTER       =

*         INITIAL_DIRECTORY =

*         PROMPT_ON_OVERWRITE       = 'X'




        CHANGING

          FILENAME          = LV_TEMPLATE_FILE_NAME

          PATH              = LV_TEMPLATE_PATH

          FULLPATH          = LV_TEMPLATE_FULL_PATH




*         USER_ACTION       =

*         FILE_ENCODING     =

*  EXCEPTIONS

*         CNTL_ERROR        = 1

*         ERROR_NO_GUI      = 2

*         NOT_SUPPORTED_BY_GUI      = 3

*         INVALID_DEFAULT_FILE_NAME = 4

*         OTHERS            = 5




        .

      IF SY-SUBRC <> 0.




* Implement suitable error handling here




        MESSAGE '### #### ## ##' TYPE 'E'.

      ELSE.

        " ##### ######.

        " #### ##.



        " SMW0## #### ## ##

        " ### ## https://m.blog.naver.com/softwon1/222067508170

        " #### ## https://applemango2021.tistory.com/37



        SELECT SINGLE * INTO CORRESPONDING FIELDS OF LS_WWWDATA

           FROM WWWDATA

           WHERE OBJID = C_TEMPLATE_ID.



        " ## ## ###

        LS_DESTINATION = LV_TEMPLATE_FULL_PATH.



        CALL FUNCTION 'DOWNLOAD_WEB_OBJECT'

          EXPORTING

            KEY         = LS_WWWDATA

            DESTINATION = LS_DESTINATION




*         IMPORTING

*           RC          =

*         CHANGING

*           TEMP        =




          .

      ENDIF.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  INIT_DATA

*&---------------------------------------------------------------------*



*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM INIT_DATA .




* ## ### ### ###




  DATA: LT_FILE_TABLE TYPE FILETABLE,

        LS_FILE       LIKE LINE OF LT_FILE_TABLE,

        LV_RC         TYPE I.






* ## ## # ## (## ##)




  CALL METHOD CL_GUI_FRONTEND_SERVICES=>FILE_OPEN_DIALOG

    EXPORTING

      WINDOW_TITLE      = '## ### #####'

      DEFAULT_EXTENSION = '*.xlsx'

      INITIAL_DIRECTORY = 'C:\temp\'

    CHANGING

      FILE_TABLE        = LT_FILE_TABLE

      RC                = LV_RC

    EXCEPTIONS

      OTHERS            = 1. " #### ##

  IF SY-SUBRC = 0 AND LV_RC = 1.

    READ TABLE LT_FILE_TABLE INTO LS_FILE INDEX 1.

    IF SY-SUBRC = 0.

      P_FILE = LS_FILE-FILENAME.

    ENDIF.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  PARSE_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM PARSE_DATA.

  " ##### TABLE CLEAR

  CLEAR GT_EXCEL_DATA.



  DATA: LT_EXCEL_DATA TYPE TABLE OF ALSMEX_TABLINE WITH HEADER LINE.

  " https://m.blog.naver.com/howwithus/221604188404

  CALL FUNCTION 'ALSM_EXCEL_TO_INTERNAL_TABLE'

    EXPORTING

      FILENAME    = P_FILE " EXCEL # ## ##

      I_BEGIN_COL = 1  " ## ###

      I_BEGIN_ROW = 2  " ## # ##, 1## HEADER

      I_END_COL   = 7    " ## ##

      I_END_ROW   = 65000 " ## # ##

    TABLES

      INTERN      = LT_EXCEL_DATA

    EXCEPTIONS

      OTHERS      = 1.



  IF SY-SUBRC NE 0 OR LT_EXCEL_DATA[] IS INITIAL.

    MESSAGE '### ### ####' TYPE 'E'.

  ENDIF.



  " ## #### #### ###

  LOOP AT LT_EXCEL_DATA INTO DATA(LS_EXCEL_DATA).

    " GS_EXCEL_DATA# COL# ## COL# #### ### # ##

    ASSIGN COMPONENT LS_EXCEL_DATA-COL OF STRUCTURE GS_EXCEL_DATA TO FIELD-SYMBOL(<FS>).



    IF SY-SUBRC EQ 0.

      <FS> = LS_EXCEL_DATA-VALUE.

    ENDIF.



    AT END OF ROW.

      " ### ## ##

      GS_EXCEL_DATA-KURST = C_KURST.

      " ### ##### ## ##

      GS_EXCEL_DATA-ERNAM = SY-UNAME.

      GS_EXCEL_DATA-ERDAT = SY-DATUM.

      " #### ## ##. GDATU ### ## ######.

      CALL FUNCTION 'CONVERSION_EXIT_INVDT_INPUT'

        EXPORTING

          INPUT  = P_DATE

        IMPORTING

          OUTPUT = GS_EXCEL_DATA-GDATU.

      APPEND GS_EXCEL_DATA TO GT_EXCEL_DATA.

      CLEAR GS_EXCEL_DATA.

    ENDAT.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJ

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CREATE_OBJ .

  CREATE OBJECT GC_DOCKING

    EXPORTING




*     PARENT    =




      REPID     = SY-REPID

      DYNNR     = SY-DYNNR




*     SIDE      = DOCK_AT_LEFT




      EXTENSION = 500000




*     STYLE     =

*     LIFETIME  = lifetime_default

*     CAPTION   =

*     METRIC    = 0

*     RATIO     =

*     NO_AUTODEF_PROGID_DYNNR     =

*     NAME      =

*    EXCEPTIONS

*     CNTL_ERROR                  = 1

*     CNTL_SYSTEM_ERROR           = 2

*     CREATE_ERROR                = 3

*     LIFETIME_ERROR              = 4

*     LIFETIME_DYNPRO_DYNPRO_LINK = 5

*     OTHERS    = 6




    .

  IF SY-SUBRC <> 0.




*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.



  CREATE OBJECT GC_GRID

    EXPORTING




*     I_SHELLSTYLE      = 0

*     I_LIFETIME        =




      I_PARENT = GC_DOCKING




*     I_APPL_EVENTS     = space

*     I_PARENTDBG       =

*     I_APPLOGPARENT    =

*     I_GRAPHICSPARENT  =

*     I_NAME   =

*     I_FCAT_COMPLETE   = SPACE

*    EXCEPTIONS

*     ERROR_CNTL_CREATE = 1

*     ERROR_CNTL_INIT   = 2

*     ERROR_CNTL_LINK   = 3

*     ERROR_DP_CREATE   = 4

*     OTHERS   = 5




    .

  IF SY-SUBRC <> 0.




*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FCAT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FCAT .

  CLEAR: GT_FCAT.

  CLEAR: GS_FCAT.

  GS_FCAT-COL_POS = 1.

  GS_FCAT-FIELDNAME = 'KURST'.

  GS_FCAT-COLTEXT = '## ##'.

  APPEND GS_FCAT TO GT_FCAT.



  CLEAR GS_FCAT.

  GS_FCAT-COL_POS = 2.

  GS_FCAT-FIELDNAME = 'FCURR'.

  GS_FCAT-COLTEXT = '## ##'.

  APPEND GS_FCAT TO GT_FCAT.



  CLEAR GS_FCAT.

  GS_FCAT-COL_POS = 3.

  GS_FCAT-FIELDNAME = 'TCURR'.

  GS_FCAT-COLTEXT = '## ##'.

  APPEND GS_FCAT TO GT_FCAT.



  CLEAR GS_FCAT.

  GS_FCAT-COL_POS = 4.

  GS_FCAT-FIELDNAME = 'GDATU'.

  GS_FCAT-COLTEXT = '## ## ###'.

  GS_FCAT-REF_TABLE = 'ZTCURR10'.

  GS_FCAT-REF_FIELD = 'GDATU'.

  APPEND GS_FCAT TO GT_FCAT.



  CLEAR GS_FCAT.

  GS_FCAT-COL_POS = 5.

  GS_FCAT-FIELDNAME = 'UKURS'.

  GS_FCAT-COLTEXT = '##'.

  GS_FCAT-EDIT = 'X'.

  GS_FCAT-DECIMALS_O = 5.

  GS_FCAT-DECIMALS = 5.

  APPEND GS_FCAT TO GT_FCAT.



  CLEAR GS_FCAT.

  GS_FCAT-COL_POS = 6.

  GS_FCAT-FIELDNAME = 'FFACT'.

  GS_FCAT-COLTEXT = '## ## ### ##'.

  APPEND GS_FCAT TO GT_FCAT.



  CLEAR GS_FCAT.

  GS_FCAT-COL_POS = 7.

  GS_FCAT-FIELDNAME = 'TFACT'.

  GS_FCAT-COLTEXT = '## ## ### ##'.

  APPEND GS_FCAT TO GT_FCAT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_ALV

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_ALV .

  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING




*     I_BUFFER_ACTIVE =

*     I_BYPASSING_BUFFER            =

*     I_CONSISTENCY_CHECK           =

*     I_STRUCTURE_NAME              =

*     IS_VARIANT      =

*     I_SAVE          =

*     I_DEFAULT       = 'X'




      IS_LAYOUT       = GS_LAYO




*     IS_PRINT        =

*     IT_SPECIAL_GROUPS             =

*     IT_TOOLBAR_EXCLUDING          =

*     IT_HYPERLINK    =

*     IT_ALV_GRAPHICS =

*     IT_EXCEPT_QINFO =

*     IR_SALV_ADAPTER =




    CHANGING

      IT_OUTTAB       = GT_EXCEL_DATA

      IT_FIELDCATALOG = GT_FCAT




*     IT_SORT         =

*     IT_FILTER       =

*    EXCEPTIONS

*     INVALID_PARAMETER_COMBINATION = 1

*     PROGRAM_ERROR   = 2

*     TOO_MANY_LINES  = 3

*     OTHERS          = 4




    .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SORT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SORT .

  CLEAR: GT_SORT, GS_SORT.



  GS_SORT-FIELDNAME = 'GDATU'.

  GS_SORT-UP = 'X'.

  APPEND GS_SORT TO GT_SORT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  LAYO

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM LAYO .

  CLEAR GS_LAYO.

  GS_LAYO-ZEBRA = 'X'.



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

  DATA: LS_STABLE TYPE LVC_S_STBL.



  LS_STABLE-ROW = 'X'.

  LS_STABLE-COL = 'X'.



  CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY

    EXPORTING

      IS_STABLE = LS_STABLE




*     I_SOFT_REFRESH =

*    EXCEPTIONS

*     FINISHED  = 1

*     OTHERS    = 2




    .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SAVE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SAVE .

  DATA: LT_SAVE TYPE TABLE OF ZTCURR10.

  MOVE-CORRESPONDING GT_EXCEL_DATA TO LT_SAVE.

  MODIFY ZTCURR10 FROM TABLE LT_SAVE.

ENDFORM.