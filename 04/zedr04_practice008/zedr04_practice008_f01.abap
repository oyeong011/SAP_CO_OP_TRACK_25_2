
*&---------------------------------------------------------------------*

*&  Include           ZEDR04_PRACTICE008_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SET_INIT

*&---------------------------------------------------------------------*




FORM SET_INIT .

  " ####, #### ### # ##

  CONCATENATE SY-DATUM(6) '01' INTO GV_DATE.  " ### ## # ##

  S_ZJDATE-LOW = GV_DATE.

  S_ZDDATE-LOW = GV_DATE.



  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'       " ### ## ### ##

  EXPORTING

    DAY_IN            = GV_DATE

  IMPORTING

    LAST_DAY_OF_MONTH = GV_DATE.

  S_ZJDATE-HIGH = GV_DATE.

  S_ZDDATE-HIGH = GV_DATE.



  APPEND S_ZJDATE.

  APPEND S_ZDDATE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_SCREEN

*&---------------------------------------------------------------------*




FORM SET_SCREEN .

  " ### ### ## ##### #### # ## ##

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'M1'.      " ####

      IF P_RD1 = C_X.

        SCREEN-ACTIVE = '1'.

      ELSE.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ELSEIF SCREEN-GROUP1 = 'M2'.  " ####

      IF P_RD2 = C_X.

        SCREEN-ACTIVE = '1'.

      ELSE.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_DATA

*&---------------------------------------------------------------------*




FORM CHECK_DATA .

  " ### #### ## ### # ##

  IF P_RD1 = C_X.   " ####

    IF ( S_ZORDNO IS INITIAL ) AND ( S_ZJDATE IS INITIAL ).

      MESSAGE I000.

      STOP.

    ENDIF.

  ELSE.             " ####

    IF ( S_ZORDNO IS INITIAL ) AND ( S_ZDDATE IS INITIAL ).

      MESSAGE I000.

      STOP.

    ENDIF.

  ENDIF.



  " ## ID# RANGES### ###

  IF P_ZID IS NOT INITIAL.

    R_ZID-SIGN = 'I'.

    R_ZID-OPTION = 'EQ'.

    R_ZID-LOW = P_ZID.

    APPEND R_ZID.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SELECT_DATA_R1

*&---------------------------------------------------------------------*




FORM SELECT_DATA_R1 .

  SELECT * FROM ZEDT04_100

    INTO CORRESPONDING FIELDS OF TABLE GT_ORD

    WHERE ZORDNO IN S_ZORDNO

    AND ZIDCODE IN R_ZID

    AND ZMATNR IN S_ZMATNR

    AND ZJDATE IN S_ZJDATE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA_R1

*&---------------------------------------------------------------------*




FORM MODIFY_DATA_R1 .

  LOOP AT GT_ORD INTO GS_ORD.

    CLEAR GS_WRITE_ORD.

    MOVE-CORRESPONDING GS_ORD TO GS_WRITE_ORD.



    " #####

    PERFORM MAKE_ZMTART_NAME  USING GS_ORD-ZMTART

                              CHANGING GS_WRITE_ORD-ZMTART_NAME.



    " ####, ## ###

    CASE GS_ORD-ZSALE_FG.

      WHEN '1'.

        GS_WRITE_ORD-ZSALE_FG_NAME = '##'.

        GS_WRITE_ORD-ZCOLOR = '@08@'.   " ##

      WHEN '2'.

        GS_WRITE_ORD-ZSALE_FG_NAME = '##'.

        GS_WRITE_ORD-ZCOLOR = '@0A@'.   " ##

    ENDCASE.



    " #####

    PERFORM MAKE_ZRET_FG_NAME USING GS_ORD-ZRET_FG

                              CHANGING GS_WRITE_ORD-ZRET_FG_NAME.



    APPEND GS_WRITE_ORD TO GT_WRITE_ORD.

  ENDLOOP.



  IF P_ZFLAG = ''.  " ###### # ## # ## ## ### ##

    DELETE GT_WRITE_ORD WHERE ZSALE_FG_NAME = '##'.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MAKE_ZMTART_NAME

*&---------------------------------------------------------------------*




FORM MAKE_ZMTART_NAME  USING    P_ZMTART

                       CHANGING P_ZMTART_NAME.

  CASE P_ZMTART.

    WHEN '001'.

      P_ZMTART_NAME = '##'.

    WHEN '002'.

      P_ZMTART_NAME = '##'.

    WHEN '003'.

      P_ZMTART_NAME = '##'.

    WHEN '004'.

      P_ZMTART_NAME = '##'.

    WHEN '005'.

      P_ZMTART_NAME = '##'.

    WHEN '006'.

      P_ZMTART_NAME = '###'.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MAKE_ZRET_FG_NAME

*&---------------------------------------------------------------------*




FORM MAKE_ZRET_FG_NAME  USING    P_ZRET_FG

                        CHANGING P_ZRET_FG_NAME.

  CASE P_ZRET_FG.

    WHEN '1'.

      P_ZRET_FG_NAME = '####'.

    WHEN '2'.

      P_ZRET_FG_NAME = '####'.

    WHEN '3'.

      P_ZRET_FG_NAME = '####'.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SELECT_DATA_R2

*&---------------------------------------------------------------------*




FORM SELECT_DATA_R2 .

  SELECT * FROM ZEDT04_101

    INTO CORRESPONDING FIELDS OF TABLE GT_DEL

    WHERE ZORDNO IN S_ZORDNO

    AND ZIDCODE IN R_ZID

    AND ZMATNR IN S_ZMATNR

    AND ZDDATE IN S_ZDDATE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA_R2

*&---------------------------------------------------------------------*




FORM MODIFY_DATA_R2 .

  LOOP AT GT_DEL INTO GS_DEL.

    CLEAR GS_WRITE_DEL.

    MOVE-CORRESPONDING GS_DEL TO GS_WRITE_DEL.



    " ## ## ## ###

    IF GS_DEL-ZFLAG = C_X.

      GS_WRITE_DEL-ZCOLOR = '@0A@'.   " ##

    ELSE.

      GS_WRITE_DEL-ZCOLOR = '@08@'.   " ##

    ENDIF.



    " #####

    PERFORM MAKE_ZMTART_NAME  USING GS_DEL-ZMTART

                              CHANGING GS_WRITE_DEL-ZMTART_NAME.



    " ####

    CASE GS_DEL-ZDFLAG.

      WHEN '1'.

        GS_WRITE_DEL-ZDFLAG_NAME = '####'.

      WHEN '2'.

        GS_WRITE_DEL-ZDFLAG_NAME = '###'.

      WHEN '3'.

        IF GS_WRITE_DEL-ZFLAG <> C_X.   " ## ## ## #### ##

          GS_WRITE_DEL-ZDFLAG_NAME = '####'.

        ENDIF.

    ENDCASE.



    " #####

    PERFORM MAKE_ZDGUBUN_NAME USING GS_DEL-ZDGUBUN

                              CHANGING GS_WRITE_DEL-ZDGUBUN_NAME.



    APPEND GS_WRITE_DEL TO GT_WRITE_DEL.

  ENDLOOP.



  IF P_ZFLAG = ''.  " ###### # ## # ## ## ### ##

    DELETE GT_WRITE_DEL WHERE ZFLAG = C_X.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MAKE_ZDGUBUN_NAME

*&---------------------------------------------------------------------*




FORM MAKE_ZDGUBUN_NAME  USING    P_ZDGUBUN

                        CHANGING P_ZDGUBUN_NAME.

  CASE P_ZDGUBUN.

    WHEN '1'.

      P_ZDGUBUN_NAME = '###'.

    WHEN '2'.

      P_ZDGUBUN_NAME = '###'.

    WHEN '3'.

      P_ZDGUBUN_NAME = '###'.

    WHEN '4'.

      P_ZDGUBUN_NAME = '###'.

    WHEN '5'.

      P_ZDGUBUN_NAME = '###'.

    WHEN '6'.

      P_ZDGUBUN_NAME = '###'.

    WHEN '7'.

      P_ZDGUBUN_NAME = '###'.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*




FORM CREATE_OBJECT .

  CREATE OBJECT GC_DOCKING

    EXPORTING

      REPID                       = SY-REPID  " #### ID

      DYNNR                       = SY-DYNNR  " ### ##

      EXTENSION                   = 2000.     " ## ##



  CREATE OBJECT GC_GRID

    EXPORTING

      I_PARENT          = GC_DOCKING.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG_0100

*&---------------------------------------------------------------------*




FORM FIELD_CATALOG_0100 .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZCOLOR'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-ICON = C_X.           " ### ###

  GS_FIELDCAT-JUST = 'C'.           " ### ##

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

  GS_FIELDCAT-FIELDNAME = 'ZMTART_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZVOLUM'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-QFIELDNAME = 'VRKME'.  " ## ##

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

  GS_FIELDCAT-DO_SUM = C_X.           " ## ##

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'.  " ## ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'ZSLAMT'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-DO_SUM = C_X.           " ## ##

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'.  " ## ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'ZDCAMT'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-DO_SUM = C_X.           " ## ##

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'.  " ## ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 12.

  GS_FIELDCAT-FIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-EMPHASIZE = C_X.    " ##### # ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 13.

  GS_FIELDCAT-FIELDNAME = 'ZSALE_FG_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 14.

  GS_FIELDCAT-FIELDNAME = 'ZJDATE'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN  = 10.   " # ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CHECK P_ZFLAG = C_X.  " ###### ## ### ## ## ##



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 15.

  GS_FIELDCAT-FIELDNAME = 'ZRET_FG_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 16.

  GS_FIELDCAT-FIELDNAME = 'ZRDATE'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN  = 10.   " # ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*




FORM ALV_LAYOUT .

  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = C_X.          " ## ## # ### ##



  CLEAR GS_VARIANT.

  GS_VARIANT-REPORT = SY-REPID.

  GS_VARIANT-USERNAME = SY-UNAME.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_SORT

*&---------------------------------------------------------------------*




FORM ALV_SORT .

  GS_SORT-SPOS = 1.             " ## ## (## ####?)

  GS_SORT-FIELDNAME = 'ZIDCODE'.

  GS_SORT-UP = C_X.             " ####

  GS_SORT-SUBTOT = C_X.         " ## ## ###

  APPEND GS_SORT TO GT_SORT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*




FORM ALV_DISPLAY  USING    P_GT_WRITE.

  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_LAYOUT                     = GS_LAYOUT

      IS_VARIANT                    = GS_VARIANT

      I_SAVE                        = 'A'         " ALV#### #### ##### ## ##

    CHANGING

      IT_OUTTAB                     = P_GT_WRITE

      IT_FIELDCATALOG               = GT_FIELDCAT

      IT_SORT                       = GT_SORT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG_0200

*&---------------------------------------------------------------------*




FORM FIELD_CATALOG_0200 .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZCOLOR'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-ICON = C_X.           " ### ###

  GS_FIELDCAT-JUST = 'C'.           " ### ##

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

  GS_FIELDCAT-FIELDNAME = 'ZMTART_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZVOLUM'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-QFIELDNAME = 'VRKME'.  " ## ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'VRKME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'ZSLAMT'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-DO_SUM = C_X.           " ## ##

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'.  " ## ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-EMPHASIZE = C_X.    " ##### # ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'ZDFLAG_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 12.

  GS_FIELDCAT-FIELDNAME = 'ZDGUBUN_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-EMPHASIZE = C_X.    " ##### # ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 13.

  GS_FIELDCAT-FIELDNAME = 'ZDDATE'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN  = 10.   " # ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CHECK P_ZFLAG = C_X.  " ###### ## ### ## ## ##



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 14.

  GS_FIELDCAT-FIELDNAME = 'ZRDATE'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN  = 10.   " # ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 14.

  GS_FIELDCAT-FIELDNAME = 'ZFLAG'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-JUST = 'C'.

  GS_FIELDCAT-EMPHASIZE = C_X.    " ##### # ##

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.