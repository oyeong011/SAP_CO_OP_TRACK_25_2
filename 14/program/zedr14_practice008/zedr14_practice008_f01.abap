
*&---------------------------------------------------------------------*

*&  Include           ZEDR14_PRACTICE008_F01

*&---------------------------------------------------------------------*



*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM CREATE_OBJECT .



  CREATE OBJECT GC_DOCKING

  EXPORTING

    REPID                       = SY-REPID

    DYNNR                       = SY-DYNNR

    EXTENSION                   = 2000.



  CREATE OBJECT GC_GRID

    EXPORTING

      I_PARENT          = GC_DOCKING.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM CALL_ALV USING PT_ITAB TYPE STANDARD TABLE.



  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

        EXPORTING

          IS_VARIANT                    = GS_VARIANT

          I_SAVE                        = 'A'

          IS_LAYOUT                     = GS_LAYOUT

        CHANGING

          IT_OUTTAB                     = PT_ITAB

          IT_FIELDCATALOG               = GT_FIELDCAT

          IT_SORT                       = GT_SORT.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM ALV_LAYOUT .



  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.



  CLEAR GS_VARIANT.

  GS_VARIANT-REPORT = SY-REPID.

  GS_VARIANT-USERNAME = SY-UNAME.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_SORT

*&---------------------------------------------------------------------*

*       text

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

*&      Form  FIELD_CATALOG_0100

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG_0100 .



  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZCOLOR'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-ICON = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZORDNO'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZIDCODE'.

  GS_FIELDCAT-COLTEXT = '##ID'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZMATNR'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZMATNAME'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZMTART_TEXT'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZVOLUM'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'VRKME'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'ZNSAMT'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-DO_SUM = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'ZSLAMT'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-DO_SUM = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'ZDCAMT'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-DO_SUM = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 12.

  GS_FIELDCAT-FIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-EMPHASIZE = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 13.

  GS_FIELDCAT-FIELDNAME = 'ZSALE_TEXT'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 14.

  GS_FIELDCAT-FIELDNAME = 'ZJDATE'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  IF P_CH1 = 'X'.

    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 15.

    GS_FIELDCAT-FIELDNAME = 'ZRET_TEXT'.

    GS_FIELDCAT-COLTEXT = '####'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.



    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 16.

    GS_FIELDCAT-FIELDNAME = 'ZRDATE'.

    GS_FIELDCAT-COLTEXT = '####'.

    GS_FIELDCAT-OUTPUTLEN = '10'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG_0200

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG_0200 .



  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZCOLOR'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-ICON = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZORDNO'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZIDCODE'.

  GS_FIELDCAT-COLTEXT = '##ID'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZMATNR'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZMATNAME'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZMTART_TEXT'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZVOLUM'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'VRKME'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'ZSLAMT'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-DO_SUM = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-EMPHASIZE = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'ZDFLAG_TEXT'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 12.

  GS_FIELDCAT-FIELDNAME = 'ZDGUBUN_TEXT'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-EMPHASIZE = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 13.

  GS_FIELDCAT-FIELDNAME = 'ZDDATE'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  IF P_CH1 = 'X'.

    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 14.

    GS_FIELDCAT-FIELDNAME = 'ZRDATE'.

    GS_FIELDCAT-COLTEXT = '####'.

    GS_FIELDCAT-OUTPUTLEN = '10'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.



    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 15.

    GS_FIELDCAT-FIELDNAME = 'ZFLAG'.

    GS_FIELDCAT-COLTEXT = '####'.

    GS_FIELDCAT-JUST = 'C'.

    GS_FIELDCAT-EMPHASIZE = 'X'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_INITIAL

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM SET_INITIAL .



  S_ZJDATE-LOW = SY-DATUM.

  S_ZJDATE-LOW+6(2) = FIRST_DATE.

  S_ZDDATE-LOW = SY-DATUM.

  S_ZDDATE-LOW+6(2) = FIRST_DATE.



  CALL FUNCTION 'SLS_MISC_GET_LAST_DAY_OF_MONTH'   "#### ## ##

    EXPORTING

      DAY_IN = SY-DATUM

    IMPORTING

      LAST_DAY_OF_MONTH = S_ZJDATE-HIGH.

      S_ZDDATE-HIGH = S_ZJDATE-HIGH.



  APPEND S_ZJDATE.

  APPEND S_ZDDATE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM GET_DATA .



  RANGES : LR_ZID FOR ZEDT14_100-ZIDCODE,   "RANGES ## -> #### ##

           LR_ZSALEFG FOR ZEDT14_100-ZSALE_FG,

           LR_ZFLAG FOR ZEDT14_101-ZFLAG.



  IF P_ZID IS NOT INITIAL.    "P_ZID# #### ## #

    LR_ZID-SIGN = 'I'.

    LR_ZID-OPTION = 'EQ'.

    LR_ZID-LOW = P_ZID.

    APPEND LR_ZID.

  ENDIF.



  IF P_R1 = 'X'.  "####

    IF P_CH1 IS INITIAL.  "#### ## X

      LR_ZSALEFG-SIGN = 'I'.

      LR_ZSALEFG-OPTION = 'NE'.

      LR_ZSALEFG-LOW = '2'.

      APPEND LR_ZSALEFG.

    ENDIF.



    SELECT * FROM ZEDT14_100

      INTO CORRESPONDING FIELDS OF TABLE GT_PRINT100

      WHERE ZORDNO IN S_ZORDNO

        AND ZIDCODE IN LR_ZID

        AND ZMATNR IN S_ZMATNR

        AND ZJDATE IN S_ZJDATE

        AND ZSALE_FG IN LR_ZSALEFG.



  ELSEIF P_R2 = 'X'.  "####

    IF P_CH1 IS INITIAL.  "#### ## X

      LR_ZFLAG-SIGN = 'I'.

      LR_ZFLAG-OPTION = 'NE'.

      LR_ZFLAG-LOW = 'X'.

      APPEND LR_ZFLAG.

    ENDIF.



    SELECT * FROM ZEDT14_101

      INTO CORRESPONDING FIELDS OF TABLE GT_PRINT101

      WHERE ZORDNO IN S_ZORDNO

        AND ZIDCODE IN LR_ZID

        AND ZMATNR IN S_ZMATNR

        AND ZDDATE IN S_ZDDATE

        AND ZFLAG IN LR_ZFLAG.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




FORM MODIFY_DATA .



  IF P_R1 = 'X'.

    LOOP AT GT_PRINT100 INTO GS_PRINT100.

      MOVE-CORRESPONDING GS_PRINT100 TO GS_FINAL100.



      CASE GS_FINAL100-ZMTART.    "#### ### ##

        WHEN '001'. GS_FINAL100-ZMTART_TEXT = '##'.

        WHEN '002'. GS_FINAL100-ZMTART_TEXT = '##'.

        WHEN '003'. GS_FINAL100-ZMTART_TEXT = '##'.

        WHEN '004'. GS_FINAL100-ZMTART_TEXT = '##'.

        WHEN '005'. GS_FINAL100-ZMTART_TEXT = '##'.

        WHEN '006'. GS_FINAL100-ZMTART_TEXT = '###'.

      ENDCASE.



      CASE GS_FINAL100-ZSALE_FG.    "## ### ##

        WHEN '1'. GS_FINAL100-ZSALE_TEXT = '##'.

        WHEN '2'. GS_FINAL100-ZSALE_TEXT = '##'.

      ENDCASE.



      CASE GS_FINAL100-ZRET_FG.   "#### ### ##

        WHEN '1'. GS_FINAL100-ZRET_TEXT = '####'.

        WHEN '2'. GS_FINAL100-ZRET_TEXT = '####'.

        WHEN '3'. GS_FINAL100-ZRET_TEXT = '####'.

        WHEN OTHERS. CLEAR GS_FINAL100-ZRET_TEXT.

      ENDCASE.



      IF GS_FINAL100-ZSALE_FG = '1'.

        GS_FINAL100-ZCOLOR = '@08@'. "##

      ELSE.

        GS_FINAL100-ZCOLOR = '@0A@'. "##

      ENDIF.



      APPEND GS_FINAL100 TO GT_FINAL100.

    ENDLOOP.



  ELSEIF P_R2 = 'X'.

    LOOP AT GT_PRINT101 INTO GS_PRINT101.

      MOVE-CORRESPONDING GS_PRINT101 TO GS_FINAL101.



      CASE GS_FINAL101-ZMTART.    "## ## ### ##

        WHEN '001'. GS_FINAL101-ZMTART_TEXT = '##'.

        WHEN '002'. GS_FINAL101-ZMTART_TEXT = '##'.

        WHEN '003'. GS_FINAL101-ZMTART_TEXT = '##'.

        WHEN '004'. GS_FINAL101-ZMTART_TEXT = '##'.

        WHEN '005'. GS_FINAL101-ZMTART_TEXT = '##'.

        WHEN '006'. GS_FINAL101-ZMTART_TEXT = '###'.

      ENDCASE.



      CASE GS_FINAL101-ZDFLAG.

        WHEN '1'. GS_FINAL101-ZDFLAG_TEXT = '####'.

        WHEN '2'. GS_FINAL101-ZDFLAG_TEXT = '###'.

        WHEN '3'. GS_FINAL101-ZDFLAG_TEXT = '####'.

      ENDCASE.



      CASE GS_FINAL101-ZDGUBUN.

        WHEN '1'. GS_FINAL101-ZDGUBUN_TEXT = '###'.

        WHEN '2'. GS_FINAL101-ZDGUBUN_TEXT = '###'.

        WHEN '3'. GS_FINAL101-ZDGUBUN_TEXT = '###'.

        WHEN '4'. GS_FINAL101-ZDGUBUN_TEXT = '###'.

        WHEN '5'. GS_FINAL101-ZDGUBUN_TEXT = '###'.

        WHEN '6'. GS_FINAL101-ZDGUBUN_TEXT = '###'.

        WHEN '7'. GS_FINAL101-ZDGUBUN_TEXT = '###'.

      ENDCASE.



      IF GS_FINAL101-ZFLAG = 'X'.

        GS_FINAL101-ZCOLOR = '@0A@'. "##

      ELSE.

        GS_FINAL101-ZCOLOR = '@08@'. "##

      ENDIF.



      APPEND GS_FINAL101 TO GT_FINAL101.

    ENDLOOP.

  ENDIF.



ENDFORM.