
*&---------------------------------------------------------------------*

*&  Include           ZEDR20_PRACTICE008_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SET_SCREEN

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_SCREEN .

    LOOP AT SCREEN.

      IF P_R1 = 'X'.

        IF SCREEN-GROUP1 = 'M1'.

          SCREEN-ACTIVE = 1.

        ELSEIF SCREEN-GROUP1 = 'M2'.

          SCREEN-ACTIVE = 0.

        ENDIF.

      ELSEIF P_R2 = 'X'.

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

*&      Form  SET_DEFAULT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_DEFAULT.

  GV_TODAY = SY-DATUM.

  CONCATENATE GV_TODAY+0(6) '01' INTO R_DATE-LOW.

  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

    EXPORTING

      DAY_IN                  = R_DATE-LOW

   IMPORTING

     LAST_DAY_OF_MONTH       = R_DATE-HIGH.




*   EXCEPTIONS

*     DAY_IN_NO_DATE          = 1

*     OTHERS                  = 2




            .

  MOVE-CORRESPONDING R_DATE TO S_ZJDATE.

  MOVE-CORRESPONDING R_DATE TO S_ZDDATE.

  APPEND S_ZJDATE.

  APPEND S_ZDDATE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_INPUT_ERROR

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_INPUT_ERROR .

  IF ( S_ZORDNO IS INITIAL ) AND ( S_ZJDATE IS INITIAL ).

    MESSAGE I000.

    EXIT.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_ZJDATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_ZJDATA .

  SELECT

    *

    INTO CORRESPONDING FIELDS OF TABLE GT_ZJDATA

    FROM ZEDT20_100

    WHERE ZORDNO IN S_ZORDNO

    AND ZIDCODE IN S_ZID

    AND ZMATNR IN S_ZMATNR

    AND ZJDATE IN S_ZJDATE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_ZDDATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_ZDDATA .

  SELECT

    *

    INTO CORRESPONDING FIELDS OF TABLE GT_ZDDATA

    FROM ZEDT20_101

    WHERE ZORDNO IN S_ZORDNO

    AND ZIDCODE IN S_ZID

    AND ZMATNR IN S_ZMATNR

    AND ZDDATE IN S_ZDDATE.

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

  IF P_R1 = 'X'.

    PERFORM GET_ZJDATA.

  ELSEIF P_R2 = 'X'.

    PERFORM GET_ZDDATA.

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

  IF P_R1 = 'X'.

    PERFORM MODIFY_ZJDATA.

  ELSEIF P_R2 = 'X'.

    PERFORM MODIFY_ZDDATA.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_ZJDATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_ZJDATA .

  LOOP AT GT_ZJDATA INTO GS_ZJDATA.

    CLEAR: GS_ZJALV.

    CHECK ( P_C1 = 'X' ) OR ( P_C1 NE 'X' AND GS_ZJDATA-ZSALE_FG = 1 ).

    MOVE-CORRESPONDING GS_ZJDATA TO GS_ZJALV.

    PERFORM MODIFY_ZMTART USING GS_ZJDATA-ZMTART

                          CHANGING GS_ZJALV-ZMTART_KR.

    PERFORM MODIFY_ZSALE_FG USING GS_ZJDATA-ZSALE_FG

                            CHANGING GS_ZJALV-ZSALE_KR.

    PERFORM MODIFY_ZCOLOR USING GS_ZJDATA-ZSALE_FG

                          CHANGING GS_ZJALV-ZCOLOR.

    PERFORM MODIFY_ZRET_FG USING GS_ZJDATA-ZRET_FG

                           CHANGING GS_ZJALV-ZRET_KR.

    APPEND GS_ZJALV TO GT_ZJALV.

  ENDLOOP.

  ASSIGN GT_ZJALV TO <FS_T>.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_ZDDATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_ZDDATA .

  LOOP AT GT_ZDDATA INTO GS_ZDDATA.

    CLEAR: GS_ZDALV.

    CHECK ( P_C1 = 'X' ) OR ( P_C1 NE 'X' AND GS_ZDDATA-ZFLAG <> 'X' ).

    MOVE-CORRESPONDING GS_ZDDATA TO GS_ZDALV.

    PERFORM MODIFY_ZCOLOR USING GS_ZDDATA-ZFLAG

                          CHANGING GS_ZDALV-ZCOLOR.

    PERFORM MODIFY_ZMTART USING GS_ZDDATA-ZMTART

                          CHANGING GS_ZDALV-ZMTART_KR.

    PERFORM MODIFY_ZDFLAG USING GS_ZDDATA-ZDFLAG

                          CHANGING GS_ZDALV-ZDFLAG_KR.

    PERFORM MODIFY_ZDGUBUN USING GS_ZDDATA-ZDGUBUN

                           CHANGING GS_ZDALV-ZDGUBUN_KR.

    APPEND GS_ZDALV TO GT_ZDALV.

  ENDLOOP.

  ASSIGN GT_ZDALV TO <FS_T>.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_ZMATNR

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_ZJDATA_ZMATNR  text

*      <--P_GS_ZJALV_ZMATNR_KR  text

*----------------------------------------------------------------------*




FORM MODIFY_ZMTART  USING    P_ZMTART

                    CHANGING P_ZMTART_KR.

  CASE P_ZMTART.

    WHEN '001'.

      P_ZMTART_KR = '##'.

    WHEN '002'.

      P_ZMTART_KR = '##'.

    WHEN '003'.

      P_ZMTART_KR = '##'.

    WHEN '004'.

      P_ZMTART_KR = '##'.

    WHEN '005'.

      P_ZMTART_KR = '##'.

    WHEN '006'.

      P_ZMTART_KR = '###'.

    ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_ZCOLOR

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_ZJDATA_ZSALE_FG  text

*      <--P_GS_ZJALV_ZCOLOR  text

*----------------------------------------------------------------------*




FORM MODIFY_ZCOLOR  USING    P_FG

                    CHANGING P_ZCOLOR.

  CASE P_FG.

    WHEN '1' OR ''.

      P_ZCOLOR = '@08@'.

    WHEN '2' OR 'X'.

      P_ZCOLOR = '@0A@'.

    ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_ZSALE_FG

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_ZJDATA_ZSALE_FG  text

*      <--P_GS_ZJALV_ZSALE_KR  text

*----------------------------------------------------------------------*




FORM MODIFY_ZSALE_FG  USING    P_ZSALE_FG

                      CHANGING P_ZSALE_KR.

  CASE P_ZSALE_FG.

    WHEN '1'.

      P_ZSALE_KR = '##'.

    WHEN '2'.

      P_ZSALE_KR = '##'.

    ENDCASE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_ZRET_FG

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_ZJDATA_ZRET_FG  text

*      <--P_GS_ZJALV_ZRET_KR  text

*----------------------------------------------------------------------*




FORM MODIFY_ZRET_FG  USING    P_ZRET_FG

                     CHANGING P_ZRET_KR.

  CASE P_ZRET_FG.

    WHEN '1'.

      P_ZRET_KR = '####'.

    WHEN '2'.

      P_ZRET_KR = '####'.

    WHEN '3'.

      P_ZRET_KR = '####'.

    ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_ZDFLAG

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_ZDDATA_ZDFLAG  text

*      <--P_GS_ZDALV_ZDFLAG_KR  text

*----------------------------------------------------------------------*




FORM MODIFY_ZDFLAG  USING    P_ZDFLAG

                    CHANGING P_ZDFLAG_KR.

  CASE P_ZDFLAG.

    WHEN '1'.

      P_ZDFLAG_KR = '####'.

    WHEN '2'.

      P_ZDFLAG_KR = '###'.

    WHEN '3'.

      P_ZDFLAG_KR = '####'.

    ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_ZDGUBUN

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_ZDDATA_ZDGUBUN  text

*      <--P_GS_ZDALV_ZDGUBUN_KR  text

*----------------------------------------------------------------------*




FORM MODIFY_ZDGUBUN  USING    P_ZDGUBUN

                     CHANGING P_ZDGUBUN_KR.

  CASE P_ZDGUBUN.

    WHEN '1'.

      P_ZDGUBUN_KR = '###'.

    WHEN '2'.

      P_ZDGUBUN_KR = '###'.

    WHEN '3'.

      P_ZDGUBUN_KR = '###'.

    WHEN '4'.

      P_ZDGUBUN_KR = '###'.

    WHEN '5'.

      P_ZDGUBUN_KR = '###'.

    WHEN '6'.

      P_ZDGUBUN_KR = '###'.

    WHEN '7'.

      P_ZDGUBUN_KR = '###'.

    ENDCASE.

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

CREATE OBJECT GC_DOCKING

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

CREATE OBJECT GC_GRID

  EXPORTING




*    I_SHELLSTYLE      = 0

*    I_LIFETIME        =




    I_PARENT          = GC_DOCKING




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

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG_ZJALV .

  CLEAR: GT_FIELDCAT, GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZCOLOR'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZORDNO'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZIDCODE'.

  GS_FIELDCAT-SCRTEXT_M = '##ID'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZMATNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZMATNAME'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZMTART_KR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZVOLUM'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-QFIELDNAME = 'VRKME'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'VRKME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'ZNSAMT'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-DO_SUM = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'ZSLAMT'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-DO_SUM = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'ZDCAMT'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

    GS_FIELDCAT-CFIELDNAME = 'ZWAERS'.

    GS_FIELDCAT-DO_SUM = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 12.

  GS_FIELDCAT-FIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-EMPHASIZE = C_GREEN.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 13.

  GS_FIELDCAT-FIELDNAME = 'ZSALE_KR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 14.

  GS_FIELDCAT-FIELDNAME = 'ZJDATE'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CHECK P_C1 = 'X'.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 15.

  GS_FIELDCAT-FIELDNAME = 'ZRET_KR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 16.

  GS_FIELDCAT-FIELDNAME = 'ZRDATE'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.





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

  GS_SORT-SPOS = 1.

  GS_SORT-FIELDNAME = 'ZIDCODE'.

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

  CLEAR: GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.



  CLEAR: GS_VARIANT.

  GS_VARIANT-REPORT = SY-REPID.

  GS_VARIANT-USERNAME = SY-UNAME.

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




      IS_VARIANT                    = GS_VARIANT

      I_SAVE                        = 'A'




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

      IT_OUTTAB                     = <FS_T>

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

*&      Form  CALL_SCREEN

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CALL_SCREEN .

  IF P_R1 = 'X'.

    CALL SCREEN 100.

  ELSEIF P_R2 = 'X'.

    CALL SCREEN 200.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG_ZDALV

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG_ZDALV .

  CLEAR: GT_FIELDCAT, GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZCOLOR'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZORDNO'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZIDCODE'.

  GS_FIELDCAT-SCRTEXT_M = '##ID'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZMATNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZMATNAME'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZMTART_KR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZVOLUM'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-QFIELDNAME = 'VRKME'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'VRKME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'ZSLAMT'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-DO_SUM = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-EMPHASIZE = C_GREEN.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'ZDFLAG_KR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 12.

  GS_FIELDCAT-FIELDNAME = 'ZDGUBUN_KR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 13.

  GS_FIELDCAT-FIELDNAME = 'ZDDATE'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CHECK P_C1 = 'X'.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 14.

  GS_FIELDCAT-FIELDNAME = 'ZRDATE'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR: GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 15.

  GS_FIELDCAT-FIELDNAME = 'ZFLAG'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.