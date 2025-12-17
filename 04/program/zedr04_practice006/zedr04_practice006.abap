
*&---------------------------------------------------------------------*

*& Report ZEDR04_PRACTICE006

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR04_PRACTICE006 MESSAGE-ID ZMED04.



TABLES : ZEDT04_102.  " SELECT-OPTIONS# ##



CONSTANTS C_X VALUE 'X'.

RANGES R_FLAG FOR ZEDT04_102-ZQFLAG.



DATA : BEGIN OF GS_INFO,  " ####

  ZPERNR TYPE ZEDT04_102-ZPERNR,      " ####

  ZPNAME TYPE ZEDT04_103-ZPNAME,      " ####

  ZDEPCODE TYPE ZEDT04_102-ZDEPCODE,  " ####

  ZDEPRANK TYPE ZEDT04_102-ZDEPRANK,  " ####

  ZEDATE TYPE ZEDT04_102-ZEDATE,      " ####

  ZQFLAG TYPE ZEDT04_102-ZQFLAG,      " ####

  ZGENDER TYPE ZEDT04_103-ZGENDER,    " ##

  ZADDRESS TYPE ZEDT04_103-ZADDRESS,  " ##

  ZBANKCODE TYPE ZEDT04_106-ZBANKCODE,  " ####

  ZACCOUNT TYPE ZEDT04_106-ZACCOUNT,    " ####

  END OF GS_INFO.

DATA GT_INFO LIKE TABLE OF GS_INFO.



DATA : BEGIN OF GS_WRITE_INFO,  " #### ###

  ZPERNR TYPE ZEDT04_102-ZPERNR,  " ####

  ZPNAME TYPE ZEDT04_103-ZPNAME,  " ####

  ZDEPCODE TYPE ZEDT04_102-ZDEPCODE,  " ####

  ZDEP_NAME TYPE C LENGTH 7,           " ###(##)

  ZRANK_NAME TYPE C LENGTH 5,          " ###(##)

  ZEDATE TYPE ZEDT04_102-ZEDATE,      " ###

  ZQF_NAME TYPE C LENGTH 5,     " ####(##)

  ZGEN_NAME TYPE C LENGTH 5,   " ##(##)

  ZADDRESS TYPE ZEDT04_103-ZADDRESS,    " ##

  ZBANKCODE TYPE ZEDT04_106-ZBANKCODE,  " ####

  ZBANK_NAME TYPE C LENGTH 7,           " ###(##)

  ZACCOUNT TYPE ZEDT04_106-ZACCOUNT,    " ####

  END OF GS_WRITE_INFO.

DATA GT_WRITE_INFO LIKE TABLE OF GS_WRITE_INFO.



DATA : BEGIN OF GS_SAL,   " ##### ### ##

  ZPERNR TYPE ZEDT04_102-ZPERNR,  " ####

  DATBI TYPE ZEDT04_102-DATBI,  " ####

  DATAB TYPE ZEDT04_102-DATAB,  " ####

  ZRANK TYPE ZEDT04_104-ZRANK,  " ####

  ZSALARY TYPE ZEDT04_106-ZSALARY,  " ##

  ZPAY TYPE ZEDT04_106-ZSALARY,     " ##

  END OF GS_SAL.

DATA GT_SAL LIKE TABLE OF GS_SAL.



DATA : BEGIN OF GS_RANK,  " ##### ### ##

  ZPERNR TYPE ZEDT04_102-ZPERNR,      " ####

  ZPNAME TYPE ZEDT04_103-ZPNAME,      " ####

  ZDEPCODE TYPE ZEDT04_102-ZDEPCODE,  " ####

  ZDEPRANK TYPE ZEDT04_102-ZDEPRANK,  " ####

  ZEDATE TYPE ZEDT04_102-ZEDATE,      " ####

  ZSALARY TYPE ZEDT04_106-ZSALARY,     " ####

  ZRANK TYPE ZEDT04_104-ZRANK,         " ####

  END OF GS_RANK.

DATA GT_RANK LIKE TABLE OF GS_RANK.



DATA : BEGIN OF GS_WRITE_RANK,  " #### ###

  ZPERNR TYPE ZEDT04_102-ZPERNR,  " ####

  ZPNAME TYPE ZEDT04_103-ZPNAME,  " ####

  ZDEPCODE TYPE ZEDT04_102-ZDEPCODE,   " ####

  ZDEP_NAME TYPE C LENGTH 7,           " ###(##)

  ZRANK_NAME TYPE C LENGTH 5,          " ###(##)

  ZEDATE TYPE ZEDT04_102-ZEDATE,       " ###

  ZSALARY TYPE ZEDT04_106-ZSALARY,     " ####

  ZRANK TYPE ZEDT04_104-ZRANK,         " ####

  ZMON TYPE ZEDT04_105-ZMON01,         " ## ###

  END OF GS_WRITE_RANK.

DATA GT_WRITE_RANK LIKE TABLE OF GS_WRITE_RANK.



DATA GV_CHECK.  " #### ##/## ## ##



DATA GS_FIELDCAT TYPE SLIS_FIELDCAT_ALV.    " ## ####

DATA GT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV.



DATA GS_LAYOUT TYPE SLIS_LAYOUT_ALV.    " ALV ####



DATA GS_SORT TYPE SLIS_SORTINFO_ALV.    " ALV SORT

DATA GT_SORT TYPE SLIS_T_SORTINFO_ALV.



" ###

SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS S_ZPERNR FOR ZEDT04_102-ZPERNR.  " ####

  SELECT-OPTIONS S_ZDATE  FOR ZEDT04_102-ZEDATE   NO-EXTENSION              MODIF ID M1.  " ##

  SELECT-OPTIONS S_ZDCODE FOR ZEDT04_102-ZDEPCODE NO INTERVALS NO-EXTENSION MODIF ID M1.  " ####

  PARAMETERS P_ZYEAR      TYPE GJAHR  MODIF ID M2.    " ##

  PARAMETERS P_ZMONTH     TYPE MONAT  MODIF ID M2.    " #

SELECTION-SCREEN END OF BLOCK B1.



SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

  PARAMETERS P_RDINFO RADIOBUTTON GROUP R1 DEFAULT 'X' USER-COMMAND UC1.  " ####

  PARAMETERS P_RDSAL  RADIOBUTTON GROUP R1.   " ####

  PARAMETERS P_RDRANK RADIOBUTTON GROUP R1.   " ####

SELECTION-SCREEN END OF BLOCK B2.



SELECTION-SCREEN BEGIN OF BLOCK B3 WITH FRAME.

  PARAMETERS C_ZFLAG  AS CHECKBOX DEFAULT 'X' MODIF ID M1.  " ####

SELECTION-SCREEN END OF BLOCK B3.





INITIALIZATION.

  " ## ### # ##

  CONCATENATE SY-DATUM(4) '0101' INTO S_ZDATE-LOW.

  S_ZDATE-HIGH = SY-DATUM.

  APPEND S_ZDATE.



  " ##, # ### # ##

  P_ZYEAR = SY-DATUM(4).

  P_ZMONTH = SY-DATUM+4(2).





AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'M1'.      " #### ## # ##

      IF P_RDINFO = C_X.

        SCREEN-ACTIVE = '1'.

      ELSE.

        SCREEN-ACTIVE = '0'.

      ENDIF.

    ELSEIF SCREEN-GROUP1 = 'M2'.  " ####, #### ## # ##

      IF P_RDINFO = C_X.

        SCREEN-ACTIVE = '0'.

      ELSE.

        SCREEN-ACTIVE = '1'.

      ENDIF.

    ENDIF.



    MODIFY SCREEN.

  ENDLOOP.



START-OF-SELECTION.

  IF P_RDINFO = C_X.      " ####

    PERFORM GET_DATA_INFO.

    IF GT_INFO[] IS INITIAL.

      MESSAGE I001. " #### # ## #

      EXIT.         " INITIALIZATION## ##

    ENDIF.

    PERFORM MODIFY_DATA_INFO.

    PERFORM WRITE_DATA_INFO.

  ELSEIF P_RDSAL = C_X.   " ####

    PERFORM GET_DATA_SAL.

    IF GT_SAL[] IS INITIAL.

      MESSAGE I001.

      EXIT.

    ENDIF.

    PERFORM MODIFY_DATA_SAL.

  ELSE.                   " ####

    PERFORM GET_DATA_RANK.

    IF GT_RANK[] IS INITIAL.

      MESSAGE I001.

      EXIT.

    ENDIF.

    PERFORM MODIFY_DATA_RANK.

    PERFORM WRITE_DATA_RANK.

  ENDIF.

END-OF-SELECTION.

  CHECK P_RDSAL = C_X AND

    P_ZYEAR IS NOT INITIAL AND P_ZMONTH IS NOT INITIAL.

    IF GV_CHECK = C_X.

      MESSAGE I003.

    ELSE.

      MESSAGE I002.

    ENDIF.








*&---------------------------------------------------------------------*

*&      Form  GET_DATA_INFO

*&---------------------------------------------------------------------*




FORM GET_DATA_INFO .

  IF S_ZDATE-HIGH IS INITIAL.

    IF S_ZDATE-LOW IS INITIAL.

      MESSAGE I000.   " #### ## ### ##

      STOP.           " END-OF-SELECTION## ##

    ELSE.

      S_ZDATE-HIGH = S_ZDATE-LOW. " LOW# HIGH# ##

    ENDIF.

  ENDIF.



    CLEAR R_FLAG.



  IF C_ZFLAG = C_X.

    R_FLAG-SIGN = 'I'.

    R_FLAG-OPTION = 'EQ'.

    R_FLAG-LOW = ''.

    APPEND R_FLAG.

  ELSE.

    R_FLAG-SIGN = 'I'.

    R_FLAG-OPTION = 'EQ'.

    R_FLAG-LOW = ''.

    APPEND R_FLAG.

    R_FLAG-LOW = C_X.

    APPEND R_FLAG.

  ENDIF.



  " #### ##

  SELECT  A~ZPERNR

          B~ZPNAME

          A~ZDEPCODE

          A~ZDEPRANK

          A~ZEDATE

          A~ZQFLAG

          B~ZGENDER

          B~ZADDRESS

          C~ZBANKCODE

          C~ZACCOUNT

    INTO CORRESPONDING FIELDS OF TABLE GT_INFO

    FROM ZEDT04_102 AS A

      INNER JOIN ZEDT04_103 AS B

      ON A~ZPERNR = B~ZPERNR

      INNER JOIN ZEDT04_106 AS C

      ON A~ZPERNR = C~ZPERNR

    WHERE A~ZPERNR IN S_ZPERNR

      AND A~DATBI <= S_ZDATE-HIGH

      AND A~DATAB > S_ZDATE-HIGH

      AND A~ZDEPCODE IN S_ZDCODE




*      AND ( ZQFLAG <> C_X OR ZQFLAG <> C_ZFLAG ).  " #### ## # ### ### ##




      AND A~ZQFLAG IN R_FLAG.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA_INFO

*&---------------------------------------------------------------------*




FORM MODIFY_DATA_INFO .

  LOOP AT GT_INFO INTO GS_INFO.

    CLEAR GS_WRITE_INFO.

    MOVE-CORRESPONDING GS_INFO TO GS_WRITE_INFO.



    " ###

    PERFORM MAKE_ZDEP_NAME  USING GS_INFO-ZDEPCODE

                            CHANGING GS_WRITE_INFO-ZDEP_NAME.



    " ###

    PERFORM MAKE_ZRANK_NAME USING GS_INFO-ZDEPRANK

                            CHANGING GS_WRITE_INFO-ZRANK_NAME.



    " ####

    IF GS_INFO-ZQFLAG = C_X.

        GS_WRITE_INFO-ZQF_NAME = '##'.

    ELSE.

        GS_WRITE_INFO-ZQF_NAME = '##'.

    ENDIF.



    " ##

    IF GS_INFO-ZGENDER ='M'.

        GS_WRITE_INFO-ZGEN_NAME = '##'.

    ELSEIF GS_INFO-ZGENDER = 'F'.

        GS_WRITE_INFO-ZGEN_NAME = '##'.

    ENDIF.



    " ###

    CASE GS_INFO-ZBANKCODE.

      WHEN '001'.

        GS_WRITE_INFO-ZBANK_NAME = '##'.

      WHEN '002'.

        GS_WRITE_INFO-ZBANK_NAME = '##'.

      WHEN '003'.

        GS_WRITE_INFO-ZBANK_NAME = '##'.

      WHEN '004'.

        GS_WRITE_INFO-ZBANK_NAME = '##'.

      WHEN '005'.

        GS_WRITE_INFO-ZBANK_NAME = '###'.

    ENDCASE.



    APPEND GS_WRITE_INFO TO GT_WRITE_INFO.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  WRITE_DATA_INFO

*&---------------------------------------------------------------------*




FORM WRITE_DATA_INFO .

  PERFORM FIELD_CATALOG_INFO.

  PERFORM ALV_LAYOUT.

  PERFORM ALV_SORT.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

    EXPORTING

      IT_FIELDCAT                       = GT_FIELDCAT

      IS_LAYOUT                         = GS_LAYOUT

      IT_SORT                           = GT_SORT

    TABLES

      T_OUTTAB                          = GT_WRITE_INFO.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG_INFO

*&---------------------------------------------------------------------*




FORM FIELD_CATALOG_INFO .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-seltext_m = '####'.

  GS_FIELDCAT-KEY = C_X.  " ###. ## ##. #### # ##.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZPNAME'.

  GS_FIELDCAT-seltext_m = '####'.

  GS_FIELDCAT-KEY = C_X.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZDEPCODE'.

  GS_FIELDCAT-seltext_m = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZDEP_NAME'.

  GS_FIELDCAT-seltext_m = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZRANK_NAME'.

  GS_FIELDCAT-seltext_m = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZEDATE'.

  GS_FIELDCAT-seltext_m = '###'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZQF_NAME'.

  GS_FIELDCAT-seltext_m = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'ZGEN_NAME'.

  GS_FIELDCAT-seltext_m = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'ZADDRESS'.

  GS_FIELDCAT-seltext_m = '##'.

  GS_FIELDCAT-OUTPUTLEN = 12.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'ZBANKCODE'.

  GS_FIELDCAT-seltext_m = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'ZBANK_NAME'.

  GS_FIELDCAT-seltext_m = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'ZACCOUNT'.

  GS_FIELDCAT-seltext_m = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*




FORM ALV_LAYOUT .

  GS_LAYOUT-ZEBRA = C_X.          " ## ## # ### ##

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MAKE_ZDEP_NAME

*&---------------------------------------------------------------------*




FORM MAKE_ZDEP_NAME  USING    P_GS_INFO_ZDEPCODE

                     CHANGING P_GS_WRITE_INFO_ZDEP_NAME.

  CASE P_GS_INFO_ZDEPCODE.

    WHEN 'SS0001'.

      P_GS_WRITE_INFO_ZDEP_NAME = '###'.

    WHEN 'SS0002'.

      P_GS_WRITE_INFO_ZDEP_NAME = '###'.

    WHEN 'SS0003'.

      P_GS_WRITE_INFO_ZDEP_NAME = '###'.

    WHEN 'SS0004'.

      P_GS_WRITE_INFO_ZDEP_NAME = '###'.

    WHEN 'SS0005'.

      P_GS_WRITE_INFO_ZDEP_NAME = '###'.

    WHEN 'SS0006'.

      P_GS_WRITE_INFO_ZDEP_NAME = '###'.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MAKE_ZRANK_NAME

*&---------------------------------------------------------------------*




FORM MAKE_ZRANK_NAME  USING    P_GS_INFO_ZDEPRANK

                      CHANGING P_GS_WRITE_INFO_ZRANK_NAME.

  CASE P_GS_INFO_ZDEPRANK.

    WHEN 'A'.

      P_GS_WRITE_INFO_ZRANK_NAME = '##'.

    WHEN 'B'.

      P_GS_WRITE_INFO_ZRANK_NAME = '##'.

    WHEN 'C'.

      P_GS_WRITE_INFO_ZRANK_NAME = '##'.

    WHEN 'D'.

      P_GS_WRITE_INFO_ZRANK_NAME = '##'.

    WHEN 'E'.

      P_GS_WRITE_INFO_ZRANK_NAME = '##'.

    WHEN 'F'.

      P_GS_WRITE_INFO_ZRANK_NAME = '##'.

    WHEN 'G'.

      P_GS_WRITE_INFO_ZRANK_NAME = '##'.

  ENDCASE.

ENDFORM.






*&---------------------------------------------------------------------*

*&      Form  GET_DATA_SAL

*&---------------------------------------------------------------------*




FORM GET_DATA_SAL .

  IF P_ZYEAR IS INITIAL OR P_ZMONTH IS INITIAL.

    MESSAGE I000.   " #### ## ### ##

    EXIT.           " END-OF-SELECTION## ##

  ENDIF.



  SELECT  A~ZPERNR

          A~DATBI

          A~DATAB

          B~ZRANK

          C~ZSALARY

    INTO CORRESPONDING FIELDS OF TABLE GT_SAL

    FROM ZEDT04_102 AS A

      INNER JOIN ZEDT04_104 AS B

      ON A~ZPERNR = B~ZPERNR

      INNER JOIN ZEDT04_106 AS C

      ON A~ZPERNR = C~ZPERNR AND B~ZYEAR = C~ZYEAR

    WHERE A~ZPERNR IN S_ZPERNR

      AND B~ZYEAR = P_ZYEAR

      AND C~ZSALARY <> 0.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA_SAL

*&---------------------------------------------------------------------*




FORM MODIFY_DATA_SAL .

  DATA LV_ZMONTH(6).

  CONCATENATE P_ZYEAR P_ZMONTH INTO LV_ZMONTH.



  LOOP AT GT_SAL INTO GS_SAL.

    IF GS_SAL-DATBI(6) > LV_ZMONTH

      OR GS_SAL-DATAB(6) <= LV_ZMONTH.

      CONTINUE. " ###, ### ## ## # ## # ####

    ENDIF.



    " ## ##

    GS_SAL-ZPAY = GS_SAL-ZSALARY / 12.

    IF GS_SAL-ZRANK = 'A'.

      GS_SAL-ZPAY = GS_SAL-ZPAY + '500.00'.

    ENDIF.



    CHECK GS_SAL-ZPAY <> 0.



    PERFORM UPDATE_PAY.

    IF GV_CHECK = C_X.

      STOP.

    ENDIF.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  UPDATE_PAY

*&---------------------------------------------------------------------*




FORM UPDATE_PAY .

  CASE P_ZMONTH.

    WHEN '1'.

      UPDATE ZEDT04_105 SET ZMON01 = GS_SAL-ZPAY

      WHERE ZPERNR = GS_SAL-ZPERNR

      AND ZYEAR = P_ZYEAR.

    WHEN '2'.

      UPDATE ZEDT04_105 SET ZMON02 = GS_SAL-ZPAY

      WHERE ZPERNR = GS_SAL-ZPERNR

      AND ZYEAR = P_ZYEAR.

    WHEN '3'.

      UPDATE ZEDT04_105 SET ZMON03 = GS_SAL-ZPAY

      WHERE ZPERNR = GS_SAL-ZPERNR

      AND ZYEAR = P_ZYEAR.

    WHEN '4'.

      UPDATE ZEDT04_105 SET ZMON04 = GS_SAL-ZPAY

      WHERE ZPERNR = GS_SAL-ZPERNR

      AND ZYEAR = P_ZYEAR.

    WHEN '5'.

      UPDATE ZEDT04_105 SET ZMON05 = GS_SAL-ZPAY

      WHERE ZPERNR = GS_SAL-ZPERNR

      AND ZYEAR = P_ZYEAR.

    WHEN '6'.

      UPDATE ZEDT04_105 SET ZMON06 = GS_SAL-ZPAY

      WHERE ZPERNR = GS_SAL-ZPERNR

      AND ZYEAR = P_ZYEAR.

    WHEN '7'.

      UPDATE ZEDT04_105 SET ZMON07 = GS_SAL-ZPAY

      WHERE ZPERNR = GS_SAL-ZPERNR

      AND ZYEAR = P_ZYEAR.

    WHEN '8'.

      UPDATE ZEDT04_105 SET ZMON08 = GS_SAL-ZPAY

      WHERE ZPERNR = GS_SAL-ZPERNR

      AND ZYEAR = P_ZYEAR.

    WHEN '9'.

      UPDATE ZEDT04_105 SET ZMON09 = GS_SAL-ZPAY

      WHERE ZPERNR = GS_SAL-ZPERNR

      AND ZYEAR = P_ZYEAR.

    WHEN '10'.

      UPDATE ZEDT04_105 SET ZMON10 = GS_SAL-ZPAY

      WHERE ZPERNR = GS_SAL-ZPERNR

      AND ZYEAR = P_ZYEAR.

    WHEN '11'.

      UPDATE ZEDT04_105 SET ZMON11 = GS_SAL-ZPAY

      WHERE ZPERNR = GS_SAL-ZPERNR

      AND ZYEAR = P_ZYEAR.

    WHEN '12'.

      UPDATE ZEDT04_105 SET ZMON12 = GS_SAL-ZPAY

      WHERE ZPERNR = GS_SAL-ZPERNR

      AND ZYEAR = P_ZYEAR.

  ENDCASE.



  IF SY-SUBRC <> 0.

    GV_CHECK = C_X.

  ENDIF.



  UPDATE ZEDT04_105

  SET AENAME = SY-UNAME

      AEDATE = SY-DATUM

      AEZEIT = SY-UZEIT

  WHERE ZPERNR = GS_SAL-ZPERNR

  AND ZYEAR = P_ZYEAR.



  IF SY-SUBRC <> 0.

    GV_CHECK = C_X.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_DATA_RANK

*&---------------------------------------------------------------------*




FORM GET_DATA_RANK .

  IF P_ZYEAR IS INITIAL OR P_ZMONTH IS INITIAL.

    MESSAGE I000.   " #### ## ### ##

    EXIT.           " END-OF-SELECTION## ##

  ENDIF.



  " #### ##

  SELECT  A~ZPERNR

          B~ZPNAME

          A~ZDEPCODE

          A~ZDEPRANK

          A~ZEDATE

          D~ZSALARY

          C~ZRANK

    INTO CORRESPONDING FIELDS OF TABLE GT_RANK

    FROM ZEDT04_102 AS A

      INNER JOIN ZEDT04_103 AS B

      ON A~ZPERNR = B~ZPERNR

      INNER JOIN ZEDT04_104 AS C

      ON A~ZPERNR = C~ZPERNR

      INNER JOIN ZEDT04_106 AS D

      ON A~ZPERNR = D~ZPERNR AND C~ZYEAR = D~ZYEAR

    WHERE A~ZPERNR IN S_ZPERNR

      AND C~ZYEAR = P_ZYEAR

      AND D~ZSALARY <> 0.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA_RANK

*&---------------------------------------------------------------------*




FORM MODIFY_DATA_RANK .

  LOOP AT GT_RANK INTO GS_RANK.

    CLEAR GS_WRITE_RANK.

    MOVE-CORRESPONDING GS_RANK TO GS_WRITE_RANK.



    " ###

    PERFORM MAKE_ZDEP_NAME  USING GS_RANK-ZDEPCODE

                            CHANGING GS_WRITE_RANK-ZDEP_NAME.



    " ###

    PERFORM MAKE_ZRANK_NAME USING GS_RANK-ZDEPRANK

                            CHANGING GS_WRITE_RANK-ZRANK_NAME.



    " ## ##

    PERFORM GET_PAY USING P_ZYEAR P_ZMONTH GS_RANK-ZPERNR

                    CHANGING GS_WRITE_RANK-ZMON.



    IF GS_WRITE_RANK-ZMON <> 0.

      APPEND GS_WRITE_RANK TO GT_WRITE_RANK.

    ENDIF.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_PAY

*&---------------------------------------------------------------------*




FORM GET_PAY  USING    P_P_ZYEAR

                       P_P_ZMONTH

                       P_GS_RANK_ZPERNR

              CHANGING P_GS_WRITE_RANK_ZMON.

  CASE P_P_ZMONTH.

    WHEN '1'.

      SELECT SINGLE ZMON01 FROM ZEDT04_105 INTO P_GS_WRITE_RANK_ZMON

        WHERE ZPERNR = P_GS_RANK_ZPERNR

        AND ZYEAR = P_P_ZYEAR.

    WHEN '2'.

      SELECT SINGLE ZMON02 FROM ZEDT04_105 INTO P_GS_WRITE_RANK_ZMON

        WHERE ZPERNR = P_GS_RANK_ZPERNR

        AND ZYEAR = P_P_ZYEAR.

    WHEN '3'.

      SELECT SINGLE ZMON03 FROM ZEDT04_105 INTO P_GS_WRITE_RANK_ZMON

        WHERE ZPERNR = P_GS_RANK_ZPERNR

        AND ZYEAR = P_P_ZYEAR.

    WHEN '4'.

      SELECT SINGLE ZMON04 FROM ZEDT04_105 INTO P_GS_WRITE_RANK_ZMON

        WHERE ZPERNR = P_GS_RANK_ZPERNR

        AND ZYEAR = P_P_ZYEAR.

    WHEN '5'.

      SELECT SINGLE ZMON05 FROM ZEDT04_105 INTO P_GS_WRITE_RANK_ZMON

        WHERE ZPERNR = P_GS_RANK_ZPERNR

        AND ZYEAR = P_P_ZYEAR.

    WHEN '6'.

      SELECT SINGLE ZMON06 FROM ZEDT04_105 INTO P_GS_WRITE_RANK_ZMON

        WHERE ZPERNR = P_GS_RANK_ZPERNR

        AND ZYEAR = P_P_ZYEAR.

    WHEN '7'.

      SELECT SINGLE ZMON07 FROM ZEDT04_105 INTO P_GS_WRITE_RANK_ZMON

        WHERE ZPERNR = P_GS_RANK_ZPERNR

        AND ZYEAR = P_P_ZYEAR.

    WHEN '8'.

      SELECT SINGLE ZMON08 FROM ZEDT04_105 INTO P_GS_WRITE_RANK_ZMON

        WHERE ZPERNR = P_GS_RANK_ZPERNR

        AND ZYEAR = P_P_ZYEAR.

    WHEN '9'.

      SELECT SINGLE ZMON09 FROM ZEDT04_105 INTO P_GS_WRITE_RANK_ZMON

        WHERE ZPERNR = P_GS_RANK_ZPERNR

        AND ZYEAR = P_P_ZYEAR.

    WHEN '10'.

      SELECT SINGLE ZMON10 FROM ZEDT04_105 INTO P_GS_WRITE_RANK_ZMON

        WHERE ZPERNR = P_GS_RANK_ZPERNR

        AND ZYEAR = P_P_ZYEAR.

    WHEN '11'.

      SELECT SINGLE ZMON11 FROM ZEDT04_105 INTO P_GS_WRITE_RANK_ZMON

        WHERE ZPERNR = P_GS_RANK_ZPERNR

        AND ZYEAR = P_P_ZYEAR.

    WHEN '12'.

      SELECT SINGLE ZMON12 FROM ZEDT04_105 INTO P_GS_WRITE_RANK_ZMON

        WHERE ZPERNR = P_GS_RANK_ZPERNR

        AND ZYEAR = P_P_ZYEAR.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  WRITE_DATA_RANK

*&---------------------------------------------------------------------*




FORM WRITE_DATA_RANK .

  IF GT_WRITE_RANK[] IS INITIAL.

    MESSAGE I001.

    STOP.

  ENDIF.

  PERFORM FIELD_CATALOG_RANK.

  PERFORM ALV_LAYOUT.

  PERFORM ALV_SORT.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

    EXPORTING

      IT_FIELDCAT                       = GT_FIELDCAT

      IS_LAYOUT                         = GS_LAYOUT

      IT_SORT                           = GT_SORT

    TABLES

      T_OUTTAB                          = GT_WRITE_RANK.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG_RANK

*&---------------------------------------------------------------------*




FORM FIELD_CATALOG_RANK .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-seltext_m = '####'.

  GS_FIELDCAT-KEY = C_X.  " ###. ## ##. #### # ##.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZPNAME'.

  GS_FIELDCAT-seltext_m = '####'.

  GS_FIELDCAT-KEY = C_X.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZDEPCODE'.

  GS_FIELDCAT-seltext_m = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZDEP_NAME'.

  GS_FIELDCAT-seltext_m = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZRANK_NAME'.

  GS_FIELDCAT-seltext_m = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZEDATE'.

  GS_FIELDCAT-seltext_m = '###'.

  GS_FIELDCAT-OUTPUTLEN = 10.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZSALARY'.

  GS_FIELDCAT-seltext_m = '####'.

  GS_FIELDCAT-CURRENCY = 'KRW'.   " ### ##

  GS_FIELDCAT-JUST = 'R'.         " ### ### ##

  GS_FIELDCAT-DO_SUM = C_X.       " ## ##.

  GS_FIELDCAT-OUTPUTLEN = 15.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'ZRANK'.

  GS_FIELDCAT-seltext_m = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'ZMON'.

  GS_FIELDCAT-seltext_m = P_ZMONTH && '####'. "&&## ## ## (=CONCATENATE)

  GS_FIELDCAT-CURRENCY = 'KRW'.   " ### ##

  GS_FIELDCAT-JUST = 'R'.         " ### ### ##

  GS_FIELDCAT-DO_SUM = C_X.       " ## ##.

  GS_FIELDCAT-OUTPUTLEN = 15.

  APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_SORT

*&---------------------------------------------------------------------*




FORM ALV_SORT .

  GS_SORT-SPOS = 1.             " ## ## (## ####?)

  GS_SORT-FIELDNAME = 'ZPERNR'.

  GS_SORT-UP = C_X.           " ####

  APPEND GS_SORT TO GT_SORT.

ENDFORM.