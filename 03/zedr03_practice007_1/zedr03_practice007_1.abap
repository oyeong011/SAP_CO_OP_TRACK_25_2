
*&---------------------------------------------------------------------*

*& Report ZEDR03_PRACTICE007_1

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR03_PRACTICE007_1 MESSAGE-ID ZMED03.






* TABLES




TABLES: ZEDT03_102,

        ZEDT03_103,

        ZEDT03_104,

        ZEDT03_105,

        ZEDT03_106.



" ### ##

CONSTANTS: C_X TYPE CHAR1 VALUE 'X'.



"### ###

"## ## ###

TYPES: BEGIN OF TY_EMP,

          ZPERNR TYPE ZEDT03_102-ZPERNR,

          ZPNAME TYPE ZEDT03_103-ZPNAME,

          ZDEPCODE TYPE ZEDT03_102-ZDEPCODE,

          ZDEPCODE_T TYPE C LENGTH 20,

          ZDEPRANK    TYPE ZEDT03_102-ZDEPRANK,

          ZDEPRANK_T  TYPE C LENGTH 20,

          ZEDATE      TYPE ZEDT03_102-ZEDATE,

          ZQDATE      TYPE ZEDT03_102-ZQDATE,

          ZQFLAG      TYPE ZEDT03_102-ZQFLAG,

          ZQFLAG_T    TYPE C LENGTH 4,

          ZGENDER     TYPE ZEDT03_103-ZGENDER,

          ZGENDER_T   TYPE C LENGTH 2,

          ZADDRESS    TYPE ZEDT03_103-ZADDRESS,

          ZBANKCODE   TYPE ZEDT03_106-ZBANKCODE,

          ZBANKCODE_T TYPE C LENGTH 20,

          ZACCOUNT    TYPE ZEDT03_106-ZACCOUNT,

  END OF TY_EMP.



TYPES TY_T_EMP TYPE STANDARD TABLE OF TY_EMP WITH EMPTY KEY.



"ALV ### ## ## ###

TYPES : BEGIN OF TY_EMP_OUT,

         ZPERNR      TYPE ZEDT03_102-ZPERNR,

         ZPNAME      TYPE ZEDT03_103-ZPNAME,

         ZDEPCODE    TYPE ZEDT03_102-ZDEPCODE,

         ZDEPCODE_T  TYPE C LENGTH 20,

         ZDEPRANK_T  TYPE C LENGTH 20,

         ZEDATE      TYPE ZEDT03_102-ZEDATE,

         ZQFLAG_T    TYPE C LENGTH 4,

         ZGENDER_T   TYPE C LENGTH 2,

         ZADDRESS    TYPE ZEDT03_103-ZADDRESS,

         ZBANKCODE   TYPE ZEDT03_106-ZBANKCODE,

         ZBANKCODE_T TYPE C LENGTH 20,

         ZACCOUNT    TYPE ZEDT03_106-ZACCOUNT,

       END OF TY_EMP_OUT.



TYPES TY_T_EMP_OUT TYPE STANDARD TABLE OF TY_EMP_OUT WITH EMPTY KEY.



"## ## ###

TYPES: BEGIN OF TY_SAL,

         ZPERNR     TYPE ZEDT03_102-ZPERNR,

         ZPNAME     TYPE ZEDT03_103-ZPNAME,

         ZDEPCODE   TYPE ZEDT03_102-ZDEPCODE,

         ZDEPCODE_T TYPE C LENGTH 20,

         ZDEPRANK   TYPE ZEDT03_102-ZDEPRANK,

         ZDEPRANK_T TYPE C LENGTH 20,

         ZEDATE     TYPE ZEDT03_102-ZEDATE,

         DATAB      TYPE ZEDT03_102-DATAB,

         ZSALARY    TYPE ZEDT03_106-ZSALARY,

         ZYEAR      TYPE ZEDT03_106-ZYEAR,

         ZRANK      TYPE ZEDT03_104-ZRANK,

         ZSAL_MONTH TYPE ZEDT03_106-ZSALARY,

       END OF TY_SAL.



TYPES TY_T_SAL TYPE STANDARD TABLE OF TY_SAL WITH EMPTY KEY.



TYPES: BEGIN OF TY_EVAL,

         ZPERNR     TYPE ZEDT03_102-ZPERNR,

         ZPNAME     TYPE ZEDT03_103-ZPNAME,

         ZDEPCODE   TYPE ZEDT03_102-ZDEPCODE,

         ZDEPCODE_T TYPE C LENGTH 20,

         ZDEPRANK_T TYPE C LENGTH 20,

         ZEDATE     TYPE ZEDT03_102-ZEDATE,

         ZSALARY    TYPE ZEDT03_106-ZSALARY,

         ZRANK      TYPE ZEDT03_104-ZRANK,

         ZSAL_MONTH TYPE ZEDT03_106-ZSALARY,

       END OF TY_EVAL.



TYPES TY_T_EVAL TYPE STANDARD TABLE OF TY_EVAL WITH EMPTY KEY.



"DATA

DATA : GV_SUBRC TYPE I,

       GR_ZFG TYPE RANGE OF ZEDT03_102-ZQFLAG.



DATA : GT_EMP TYPE TY_T_EMP,

       GS_EMP TYPE TY_EMP,

       GT_EMP_OUT TYPE TY_T_EMP_OUT,

       GS_EMP_OUT TYPE TY_EMP_OUT.



DATA: GT_SAL      TYPE TY_T_SAL,

      GS_SAL      TYPE TY_SAL.



DATA: GT_EVAL     TYPE TY_T_EVAL,

      GS_EVAL     TYPE TY_EVAL.



"ALV

DATA: GS_FIELDCAT TYPE SLIS_FIELDCAT_ALV,

      GT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV,

      GS_LAYOUT   TYPE SLIS_LAYOUT_ALV,

      GS_SORT     TYPE SLIS_SORTINFO_ALV,

      GT_SORT     TYPE SLIS_T_SORTINFO_ALV.



"SELECTION-SCREEN

SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

SELECT-OPTIONS : S_PERNR FOR ZEDT03_102-ZPERNR.

SELECT-OPTIONS : S_DATE FOR ZEDT03_102-DATBI MODIF ID M1.

SELECT-OPTIONS : S_DEPT FOR ZEDT03_102-ZDEPCODE NO INTERVALS NO-EXTENSION MODIF ID M1.

PARAMETERS : P_YEAR TYPE BKPF-GJAHR OBLIGATORY DEFAULT SY-DATUM(4) MODIF ID M2.

PARAMETERS : P_MONTH TYPE BKPF-MONAT OBLIGATORY DEFAULT SY-DATUM+4(2) MODIF ID M2.

SELECTION-SCREEN END OF BLOCK B1.



SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

PARAMETERS: P_R1 RADIOBUTTON GROUP R1 DEFAULT 'X' USER-COMMAND UC1,

            P_R2 RADIOBUTTON GROUP R1,

            P_R3 RADIOBUTTON GROUP R1.

SELECTION-SCREEN END OF BLOCK B2.



SELECTION-SCREEN BEGIN OF BLOCK B3 WITH FRAME.

PARAMETERS: P_CH1 AS CHECKBOX DEFAULT 'X' MODIF ID M1.

SELECTION-SCREEN END OF BLOCK B3.



"INITIALIZATION

INITIALIZATION.

S_DATE-SIGN = 'I'.

S_DATE-OPTION = 'BT'.

S_DATE-LOW = SY-DATUM(4) && '0101'.

CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'

  EXPORTING

    DAY_IN = SY-DATUM

  IMPORTING

    LAST_DAY_OF_MONTH = S_DATE-HIGH.

APPEND S_DATE.



AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    CASE SCREEN-GROUP1.

      WHEN 'M1'.

        IF P_R1 = C_X.

          SCREEN-ACTIVE = 1.

        ELSE.

          SCREEN-ACTIVE = 0.

        ENDIF.

      WHEN 'M2'.

        IF P_R2 = C_X OR P_R3 = C_X.

          SCREEN-ACTIVE = 1.

        ELSE.

          SCREEN-ACTIVE = 0.

        ENDIF.

     ENDCASE.

     MODIFY SCREEN.

  ENDLOOP.



"START-OF-SELECTION

START-OF-SELECTION.

  IF P_R1 = C_X.

    PERFORM RANGES_CONTROL.

    PERFORM GET_EMP.

    PERFORM MODIF_EMP USING GT_EMP.

    PERFORM DISPLAY_EMP.

  ENDIF.




*&---------------------------------------------------------------------*

*&      Form  RANGES_CONTROL

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM RANGES_CONTROL .

  CLEAR GR_ZFG.

  DATA : LS_ZFG LIKE LINE OF GR_ZFG.



  LS_ZFG-SIGN = 'I'.

  LS_ZFG-OPTION = 'EQ'.



  IF P_CH1 = C_X.

    LS_ZFG-LOW = ''.

    APPEND LS_ZFG TO GR_ZFG.

  ELSE. "## #### ### ### # ###

    LS_ZFG-LOW = ''.

    APPEND LS_ZFG TO GR_ZFG.

    LS_ZFG-LOW = C_X.

    APPEND LS_ZFG TO GR_ZFG.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_EMP

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_EMP .

  CLEAR GT_EMP.



  SELECT

        T1~ZPERNR,

        T2~ZPNAME,

        T1~ZDEPCODE,

        T1~ZDEPRANK,

        T1~ZEDATE,

        T1~ZQDATE,

        T1~ZQFLAG,

        T2~ZGENDER,

        T2~ZADDRESS,

        T3~ZBANKCODE,

        T3~ZACCOUNT

    FROM ZEDT03_102 AS T1

    INNER JOIN ZEDT03_103 AS T2 ON T1~ZPERNR = T2~ZPERNR

    INNER JOIN ZEDT03_106 AS T3 ON T1~ZPERNR = T3~ZPERNR

    INTO CORRESPONDING FIELDS OF TABLE @GT_EMP

    WHERE T1~ZEDATE <= @S_DATE-HIGH

    AND ( T1~ZQDATE >= @S_DATE-LOW OR T1~ZQDATE = '00000000' )

    AND T1~ZDEPCODE IN @S_DEPT

    AND T1~ZPERNR IN @S_PERNR

    AND T1~ZQFLAG IN @GR_ZFG.



  IF GT_EMP IS INITIAL.

    MESSAGE E001.

    STOP.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIF_EMP

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GT_EMP  text

*----------------------------------------------------------------------*




FORM MODIF_EMP  USING IT_EMP TYPE TY_T_EMP.

  CLEAR GT_EMP_OUT.

  LOOP AT IT_EMP INTO GS_EMP.

    CLEAR GS_EMP_OUT.



    MOVE-CORRESPONDING GS_EMP TO GS_EMP_OUT.



    CASE GS_EMP-ZDEPCODE.

      WHEN 'SS0001'. GS_EMP_OUT-ZDEPCODE_T = '###'.

      WHEN 'SS0002'. GS_EMP_OUT-ZDEPCODE_T = '###'.

      WHEN 'SS0003'. GS_EMP_OUT-ZDEPCODE_T = '###'.

      WHEN 'SS0004'. GS_EMP_OUT-ZDEPCODE_T = '###'.

      WHEN 'SS0005'. GS_EMP_OUT-ZDEPCODE_T = '###'.

      WHEN 'SS0006'. GS_EMP_OUT-ZDEPCODE_T = '###'.

    ENDCASE.



    CASE GS_EMP-ZDEPRANK.

      WHEN 'A'. GS_EMP_OUT-ZDEPRANK_T = '##'.

      WHEN 'B'. GS_EMP_OUT-ZDEPRANK_T = '##'.

      WHEN 'C'. GS_EMP_OUT-ZDEPRANK_T = '##'.

      WHEN 'D'. GS_EMP_OUT-ZDEPRANK_T = '##'.

      WHEN 'E'. GS_EMP_OUT-ZDEPRANK_T = '##'.

      WHEN 'F'. GS_EMP_OUT-ZDEPRANK_T = '##'.

      WHEN 'G'. GS_EMP_OUT-ZDEPRANK_T = '##'.

    ENDCASE.



    CASE GS_EMP-ZQFLAG.

      WHEN 'X'.       GS_EMP_OUT-ZQFLAG_T = '##'.

      WHEN OTHERS.    GS_EMP_OUT-ZQFLAG_T = '##'.

    ENDCASE.



    CASE GS_EMP-ZGENDER.

      WHEN 'M'. GS_EMP_OUT-ZGENDER_T = '##'.

      WHEN 'F'. GS_EMP_OUT-ZGENDER_T = '##'.

    ENDCASE.



    CASE GS_EMP-ZBANKCODE.

      WHEN '001'. GS_EMP_OUT-ZBANKCODE_T = '##'.

      WHEN '002'. GS_EMP_OUT-ZBANKCODE_T = '##'.

      WHEN '003'. GS_EMP_OUT-ZBANKCODE_T = '##'.

      WHEN '004'. GS_EMP_OUT-ZBANKCODE_T = '##'.

      WHEN '005'. GS_EMP_OUT-ZBANKCODE_T = '###'.

    ENDCASE.



    APPEND GS_EMP_OUT TO GT_EMP_OUT.

   ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  DISPLAY_EMP

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM DISPLAY_EMP .

  PERFORM ALV_FIELDCAT_EMP.

  PERFORM ALV_LAYOUT_EMP.

  PERFORM ALV_SORT_EMP.



  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'

    EXPORTING

      IT_FIELDCAT = GT_FIELDCAT

      IS_LAYOUT = GS_LAYOUT

      IT_SORT = GT_SORT

    TABLES

      T_OUTTAB = GT_EMP_OUT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_FIELDCAT_EMP

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_FIELDCAT_EMP .

  CLEAR GT_FIELDCAT.



  CLEAR GS_FIELDCAT.  GS_FIELDCAT-COL_POS = 1.  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.      GS_FIELDCAT-SELTEXT_M = '####'.   GS_FIELDCAT-KEY = C_X. APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR GS_FIELDCAT. GS_FIELDCAT-COL_POS = 2.  GS_FIELDCAT-FIELDNAME = 'ZPNAME'.      GS_FIELDCAT-SELTEXT_M = '####'.   GS_FIELDCAT-KEY = C_X. APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR GS_FIELDCAT. GS_FIELDCAT-COL_POS = 3.  GS_FIELDCAT-FIELDNAME = 'ZDEPCODE'.    GS_FIELDCAT-SELTEXT_M = '####'.   APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR GS_FIELDCAT. GS_FIELDCAT-COL_POS = 4.  GS_FIELDCAT-FIELDNAME = 'ZDEPCODE_T'.  GS_FIELDCAT-SELTEXT_M = '###'.     APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR GS_FIELDCAT. GS_FIELDCAT-COL_POS = 5.  GS_FIELDCAT-FIELDNAME = 'ZDEPRANK_T'.  GS_FIELDCAT-SELTEXT_M = '###'.     APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR GS_FIELDCAT. GS_FIELDCAT-COL_POS = 6.  GS_FIELDCAT-FIELDNAME = 'ZEDATE'.      GS_FIELDCAT-SELTEXT_M = '###'.     APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR GS_FIELDCAT. GS_FIELDCAT-COL_POS = 7.  GS_FIELDCAT-FIELDNAME = 'ZQFLAG_T'.    GS_FIELDCAT-SELTEXT_M = '####'.   APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR GS_FIELDCAT.  GS_FIELDCAT-COL_POS = 8.  GS_FIELDCAT-FIELDNAME = 'ZGENDER_T'.   GS_FIELDCAT-SELTEXT_M = '##'.       APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR GS_FIELDCAT. GS_FIELDCAT-COL_POS = 9.  GS_FIELDCAT-FIELDNAME = 'ZADDRESS'.    GS_FIELDCAT-SELTEXT_M = '##'.       APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR GS_FIELDCAT. GS_FIELDCAT-COL_POS = 10. GS_FIELDCAT-FIELDNAME = 'ZBANKCODE'.   GS_FIELDCAT-SELTEXT_M = '####'.   APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR  GS_FIELDCAT. GS_FIELDCAT-COL_POS = 11. GS_FIELDCAT-FIELDNAME = 'ZBANKCODE_T'. GS_FIELDCAT-SELTEXT_M = '###'.     APPEND GS_FIELDCAT TO GT_FIELDCAT.

  CLEAR GS_FIELDCAT. GS_FIELDCAT-COL_POS = 12. GS_FIELDCAT-FIELDNAME = 'ZACCOUNT'.    GS_FIELDCAT-SELTEXT_M = '####'.   APPEND GS_FIELDCAT TO GT_FIELDCAT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT_EMP

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_LAYOUT_EMP .

  GS_LAYOUT-ZEBRA = C_X.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_SORT_EMP

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_SORT_EMP .

  CLEAR GT_SORT.

  GS_SORT-SPOS = 1.

  GS_SORT-FIELDNAME = 'ZPERNR'.

  GS_SORT-UP = C_X.

  APPEND GS_SORT TO GT_SORT.

ENDFORM.