
*&---------------------------------------------------------------------*

*&  Include           ZEDR022_PRACTICE008_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SET_DATE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




"## ### ##### ## default# ###### ##,

"### ##+#+01~### ## ## ###### ## FIX

"ZORDNO : ####

"ZJDATE : ####

FORM SET_DATE .

  IF S_ZJDATE[] IS INITIAL.

    S_ZJDATE-LOW = SY-DATUM(6) && '01'.

    S_ZJDATE-HIGH = SY-DATUM(6) && '01'.

    S_ZJDATE-SIGN = 'I'.

    S_ZJDATE-OPTION = 'BT'.



    CALL FUNCTION 'LAST_DAY_OF_MONTHS'

      exporting

        DAY_IN            = S_ZJDATE-HIGH

      importing

        LAST_DAY_OF_MONTH = S_ZJDATE-HIGH.



    APPEND S_ZJDATE.

  ENDIF.



  IF S_ZDDATE[] IS INITIAL.

    S_ZDDATE-LOW = SY-DATUM(6) && '01'.

    S_ZDDATE-HIGH = SY-DATUM(6) && '01'.

    S_ZDDATE-SIGN = 'I'.

    S_ZDDATE-OPTION = 'BT'.

    CALL FUNCTION 'LAST_DAY_OF_MONTHS'

      exporting

        DAY_IN            =     S_ZDDATE-HIGH

      importing

        LAST_DAY_OF_MONTH =     S_ZDDATE-HIGH.

    APPEND S_ZDDATE.

  ENDIF.





ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_DATA .

  " #### ## #

  IF P_R1 = C_X.

    IF S_ZJDATE IS INITIAL.

      IF S_ZORDNO IS INITIAL.

        MESSAGE I001.

        STOP.

      ENDIF.

    ENDIF.

  " #### ## #

  ELSEIF P_R2 = C_X.

    IF S_ZDDATE IS INITIAL.

      IF S_ZORDNO IS INITIAL.

        MESSAGE I001.

        STOP.

      ENDIF.

    ENDIF.

  ENDIF.



" ##### ## ### ## ##

CASE 'X'.

  " #### ## #

  WHEN P_R1.

    R_FG-SIGN = 'I'.

    R_FG-OPTION = 'EQ'.

    R_FG-LOW = '1'.  " ####

    APPEND R_FG.



    " #### ## #

    IF P_CH1 = C_X.

      R_FG-LOW = '2'.  " ####

      APPEND R_FG.

    ENDIF.



  " #### ## #

  WHEN P_R2.

    R_ZG-SIGN = 'I'.

    R_ZG-OPTION = 'EQ'.

    R_ZG-LOW = ' '.  " ####

    APPEND R_ZG.



    " #### ## #

    IF P_CH1 = C_X.

      R_ZG-LOW = C_X.  " ####

      APPEND R_ZG.

    ENDIF.



ENDCASE.





  " ##### ## ### ## ##

"  IF P_R1 = C_X.

"    R_FG-SIGN = 'I'.

"    R_FG-OPTION = 'EQ'.

"    R_FG-LOW = '1'.  " ####

"    APPEND R_FG.

"    IF P_CH1 = C_X.

"      R_FG-LOW = '2'.  " ####

"      APPEND R_FG.

"    ENDIF.

"  ELSEIF P_R2 = C_X.

"    R_ZG-SIGN = 'I'.

"    R_ZG-OPTION = 'EQ'.

"    R_ZG-LOW = ' '.  " ####

"    APPEND R_ZG.

"    IF P_CH1 = C_X.

"      R_ZG-LOW = C_X.  " ####

"      APPEND R_ZG.

"    ENDIF.

"  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_SCREEN

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SCREEN_CONTROL .

    LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'M2'."####

      IF P_R1 = 'X'."####

        SCREEN-ACTIVE = '0'.

      ELSEIF P_R2 = 'X'."####

        SCREEN-ACTIVE = '1'.

      ENDIF.

    ELSEIF SCREEN-GROUP1 = 'M1'."####

      IF P_R1 = 'X'."## ##

        SCREEN-ACTIVE = '1'.

      ELSEIF P_R2 = 'X'."####

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA_R1

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_ORDER .

  SELECT * FROM ZEDT022_100

    INTO CORRESPONDING FIELDS OF TABLE GT_ORDER

    WHERE ZORDNO IN S_ZORDNO

    AND ZIDCODE IN S_ZID

    AND ZMATNR IN S_ZMATNR

    AND ZJDATE IN S_ZJDATE

    AND ZSALE_FG IN R_FG.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA_R1

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_ORDER ."### ### -> ALV #### ##



  LOOP AT GT_ORDER INTO GS_ORDER.

    MOVE-CORRESPONDING GS_ORDER TO GS_100.



    " #### ## # ##### ##

    PERFORM ZMTART_NAME USING GS_ORDER-ZMTART

                        CHANGING GS_100-ZMAT_NAME.



    CASE GS_ORDER-ZSALE_FG.

      WHEN '1'.

        GS_100-ZSALE_NAME = '##'.

        GS_100-ICON = '@08@'. " ### ### (####)

      WHEN '2'.

        GS_100-ZSALE_NAME = '##'.

        GS_100-ICON = '@0A@'. " ### ### (##)

      WHEN OTHERS.

        GS_100-ZSALE_NAME = '##'.

        GS_100-ICON = '@0B@'. " ## ### (##)

    ENDCASE.





    " #### (#### ON# ## ##)

    IF P_CH1 = 'X'.

      PERFORM ZRET_NAME USING GS_ORDER-ZRET_FG

                        CHANGING GS_100-ZRET_NAME.

    ENDIF.



    " ## #### ##

    APPEND GS_100 TO GT_100.

    CLEAR : GS_ORDER, GS_100.

  ENDLOOP.



ENDFORM.

.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA_R2

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_DELIVERY .

    SELECT * FROM ZEDT022_101

    INTO CORRESPONDING FIELDS OF TABLE GT_DELIVERY

    WHERE ZORDNO IN S_ZORDNO

    AND ZIDCODE IN S_ZID

    AND ZMATNR IN S_ZMATNR

    AND ZDDATE IN S_ZDDATE

    AND ZFLAG IN R_ZG.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA_R2

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_DELIVERY .



  LOOP AT GT_DELIVERY INTO GS_DELIVERY.

    MOVE-CORRESPONDING GS_DELIVERY TO GS_200.



    " #### ## # ##### ##

    PERFORM ZMTART_NAME USING GS_DELIVERY-ZMTART

                        CHANGING GS_200-ZMAT_NAME.



    " #### ## ##

    CASE GS_DELIVERY-ZDFLAG.

      WHEN '1'.

        GS_200-ZDFLAG_NAME = '####'.

      WHEN '2'.

        GS_200-ZDFLAG_NAME = '####'.

      WHEN OTHERS.

        GS_200-ZDFLAG_NAME = '####'. " ## ### ##

    ENDCASE.



    " ##### ## ### ##

    CASE GS_DELIVERY-ZFLAG.

      WHEN 'X'.

        GS_200-ICON = '@0A@'. " ### ### (##)

      WHEN ' '.

        GS_200-ICON = '@08@'. " ### ### (##)

      WHEN OTHERS.

        GS_200-ICON = '@0B@'. " ## ### (##/##)

    ENDCASE.



    " #### ## # ## ##

    PERFORM ZDGUBUN_NAME USING GS_DELIVERY-ZDGUBUN

                         CHANGING GS_200-ZDGUBUN_NAME.



    " ## #### ##

    APPEND GS_200 TO GT_200.

    CLEAR : GS_DELIVERY, GS_200.

  ENDLOOP.



ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GC_DOCKING  text

*      -->P_GC_GRID_100  text

*----------------------------------------------------------------------*




FORM CREATE_OBJECT  USING    P_DOCKING TYPE REF TO CL_GUI_DOCKING_CONTAINER

                             P_GRID TYPE REF TO CL_GUI_ALV_GRID.

CREATE OBJECT P_DOCKING

  EXPORTING




*    PARENT                      =




    REPID                       = SY-REPID

    DYNNR                       = SY-DYNNR




*    SIDE                        = DOCK_AT_LEFT




    EXTENSION                   = 2000




*    STYLE                       =

*    LIFETIME                    = lifetime_default

*    CAPTION                     =

*    METRIC                      = 0

*    RATIO                       =

*    NO_AUTODEF_PROGID_DYNNR     =

*    NAME                        =

*  EXCEPTIONS

*    CNTL_ERROR                  = 1

*    CNTL_SYSTEM_ERROR           = 2

*    CREATE_ERROR                = 3

*    LIFETIME_ERROR              = 4

*    LIFETIME_DYNPRO_DYNPRO_LINK = 5

*    others                      = 6




    .

IF SY-SUBRC <> 0.




* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




ENDIF.

CREATE OBJECT P_GRID

  EXPORTING




*    I_SHELLSTYLE      = 0

*    I_LIFETIME        =




    I_PARENT          = P_DOCKING




*    I_APPL_EVENTS     = space

*    I_PARENTDBG       =

*    I_APPLOGPARENT    =

*    I_GRAPHICSPARENT  =

*    I_NAME            =

*    I_FCAT_COMPLETE   = SPACE

*  EXCEPTIONS

*    ERROR_CNTL_CREATE = 1

*    ERROR_CNTL_INIT   = 2

*    ERROR_CNTL_LINK   = 3

*    ERROR_DP_CREATE   = 4

*    others            = 5




    .

IF SY-SUBRC <> 0.




* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




ENDIF.





ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG_100

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG_100 .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ICON'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-ICON = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZORDNO'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZIDCODE'.

  GS_FIELDCAT-SCRTEXT_M = '##ID'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZMATNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZMATNAME'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZMAT_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZVOLUM'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-QFIELDNAME = 'VRKME'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'VRKME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'ZNSAMT'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-DO_SUM = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'ZSLAMT'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-DO_SUM = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'ZDCAMT'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-DO_SUM = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 12.

  GS_FIELDCAT-FIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-EMPHASIZE = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 13.

  GS_FIELDCAT-FIELDNAME = 'ZSALE_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 14.

  GS_FIELDCAT-FIELDNAME = 'ZJDATE'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  IF P_CH1 = C_X.

    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 15.

    GS_FIELDCAT-FIELDNAME = 'ZRET_NAME'.

    GS_FIELDCAT-SCRTEXT_M = '####'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.



    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 16.

    GS_FIELDCAT-FIELDNAME = 'ZRDATE'.

    GS_FIELDCAT-SCRTEXT_M = '####'.

    GS_FIELDCAT-OUTPUTLEN = '10'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

  ENDIF.



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

  CLEAR : GS_SORT, GT_SORT.

  GS_SORT-SPOS = 1.

  GS_SORT-FIELDNAME = 'ZIDCODE'.

  GS_SORT-UP = 'X'.

  GS_SORT-SUBTOT = 'X'.

  APPEND GS_SORT TO GT_SORT.

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

  GS_LAYOUT-ZEBRA = 'X'.



  CLEAR : GS_VARIANT.

  GS_VARIANT-REPORT = SY-REPID.

  GS_VARIANT-USERNAME = SY-UNAME.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALL_ALV

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GT_100[]  text

*      -->P_GC_GRID_100  text

*      -->P_GS_LAYOUT  text

*      -->P_GS_VARIANT  text

*----------------------------------------------------------------------*




FORM CALL_ALV  USING    PT_ITAB TYPE STANDARD TABLE

                        P_GRID TYPE REF TO CL_GUI_ALV_GRID

                        PS_LAYOUT TYPE LVC_S_LAYO

                        PS_VARIANT LIKE DISVARIANT.



CALL METHOD P_GRID->SET_TABLE_FOR_FIRST_DISPLAY

  EXPORTING




*    I_BUFFER_ACTIVE               =

*    I_BYPASSING_BUFFER            =

*    I_CONSISTENCY_CHECK           =

*    I_STRUCTURE_NAME              =




    IS_VARIANT                    = PS_VARIANT

    I_SAVE                        = 'A'




*    I_DEFAULT                     = 'X'




    IS_LAYOUT                     = PS_LAYOUT




*    IS_PRINT                      =

*    IT_SPECIAL_GROUPS             =

*    IT_TOOLBAR_EXCLUDING          =

*    IT_HYPERLINK                  =

*    IT_ALV_GRAPHICS               =

*    IT_EXCEPT_QINFO               =

*    IR_SALV_ADAPTER               =




  CHANGING

    IT_OUTTAB                     = PT_ITAB

    IT_FIELDCATALOG               = GT_FIELDCAT

    IT_SORT                       = GT_SORT




*    IT_FILTER                     =

*  EXCEPTIONS

*    INVALID_PARAMETER_COMBINATION = 1

*    PROGRAM_ERROR                 = 2

*    TOO_MANY_LINES                = 3

*    others                        = 4




        .

IF SY-SUBRC <> 0.




* Implement suitable error handling here




ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG_200

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG_200 .

CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ICON'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-ICON = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZORDNO'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZIDCODE'.

  GS_FIELDCAT-SCRTEXT_M = '##ID'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZMATNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZMATNAME'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZMAT_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZVOLUM'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-QFIELDNAME = 'VRKME'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'VRKME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'ZSLAMT'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-DO_SUM = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-EMPHASIZE = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 12.

  GS_FIELDCAT-FIELDNAME = 'ZDFLAG_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-CURRENCY = 'KRW'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 13.

  GS_FIELDCAT-FIELDNAME = 'ZDGUBUN_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-EMPHASIZE = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 14.

  GS_FIELDCAT-FIELDNAME = 'ZDDATE'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  IF P_CH1 = C_X.

    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 15.

    GS_FIELDCAT-FIELDNAME = 'ZRDATE'.

    GS_FIELDCAT-SCRTEXT_M = '####'.

    GS_FIELDCAT-OUTPUTLEN = '10'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.



    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 16.

    GS_FIELDCAT-FIELDNAME = 'ZFLAG'.

    GS_FIELDCAT-SCRTEXT_M = '####'.

    GS_FIELDCAT-OUTPUTLEN = '8'.

    GS_FIELDCAT-JUST = 'C'.

    GS_FIELDCAT-EMPHASIZE = 'X'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ZMTART_NAME

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_ORDER_ZMTART  text

*      <--P_GS_0100_ZMAT_NAME  text

*----------------------------------------------------------------------*




FORM ZMTART_NAME  USING P_ZMTART

                  CHANGING P_NAME.

  CASE P_ZMTART.

    WHEN '001'.

      P_NAME = '##'.

    WHEN '002'.

      P_NAME = '##'.

    WHEN '003'.

      P_NAME = '##'.

    WHEN '004'.

      P_NAME = '##'.

    WHEN '005'.

      P_NAME = '##'.

    WHEN '006'.

      P_NAME = '###'.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ZRET_NAME

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_ORDER_ZRET_FG  text

*      <--P_GS_0100_ZRET_NAME  text

*----------------------------------------------------------------------*




FORM ZRET_NAME  USING P_FG

                CHANGING P_NAME.

  CASE P_FG.

    WHEN '1'.

      P_NAME = '####'.

    WHEN '2'.

      P_NAME = '####'.

    WHEN '3'.

      P_NAME = '####'.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ZDGUBUN_NAME

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_DELIVERY_ZDGUBUN  text

*      <--P_GS_0200_ZDGUBUN_NAME  text

*----------------------------------------------------------------------*




FORM ZDGUBUN_NAME  USING P_ZDGUBUN

                   CHANGING P_NAME.

  CASE P_ZDGUBUN.

    WHEN '1'.

      P_NAME = '##'.

    WHEN '2'.

      P_NAME = '###'.

    WHEN '3'.

      P_NAME = '###'.

    WHEN '4'.

      P_NAME = '###'.

    WHEN '5'.

      P_NAME = '###'.

    WHEN '6'.

      P_NAME = '###'.

    WHEN '7'.

      P_NAME = '###'.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  PROGRESS_DISPLAY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_0029   text

*----------------------------------------------------------------------*




FORM PROGRESS_DISPLAY  USING P_TEXT.

  CHECK P_TEXT <> ''.



  CALL FUNCTION 'SAPGUI_PROGRESS_INDICATOR'

   EXPORTING




*     PERCENTAGE       = 0




     TEXT             = P_TEXT.



ENDFORM.