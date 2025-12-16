
*&---------------------------------------------------------------------*

*&  Include           ZMM03_004_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SELECTION_SCFREEN_OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SELECTION_SCFREEN_OUTPUT .

LOOP AT SCREEN.

    "## ## ####, ### M1 (#####)# ## ## ##

    IF P_R2 = 'X' AND SCREEN-GROUP1 = 'M1'.

      SCREEN-ACTIVE = '0'.

      MODIFY SCREEN.

    ENDIF.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_SELECTION_SCREEN

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_SELECTION_SCREEN .

  IF SSCRFIELDS-UCOMM = 'ONLI'. "## ### ### ## ## ##

    "## ##(##) ### #

    IF P_R1 = 'X'.

      "1. ### ##

      IF P_EBELN IS INITIAL.

        MESSAGE '##### #####.' TYPE 'E'.

      ELSEIF P_WERKS IS INITIAL.

        MESSAGE '#### #####.' TYPE 'E'.

      ELSEIF P_IVDAT IS INITIAL.

        MESSAGE '###### #####.' TYPE 'E'.

      ENDIF.



      "2. PO ### ##

      DATA : LV_EBELN TYPE ZEDT03_EKKO-EBELN.



      SELECT SINGLE EBELN

        FROM ZEDT03_EKKO

        INTO @LV_EBELN

       WHERE EBELN = @P_EBELN.



      IF SY-SUBRC <> 0.

        MESSAGE '#### ## #### #####.' TYPE 'E'.

      ENDIF.



    "## ## ### #

    ELSEIF P_R2 = 'X'.

      "### ##

      IF P_EBELN IS INITIAL.

        MESSAGE '##### #####.' TYPE 'E'.

      ELSEIF P_WERKS IS INITIAL.

        MESSAGE '#### #####.' TYPE 'E'.

      ENDIF.

    ENDIF.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_HANDLE_DATA_CHANGED

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_ER_DATA_CHANGED  text

*----------------------------------------------------------------------*




FORM ALV_HANDLE_DATA_CHANGED  USING    P_ER_DATA_CHANGED.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA_CRE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA_CRE .

  "## ## ##

  DATA: LV_OPEN_QTY TYPE ZEDT03_EKPO-MENGE. "##

  DATA: LV_MWSKZ    TYPE ZEDT03_LFM1-MWSKZ. "## ##



  "### ## ### ##

  DATA: BEGIN OF LS_SUM,

           EBELN TYPE ZEDT03_EKKO-EBELN, "PO##

           EBELP TYPE ZEDT03_EKPO-EBELP, "##

           MENGE TYPE ZEDT03_RSEG-MENGE, "## ##

         END OF LS_SUM.

  DATA: LT_SUM LIKE TABLE OF LS_SUM.



  "## ### ## ## ###(RSEG)# ## ### ###

  DATA: LT_RSEG TYPE TABLE OF ZEDT03_RSEG,

        LS_RSEG TYPE ZEDT03_RSEG.



  "### ###

  REFRESH GT_DATA.



  "PO ##(EKKO)+###(EKPO) #### ## ## ####

  "##: ### ####(P_EBELN), ###(P_WERKS)

  SELECT A~EBELN A~LIFNR A~WAERS A~EKORG

         B~EBELP B~MATNR B~MAKTX B~WERK AS WERKS

         B~MENGE B~BPRME B~MEINS

    INTO CORRESPONDING FIELDS OF TABLE GT_DATA

    FROM ZEDT03_EKKO AS A

    INNER JOIN ZEDT03_EKPO AS B

       ON A~EBELN = B~EBELN

   WHERE A~EBELN = P_EBELN

     AND B~WERK  = P_WERKS.



  "#### ### ##

  IF GT_DATA[] IS INITIAL.

    RETURN.

  ENDIF.



  "GT_DATA# ## PO#### ## ### # ####

  SELECT * FROM ZEDT03_RSEG

    INTO TABLE LT_RSEG

    FOR ALL ENTRIES IN GT_DATA

   WHERE EBELN = GT_DATA-EBELN

     AND EBELP = GT_DATA-EBELP.



  "## ### ### ## ####(COLLECT)

  LOOP AT LT_RSEG INTO LS_RSEG.

      CLEAR LS_SUM.

      LS_SUM-EBELN = LS_RSEG-EBELN.

      LS_SUM-EBELP = LS_RSEG-EBELP.



      "#### ## ## ##

      IF LS_RSEG-SHKZG = 'S'.      "### # ## ##(+)

        LS_SUM-MENGE = LS_RSEG-MENGE.

      ELSEIF LS_RSEG-SHKZG = 'H'.  "### # ## ##(-)

        LS_SUM-MENGE = LS_RSEG-MENGE * -1.

      ENDIF.



      "COLLECT# #(EBELN, EBELP)# ## ## ### #####.

      COLLECT LS_SUM INTO LT_SUM.

   ENDLOOP.



  "## ### ## ## ### ## ##

  SORT LT_SUM BY EBELN EBELP.



  "## ## # ## ## ##

  LOOP AT GT_DATA INTO GS_DATA.

    CLEAR: LV_OPEN_QTY.



    "## #### ##### ###(LT_SUM)## ####

    READ TABLE LT_SUM INTO LS_SUM WITH KEY EBELN = GS_DATA-EBELN

                                                 EBELP = GS_DATA-EBELP

                                  BINARY SEARCH.

    IF SY-SUBRC = 0.

      "## ## ### ## ### # ##

      LV_OPEN_QTY = GS_DATA-MENGE - LS_SUM-MENGE.

    ELSE.

      "## ### ### PO ### # ##

      LV_OPEN_QTY = GS_DATA-MENGE.

    ENDIF.



    "### #### ### ### ##

    IF LV_OPEN_QTY > 0.

      "1. ## ##

      GS_DATA-IVMNG = LV_OPEN_QTY. "### '####'# ### ##### #



      "2. #### ##

      GS_DATA-WRBTR = GS_DATA-IVMNG * GS_DATA-BPRME. "#### = ## * ##



      "3. ## ## #### (LFM1 #########)

      CLEAR LV_MWSKZ.

      SELECT SINGLE MWSKZ

        FROM ZEDT03_LFM1

        INTO LV_MWSKZ

        WHERE LIFNR = GS_DATA-LIFNR

          AND EKORG = GS_DATA-EKORG.



      "### ## ### ALV #### ##

      IF SY-SUBRC = 0.

        GS_DATA-MWSKZ = LV_MWSKZ.

      ELSE.

        GS_DATA-MWSKZ = 'V1'. "#### ### ### V1(10%) ## (####)

      ENDIF.



      "4. ## ### ## ###(MWSTS) ##

      CASE GS_DATA-MWSKZ.

        WHEN 'V1' OR 'V5'   . "10% ## (##, ####)

            GS_DATA-MWSTS = GS_DATA-WRBTR * '0.1'.



        WHEN 'V4'.         "10% ###

            "##### #### # ### #### ##### #

            "## ## # ## ## ## ## ###. ##### ## ### ### #.

            GS_DATA-MWSTS = GS_DATA-WRBTR * '0.1'.



        WHEN 'V2' OR 'V3'. "0% (###, ##)

            GS_DATA-MWSTS = 0.

        WHEN OTHERS.       "# # (## ## ##)

            GS_DATA-MWSTS = 0.

       ENDCASE.



       "### ##

       CONCATENATE GS_DATA-EBELN '####' INTO GS_DATA-SGTXT SEPARATED BY SPACE.

       MODIFY GT_DATA FROM GS_DATA.

    ELSE.

      "## ## ## ### ## ## #### ##

      DELETE GT_DATA INDEX SY-TABIX.

    ENDIF.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA_DIS

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA_DIS .



  "### ###

  REFRESH GT_DATA.



  "DB## ### ####

  " ####(A) + #####(B) + #######(C-######)

   SELECT A~BELNR A~GJAHR A~BLDAT A~BUDAT A~LIFNR A~WAERS A~STBLG

         B~EBELN B~EBELP B~MATNR

         B~MENGE AS IVMNG

         B~WRBTR B~MWSKZ B~MEINS

         B~SHKZG

         C~MAKTX C~WERK AS WERKS

         C~MENGE

    INTO CORRESPONDING FIELDS OF TABLE GT_DATA

    FROM ZEDT03_RBKP AS A

    INNER JOIN ZEDT03_RSEG AS B

       ON A~BELNR = B~BELNR

      AND A~GJAHR = B~GJAHR

    INNER JOIN ZEDT03_EKPO AS C

       ON B~EBELN = C~EBELN

      AND B~EBELP = C~EBELP

   WHERE B~EBELN = P_EBELN

     AND B~WERKS  = P_WERKS.



  IF GT_DATA[] IS INITIAL.

    RETURN.

  ENDIF.



  "## ### ### ## Loop

  LOOP AT GT_DATA INTO GS_DATA.



    "###(SGTXT) ####

    "#### ###### ##### ### ###

    SELECT SINGLE SGTXT

      FROM ZEDT03_BSIK

      INTO GS_DATA-SGTXT

     WHERE BELNR = GS_DATA-BELNR

       AND GJAHR = GS_DATA-GJAHR.



    "###(SHKZG)# ## ## ## (## ###)

    "DB## ### #### ###, ###### #### ##### ####.

    IF GS_DATA-SHKZG = 'H'.

      GS_DATA-IVMNG = GS_DATA-IVMNG * -1.  " ## ## ##

      GS_DATA-WRBTR = GS_DATA-WRBTR * -1.  " ## ## ##

    ENDIF.



    "##(MWSTS) ###

    "### ###(RSEG)## ## ## ### #### ### # ##

    CASE GS_DATA-MWSKZ.

      WHEN 'V1' OR 'V5' OR 'V4'. "10%

        GS_DATA-MWSTS = GS_DATA-WRBTR * '0.1'.

      WHEN 'V3' OR 'V2'.         "0%

        GS_DATA-MWSTS = 0.

      WHEN OTHERS.

        GS_DATA-MWSTS = 0.

    ENDCASE.



    MODIFY GT_DATA FROM GS_DATA.

  ENDLOOP.



  "## (#### #)

  SORT GT_DATA BY BELNR EBELP.



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




*      PARENT                      =




      REPID                       = SY-REPID "#### ID

      DYNNR                       = SY-DYNNR "### ##"




*      SIDE                        = DOCK_AT_LEFT




      EXTENSION                   = 2000




*      STYLE                       =

*      LIFETIME                    = lifetime_default

*      CAPTION                     =

*      METRIC                      = 0

*      RATIO                       =

*      NO_AUTODEF_PROGID_DYNNR     =

*      NAME                        =

*    EXCEPTIONS

*      CNTL_ERROR                  = 1

*      CNTL_SYSTEM_ERROR           = 2

*      CREATE_ERROR                = 3

*      LIFETIME_ERROR              = 4

*      LIFETIME_DYNPRO_DYNPRO_LINK = 5

*      others                      = 6




      .

  IF SY-SUBRC <> 0.




*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.



  CREATE OBJECT GC_GRID

    EXPORTING




*      I_SHELLSTYLE      = 0

*      I_LIFETIME        =




      I_PARENT          = GC_DOCKING




*      I_APPL_EVENTS     = space

*      I_PARENTDBG       =

*      I_APPLOGPARENT    =

*      I_GRAPHICSPARENT  =

*      I_NAME            =

*      I_FCAT_COMPLETE   = SPACE

*    EXCEPTIONS

*      ERROR_CNTL_CREATE = 1

*      ERROR_CNTL_INIT   = 2

*      ERROR_CNTL_LINK   = 3

*      ERROR_DP_CREATE   = 4

*      others            = 5




      .

  IF SY-SUBRC <> 0.




*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




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

  CLEAR: GT_FIELDCAT, GS_FIELDCAT.

  "1. #### (L_CHECK)

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'L_CHECK'.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-CHECKBOX  = 'X'.      " ##### ##

  GS_FIELDCAT-EDIT      = 'X'.      " #### ## #### #

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  "## ## ## # ## #### ##

  IF P_R2 = 'X'.

    "###### (BELNR)

    CLEAR GS_FIELDCAT.

    GS_FIELDCAT-FIELDNAME = 'BELNR'.

    GS_FIELDCAT-COLTEXT   = '####'.

    GS_FIELDCAT-REF_TABLE = 'ZEDT03_RBKP'.

    GS_FIELDCAT-REF_FIELD = 'BELNR'.

    GS_FIELDCAT-KEY       = 'X'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.



    "#### (GJAHR)

    CLEAR GS_FIELDCAT.

    GS_FIELDCAT-FIELDNAME = 'GJAHR'.

    GS_FIELDCAT-COLTEXT   = '##'.

    GS_FIELDCAT-REF_TABLE = 'ZEDT03_RBKP'.

    GS_FIELDCAT-REF_FIELD = 'GJAHR'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.



    "### (BLDAT)

    CLEAR GS_FIELDCAT.

    GS_FIELDCAT-FIELDNAME = 'BLDAT'.

    GS_FIELDCAT-COLTEXT   = '###'.

    GS_FIELDCAT-REF_TABLE = 'ZEDT03_RBKP'.

    GS_FIELDCAT-REF_FIELD = 'BLDAT'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.



    "### #### (STBLG) - ## ## ###

    CLEAR GS_FIELDCAT.

    GS_FIELDCAT-FIELDNAME = 'STBLG'.

    GS_FIELDCAT-COLTEXT   = '### ##'.

    GS_FIELDCAT-REF_TABLE = 'ZEDT03_RBKP'.

    GS_FIELDCAT-REF_FIELD = 'STBLG'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

  ENDIF.







  "2. ###### (EBELN)

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'EBELN'.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT03_EKKO'.

  GS_FIELDCAT-REF_FIELD = 'EBELN'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  "3. #### (EBELP)

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'EBELP'.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT03_EKPO'.

  GS_FIELDCAT-REF_FIELD = 'EBELP'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  "4. #### (MATNR)

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'MATNR'.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT03_EKPO'.

  GS_FIELDCAT-REF_FIELD = 'MATNR'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  "5. ### (MAKTX)

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'MAKTX'.

  GS_FIELDCAT-COLTEXT   = '###'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT03_EKPO'.

  GS_FIELDCAT-REF_FIELD = 'MAKTX'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  "6. ### (WERK)

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'WERKS'.

  GS_FIELDCAT-COLTEXT   = '###'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT03_EKPO'.

  GS_FIELDCAT-REF_FIELD = 'WERK'.

  GS_FIELDCAT-JUST      = 'C'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 7. #### (IVMNG)

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'IVMNG'.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT03_RSEG'.

  GS_FIELDCAT-REF_FIELD = 'MENGE'.

  GS_FIELDCAT-QFIELDNAME = 'MEINS'.



  "## ## ### ## ## #### ##

  IF P_R1 = 'X'.

    GS_FIELDCAT-EDIT = 'X'.

  ENDIF.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  "8. ## (MEINS)

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'MEINS'.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT03_EKPO'.

  GS_FIELDCAT-REF_FIELD = 'MEINS'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  " 9. #### (WRBTR)

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'WRBTR'.

  GS_FIELDCAT-COLTEXT   = '####'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT03_RSEG'.

  GS_FIELDCAT-REF_FIELD = 'WRBTR'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'. "## ## ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  "10. ## (MWSTS)

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'MWSTS'.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT03_BSIK'.

  GS_FIELDCAT-REF_FIELD = 'MWSTS'.

  GS_FIELDCAT-CFIELDNAME = 'WAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  "11. ## (WAERS)

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'WAERS'.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT03_EKKO'.

  GS_FIELDCAT-REF_FIELD = 'WAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.





  "12. ## (SGTXT)

  CLEAR GS_FIELDCAT.

  GS_FIELDCAT-FIELDNAME = 'SGTXT'.

  GS_FIELDCAT-COLTEXT   = '##'.

  GS_FIELDCAT-REF_TABLE = 'ZEDT03_BSIK'.

  GS_FIELDCAT-REF_FIELD = 'SGTXT'.

  GS_FIELDCAT-OUTPUTLEN = 30.

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

  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA      = 'X'.       "####

  GS_LAYOUT-CWIDTH_OPT = 'X'.       "# ## ## ###

  GS_LAYOUT-SEL_MODE   = 'A'.       "# ## ## ##

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_SORT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_SORT .

  CLEAR: GS_SORT, GT_SORT.



  "###### ####

  IF P_R2 = 'X'.

    CLEAR GS_SORT.

    GS_SORT-SPOS      = 1.

    GS_SORT-FIELDNAME = 'BELNR'.

    GS_SORT-UP        = 'X'. " ####

    APPEND GS_SORT TO GT_SORT.

  ENDIF.



  "###### ####

  CLEAR GS_SORT.

  GS_SORT-SPOS = 2.

  GS_SORT-FIELDNAME = 'EBELN'.

  GS_SORT-UP        = 'X'.

  APPEND GS_SORT TO GT_SORT.



  "#### ####

  CLEAR GS_SORT.

  GS_SORT-SPOS = 3.

  GS_SORT-FIELDNAME = 'EBELP'.

  GS_SORT-UP        = 'X'.

  APPEND GS_SORT TO GT_SORT.

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

  "### ### ## ##

  IF GO_EVENT IS INITIAL.

    CREATE OBJECT GO_EVENT.

  ENDIF.



  "1. ### ## #### #### ##

  SET HANDLER GO_EVENT->HANDLE_DATA_CHANGED FOR GC_GRID.



  "2. #### #### ###### #### ##### ## (MC_EVT_MODIFIED)

  CALL METHOD GC_GRID->REGISTER_EDIT_EVENT

    EXPORTING

      I_EVENT_ID = CL_GUI_ALV_GRID=>MC_EVT_MODIFIED.

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

      IT_OUTTAB                     = GT_DATA

      IT_FIELDCATALOG               = GT_FIELDCAT

      IT_SORT                       = GT_SORT




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

 DATA: LS_STABLE TYPE LVC_S_STBL.

  LS_STABLE-ROW = 'X'.

  LS_STABLE-COL = 'X'.



  CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY

      EXPORTING

        IS_STABLE = LS_STABLE. " ### ## ##

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

  "DB ### ## ##

  DATA: LS_RBKP TYPE ZEDT03_RBKP,

        LS_RSEG TYPE ZEDT03_RSEG,

        LT_RSEG TYPE TABLE OF ZEDT03_RSEG,

        LS_BSIK TYPE ZEDT03_BSIK.



  "## ##

  DATA: LV_BELNR     TYPE ZEDT03_RBKP-BELNR, "### ######

        LV_TOTAL_AMT TYPE ZEDT03_BSIK-DMBTR, "#### ##

        LV_TOTAL_TAX TYPE ZEDT03_BSIK-MWSTS, "## ##

        LV_LAST_DATE TYPE DATS.              "### (######)



  "1. ### #### ### ##

  READ TABLE GT_DATA WITH KEY L_CHECK = 'X' TRANSPORTING NO FIELDS.

  IF SY-SUBRC <> 0.

    MESSAGE '### #### #####.' TYPE 'I' DISPLAY LIKE 'E'.

    RETURN.

  ENDIF.



  LOOP AT GT_DATA INTO GS_DATA WHERE L_CHECK = 'X'.

    IF GS_DATA-IVMNG <= 0.

      MESSAGE '## ### 0## ## ###.' TYPE 'S' DISPLAY LIKE 'E'.

      RETURN.

    ENDIF.

  ENDLOOP.



  "2. #### ## (## # ## + 1)

  SELECT MAX( BELNR ) FROM ZEDT03_RBKP INTO LV_BELNR.

  IF LV_BELNR IS INITIAL.

    LV_BELNR = '5000000000'. "#### ### ### ##

  ELSE.

    LV_BELNR = LV_BELNR + 1. "### +1 ##

  ENDIF.



  "3. #####(ZFBDT) ##: ###### '###' ###

  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

    EXPORTING

      DAY_IN            = P_IVDAT

    IMPORTING

      LAST_DAY_OF_MONTH = LV_LAST_DATE

    EXCEPTIONS

      DAY_IN_NO_DATE    = 1

      OTHERS            = 2.

  IF SY-SUBRC <> 0.

    LV_LAST_DATE = P_IVDAT. " ## # ## ####

  ENDIF.



  "4. ### ##, ##

  LOOP AT GT_DATA INTO GS_DATA WHERE L_CHECK = 'X'.

    "RSEG ### ##

    CLEAR LS_RSEG.

    LS_RSEG-MANDT = SY-MANDT.

    LS_RSEG-BELNR = LV_BELNR.        "### ##

    LS_RSEG-GJAHR = P_IVDAT(4).      "####(##### ##)

    LS_RSEG-BUZEI = GS_DATA-EBELP.   "####(PO## ##)

    LS_RSEG-EBELN = GS_DATA-EBELN.

    LS_RSEG-EBELP = GS_DATA-EBELP.

    LS_RSEG-MATNR = GS_DATA-MATNR.

    LS_RSEG-WERKS = GS_DATA-WERKS.

    LS_RSEG-MWSKZ = GS_DATA-MWSKZ.

    LS_RSEG-MEINS = GS_DATA-MEINS.



    " ##/## (ALV## ### # ##)

    LS_RSEG-MENGE = GS_DATA-IVMNG.

    LS_RSEG-WRBTR = GS_DATA-IVMNG * GS_DATA-BPRME. " ## x ## ###



    "## ## = ##(S), #### ##

    LS_RSEG-SHKZG = 'S'.



    APPEND LS_RSEG TO LT_RSEG.



    "##/BSIK ### ## ## ##

    LV_TOTAL_AMT = LV_TOTAL_AMT + LS_RSEG-WRBTR.

    LV_TOTAL_TAX = LV_TOTAL_TAX + GS_DATA-MWSTS.



    "# ## #### ## ## ##

    IF LS_RBKP IS INITIAL.

       LS_RBKP-MANDT = SY-MANDT.

       LS_RBKP-BELNR = LV_BELNR.

       LS_RBKP-GJAHR = P_IVDAT(4).

       "PO##(EKKO)## #### ###

       SELECT SINGLE BUKRS

         FROM ZEDT03_EKKO

         INTO LS_RBKP-BUKRS

        WHERE EBELN = GS_DATA-EBELN.



       LS_RBKP-LIFNR = GS_DATA-LIFNR.

       LS_RBKP-BLDAT = P_IVDAT.      "### = #####

       LS_RBKP-BUDAT = P_IVDAT.      "### = #####

       LS_RBKP-WAERS = GS_DATA-WAERS.

       LS_RBKP-EBELN = GS_DATA-EBELN. "## #### ##

    ENDIF.

  ENDLOOP.



  "5. ## # ## ### ### ##

  "RBKP : ##

  LS_RBKP-RMWWR = LV_TOTAL_AMT + LV_TOTAL_TAX. "# #### = ### + ##

  LS_RBKP-WMWST = LV_TOTAL_TAX.                "# ##



  "BSIK : #####

  LS_BSIK-MANDT = SY-MANDT.

  LS_BSIK-BUKRS = LS_RBKP-BUKRS.

  LS_BSIK-LIFNR = LS_RBKP-LIFNR.

  LS_BSIK-BELNR = LV_BELNR.

  LS_BSIK-GJAHR = LS_RBKP-GJAHR.

  LS_BSIK-BLDAT = LS_RBKP-BLDAT.

  LS_BSIK-BUDAT = LS_RBKP-BUDAT.

  LS_BSIK-WAERS = LS_RBKP-WAERS.

  LS_BSIK-GSBER = '1000'.

  LS_BSIK-MWSKZ = GS_DATA-MWSKZ.



  "#### = ##(H), ## ##

  LS_BSIK-BLART = 'RE'. " ####

  LS_BSIK-SHKZG = 'H'.  " ##



  "### ## ### ##

  LS_BSIK-DMBTR = LV_TOTAL_AMT.

  LS_BSIK-MWSTS = LV_TOTAL_TAX.



  "###: ###### + ####

  CONCATENATE LS_RBKP-EBELN '####' INTO LS_BSIK-SGTXT SEPARATED BY SPACE.



  "#####(###)

  LS_BSIK-ZFBDT = LV_LAST_DATE.



  "6. DB ##

  INSERT ZEDT03_RBKP FROM LS_RBKP.

  INSERT ZEDT03_RSEG FROM TABLE LT_RSEG.

  INSERT ZEDT03_BSIK FROM LS_BSIK.



  DATA: LV_MSG TYPE STRING. "### ## ##

  "## ##

  IF SY-SUBRC = 0.

    COMMIT WORK.

    CONCATENATE '### ##### #######. ##:' LV_BELNR INTO LV_MSG SEPARATED BY SPACE.

    MESSAGE LV_MSG TYPE 'S'.



    "## # ## ## (### ## #### ##### ## ##)

    PERFORM GET_DATA_CRE.

    PERFORM REFRESH.

  ELSE.

    ROLLBACK WORK.

    MESSAGE '## # ### ######.' TYPE 'E'.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CANCEL_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CANCEL_DATA .

  "## ## # ### ##

  DATA: LS_RBKP_NEW TYPE ZEDT03_RBKP, "## ## ## ## ##

        LS_RBKP_OLD TYPE ZEDT03_RBKP, "## ## ##



        LS_RSEG_NEW TYPE ZEDT03_RSEG, "## ## ## ###

        LS_RSEG_OLD TYPE ZEDT03_RSEG, "## ###

        LT_RSEG_NEW TYPE TABLE OF ZEDT03_RSEG,

        LT_RSEG_OLD TYPE TABLE OF ZEDT03_RSEG,



        LS_BSIK_NEW TYPE ZEDT03_BSIK, "## ## ## ####

        LS_BSIK_OLD TYPE ZEDT03_BSIK. "## ####

  DATA: LV_MSG TYPE STRING. "### ## ##



  "## ### ## #### ### ###

  TYPES: BEGIN OF TY_DOC,

           BELNR TYPE ZEDT03_RBKP-BELNR,

           GJAHR TYPE ZEDT03_RBKP-GJAHR,

         END OF TY_DOC.

  DATA: LT_DOC_LIST TYPE TABLE OF TY_DOC,

        LS_DOC_LIST TYPE TY_DOC.



  DATA: LV_NEW_BELNR TYPE ZEDT03_RBKP-BELNR. "## ### ##



  "### ### ### ### ##

  LOOP AT GT_DATA INTO GS_DATA WHERE L_CHECK = 'X'.

    LS_DOC_LIST-BELNR = GS_DATA-BELNR.

    LS_DOC_LIST-GJAHR = GS_DATA-GJAHR.



    "## ### #### ## # ###### ## ### # ## #### ## COLLECT ##

    COLLECT LS_DOC_LIST INTO LT_DOC_LIST.

  ENDLOOP.



  IF LT_DOC_LIST IS INITIAL.  "### ## ### ##

    MESSAGE '### #### #####.' TYPE 'I' DISPLAY LIKE 'E'.

    RETURN.

  ENDIF.



  "## ### ## #### ##

  LOOP AT LT_DOC_LIST INTO LS_DOC_LIST.



    CLEAR: LS_RBKP_OLD, LS_BSIK_OLD, LT_RSEG_OLD.

    CLEAR: LS_RBKP_NEW, LS_BSIK_NEW, LT_RSEG_NEW, LT_RSEG_NEW.



    "## ### ##

    SELECT SINGLE * FROM ZEDT03_RBKP INTO LS_RBKP_OLD

     WHERE BELNR = LS_DOC_LIST-BELNR

       AND GJAHR = LS_DOC_LIST-GJAHR.



    "### ##, ## ### ### ## (STBLG# ### ### ### #)

    IF LS_RBKP_OLD-STBLG IS NOT INITIAL.

      CLEAR LV_MSG.

      CONCATENATE LS_DOC_LIST-BELNR '## ## ### #####.'

             INTO LV_MSG SEPARATED BY SPACE.

      MESSAGE LV_MSG TYPE 'S' DISPLAY LIKE 'E'.

      CONTINUE. "## ### ####

    ENDIF.



    "# ## ##

    SELECT MAX( BELNR ) FROM ZEDT03_RBKP INTO LV_NEW_BELNR.

    LV_NEW_BELNR = LV_NEW_BELNR + 1. "MAX + 1



    "## ## (RBKP)

    MOVE-CORRESPONDING LS_RBKP_OLD TO LS_RBKP_NEW. "## ## ##

    LS_RBKP_NEW-BELNR = LV_NEW_BELNR.      "# ##

    LS_RBKP_NEW-GJAHR = SY-DATUM(4).       "#### ## ##

    LS_RBKP_NEW-BLDAT = SY-DATUM.          "### = ##

    LS_RBKP_NEW-BUDAT = SY-DATUM.          "### = ##



    "## ## (### ## ## ##)

    LS_RBKP_NEW-STBLG = LS_RBKP_OLD-BELNR. " # ### ## ### ###

    LS_RBKP_NEW-STJAH = LS_RBKP_OLD-GJAHR.



    "### ## (RSEG) : SHKZG ###

    "## #### ## ###

    SELECT * FROM ZEDT03_RSEG INTO TABLE LT_RSEG_OLD

     WHERE BELNR = LS_RBKP_OLD-BELNR

       AND GJAHR = LS_RBKP_OLD-GJAHR.



    LOOP AT LT_RSEG_OLD INTO LS_RSEG_OLD.

      CLEAR LS_RSEG_NEW.

      MOVE-CORRESPONDING LS_RSEG_OLD TO LS_RSEG_NEW.



      LS_RSEG_NEW-BELNR = LV_NEW_BELNR.

      LS_RSEG_NEW-GJAHR = LS_RBKP_NEW-GJAHR.



      "### #### (S <-> H)

      IF LS_RSEG_OLD-SHKZG = 'S'.

        LS_RSEG_NEW-SHKZG = 'H'. " ## -> ##

      ELSE.

        LS_RSEG_NEW-SHKZG = 'S'.

      ENDIF.



      APPEND LS_RSEG_NEW TO LT_RSEG_NEW.

    ENDLOOP.



    "## ## ## (BSIK) : SHKZG ###, ## ##

    SELECT SINGLE * FROM ZEDT03_BSIK INTO LS_BSIK_OLD

     WHERE BELNR = LS_RBKP_OLD-BELNR

       AND GJAHR = LS_RBKP_OLD-GJAHR.



    IF SY-SUBRC = 0.

      MOVE-CORRESPONDING LS_BSIK_OLD TO LS_BSIK_NEW.

      LS_BSIK_NEW-BELNR = LV_NEW_BELNR.

      LS_BSIK_NEW-GJAHR = LS_RBKP_NEW-GJAHR.

      LS_BSIK_NEW-BLDAT = LS_RBKP_NEW-BLDAT.

      LS_BSIK_NEW-BUDAT = LS_RBKP_NEW-BUDAT.



      "### ##

      IF LS_BSIK_OLD-SHKZG = 'H'.

        LS_BSIK_NEW-SHKZG = 'S'. "##### ###### ## -> ### ######

      ELSE.

        LS_BSIK_NEW-SHKZG = 'H'.

      ENDIF.



      "## ##

      "## ### ## ### ###### ####

      LS_BSIK_NEW-AUGBL = LS_RBKP_OLD-BELNR. "## ## = ## ##

      LS_BSIK_NEW-AUGDT = SY-DATUM.          "### = ##



      CONCATENATE '(###)' LS_BSIK_OLD-SGTXT INTO LS_BSIK_NEW-SGTXT.

    ENDIF.



    "DB ## # ####

    "# ## ## ##

    INSERT ZEDT03_RBKP FROM LS_RBKP_NEW.

    INSERT ZEDT03_RSEG FROM TABLE LT_RSEG_NEW.

    INSERT ZEDT03_BSIK FROM LS_BSIK_NEW.



    "## ## ####, ###### ##

    UPDATE ZEDT03_RBKP

       SET STBLG = LS_RBKP_NEW-BELNR  "### # ### #### # (## ##)

           STJAH = LS_RBKP_NEW-GJAHR

     WHERE BELNR = LS_RBKP_OLD-BELNR

       AND GJAHR = LS_RBKP_OLD-GJAHR.



    "## #### ####, ###### ##

    UPDATE ZEDT03_BSIK

       SET AUGBL = LS_RBKP_NEW-BELNR

           AUGDT = SY-DATUM

     WHERE BELNR = LS_BSIK_OLD-BELNR

       AND GJAHR = LS_BSIK_OLD-GJAHR.



    "## ##

    IF SY-SUBRC = 0.

      COMMIT WORK.

      CONCATENATE '## ### #######. ##:' LV_NEW_BELNR INTO LV_MSG SEPARATED BY SPACE.

      MESSAGE LV_MSG TYPE 'S'.

    ELSE.

      ROLLBACK WORK.

      MESSAGE '## ## # ### ######.' TYPE 'E'.

    ENDIF.

  ENDLOOP.



  "## ##

  PERFORM GET_DATA_DIS.

  PERFORM REFRESH.

ENDFORM.