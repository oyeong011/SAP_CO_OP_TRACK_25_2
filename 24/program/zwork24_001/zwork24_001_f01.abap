
*&---------------------------------------------------------------------*

*&  Include           ZWORK24_001_F01

*&---------------------------------------------------------------------*





*&---------------------------------------------------------------------*

*&      Form  SET_INIT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_INIT .

  S_KURST-LOW = 'M'.

  S_KURST-OPTION = 'EQ'.

  S_KURST-SIGN = 'I'.

  APPEND S_KURST.

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

      REPID = SY-REPID

      DYNNR = SY-DYNNR

      EXTENSION = 2000

      NAME = '## ###'.



  IF SY-SUBRC <> 0.

  ENDIF.



  CREATE OBJECT GC_GRID

    EXPORTING

      I_PARENT = GC_DOCKING.



  IF SY-SUBRC <> 0.

  ENDIF.

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

  CLEAR : GS_FC, GT_FC.



  GS_FC-COL_POS = 1.

  GS_FC-FIELDNAME = 'KURST'.

  GS_FC-COLTEXT = '####'.

  APPEND GS_FC TO GT_FC.



  CLEAR GS_FC.

  GS_FC-COL_POS = 2.

  GS_FC-FIELDNAME = 'FCURR'.

  GS_FC-COLTEXT = '####'.

  APPEND GS_FC TO GT_FC.



  CLEAR GS_FC.

  GS_FC-COL_POS = 3.

  GS_FC-FIELDNAME = 'TCURR'.

  GS_FC-COLTEXT = '####'.

  APPEND GS_FC TO GT_FC.



  CLEAR GS_FC.

  GS_FC-COL_POS = 4.

  GS_FC-FIELDNAME = 'GDATU'.

  GS_FC-COLTEXT = '####'.

  APPEND GS_FC TO GT_FC.



  CLEAR GS_FC.

  GS_FC-COL_POS = 5.

  GS_FC-FIELDNAME = 'UKURS'.

  GS_FC-COLTEXT = '##'.

  GS_FC-OUTPUTLEN = 12.

  GS_FC-EDIT = 'X'.

  GS_FC-DECIMALS = 5.

  APPEND GS_FC TO GT_FC.



  CLEAR GS_FC.

  GS_FC-COL_POS = 6.

  GS_FC-FIELDNAME = 'FFACT'.

  GS_FC-COLTEXT = '########'.

  APPEND GS_FC TO GT_FC.



  CLEAR GS_FC.

  GS_FC-COL_POS = 7.

  GS_FC-FIELDNAME = 'TFACT'.

  GS_FC-COLTEXT = '########'.

  APPEND GS_FC TO GT_FC.



  CLEAR GS_FC.

  GS_FC-COL_POS = 8.

  GS_FC-FIELDNAME = 'WRITER'.

  GS_FC-COLTEXT = '###'.

  GS_FC-OUTPUTLEN = 8.

  APPEND GS_FC TO GT_FC.



  CLEAR GS_FC.

  GS_FC-COL_POS = 7.

  GS_FC-FIELDNAME = 'EDATE'.

  GS_FC-COLTEXT = '###'.

  GS_FC-OUTPUTLEN = 10.

  APPEND GS_FC TO GT_FC.

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

  "## ###

  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    CHANGING

      IT_OUTTAB = GT_OUTPUT

      IT_FIELDCATALOG = GT_FC.



  IF SY-SUBRC <> 0.

  ENDIF.

ENDFORM.








*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_DATA .

  CLEAR : GS_EXCEL, GS_OUTPUT.



  "### ## ### ##

  LOOP AT GT_EXCEL INTO GS_EXCEL.

    "M# ## ## #### ##

    IF GS_EXCEL-KURST <> 'M'.

      CONTINUE.

    ENDIF.



    MOVE-CORRESPONDING GS_EXCEL TO GS_OUTPUT.



    GS_OUTPUT-WRITER = SY-UNAME.

    GS_OUTPUT-EDATE = SY-DATUM.



    APPEND GS_OUTPUT TO GT_OUTPUT.



    CLEAR : GS_EXCEL, GS_OUTPUT.

  ENDLOOP.

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



  "### ### #

  LS_STABLE-ROW = 'X'.

  LS_STABLE-COL = 'X'.



  "## ##

  CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY

    EXPORTING

      IS_STABLE = LS_STABLE.



  IF SY-SUBRC <> 0.

  ENDIF.

ENDFORM.








*&---------------------------------------------------------------------*

*&      Form  SCREEN_INIT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SCREEN_INIT .

  DATA : LS_FUNCTEXT TYPE SMP_DYNTXT. "SMP_DYNTXT #####



  LS_FUNCTEXT-ICON_ID = ICON_EXPORT.

  LS_FUNCTEXT-ICON_TEXT = '### ####'.

  SSCRFIELDS-FUNCTXT_01 = LS_FUNCTEXT.

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

  "### ### ##

  CREATE OBJECT GO_EVENT.



  CALL METHOD GC_GRID->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED.



  SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED FOR GC_GRID.

  SET HANDLER GO_EVENT->HANDLER_DATA_CHANGED_FINISHED FOR GC_GRID.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLER_DATA_CHANGED

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_ER_DATA_CHANGED  text

*      -->P_E_ONF4  text

*      -->P_E_ONF4_BEFORE  text

*      -->P_E_ONF4_AFTER  text

*      -->P_E_UCOMM  text

*----------------------------------------------------------------------*




FORM ALV_HANDLER_DATA_CHANGED  USING    P_DATA_CHANGED TYPE REF TO CL_ALV_CHANGED_DATA_PROTOCOL

                                        P_ONF4

                                        P_ONF4_BEFORE

                                        P_ONF4_AFTER

                                        P_UCOMM.

  DATA : LS_MODI TYPE LVC_S_MODI.

  DATA : LV_LEN(02).

  DATA : LV_RATE_API TYPE DECFLOAT16, "## ## ###

         LV_RATE_ADJ TYPE DECFLOAT16, "## ##

         LV_RATE_CHAR TYPE CHAR20. "####



  DATA : LS_TEMP TYPE P DECIMALS 5 LENGTH 9.



  LOOP AT P_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MODI.

    IF LS_MODI-FIELDNAME = 'UKURS'.

      READ TABLE GT_OUTPUT INTO GS_OUTPUT INDEX LS_MODI-ROW_ID.

      "CHECK THE CHANGED VALUE

      GS_OUTPUT-WRITER = SY-UNAME.

      GS_OUTPUT-EDATE = SY-DATUM.

      GS_OUTPUT-UKURS = LS_MODI-VALUE.



      REPLACE ALL OCCURRENCES OF ',' IN LS_MODI-VALUE WITH ''.

      LS_TEMP = LS_MODI-VALUE.

      GS_OUTPUT-UKURS = LS_TEMP.






*      "## ### #### ## ## (JPY, VND)

*      IF GS_OUTPUT-FCURR = 'JPY' OR GS_OUTPUT-FCURR = 'VND'.

*        BREAK-POINT.

*        LV_RATE_API = GS_OUTPUT-UKURS.

*        LV_RATE_ADJ = LV_RATE_API * 100. "100JPY# ##

*

*        "#### ## ## # UKURS# ##

*        WRITE LV_RATE_ADJ TO LV_RATE_CHAR DECIMALS 5.

*        GS_OUTPUT-UKURS = LV_RATE_CHAR.

*      ENDIF.






      MODIFY GT_OUTPUT FROM GS_OUTPUT INDEX LS_MODI-ROW_ID.







    ENDIF.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DATA_CHANGED_FINISHED

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_E_MODIFIED  text

*      -->P_ET_GOOD_CELLS  text

*----------------------------------------------------------------------*




FORM ALV_DATA_CHANGED_FINISHED  USING    P_MODIFIED

                                         PT_GOOD_CELLS TYPE LVC_T_MODI..

  DATA : LS_MODI TYPE LVC_S_MODI.



  CLEAR LS_MODI.



  LOOP AT PT_GOOD_CELLS INTO LS_MODI.

    IF LS_MODI-FIELDNAME = 'UKURS'.

      READ TABLE GT_OUTPUT INTO GS_OUTPUT INDEX LS_MODI-ROW_ID.



      CLEAR GS_OUTPUT.

    ENDIF.

  ENDLOOP.



  PERFORM REFRESH.

  PERFORM UPDATE_DATA.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  UPDATE_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM UPDATE_DATA .

  DATA : LS_LINE TYPE ZTCURR24. "## ### #### ######

  CLEAR GS_OUTPUT.



  LOOP AT GT_OUTPUT INTO GS_OUTPUT.

    MOVE-CORRESPONDING GS_OUTPUT TO LS_LINE.



    MODIFY ZTCURR24 FROM LS_LINE.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SAVE_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SAVE_DATA .

  DATA : LV_ANSWER TYPE C.



  CALL FUNCTION 'POPUP_TO_CONFIRM'

    EXPORTING

      TITLEBAR = ' '

      TEXT_QUESTION = '########?'

      TEXT_BUTTON_1 = 'YES'(001)

      TEXT_BUTTON_2 = 'NO'(002)

      DEFAULT_BUTTON = '1'

      DISPLAY_CANCEL_BUTTON = ' '

    IMPORTING

      ANSWER = LV_ANSWER.



  CASE LV_ANSWER.

    WHEN '1'.

      PERFORM UPDATE_DATA.

      MESSAGE '#######.' TYPE 'I'.

    WHEN '2'.

      MESSAGE '#######.' TYPE 'I'.

  ENDCASE.



ENDFORM.