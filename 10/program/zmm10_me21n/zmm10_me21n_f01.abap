
*&---------------------------------------------------------------------*

*&  Include           ZMM10_ME21N_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DATA .

  IF PR_CREA = 'X'.




*    SELECT * FROM ZEDT10_EKKO

*      INTO CORRESPONDING FIELDS OF GT_EKKO

*      WHERE EBELN = P_EBELN1.




    SELECT SINGLE * FROM ZEDT10_LFM1

      INTO CORRESPONDING FIELDS OF GS_LFM1 WHERE LIFNR = P_LIFNR1.



  ELSEIF PR_SEAR = 'X'.

    SELECT

      P~EBELN,   " ## ## ##

      P~EBELP,   " ## ##

      P~MATNR,   " ## ##

      P~WERKS,   " ###

      P~MENGE,   " ##

      P~MEINS,   " ##

      P~NETPR,   " ##

      P~LGORT,

      P~PRDAT,

      P~MAKTX,

      P~LOEVM,

      K~BUKRS,   " ## ##

      K~LIFNR,   " ####(Vendor)

      K~BEDAT,    " ###(PO ###)

      K~WAERS,

      M~MWSKZ

      INTO CORRESPONDING FIELDS OF TABLE @GT_ITEM

      FROM ZEDT10_EKPO AS P

      INNER JOIN ZEDT10_EKKO AS K

        ON P~EBELN = K~EBELN

        AND K~EBELN = @P_EBELN2

      INNER JOIN ZEDT10_LFM1 AS M

        ON M~LIFNR = K~LIFNR

      WHERE P~LOEVM <> 'L'

      .



    IF SY-SUBRC = 0.

      READ TABLE GT_EKKO INTO GS_EKKO INDEX 1.

      GV_EBELN = GS_EKKO-EBELN.




*      PERFORM GET_ITEM USING GV_EBELN.




    ENDIF.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_ITEM

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GV_EBELN  text

*----------------------------------------------------------------------*




FORM GET_ITEM  USING    P_GV_EBELN TYPE EBELN.

  SELECT * INTO CORRESPONDING FIELDS OF TABLE GT_ITEM

    FROM ZEDT10_EKPO WHERE EBELN = P_GV_EBELN ORDER BY EBELP.



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

  CREATE OBJECT GO_EVENT_HANDLER.

  CREATE OBJECT GO_CONTAINER_ITEM

    EXPORTING




*     PARENT         =




      CONTAINER_NAME = 'CONTAINER_ITEM'




*     STYLE          =

*     LIFETIME       = lifetime_default

*     REPID          =

*     DYNNR          =

*     NO_AUTODEF_PROGID_DYNNR     =

*    EXCEPTIONS

*     CNTL_ERROR     = 1

*     CNTL_SYSTEM_ERROR           = 2

*     CREATE_ERROR   = 3

*     LIFETIME_ERROR = 4

*     LIFETIME_DYNPRO_DYNPRO_LINK = 5

*     OTHERS         = 6




    .

  IF SY-SUBRC <> 0.




*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.



  CREATE OBJECT GO_ALV_ITEM

    EXPORTING




*     I_SHELLSTYLE      = 0

*     I_LIFETIME        =




      I_PARENT = GO_CONTAINER_ITEM




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

  DATA: LS_FCAT TYPE LVC_S_FCAT.



  " ITERM FCAT ##

  CLEAR GT_FIELDCAT_ITEM.



  " EBELN

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'EBELN'.

  LS_FCAT-SCRTEXT_M = 'PO##'.

  LS_FCAT-COL_POS = 1.

  LS_FCAT-OUTPUTLEN = 10.

  LS_FCAT-NO_OUT = 'X'.  " ##

  APPEND LS_FCAT TO GT_FIELDCAT_ITEM.



  " EBELP

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'EBELP'.

  LS_FCAT-SCRTEXT_M = '##'.

  LS_FCAT-COL_POS = 12.

  LS_FCAT-OUTPUTLEN = 5.

  APPEND LS_FCAT TO GT_FIELDCAT_ITEM.



  " MATNR

  CLEAR LS_FCAT.

  LS_FCAT-F4AVAILABL = 'X'.




*  LS_FCAT-REF_TABLE = 'ZMARA10'.

*  LS_FCAT-REF_FIELD = 'MATNR'.




  LS_FCAT-FIELDNAME = 'MATNR'.

  LS_FCAT-SCRTEXT_M = '####'.

  LS_FCAT-COL_POS = 13.

  LS_FCAT-OUTPUTLEN = 10.

  LS_FCAT-EDIT = 'X'.  " ## ##

  APPEND LS_FCAT TO GT_FIELDCAT_ITEM.



  " MAKTX

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'MAKTX'.

  LS_FCAT-SCRTEXT_M = '###'.

  LS_FCAT-COL_POS = 14.

  LS_FCAT-OUTPUTLEN = 20.

  APPEND LS_FCAT TO GT_FIELDCAT_ITEM.



  " MENGE

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'MENGE'.

  LS_FCAT-SCRTEXT_M = '##'.

  LS_FCAT-COL_POS = 15.

  LS_FCAT-OUTPUTLEN = 13.

  LS_FCAT-EDIT = 'X'.

  LS_FCAT-QFIELDNAME = 'MEINS'.

  APPEND LS_FCAT TO GT_FIELDCAT_ITEM.



  " MEINS

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'MEINS'.

  LS_FCAT-SCRTEXT_M = '##'.

  LS_FCAT-COL_POS = 16.

  LS_FCAT-OUTPUTLEN = 5.

  LS_FCAT-EDIT = 'X'.

  APPEND LS_FCAT TO GT_FIELDCAT_ITEM.



  " BPRME

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'NETPR'.

  LS_FCAT-SCRTEXT_M = '##'.

  LS_FCAT-COL_POS = 17.

  LS_FCAT-OUTPUTLEN = 15.

  LS_FCAT-EDIT = 'X'.

  LS_FCAT-CFIELDNAME = 'WAERS'.

  APPEND LS_FCAT TO GT_FIELDCAT_ITEM.



  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'WAERS'.

  LS_FCAT-SCRTEXT_M = '##'.

  LS_FCAT-COL_POS = 18.

  LS_FCAT-OUTPUTLEN = 5.

  APPEND LS_FCAT TO GT_FIELDCAT_ITEM.



  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'MWSKZ'.

  LS_FCAT-SCRTEXT_M = '####'.

  LS_FCAT-COL_POS = 19.

  LS_FCAT-OUTPUTLEN = 5.

  LS_FCAT-REF_TABLE = 'zedt10_mwskz'.

  LS_FCAT-REF_FIELD = 'MWSKZ'.

  LS_FCAT-EDIT = 'X'.

  APPEND LS_FCAT TO GT_FIELDCAT_ITEM.



  " PRDAT

  CLEAR LS_FCAT.

  LS_FCAT-F4AVAILABL = 'X'.

  LS_FCAT-REF_TABLE = 'SYST'.

  LS_FCAT-REF_FIELD = 'DATUM'.

  LS_FCAT-FIELDNAME = 'PRDAT'.

  LS_FCAT-SCRTEXT_M = '###'.

  LS_FCAT-COLTEXT = '###'.

  LS_FCAT-COL_POS = 20.

  LS_FCAT-EDIT = 'X'.

  APPEND LS_FCAT TO GT_FIELDCAT_ITEM.



  " WERKS

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'WERKS'.

  LS_FCAT-SCRTEXT_M = '###'.

  LS_FCAT-COL_POS = 21.

  LS_FCAT-OUTPUTLEN = 6.

  LS_FCAT-EDIT = 'X'.

  APPEND LS_FCAT TO GT_FIELDCAT_ITEM.



  " LGORT

  CLEAR LS_FCAT.

  LS_FCAT-FIELDNAME = 'LGORT'.

  LS_FCAT-SCRTEXT_M = '####'.

  LS_FCAT-COL_POS = 22.

  LS_FCAT-OUTPUTLEN = 6.

  LS_FCAT-EDIT = 'X'.

  APPEND LS_FCAT TO GT_FIELDCAT_ITEM.






*  CLEAR LS_FCAT.

*  LS_FCAT-FIELDNAME = 'LOEVM'.

*  LS_FCAT-SCRTEXT_M = '####'.

*  LS_FCAT-COL_POS = 99.           "# # ## ##"

*  LS_FCAT-OUTPUTLEN = 1.

*  LS_FCAT-NO_OUT = 'X'.           "# [##] ### ## ##"

*  LS_FCAT-NO_ZERO = 'X'.

*  APPEND LS_FCAT TO GT_FIELDCAT_ITEM.




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

  GS_LAYOUT-ZEBRA = 'X'.          " ###

  GS_LAYOUT-SEL_MODE = 'A'.       " ## ## ##

  GS_LAYOUT-CWIDTH_OPT = ' '.     " ## ## ###

  GS_LAYOUT-STYLEFNAME = 'CELLTAB'. " Cell ###

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



  CALL METHOD GO_ALV_ITEM->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING




*     I_BUFFER_ACTIVE =

*     I_BYPASSING_BUFFER            =

*     I_CONSISTENCY_CHECK           =

*     I_STRUCTURE_NAME              =

*     IS_VARIANT      =

*     I_SAVE          =

*     I_DEFAULT       = 'X'




      IS_LAYOUT       = GS_LAYOUT




*     IS_PRINT        =

*     IT_SPECIAL_GROUPS             =

*     IT_TOOLBAR_EXCLUDING          =

*     IT_HYPERLINK    =

*     IT_ALV_GRAPHICS =

*     IT_EXCEPT_QINFO =

*     IR_SALV_ADAPTER =




    CHANGING

      IT_OUTTAB       = GT_ITEM

      IT_FIELDCATALOG = GT_FIELDCAT_ITEM




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

*&      Form  REGI_EVENT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM REGI_EVENT .

  SET HANDLER GO_EVENT_HANDLER->HANDLE_TOOLBAR      FOR GO_ALV_ITEM.

  SET HANDLER GO_EVENT_HANDLER->HANDLE_USER_COMMAND FOR GO_ALV_ITEM.



  SET HANDLER GO_EVENT_HANDLER->HANDLE_ON_F4 FOR GO_ALV_ITEM.

  DATA: LT_F4 TYPE LVC_T_F4,

        LS_F4 TYPE LVC_S_F4.

  " F4 #### # ## ##

  CLEAR LS_F4.

  LS_F4-FIELDNAME  = 'MATNR'. " # #### F4# ### #### ###

  LS_F4-REGISTER   = 'X'.     " ### ##

  LS_F4-GETBEFORE  = 'X'.     " (##) F4 ## # ### ### ##

  LS_F4-CHNGEAFTER = 'X'.     " (##) F4 ## # ### ## ## ##

  APPEND LS_F4 TO LT_F4.



  " ALV# F4 ## ## ##

  CALL METHOD GO_ALV_ITEM->REGISTER_F4_FOR_FIELDS

    EXPORTING

      IT_F4 = LT_F4.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  REFRESH_ALV

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM REFRESH_ALV .

  CALL METHOD GO_ALV_ITEM->CHECK_CHANGED_DATA




*    IMPORTING

*      E_VALID   =

*    CHANGING

*      C_REFRESH = 'X'




    .

  .

  CALL METHOD GO_ALV_ITEM->REFRESH_TABLE_DISPLAY.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SAVE_DATA

*&---------------------------------------------------------------------*




FORM SAVE_DATA .

  IF PR_SEAR = 'X'.

    " #######################################################

    " [Soft Delete ##] GT_ITEM# LOEVM ## #### ##

    " #######################################################

    DATA: LT_EKPO     TYPE TABLE OF ZEDT10_EKPO,

          LS_EKPO     TYPE ZEDT10_EKPO,

          LT_DEL_EKPO TYPE TABLE OF ZEDT10_EKPO,

          LS_DEL_EKPO TYPE ZEDT10_EKPO.



    CLEAR: LT_EKPO, LT_DEL_EKPO.



    " #####################################################

    " Step 1: ## ### ## ## (LOEVM = 'L')

    " #####################################################

    LOOP AT GT_ITEM INTO GS_ITEM

      WHERE LOEVM = 'L' AND EBELN IS NOT INITIAL.



      CLEAR LS_DEL_EKPO.

      MOVE-CORRESPONDING GS_ITEM TO LS_DEL_EKPO.

      LS_DEL_EKPO-LOEVM = 'L'.



      APPEND LS_DEL_EKPO TO LT_DEL_EKPO.

    ENDLOOP.



    " #####################################################

    " Step 2: ## ## ## DB ####

    " #####################################################

    IF LT_DEL_EKPO IS NOT INITIAL.

      MODIFY ZEDT10_EKPO FROM TABLE LT_DEL_EKPO.



      IF SY-SUBRC <> 0.

        MESSAGE '## ## ## ##' TYPE 'E'.

        ROLLBACK WORK.

        RETURN.

      ENDIF.

    ENDIF.



    " #####################################################

    " Step 3: ## ## ## (LOEVM <> 'L')

    " #####################################################

    LOOP AT GT_ITEM INTO GS_ITEM

      WHERE LOEVM <> 'L'.



      CLEAR LS_EKPO.

      MOVE-CORRESPONDING GS_ITEM TO LS_EKPO.

      LS_EKPO-LOEVM = SPACE.  " # ## ##



      APPEND LS_EKPO TO LT_EKPO.

    ENDLOOP.



    " #####################################################

    " Step 4: ## ## DB ##

    " #####################################################

    IF LT_EKPO IS NOT INITIAL.

      MODIFY ZEDT10_EKPO FROM TABLE LT_EKPO.



      IF SY-SUBRC <> 0.

        MESSAGE 'PO ## ##' TYPE 'E'.

        ROLLBACK WORK.

        RETURN.

      ENDIF.

    ENDIF.



    " #####################################################

    " Step 5: ## ##

    " #####################################################

    COMMIT WORK AND WAIT.



    IF SY-SUBRC = 0.

      MESSAGE 'PO ## ##' TYPE 'S'.

    ELSE.

      MESSAGE 'PO ## ##' TYPE 'E'.

    ENDIF.

  ENDIF.

ENDFORM.






**&---------------------------------------------------------------------*

**&      Form  SAVE_DATA

**&---------------------------------------------------------------------*

**       text

**----------------------------------------------------------------------*

**  -->  p1        text

**  <--  p2        text

**----------------------------------------------------------------------*

*FORM SAVE_DATA .

*  IF PR_SEAR = 'X'.

** ####### ##

** EKPO ### ## (MENGE, MEINS # ## ##)

*    DATA: LT_EKPO TYPE TABLE OF ZEDT10_EKPO,

*          LT_EKKO TYPE TABLE OF ZEDT10_EKKO.

*    CLEAR: LT_EKKO, LT_EKPO.

*

*    MOVE-CORRESPONDING GT_ITEM[] TO LT_EKPO[].

*    MODIFY ZEDT10_EKPO FROM TABLE LT_EKPO.

*

*    MOVE-CORRESPONDING GT_ITEM[] TO LT_EKKO[].

*    MODIFY ZEDT10_EKKO FROM TABLE LT_EKKO.

*

*    IF SY-SUBRC = 0.

*      COMMIT WORK AND WAIT.

*      MESSAGE 'PO ## ##' TYPE 'S'.

*    ELSE.

*      ROLLBACK WORK.

*      MESSAGE 'PO ## ##' TYPE 'E'.

*    ENDIF.

*  ENDIF.

*ENDFORM.

*&---------------------------------------------------------------------*

*&      Module  EDIT_SCREEN  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE EDIT_SCREEN OUTPUT.

  DATA: LT_DEACT_TXT TYPE C LENGTH 1.

  IF PR_CREA = 'X'.

    LT_DEACT_TXT = '2'.

  ELSEIF PR_SEAR = 'X'.

    LT_DEACT_TXT = '1'.

  ENDIF.



  LOOP AT SCREEN.

    IF SCREEN-NAME CS LT_DEACT_TXT.

      SCREEN-ACTIVE = 0.

      MODIFY SCREEN.

    ENDIF.

  ENDLOOP.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Form  HANDLE_USER_COMMAND

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM HANDLE_USER_COMMAND USING E_UCOMM.

  DATA: LT_SELECTED_ROWS TYPE LVC_T_ROW,

        LS_SELECTED_ROW  TYPE LVC_S_ROW,

        LS_ITEM          LIKE LINE OF GT_ITEM. " GT_ITEM# ## ### ###

  DATA:         LS_EKPO          TYPE ZEDT10_EKPO.



  CASE E_UCOMM.

      " (1) ## ## ##

    WHEN 'ADD_ROW'.

      CLEAR LS_ITEM.

      " ##### ### ## (#: ### ## ## ## ## #)

      PERFORM SET_DEFAULT_ROW.



      " ## ##

      PERFORM REFRESH_ALV.



      " (2) ## ## ##

    WHEN 'DEL_ROW'.

      " #######################################################

      " [Soft Delete] LOEVM = 'L' # ## ##

      " #######################################################

      GO_ALV_ITEM->GET_SELECTED_ROWS( IMPORTING ET_INDEX_ROWS = LT_SELECTED_ROWS ).



      IF LT_SELECTED_ROWS IS INITIAL.

        MESSAGE '### ## #####.' TYPE 'S' DISPLAY LIKE 'E'.

        RETURN.

      ENDIF.



      " ##### ## (### ## ##)

      SORT LT_SELECTED_ROWS BY INDEX DESCENDING.

      LOOP AT LT_SELECTED_ROWS INTO LS_SELECTED_ROW.

        READ TABLE GT_ITEM INTO GS_ITEM INDEX LS_SELECTED_ROW-INDEX.



        IF SY-SUBRC = 0.

          " DB# ### ## # (EBELN ##)

          IF GS_ITEM-EBELN IS NOT INITIAL.

            GS_ITEM-LOEVM = 'L'.  " # Soft Delete: ## ### ##

            MODIFY GT_ITEM FROM GS_ITEM

              INDEX LS_SELECTED_ROW-INDEX

              TRANSPORTING LOEVM.



            CLEAR LS_EKPO.

            LS_EKPO-MANDT = SY-MANDT.

            LS_EKPO-EBELN = GS_ITEM-EBELN.

            LS_EKPO-EBELP = GS_ITEM-EBELP.

            LS_EKPO-LOEVM = 'L'.



            UPDATE ZEDT10_EKPO SET LOEVM = 'L'

                WHERE EBELN = GS_ITEM-EBELN

                AND EBELP = GS_ITEM-EBELP.



            IF SY-SUBRC <> 0.

              MESSAGE '## ## ## ##' TYPE 'E'.

              ROLLBACK WORK.

              RETURN.

            ENDIF.



            COMMIT WORK AND WAIT.  " # # ## ##

          ELSE.

            " ## # (## DB ###)

            DELETE GT_ITEM INDEX LS_SELECTED_ROW-INDEX.

          ENDIF.

        ENDIF.

      ENDLOOP.



      PERFORM GET_DATA.

      PERFORM REFRESH_ALV.

      MESSAGE '## ### ## #######.' TYPE 'S'.






*      " ### # ####

*      GO_ALV_ITEM->GET_SELECTED_ROWS( IMPORTING ET_INDEX_ROWS = LT_SELECTED_ROWS ).

*

*      IF LT_SELECTED_ROWS IS INITIAL.

*        MESSAGE '### ## #####.' TYPE 'S' DISPLAY LIKE 'E'.

*        RETURN.

*      ENDIF.

*

*      " ##### #### ### ## ##

*      SORT LT_SELECTED_ROWS BY INDEX DESCENDING.

*      LOOP AT LT_SELECTED_ROWS INTO LS_SELECTED_ROW.

*        READ TABLE GT_ITEM INTO GS_ITEM INDEX LS_SELECTED_ROW-INDEX.

*

*        " [##] ## ####, DB# ## ## ##### ## ### ##

*        IF PR_SEAR = 'X' AND GS_ITEM-EBELN IS NOT INITIAL.

*          DATA: LS_DEL_EKPO TYPE ZEDT10_EKPO.

*          MOVE-CORRESPONDING GS_ITEM TO LS_DEL_EKPO.

*          APPEND LS_DEL_EKPO TO GT_DELETED.

*        ENDIF.

*        DELETE GT_ITEM INDEX LS_SELECTED_ROW-INDEX.

*      ENDLOOP.

*

*      " ## ##

*      PERFORM REFRESH_ALV.






      " (3) PO ## ##

    WHEN 'CREATE_PO'.

      IF GT_ITEM IS INITIAL.

        MESSAGE 'PO# ### ### ####.' TYPE 'S' DISPLAY LIKE 'E'.

        RETURN.

      ENDIF.



      PERFORM CREATE_PO_LOGIC.

      PERFORM REFRESH_ALV.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_PO_LOGIC

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*

*FORM CREATE_PO_LOGIC .

*  DATA: LV_MAX_EBELN    TYPE EBELN.

*  DATA: LV_NEW_EBELN    TYPE EBELN.

*  DATA: LV_LIFNR        TYPE LIFNR.

*  DATA: LV_MWSKZ        TYPE MWSKZ.

*  DATA: LS_EKKO         TYPE ZEDT10_EKKO.

*  DATA: LS_EKPO         TYPE ZEDT10_EKPO.

*  DATA: LV_EBELP        TYPE EBELP.

*  DATA: LV_COUNTER      TYPE I.

*  DATA: LV_MATNR     TYPE MATNR. " [##] ## ### ##

*

*  " [## 1] ### #### ### ## ##

*  IF GT_ITEM IS INITIAL.

*    MESSAGE '### PO #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

*    EXIT.

*  ENDIF.

*

*  " [## 2] ## ### ## (Validation Loop)

*  " ##(INSERT)# #### ## #### #### ## #### #

*  LOOP AT GT_ITEM INTO GS_ITEM WHERE LOEVM <> 'L'.

*

*    " 1) ### ##

*    IF GS_ITEM-MATNR IS INITIAL OR GS_ITEM-MENGE IS INITIAL OR

*       GS_ITEM-NETPR IS INITIAL OR GS_ITEM-WERKS IS INITIAL.

*      MESSAGE '##, ##, ##, #### ## #####.' TYPE 'S' DISPLAY LIKE 'E'.

*      EXIT.

*    ENDIF.

*

*    " 2) #### ## (## ## ##)

*    SELECT SINGLE LIFNR INTO LV_LIFNR FROM ZEDT10_LFA1 WHERE LIFNR = GS_ITEM-LIFNR.

*    IF SY-SUBRC <> 0.

*      MESSAGE '#### ## ####(LIFNR)###.' TYPE 'S' DISPLAY LIKE 'E'.

*      EXIT.

*    ENDIF.

*

*    " 3) #### ## (## ## ##)

*    SELECT SINGLE MWSKZ INTO LV_MWSKZ FROM ZEDT10_LFM1 WHERE LIFNR = GS_ITEM-LIFNR.

*    IF SY-SUBRC <> 0.

*      MESSAGE '## ##### ####(MWSKZ) ### ####.' TYPE 'S' DISPLAY LIKE 'E'.

*      EXIT.

*    ENDIF.

*

*    " 4) ### ## (## ## ##)

*    IF GS_ITEM-PRDAT < GS_ITEM-BEDAT.

*      MESSAGE '###(PRDAT)# PO###(BEDAT)## ## # ####.' TYPE 'S' DISPLAY LIKE 'E'.

*      EXIT.

*    ENDIF.

*

*    " 5) [##] ## ### ### ##

*    SELECT SINGLE MATNR INTO LV_MATNR FROM ZMARA10 WHERE MATNR = GS_ITEM-MATNR.

*    IF SY-SUBRC <> 0.

*      MESSAGE '#### ## ##(MATNR)###.' TYPE 'S' DISPLAY LIKE 'E'.

*      EXIT.

*    ENDIF.

*  ENDLOOP.

*

*  " # Loop## ### #### EXIT ###, Form# ##

*  IF SY-SUBRC <> 0.

*    RETURN.

*  ENDIF.

*

** Step 1: ZEDT10_EKKO## ## EBELN ##

*  SELECT MAX( EBELN ) INTO LV_MAX_EBELN FROM ZEDT10_EKKO.

*  IF SY-SUBRC <> 0.

*    LV_MAX_EBELN = 0.

*  ENDIF.

*

** Step 2: ## ## ## (## + ##)

*  LV_NEW_EBELN = LV_MAX_EBELN + 1.

** #: 4500000001 # 4500000002

*

** ## #####:

*  LOOP AT GT_ITEM INTO GS_ITEM WHERE LOEVM <> 'L'.

*

** (1) LIFNR ## ##

*    SELECT SINGLE LIFNR FROM ZEDT10_LFA1

*      INTO LV_LIFNR WHERE LIFNR = GS_ITEM-LIFNR.

*    IF SY-SUBRC <> 0.

*      MESSAGE 'LIFNR #### ##' TYPE 'E'.

*      EXIT.

*    ENDIF.

*

** (2) MWSKZ ### (LFM1 ##)

*    SELECT SINGLE MWSKZ FROM ZEDT10_LFM1

*      INTO LV_MWSKZ

*      WHERE LIFNR EQ GS_ITEM-LIFNR

*        AND EKORG EQ GS_ITEM-EKORG.

*    IF SY-SUBRC NE 0.

*      MESSAGE |{ GS_ITEM-LIFNR } { GS_ITEM-EKORG }| TYPE 'E'.

*      ROLLBACK WORK. EXIT.

*    ENDIF.

*

** (3) PRDAT >= BEDAT (### >= ###)

*    IF GS_ITEM-PRDAT < GS_ITEM-BEDAT.

*      MESSAGE 'PRDAT# BEDAT## ## #' TYPE 'E'.

*      EXIT.

*    ENDIF.

*

*  ENDLOOP.

*

** STEP 3: ZEDT10_EKKO ## INSERT

*  CLEAR LS_EKKO.

*  LS_EKKO-MANDT   = SY-MANDT.

*  LS_EKKO-EBELN   = LV_NEW_EBELN.

*  LS_EKKO-BUKRS   = P_BUKRS1.

*  LS_EKKO-EKGRP   = GS_ITEM-EKGRP.

*  LS_EKKO-EKORG   = GS_ITEM-EKORG.

*  LS_EKKO-LIFNR   = GS_ITEM-LIFNR.

*  LS_EKKO-BEDAT   = GS_ITEM-BEDAT.

*  LS_EKKO-WAERS   = GS_ITEM-WAERS.

*

*  INSERT INTO ZEDT10_EKKO VALUES LS_EKKO.

*  IF SY-SUBRC <> 0.

*    MESSAGE 'EKKO INSERT ##' TYPE 'E'.

*    ROLLBACK WORK.

*    EXIT.

*  ENDIF.

*

** Step 4: ZEDT10_EKPO ### INSERT (##)

*  LOOP AT GT_ITEM INTO GS_ITEM.

*    CLEAR LS_EKPO.

*    LS_EKPO-MANDT  = SY-MANDT.

*    LS_EKPO-EBELN  = LV_NEW_EBELN.

*    LS_EKPO-EBELP  = GS_ITEM-EBELP.  " 10, 20, 30...

*    LS_EKPO-MATNR  = GS_ITEM-MATNR.

*    LS_EKPO-MAKTX  = GS_ITEM-MAKTX.

*    LS_EKPO-MENGE  = GS_ITEM-MENGE.

*    LS_EKPO-MEINS  = GS_ITEM-MEINS.

*    LS_EKPO-NETPR  = GS_ITEM-NETPR.

*    LS_EKPO-BPRME  = GS_ITEM-MEINS. " ### ##

*    LS_EKPO-PRDAT  = GS_ITEM-PRDAT.

*    LS_EKPO-WERKS  = GS_ITEM-WERKS.

*    LS_EKPO-LGORT  = GS_ITEM-LGORT.

*

*    INSERT INTO ZEDT10_EKPO VALUES LS_EKPO.

*    IF SY-SUBRC <> 0.

*      MESSAGE 'EKPO INSERT ##' TYPE 'E'.

*      ROLLBACK WORK.

*      EXIT.

*    ENDIF.

*  ENDLOOP.

*

** Step 5: COMMIT

*  COMMIT WORK AND WAIT.

*  IF SY-SUBRC = 0.

*    MESSAGE 'PO ## ##' TYPE 'S'.

*  ELSE.

*    ROLLBACK WORK.

*    MESSAGE 'PO ## ##' TYPE 'E'.

*  ENDIF.

*

*ENDFORM.




FORM CREATE_PO_LOGIC .

  DATA: LV_MAX_EBELN    TYPE EBELN.

  DATA: LV_NEW_EBELN    TYPE EBELN.

  DATA: LV_LIFNR        TYPE LIFNR.

  DATA: LV_MWSKZ        TYPE MWSKZ.

  DATA: LS_EKKO         TYPE ZEDT10_EKKO.

  DATA: LS_EKPO         TYPE ZEDT10_EKPO.

  DATA: LV_EBELP        TYPE EBELP.

  DATA: LV_COUNTER      TYPE I.

  DATA: LV_MATNR        TYPE MATNR.



  " [## 1] ### #### ### ## ##

  IF GT_ITEM IS INITIAL.

    MESSAGE '### PO #### ####.' TYPE 'S' DISPLAY LIKE 'E'.

    EXIT.

  ENDIF.



  " [## 2] ## ### ## (Validation Loop 1)

  LOOP AT GT_ITEM INTO GS_ITEM WHERE LOEVM <> 'L'.

    " 1) ### ##

    IF GS_ITEM-MATNR IS INITIAL OR GS_ITEM-MENGE IS INITIAL OR

       GS_ITEM-NETPR IS INITIAL OR GS_ITEM-WERKS IS INITIAL.

      MESSAGE '##, ##, ##, #### ## #####.' TYPE 'S' DISPLAY LIKE 'E'.

      RETURN. " <--- EXIT ## RETURN ## ## (Form# ## ##)

    ENDIF.



    " 2) #### ##

    SELECT SINGLE LIFNR INTO LV_LIFNR FROM ZEDT10_LFA1 WHERE LIFNR = GS_ITEM-LIFNR.

    IF SY-SUBRC <> 0.

      MESSAGE '#### ## ####(LIFNR)###.' TYPE 'S' DISPLAY LIKE 'E'.

      RETURN.

    ENDIF.



    " 3) #### ##

    SELECT SINGLE MWSKZ INTO LV_MWSKZ FROM ZEDT10_LFM1 WHERE LIFNR = GS_ITEM-LIFNR.

    IF SY-SUBRC <> 0.

      MESSAGE '## ##### ####(MWSKZ) ### ####.' TYPE 'S' DISPLAY LIKE 'E'.

      RETURN.

    ENDIF.



    " 4) ### ##

    IF GS_ITEM-PRDAT < GS_ITEM-BEDAT.

      MESSAGE '###(PRDAT)# PO###(BEDAT)## ## # ####.' TYPE 'S' DISPLAY LIKE 'E'.

      RETURN.

    ENDIF.



    " 5) ## ### ### ##

    SELECT SINGLE MATNR INTO LV_MATNR FROM ZMARA10 WHERE MATNR = GS_ITEM-MATNR.

    IF SY-SUBRC <> 0.

      MESSAGE '#### ## ##(MATNR)###.' TYPE 'S' DISPLAY LIKE 'E'.

      RETURN.

    ENDIF.

  ENDLOOP.





  " Step 1: ZEDT10_EKKO## ## EBELN ##

  SELECT MAX( EBELN ) INTO LV_MAX_EBELN FROM ZEDT10_EKKO.

  IF SY-SUBRC <> 0.

    LV_MAX_EBELN = 0.

  ENDIF.



  " Step 2: ## ## ##

  LV_NEW_EBELN = LV_MAX_EBELN + 1.





  " [## ##] ## ##### (### ######)

  LOOP AT GT_ITEM INTO GS_ITEM WHERE LOEVM <> 'L'.



    " (1) LIFNR ## ##

    SELECT SINGLE LIFNR FROM ZEDT10_LFA1

      INTO LV_LIFNR WHERE LIFNR = GS_ITEM-LIFNR.

    IF SY-SUBRC <> 0.

      " [##] TYPE 'E' -> TYPE 'S' DISPLAY LIKE 'E'

      " [##] EXIT -> RETURN (## ## ## ##)

      MESSAGE 'LIFNR #### ##' TYPE 'S' DISPLAY LIKE 'E'.

      RETURN.

    ENDIF.



    " (2) MWSKZ ### (LFM1 ##)

    SELECT SINGLE MWSKZ FROM ZEDT10_LFM1

      INTO LV_MWSKZ

      WHERE LIFNR EQ GS_ITEM-LIFNR

        AND EKORG EQ GS_ITEM-EKORG.

    IF SY-SUBRC NE 0.

      " [##] ## ## # ## ##

      MESSAGE |{ GS_ITEM-LIFNR } { GS_ITEM-EKORG } #### ##| TYPE 'S' DISPLAY LIKE 'E'.

      RETURN.

    ENDIF.



    " (3) PRDAT >= BEDAT (### >= ###)

    IF GS_ITEM-PRDAT < GS_ITEM-BEDAT.

      " [##] ## ## # ## ##

      MESSAGE 'PRDAT# BEDAT## ## #' TYPE 'S' DISPLAY LIKE 'E'.

      RETURN.

    ENDIF.



  ENDLOOP.



  " --- ### #### ## ## ### ### ---



  " STEP 3: ZEDT10_EKKO ## INSERT

  CLEAR LS_EKKO.

  LS_EKKO-MANDT   = SY-MANDT.

  LS_EKKO-EBELN   = LV_NEW_EBELN.

  LS_EKKO-BUKRS   = P_BUKRS1.

  LS_EKKO-EKGRP   = GS_ITEM-EKGRP.

  LS_EKKO-EKORG   = GS_ITEM-EKORG.

  LS_EKKO-LIFNR   = GS_ITEM-LIFNR.

  LS_EKKO-BEDAT   = GS_ITEM-BEDAT.

  LS_EKKO-WAERS   = GS_ITEM-WAERS.



  INSERT INTO ZEDT10_EKKO VALUES LS_EKKO.

  IF SY-SUBRC <> 0.

    MESSAGE 'EKKO INSERT ##' TYPE 'S' DISPLAY LIKE 'E'.

    ROLLBACK WORK.

    RETURN.

  ENDIF.



  " Step 4: ZEDT10_EKPO ### INSERT (##)

  LOOP AT GT_ITEM INTO GS_ITEM.

    CLEAR LS_EKPO.

    LS_EKPO-MANDT  = SY-MANDT.

    LS_EKPO-EBELN  = LV_NEW_EBELN.

    LS_EKPO-EBELP  = GS_ITEM-EBELP.

    LS_EKPO-MATNR  = GS_ITEM-MATNR.

    LS_EKPO-MAKTX  = GS_ITEM-MAKTX.

    LS_EKPO-MENGE  = GS_ITEM-MENGE.

    LS_EKPO-MEINS  = GS_ITEM-MEINS.

    LS_EKPO-NETPR  = GS_ITEM-NETPR.

    LS_EKPO-BPRME  = GS_ITEM-MEINS.

    LS_EKPO-PRDAT  = GS_ITEM-PRDAT.

    LS_EKPO-WERKS  = GS_ITEM-WERKS.

    LS_EKPO-LGORT  = GS_ITEM-LGORT.

    LS_EKPO-LOEVM  = GS_ITEM-LOEVM. " ## ### ## ##



    INSERT INTO ZEDT10_EKPO VALUES LS_EKPO.

    IF SY-SUBRC <> 0.

      MESSAGE 'EKPO INSERT ##' TYPE 'S' DISPLAY LIKE 'E'.

      ROLLBACK WORK.

      RETURN.

    ENDIF.

  ENDLOOP.



  " Step 5: COMMIT

  COMMIT WORK AND WAIT.

  IF SY-SUBRC = 0.

    CLEAR: GT_ITEM.

    MESSAGE 'PO ## ##' TYPE 'S'.

  ELSE.

    ROLLBACK WORK.

    MESSAGE 'PO ## ##' TYPE 'S' DISPLAY LIKE 'E'.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_DEFAULT_ROW

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      <--P_LS_ITEM  text

*----------------------------------------------------------------------*




FORM SET_DEFAULT_ROW.

  DATA: LS_ITEM LIKE GS_ITEM.

  DATA: LV_MAX_IND  TYPE I VALUE 0,

        LV_TEMP_IND TYPE I,

        LS_CELL_TAB TYPE LVC_S_STYL.

  " #### ###




*    P_BUKRS1 TYPE BUKRS MATCHCODE OBJECT ZSH10_BUKRS MODIF ID MC,

*  P_LIFNR1 TYPE LIFNR MATCHCODE OBJECT ZSH10_LIFNR MODIF ID MC,

*  P_BEDAT1 TYPE BEDAT MODIF ID MC.






  LOOP AT GT_ITEM INTO GS_ITEM.

    LV_TEMP_IND = GS_ITEM-EBELP.

    IF LV_TEMP_IND >= LV_MAX_IND.

      LV_MAX_IND = LV_TEMP_IND.

    ENDIF.

  ENDLOOP.



  CLEAR GS_ITEM.



  LV_MAX_IND = LV_MAX_IND + 10.



  MOVE-CORRESPONDING GS_LFM1 TO LS_ITEM.



  UNPACK LV_MAX_IND TO LS_ITEM-EBELP.

  " --- [## ## ##] ---

  IF PR_CREA = 'X'.

    " 1) ## ##: ## #### ## (## ##)

    LS_ITEM-BUKRS = P_BUKRS1.

    LS_ITEM-LIFNR = P_LIFNR1.

    LS_ITEM-BEDAT = P_BEDAT1.

    LS_ITEM-WAERS = GS_LFM1-WAERS.  " KRW

    LS_ITEM-MWSKZ = GS_LFM1-MWSKZ. " ## # ### ####



  ELSE.

    " 2) ## ##: ## ### ## ## ## (## ##)

    " ## #### # ## ### ## ## ##

    READ TABLE GT_ITEM INTO GS_ITEM INDEX 1.

    IF SY-SUBRC = 0.

      LS_ITEM-EBELN = GS_ITEM-EBELN. " [##] PO## ##

      LS_ITEM-BUKRS = GS_ITEM-BUKRS.

      LS_ITEM-LIFNR = GS_ITEM-LIFNR.

      LS_ITEM-BEDAT = GS_ITEM-BEDAT.

      LS_ITEM-WAERS = GS_ITEM-WAERS.

      LS_ITEM-EKGRP = GS_ITEM-EKGRP.

      LS_ITEM-EKORG = GS_ITEM-EKORG.

      LS_ITEM-MWSKZ = GS_ITEM-MWSKZ.

    ENDIF.

  ENDIF.

  " --- [## ## #] ---



  " ## ###

  LS_ITEM-MEINS = C_MEINS.

  LS_ITEM-MENGE = C_MENGE.



  APPEND LS_ITEM TO GT_ITEM.




*  LS_ITEM-BUKRS = P_BUKRS1.

*  LS_ITEM-LIFNR = P_LIFNR1.

*  LS_ITEM-BEDAT = P_BEDAT1.

*  LS_ITEM-WAERS = C_WAERS.

*  LS_ITEM-MEINS = C_MEINS.

*  LS_ITEM-MENGE = C_MENGE.

*  LS_ITEM-MWSKZ = GS_LFM1-MWSKZ.

*

*  APPEND LS_ITEM TO GT_ITEM.




ENDFORM.