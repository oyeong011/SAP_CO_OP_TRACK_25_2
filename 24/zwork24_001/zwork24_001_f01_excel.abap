
*&---------------------------------------------------------------------*

*&  Include           ZWORK24_001_F01_EXCEL

*&---------------------------------------------------------------------*



*&---------------------------------------------------------------------*

*&      Form  GET_FILE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      <--P_PA_FILE  text

*----------------------------------------------------------------------*




FORM GET_FILE.

  "EXCEL FILE ###

  CALL FUNCTION 'F4_FILENAME'

    IMPORTING

      FILE_NAME = PA_FILE.

ENDFORM.








*&---------------------------------------------------------------------*

*&      Form  READ_FILE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM READ_FILE .

  DATA : LV_EXT TYPE STRING,

         LT_PARTS TYPE TABLE OF STRING.



  "### ####

  IF PA_DATE IS INITIAL.

    MESSAGE '## ####  ######' TYPE 'E'.

    EXIT.

  ENDIF.



  IF PA_FILE IS INITIAL.

    MESSAGE '## ### ######' TYPE 'E'.

    EXIT.

  ENDIF.



  "####### #### ## ITAB# ##

  PERFORM READ_EXCEL_FILE.



  IF GT_EXCEL IS INITIAL.

    MESSAGE '#### ## #####' TYPE 'E'.

  ENDIF.

ENDFORM.








*&---------------------------------------------------------------------*

*&      Form  READ_CSV_FILE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_PA_FILE  text

*      <--P_GT_FILE_DATA  text

*----------------------------------------------------------------------*




FORM READ_EXCEL_FILE.

  DATA : LT_EXCEL TYPE TABLE OF ALSMEX_TABLINE,

         LS_EXCEL LIKE LINE OF LT_EXCEL.

  FIELD-SYMBOLS <FS> TYPE ANY.



  "####### ### ##

  CALL FUNCTION 'ALSM_EXCEL_TO_INTERNAL_TABLE'

    EXPORTING

      FILENAME = PA_FILE

      I_BEGIN_COL = 1

      I_BEGIN_ROW = 2

      I_END_COL = 7

      I_END_ROW = 65000

    TABLES

      INTERN = LT_EXCEL.



  IF SY-SUBRC <> 0.

    MESSAGE '## ## ##' TYPE 'E'.

  ENDIF.



  "## ### ITAB# ####

  LOOP AT LT_EXCEL INTO LS_EXCEL.

    ASSIGN COMPONENT LS_EXCEL-COL OF STRUCTURE GS_EXCEL TO <FS>.

    <FS> = LS_EXCEL-VALUE.



    AT END OF ROW.

      GS_EXCEL-KURST = 'M'.

      GS_EXCEL-GDATU = PA_DATE.

      APPEND GS_EXCEL TO GT_EXCEL.

      CLEAR GS_EXCEL.

    ENDAT.



  ENDLOOP.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  DOWNLOAD_FILE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM DOWNLOAD_FILE .

  DATA : LV_FILENAME TYPE STRING,

         LV_PATH TYPE STRING,

         LV_FULLPATH TYPE STRING.



  "1. DIALOG # ###

  CALL METHOD CL_GUI_FRONTEND_SERVICES=>FILE_SAVE_DIALOG

    EXPORTING

      DEFAULT_EXTENSION = CL_GUI_FRONTEND_SERVICES=>FILETYPE_EXCEL

      DEFAULT_FILE_NAME = '#####'

      FILE_FILTER = CL_GUI_FRONTEND_SERVICES=>FILETYPE_EXCEL

      INITIAL_DIRECTORY = 'C:'

    CHANGING

      FILENAME = LV_FILENAME

      PATH = LV_PATH

      FULLPATH = LV_FULLPATH.



  IF LV_FULLPATH IS INITIAL.

    RETURN .

  ENDIF.



  "2. ## ##

  DATA : LS_WWWDATA TYPE WWWDATATAB,

         LV_DESTPATH TYPE RLGRAP-FILENAME.



  SELECT SINGLE * FROM WWWDATA

    INTO CORRESPONDING FIELDS OF LS_WWWDATA

    WHERE OBJID = 'ZCURR24_TEMPLATE'.



  IF SY-SUBRC <> 0.

    MESSAGE '#### #### ## ####' TYPE 'E'.

  ENDIF.



  LV_DESTPATH = LV_FULLPATH.



  CALL FUNCTION 'DOWNLOAD_WEB_OBJECT'

    EXPORTING

      KEY = LS_WWWDATA

      DESTINATION = LV_DESTPATH.



  IF SY-SUBRC <> 0.

    MESSAGE '##### ######' TYPE 'E'.

  ENDIF.



ENDFORM.