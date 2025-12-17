
*&---------------------------------------------------------------------*

*&  Include           ZEDR10_PRACTICE008_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  INIT_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_INIT .

  S_ZORDNO-LOW = 1.

  S_ZORDNO-HIGH = 100.

  APPEND S_ZORDNO.



  DATA: LV_TEMP_DAY TYPE D.

  LV_TEMP_DAY = |{ SY-DATUM(6) }01|. " ## ##

  S_ZDDATE-LOW = LV_TEMP_DAY.

  S_ZJDATE-LOW = LV_TEMP_DAY.



  " #### ### ##

  " https://zcoding1.tistory.com/4

  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

    EXPORTING

      DAY_IN            = LV_TEMP_DAY

    IMPORTING

      LAST_DAY_OF_MONTH = LV_TEMP_DAY.



  S_ZDDATE-HIGH = LV_TEMP_DAY.

  S_ZJDATE-HIGH = LV_TEMP_DAY.



  APPEND S_ZDDATE.

  APPEND S_ZJDATE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA .

  RANGES: LR_RET_FG FOR ZEDT10_100-ZRET_FG.

  IF P_RET_F = ''.

    IF P_R_OR_F = 'X'.

      LR_RET_FG-SIGN = 'E'.

      LR_RET_FG-OPTION = 'GT'.

      LR_RET_FG-LOW = ''.

      APPEND LR_RET_FG.

    ELSEIF P_R_DE_F = 'X'.

      LR_RET_FG-SIGN = 'E'.

      LR_RET_FG-OPTION = 'EQ'.

      LR_RET_FG-LOW = 'X'.

      APPEND LR_RET_FG.

    ENDIF.

  ENDIF.



  IF P_R_OR_F = 'X'.

    SELECT * FROM ZEDT10_100 INTO CORRESPONDING FIELDS OF TABLE GT_ORDER

      WHERE ZRET_FG IN LR_RET_FG.

  ELSE.

    SELECT * FROM ZEDT10_101 INTO CORRESPONDING FIELDS OF TABLE GT_DELIVERY

      WHERE ZFLAG IN LR_RET_FG.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIF_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIF_DATA .

  IF P_R_OR_F = 'X'.

    PERFORM MODIF_DATA_WITH_TABLE CHANGING GT_ORDER.

  ELSE.

    PERFORM MODIF_DATA_WITH_TABLE CHANGING GT_DELIVERY.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIF_DATA_WITH_TABLE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      <--P_GT_ORDER  text

*----------------------------------------------------------------------*




FORM MODIF_DATA_WITH_TABLE  CHANGING P_GT TYPE STANDARD TABLE.

  DATA: LV_CHECK_COL TYPE STR.

  DATA: LV_CHECK_DCOL TYPE STR.

  DATA: LV_CHECK_DCOL2 TYPE STR.

  DATA: LV_CHECK_TCOL TYPE STR.

  DATA: LV_CHECK_TCOL2 TYPE STR.

  LV_CHECK_COL = COND #( WHEN P_R_OR_F = 'X' THEN 'ZRET_FG' ELSE 'ZFLAG').

  LV_CHECK_DCOL = COND #( WHEN P_R_OR_F = 'X' THEN 'ZSALE_FG' ELSE 'ZDGUBUN').

  LV_CHECK_DCOL2 = COND #( WHEN P_R_OR_F = 'X' THEN 'ZRET_FG' ELSE 'ZDFLAG').

  LV_CHECK_TCOL = COND #( WHEN P_R_OR_F = 'X' THEN 'ZRETNAME' ELSE 'ZDEL_LOC').

  LV_CHECK_TCOL2 = COND #( WHEN P_R_OR_F = 'X' THEN 'ZSALENAME' ELSE 'ZDFNAME').



  FIELD-SYMBOLS: <FS_FLAG> TYPE C.

  FIELD-SYMBOLS: <LS_ROW> TYPE ANY.

  FIELD-SYMBOLS: <FS_COLOR> TYPE C.

  FIELD-SYMBOLS: <FS_DATA_COL> TYPE ANY.

  FIELD-SYMBOLS: <FS_TARGET_COL> TYPE ANY.



  LOOP AT P_GT ASSIGNING <LS_ROW>.

    ASSIGN COMPONENT LV_CHECK_COL OF STRUCTURE <LS_ROW> TO <FS_FLAG>.

    IF SY-SUBRC <> 0.

      " ## ### ### ## ####

      CONTINUE.

    ENDIF.



    ASSIGN COMPONENT 'ZCOLOR' OF STRUCTURE <LS_ROW> TO <FS_COLOR>.

    IF SY-SUBRC <> 0.

      " ZCOLOR ### ### ## ####

      CONTINUE.

    ENDIF.



    " ### ##

    IF <FS_FLAG> > '0'.

      <FS_COLOR> = '@0A@'.

    ELSE.

      <FS_COLOR> = '@08@'.

    ENDIF.



    " #### ## ##

    ASSIGN COMPONENT 'ZMTART' OF STRUCTURE <LS_ROW> TO <FS_DATA_COL>.

    IF SY-SUBRC <> 0.

      CONTINUE.

    ENDIF.



    ASSIGN COMPONENT 'ZMANTNAME' OF STRUCTURE <LS_ROW> TO <FS_TARGET_COL>.

    IF SY-SUBRC <> 0.

      CONTINUE.

    ENDIF.



    CASE <FS_DATA_COL>.

      WHEN '001'.

        <FS_TARGET_COL> = '##'.

      WHEN '002'.

        <FS_TARGET_COL> = '##'.

      WHEN '003'.

        <FS_TARGET_COL> = '##'.

      WHEN '004'.

        <FS_TARGET_COL> = '##'.

      WHEN '005'.

        <FS_TARGET_COL> = '##'.

      WHEN '006'.

        <FS_TARGET_COL> = '###'.

    ENDCASE.



    " #### ## ## ## ###

    ASSIGN COMPONENT LV_CHECK_DCOL OF STRUCTURE <LS_ROW> TO <FS_DATA_COL>.

    IF SY-SUBRC <> 0.

      CONTINUE.

    ENDIF.



    ASSIGN COMPONENT LV_CHECK_TCOL OF STRUCTURE <LS_ROW> TO <FS_TARGET_COL>.

    IF SY-SUBRC <> 0.

      CONTINUE.

    ENDIF.



    IF P_R_OR_F = 'X'.

      CASE <FS_DATA_COL>.

        WHEN '1'.

          <FS_TARGET_COL> = '####'.

        WHEN '2'.

          <FS_TARGET_COL> = '####'.

        WHEN '3'.

          <FS_TARGET_COL> = '####'.

        WHEN OTHERS.

          <FS_TARGET_COL> = '#### ##'.

      ENDCASE.

    ELSE.

      CASE <FS_DATA_COL>.

        WHEN '1'.

          <FS_TARGET_COL> = '###'.

        WHEN '2'.

          <FS_TARGET_COL> = '###'.

        WHEN '3'.

          <FS_TARGET_COL> = '###'.

        WHEN '4'.

          <FS_TARGET_COL> = '###'.

        WHEN '5'.

          <FS_TARGET_COL> = '###'.

        WHEN '6'.

          <FS_TARGET_COL> = '###'.

        WHEN '7'.

          <FS_TARGET_COL> = '###'.

      ENDCASE.

    ENDIF.



    ASSIGN COMPONENT LV_CHECK_DCOL2 OF STRUCTURE <LS_ROW> TO <FS_DATA_COL>.

    IF SY-SUBRC <> 0.

      CONTINUE.

    ENDIF.



    ASSIGN COMPONENT LV_CHECK_TCOL2 OF STRUCTURE <LS_ROW> TO <FS_TARGET_COL>.

    IF SY-SUBRC <> 0.

      CONTINUE.

    ENDIF.



        IF P_R_OR_F = 'X'.

      CASE <FS_DATA_COL>.

        WHEN '1'.

          <FS_TARGET_COL> = '##'.

        WHEN '2'.

          <FS_TARGET_COL> = '##'.

      ENDCASE.

    ELSE.

      CASE <FS_DATA_COL>.

        WHEN '1'.

          <FS_TARGET_COL> = '####'.

        WHEN '2'.

          <FS_TARGET_COL> = '###'.

        WHEN '3'.

          <FS_TARGET_COL> = '####'.

      ENDCASE.

    ENDIF.

  ENDLOOP.

ENDFORM.

FORM CREATE_OBJ.

  CREATE OBJECT GC_DOCKING

    EXPORTING




*     PARENT    =




      REPID = SY-REPID

      DYNNR = SY-DYNNR




*     SIDE  = DOCK_AT_LEFT

*     EXTENSION = 50

*     STYLE =

*     LIFETIME  = lifetime_default

*     CAPTION   =

*     METRIC    = 0

*     RATIO =

*     NO_AUTODEF_PROGID_DYNNR     =

*     NAME  =

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

FORM FIELD_CAT.

  CLEAR GT_FCAT.



  CLEAR GS_FCAT.

  GS_FCAT-COL_POS = 0.

  GS_FCAT-FIELDNAME = 'ZCOLOR'.

  GS_FCAT-SELTEXT = '##'.

  GS_FCAT-COLTEXT = '##'.

  GS_FCAT-ICON = 'X'.

  APPEND GS_FCAT TO GT_FCAT.



  CLEAR GS_FCAT.

  GS_FCAT-COL_POS = 1.

  GS_FCAT-FIELDNAME = 'ZORDNO'.

  GS_FCAT-SELTEXT = '####'.

  GS_FCAT-COLTEXT = '####'.

  GS_FCAT-KEY = 'X'.

  APPEND GS_FCAT TO GT_FCAT.





  CLEAR GS_FCAT.

  GS_FCAT-COL_POS = 2.

  GS_FCAT-FIELDNAME = 'ZIDCODE'.

  GS_FCAT-SELTEXT = '##ID'.

  GS_FCAT-COLTEXT = '##ID'.

  APPEND GS_FCAT TO GT_FCAT.



  CLEAR GS_FCAT.

  GS_FCAT-COL_POS = 3.

  GS_FCAT-FIELDNAME = 'ZMATNR'.

  GS_FCAT-SELTEXT = '####'.

  GS_FCAT-COLTEXT = '####'.

  APPEND GS_FCAT TO GT_FCAT.



  CLEAR GS_FCAT.

  GS_FCAT-COL_POS = 4.

  GS_FCAT-FIELDNAME = 'ZMATNAME'.

  GS_FCAT-SELTEXT = '###'.

  GS_FCAT-COLTEXT = '###'.

  APPEND GS_FCAT TO GT_FCAT.



  CLEAR GS_FCAT.

  GS_FCAT-COL_POS = 5.

  GS_FCAT-FIELDNAME = 'ZMANTNAME'.

  GS_FCAT-SELTEXT = '####'.

  GS_FCAT-COLTEXT = '####'.

  APPEND GS_FCAT TO GT_FCAT.



  CLEAR GS_FCAT.

  GS_FCAT-COL_POS = 6.

  GS_FCAT-FIELDNAME = 'ZVOLUM'.

  GS_FCAT-SELTEXT = '##'.

  GS_FCAT-COLTEXT = '##'.

  GS_FCAT-DO_SUM = 'X'.

  APPEND GS_FCAT TO GT_FCAT.



  CLEAR GS_FCAT.

  GS_FCAT-COL_POS = 7.

  GS_FCAT-FIELDNAME = 'VRKME'.

  GS_FCAT-SELTEXT = '##'.

  GS_FCAT-COLTEXT = '##'.

  APPEND GS_FCAT TO GT_FCAT.






*  " #. ## ##

*




  IF P_R_OR_F = 'X'.

    CLEAR GS_FCAT.

    GS_FCAT-COL_POS = 8.

    GS_FCAT-FIELDNAME = 'ZNSAMT'.

    GS_FCAT-SELTEXT = '####'.

    GS_FCAT-COLTEXT = '####'.

    GS_FCAT-CFIELDNAME = 'ZWAERS'.

    GS_FCAT-DO_SUM = 'X'.

    APPEND GS_FCAT TO GT_FCAT.



    CLEAR GS_FCAT.

    GS_FCAT-COL_POS = 9.

    GS_FCAT-FIELDNAME = 'ZSLAMT'.

    GS_FCAT-SELTEXT = '####'.

    GS_FCAT-COLTEXT = '####'.

    GS_FCAT-CFIELDNAME = 'ZWAERS'.

    GS_FCAT-DO_SUM = 'X'.

    APPEND GS_FCAT TO GT_FCAT.



    CLEAR GS_FCAT.

    GS_FCAT-COL_POS = 11.

    GS_FCAT-FIELDNAME = 'ZWAERS'.

    GS_FCAT-SELTEXT = '##'.

    GS_FCAT-COLTEXT = '##'.

    GS_FCAT-EMPHASIZE = 'X'.

    APPEND GS_FCAT TO GT_FCAT.



    CLEAR GS_FCAT.

    GS_FCAT-COL_POS = 10.

    GS_FCAT-FIELDNAME = 'ZDCAMT'.

    GS_FCAT-SELTEXT = '####'.

    GS_FCAT-COLTEXT = '####'.

    GS_FCAT-CFIELDNAME = 'ZWAERS'.

    GS_FCAT-DO_SUM = 'X'.

    APPEND GS_FCAT TO GT_FCAT.



    CLEAR GS_FCAT.

    GS_FCAT-COL_POS = 20.

    GS_FCAT-FIELDNAME = 'ZSALENAME'.

    GS_FCAT-SELTEXT = '####'.

    GS_FCAT-COLTEXT = '####'.

    APPEND GS_FCAT TO GT_FCAT.



    CLEAR GS_FCAT.

    GS_FCAT-COL_POS = 21.

    GS_FCAT-FIELDNAME = 'ZJDATE'.

    GS_FCAT-SELTEXT = '####'.

    GS_FCAT-COLTEXT = '####'.

    APPEND GS_FCAT TO GT_FCAT.



    CLEAR GS_FCAT.

    GS_FCAT-COL_POS = 22.

    GS_FCAT-FIELDNAME = 'ZRETNAME'.

    GS_FCAT-SELTEXT = '####'.

    GS_FCAT-COLTEXT = '####'.

    APPEND GS_FCAT TO GT_FCAT.



    CLEAR GS_FCAT.

    GS_FCAT-COL_POS = 23.

    GS_FCAT-FIELDNAME = 'ZRDATE'.

    GS_FCAT-SELTEXT = '####'.

    GS_FCAT-COLTEXT = '####'.

    APPEND GS_FCAT TO GT_FCAT.

  ELSEIF P_R_DE_F = 'X'.

    CLEAR GS_FCAT.

    GS_FCAT-COL_POS = 9.

    GS_FCAT-FIELDNAME = 'ZSLAMT'.

    GS_FCAT-SELTEXT = '####'.

    GS_FCAT-COLTEXT = '####'.

    GS_FCAT-DO_SUM = 'X'.

    APPEND GS_FCAT TO GT_FCAT.



    CLEAR GS_FCAT.

    GS_FCAT-COL_POS = 11.

    GS_FCAT-FIELDNAME = 'ZWAERS'.

    GS_FCAT-SELTEXT = '##'.

    GS_FCAT-COLTEXT = '##'.

    GS_FCAT-EMPHASIZE = 'X'.

    APPEND GS_FCAT TO GT_FCAT.



    CLEAR GS_FCAT.

    GS_FCAT-COL_POS = 20.

    GS_FCAT-FIELDNAME = 'ZDFNAME'.

    GS_FCAT-SELTEXT = '####'.

    GS_FCAT-COLTEXT = '####'.

    APPEND GS_FCAT TO GT_FCAT.



    CLEAR GS_FCAT.

    GS_FCAT-COL_POS = 21.

    GS_FCAT-FIELDNAME = 'ZDEL_LOC'.

    GS_FCAT-SELTEXT = '####'.

    GS_FCAT-COLTEXT = '####'.

    GS_FCAT-EMPHASIZE = 'X'.

    APPEND GS_FCAT TO GT_FCAT.



    CLEAR GS_FCAT.

    GS_FCAT-COL_POS = 22.

    GS_FCAT-FIELDNAME = 'ZDDATE'.

    GS_FCAT-SELTEXT = '####'.

    GS_FCAT-COLTEXT = '####'.

    APPEND GS_FCAT TO GT_FCAT.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYO

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_LAYO .

  CLEAR GS_LAYO.

  GS_LAYO-ZEBRA = 'X'.

ENDFORM.

FORM ALV_SORT .

  CLEAR GT_SORT.



  CLEAR GS_SORT.

  GS_SORT-SPOS = 1.

  GS_SORT-FIELDNAME = 'ZIDCODE'.

  GS_SORT-UP = 'X'.

  GS_SORT-SUBTOT = 'X'.            " ## ##

  APPEND GS_SORT TO GT_SORT.






*  CLEAR GS_SORT.

*  GS_SORT-SPOS = 2.

*  GS_SORT-FIELDNAME = 'ZWAERS'.       " ### ## ##

*  GS_SORT-UP        = 'X'.

*  GS_SORT-SUBTOT    = 'X'.            " ## ##

*  APPEND GS_SORT TO GT_SORT.



*  CLEAR GS_SORT.

*  GS_SORT-SPOS = 3.

*  GS_SORT-FIELDNAME = 'ZORDNO'.

*  GS_SORT-UP = 'X'.

*  APPEND GS_SORT TO GT_SORT.




ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_DISPLAY.

  IF P_R_OR_F = 'X'.

    CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

      EXPORTING




*       I_BUFFER_ACTIVE               =

*       I_BYPASSING_BUFFER            =

*       I_CONSISTENCY_CHECK           =

*       I_STRUCTURE_NAME              =

*       IS_VARIANT                    =

*       I_SAVE                        =

*       I_DEFAULT                     = 'X'




        IS_LAYOUT                     = GS_LAYO




*       IS_PRINT                      =

*       IT_SPECIAL_GROUPS             =

*       IT_TOOLBAR_EXCLUDING          =

*       IT_HYPERLINK                  =

*       IT_ALV_GRAPHICS               =

*       IT_EXCEPT_QINFO               =

*       IR_SALV_ADAPTER               =




      CHANGING

        IT_OUTTAB                     = GT_ORDER

        IT_FIELDCATALOG               = GT_FCAT

        IT_SORT                       = GT_SORT




*       IT_FILTER                     =




      EXCEPTIONS

        INVALID_PARAMETER_COMBINATION = 1

        PROGRAM_ERROR                 = 2

        TOO_MANY_LINES                = 3

        OTHERS                        = 4.

    "--- SY-SUBRC ## ## ## ---"

    IF SY-SUBRC <> 0.

      " SY-SUBRC ## ## ## ### ##

      MESSAGE |ALV Display Error: SY-SUBRC = { SY-SUBRC }| TYPE 'E'.

      LEAVE PROGRAM. " ## ## # #### ##

    ENDIF.

  ELSEIF P_R_DE_F = 'X'.

    CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

      EXPORTING




*       I_BUFFER_ACTIVE =

*       I_BYPASSING_BUFFER            =

*       I_CONSISTENCY_CHECK           =

*       I_STRUCTURE_NAME              =

*       IS_VARIANT      =

*       I_SAVE          =

*       I_DEFAULT       = 'X'




        IS_LAYOUT       = GS_LAYO




*       IS_PRINT        =

*       IT_SPECIAL_GROUPS             =

*       IT_TOOLBAR_EXCLUDING          =

*       IT_HYPERLINK    =

*       IT_ALV_GRAPHICS =

*       IT_EXCEPT_QINFO =

*       IR_SALV_ADAPTER =




      CHANGING

        IT_OUTTAB       = GT_DELIVERY

        IT_FIELDCATALOG = GT_FCAT

        IT_SORT         = GT_SORT




*       IT_FILTER       =

*    EXCEPTIONS

*       INVALID_PARAMETER_COMBINATION = 1

*       PROGRAM_ERROR   = 2

*       TOO_MANY_LINES  = 3

*       OTHERS          = 4




      .

    IF SY-SUBRC <> 0.




*   Implement suitable error handling here




    ENDIF.

  ENDIF.



ENDFORM.