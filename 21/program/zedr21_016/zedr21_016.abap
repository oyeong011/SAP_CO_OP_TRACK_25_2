
REPORT ZEDR21_016.






*TABLES : ZEDT21_001.



*DATA : GT_STUDENT TYPE TABLE OF ZEDT21_001,

*       GS_STUDENT TYPE ZEDT21_001.



*SELECT-OPTIONS: S_ZCODE FOR ZEDT21_001-ZPERNR21 MODIF ID SC1.

*

*INITIALIZATION.

*  S_ZCODE-LOW  = 'SSU-90'.

*  S_ZCODE-HIGH = 'SSU-99'.

*  APPEND S_ZCODE.

*

*AT SELECTION-SCREEN OUTPUT.

*  LOOP AT SCREEN.

*    IF SCREEN-GROUP1 = 'SC1'.

*      SCREEN-INPUT = 0.

*      MODIFY SCREEN.

*    ENDIF.

*  ENDLOOP.

*

*START-OF-SELECTION.

*  PERFORM GET_DATA.

*  PERFORM MODIFY_DATA.

*

*END-OF-SELECTION.

*  PERFORM ALV_DISPLAY.

*

*"--------------------------



*FORM GET_DATA.

*  CLEAR GT_STUDENT.

*  REFRESH GT_STUDENT.

*

*  SELECT * FROM ZEDT21_001

*    INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT

*    WHERE ZPERNR21 IN S_ZCODE.

*ENDFORM.



*FORM MODIFY_DATA.

*  LOOP AT GT_STUDENT INTO GS_STUDENT.

*    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'

*      EXPORTING

*        INPUT  = GS_STUDENT-ZPERNR21

*      IMPORTING

*        OUTPUT = GS_STUDENT-ZPERNR21.

*    MODIFY GT_STUDENT FROM GS_STUDENT INDEX SY-TABIX.

*  ENDLOOP.

*ENDFORM.





*FORM ALV_DISPLAY.

*  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY' "REUSE_ALV_GRID_DISPLAY -> #### ##, "REUSE_ALV_LIST_DISPLAY ->  ##### ## #### #### ##

*    EXPORTING

*      I_STRUCTURE_NAME   = 'ZEDT21_001'

*    TABLES

*      T_OUTTAB           = GT_STUDENT

*    EXCEPTIONS

*      PROGRAM_ERROR      = 1

*      OTHERS             = 2.

*  IF SY-SUBRC <> 0.

*    WRITE: / 'ALV ## # ## ##.'.

*  ENDIF.

*ENDFORM.



*&---------------------------------------------------------------------*

*& Report ZEDR21_016

*&---------------------------------------------------------------------*

*& ## : ZEDT21_001 ### #### ALV# ## (## #### ## ##)

*&---------------------------------------------------------------------*










"==================================================

" ## ## ##

"==================================================




*TABLES : ZEDT21_001.

*DATA : GS_STUDENT  TYPE ZEDT21_001,

*       GT_STUDENT  LIKE TABLE OF GS_STUDENT.

*

*DATA : GS_FIELDCAT TYPE SLIS_FIELDCAT_ALV,

*       GT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV.

*

*"==================================================

*" ## ##

*"==================================================

*SELECT-OPTIONS : S_ZCODE FOR ZEDT21_001-ZPERNR21 MODIF ID SC1.

*

*INITIALIZATION.

*  S_ZCODE-LOW  = 'SSU-90'.

*  S_ZCODE-HIGH = 'SSU-99'.

*  APPEND S_ZCODE.

*

*AT SELECTION-SCREEN OUTPUT.

*  LOOP AT SCREEN.

*    IF SCREEN-GROUP1 = 'SC1'.

*      SCREEN-INPUT = 0.

*      MODIFY SCREEN.

*    ENDIF.

*  ENDLOOP.

*

*"==================================================

*" ## ## ##

*"==================================================

*START-OF-SELECTION.

*  PERFORM GET_DATA.

*  PERFORM MODIFY_DATA.

*

*END-OF-SELECTION.

*  PERFORM ALV_DISPLAY.

*

*"==================================================

*" ### ##

*"==================================================

*FORM GET_DATA.

*  CLEAR GT_STUDENT.

*  REFRESH GT_STUDENT.

*

*  SELECT * FROM ZEDT21_001

*    INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT

*    WHERE ZPERNR21 IN S_ZCODE.

*ENDFORM.

*

*"==================================================

*" ### ## (ALPHA ##)

*"==================================================

*FORM MODIFY_DATA.

*  LOOP AT GT_STUDENT INTO GS_STUDENT.

*    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'

*      EXPORTING

*        INPUT  = GS_STUDENT-ZPERNR21

*      IMPORTING

*        OUTPUT = GS_STUDENT-ZPERNR21.

*    MODIFY GT_STUDENT FROM GS_STUDENT INDEX SY-TABIX.

*  ENDLOOP.

*ENDFORM.

*

*"==================================================

*" ALV ##

*"==================================================

*FORM ALV_DISPLAY.

*  PERFORM FIELD_CATALOG.   " ## #### ##

*  PERFORM CALL_ALV.        " ALV ## ##

*ENDFORM.

*

*"==================================================

*" ## #### ##

*"==================================================

*FORM FIELD_CATALOG.

*  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

*

*

*

*

*  " 1. ####

*  GS_FIELDCAT-COL_POS   = 2.

*  GS_FIELDCAT-FIELDNAME = 'ZCODE21'.

*  GS_FIELDCAT-SELTEXT_M = '####'.

*  APPEND GS_FIELDCAT TO GT_FIELDCAT.

*

*  " 2.####

*  GS_FIELDCAT-COL_POS   = 1.

*  GS_FIELDCAT-FIELDNAME = 'ZPERNR21'.

*  GS_FIELDCAT-SELTEXT_M = '####'.

*  APPEND GS_FIELDCAT TO GT_FIELDCAT.

*

*  " 3. ##

*  CLEAR GS_FIELDCAT.

*  GS_FIELDCAT-COL_POS   = 3.

*  GS_FIELDCAT-FIELDNAME = 'ZKNAME21'.

*  GS_FIELDCAT-SELTEXT_M = '##'.

*  APPEND GS_FIELDCAT TO GT_FIELDCAT.

*

*

*ENDFORM.

*

*"==================================================

*" ALV ## ## ##

*"==================================================

*FORM CALL_ALV.

*  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

*    EXPORTING

*      I_CALLBACK_PROGRAM = SY-REPID

*      IT_FIELDCAT        = GT_FIELDCAT

*    TABLES

*      T_OUTTAB           = GT_STUDENT

*    EXCEPTIONS

*      PROGRAM_ERROR      = 1

*      OTHERS             = 2.

*

*  IF SY-SUBRC <> 0.

*    WRITE :/ 'ALV ## # ## ##.'.

*  ENDIF.

*ENDFORM.



*&---------------------------------------------------------------------*

*& Report ZEDR21_017

*&---------------------------------------------------------------------*

*& ## : ZEDT21_002 ### #### ALV# ## (## #### ## ##)

*&---------------------------------------------------------------------*








"=========================================================

" ### ##

"=========================================================

TABLES : ZEDT21_002.



"=========================================================

" ### ##

"=========================================================

DATA : GS_STUDENT  TYPE ZEDT21_002,

       GT_STUDENT  LIKE TABLE OF GS_STUDENT.



" ## ##### ##

DATA : GS_FIELDCAT TYPE SLIS_FIELDCAT_ALV,

       GT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV.



"=========================================================

" ## ## # ## ##

"=========================================================

SELECT-OPTIONS : S_ZCODE FOR ZEDT21_002-ZCODE21 MODIF ID SC1.



INITIALIZATION.

  S_ZCODE-LOW  = 'SSU-01'.

  S_ZCODE-HIGH = 'SSU-20'.

  APPEND S_ZCODE.



AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'SC1'.   " #### #### ##

      SCREEN-INPUT = 0.

      MODIFY SCREEN.

    ENDIF.

  ENDLOOP.



"=========================================================

" ## ##

"=========================================================

START-OF-SELECTION.

  PERFORM GET_DATA.

  PERFORM MODIFY_DATA.



END-OF-SELECTION.

  PERFORM ALV_DISPLAY.



"=========================================================

" ### ##

"=========================================================

FORM GET_DATA.

  CLEAR GT_STUDENT.

  REFRESH GT_STUDENT.



  SELECT * FROM ZEDT21_002

    INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT

    WHERE ZCODE21 IN S_ZCODE.

ENDFORM.



"=========================================================

" ### ## (#: ALPHA INPUT #)

"=========================================================

FORM MODIFY_DATA.

  LOOP AT GT_STUDENT INTO GS_STUDENT.

    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'

      EXPORTING

        INPUT  = GS_STUDENT-ZPERNR21

      IMPORTING

        OUTPUT = GS_STUDENT-ZPERNR21.

    MODIFY GT_STUDENT FROM GS_STUDENT INDEX SY-TABIX.

  ENDLOOP.

ENDFORM.



"=========================================================

" ALV ##

"=========================================================

FORM ALV_DISPLAY.

  PERFORM FIELD_CATALOG.   " ## #### ##

  PERFORM CALL_ALV.        " ALV ##

ENDFORM.



"=========================================================

" ## #### ##

"=========================================================

FORM FIELD_CATALOG.



  CLEAR : GS_FIELDCAT, GT_FIELDCAT.



  " 1. ####

  GS_FIELDCAT-COL_POS   = 1.

  GS_FIELDCAT-FIELDNAME = 'ZCODE21'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  GS_FIELDCAT-KEY = 'X'. "### ##### ##

  GS_FIELDCAT-JUST =  'L'. "## ## ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 2. ####

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 2.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR21'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  GS_FIELDCAT-KEY = 'X'. "### ##### ##

  GS_FIELDCAT-JUST =  'C'. "## ## ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 3. ##

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 3.

  GS_FIELDCAT-FIELDNAME = 'ZMAJOR21'.

  GS_FIELDCAT-SELTEXT_M = '##'.

  GS_FIELDCAT-JUST =  'R'. "### ## ##

  GS_FIELDCAT-NO_OUT = 'X'. "## ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 4. ##

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 4.

  GS_FIELDCAT-FIELDNAME = 'ZMNAME21'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 5. ##

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS   = 5.

  GS_FIELDCAT-FIELDNAME = 'ZSUM21'.

  GS_FIELDCAT-SELTEXT_M = '####'.

  GS_FIELDCAT-CURRENCY = 'KRW'. "### ##

  GS_FIELDCAT-DO_SUM = 'X'. "### ##

  GS_FIELDCAT-NO_ZERO = 'X'. "0# ### ##

  GS_FIELDCAT-NO_SIGN = 'X'. "## ## ##

  GS_FIELDCAT-OUTPUTLEN = 20. "### # ##

  GS_FIELDCAT-EMPHASIZE = 'X'. "####

  GS_FIELDCAT-EDIT = 'X'. "####



  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZWAERS21'.

  GS_FIELDCAT-SELTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME  = 'CRDATE'.

  GS_FIELDCAT-SELTEXT_M = '###'.

  GS_FIELDCAT-EDIT = 'X'.

  GS_FIELDCAT-EDIT_MASK = '____-__-___'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.







ENDFORM.



"=========================================================

" ALV GRID DISPLAY ##

"=========================================================

FORM CALL_ALV.



  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

    EXPORTING

      I_CALLBACK_PROGRAM = SY-REPID

      IT_FIELDCAT        = GT_FIELDCAT

      I_SAVE             = 'A'      " ALV Variant ## ##

    TABLES

      T_OUTTAB           = GT_STUDENT

    EXCEPTIONS

      PROGRAM_ERROR      = 1

      OTHERS             = 2.



  IF SY-SUBRC <> 0.

    WRITE :/ 'ALV ## # ## ##.'.

  ENDIF.



ENDFORM.