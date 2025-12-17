
*&---------------------------------------------------------------------*

*&  Include           ZEDR04_PRACTICE009_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SET_INIT

*&---------------------------------------------------------------------*




FORM SET_INIT .

  " #### ### # ##

  CALL FUNCTION 'RP_LAST_DAY_OF_MONTHS'       " ### ## ### ##

  EXPORTING

    DAY_IN            = SY-DATUM

  IMPORTING

    LAST_DAY_OF_MONTH = S_ZDATE-LOW.



  APPEND S_ZDATE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_DATA

*&---------------------------------------------------------------------*




FORM CHECK_DATA .

  " ##### #### # # #### ##

  IF S_ZPERNR IS INITIAL AND S_ZDCODE IS INITIAL.

    MESSAGE I000.

    STOP.

  ENDIF.



  " ### #### RANGES### ###

  R_FLAG-SIGN = 'I'.

  R_FLAG-OPTION = 'EQ'.

  R_FLAG-LOW = ''.

  APPEND R_FLAG.

  IF C_ZFLAG = C_X. " #####

    R_FLAG-LOW = C_X.

    APPEND R_FLAG.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SELECT_DATA

*&---------------------------------------------------------------------*




FORM SELECT_DATA .

  " #### ##

  SELECT  A~ZPERNR        " ####

          B~ZPNAME        " ##

          A~ZDEPCODE      " ####

          A~DATBI         " ####

          A~DATAB         " ####

          A~ZDEPRANK      " ####

          B~ZGENDER       " ##

          A~ZEDATE        " ####

          B~ZADDRESS      " ##

          A~ZQDATE        " ####

          A~ZQFLAG        " ####

    INTO CORRESPONDING FIELDS OF TABLE GT_INFO

    FROM ZEDT04_102 AS A

      INNER JOIN ZEDT04_103 AS B

      ON A~ZPERNR = B~ZPERNR

    WHERE A~ZPERNR IN S_ZPERNR

      AND A~DATBI <= S_ZDATE-LOW

      AND A~DATAB >= S_ZDATE-LOW

      AND A~ZDEPCODE IN S_ZDCODE

      AND A~ZQFLAG IN R_FLAG.



  IF GT_INFO[] IS INITIAL.

    EXIT.

  ENDIF.



  " #### ##

  SELECT  ZPERNR        " ####

          ZDEPCODE      " ####

          ZYEAR         " ##

          DATBI         " ####

          DATAB         " ####

          ZRANK         " ##

    INTO CORRESPONDING FIELDS OF TABLE GT_RANK

    FROM ZEDT04_104

      FOR ALL ENTRIES IN GT_INFO

    WHERE ZPERNR = GT_INFO-ZPERNR

      AND ZDEPCODE = GT_INFO-ZDEPCODE

      AND ZYEAR IN S_ZDATE.



  " #### ##

  SELECT  ZPERNR        " ####

          ZYEAR         " ##

          DATBI         " ####

          DATAB         " ####

          ZSALARY       " ####

          ZBANKCODE     " ####

          ZACCOUNT      " ####

    INTO CORRESPONDING FIELDS OF TABLE GT_CONTRACT

    FROM ZEDT04_106

      FOR ALL ENTRIES IN GT_INFO

    WHERE ZPERNR = GT_INFO-ZPERNR

      AND ZYEAR IN S_ZDATE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA

*&---------------------------------------------------------------------*




FORM MODIFY_DATA .

  " #### ### ###

  LOOP AT GT_INFO INTO GS_INFO.

    CLEAR GS_INFO_ALV.

    MOVE-CORRESPONDING GS_INFO TO GS_INFO_ALV.



    " ## ###

    IF GS_INFO-ZQFLAG = 'X'.        " ###

      GS_INFO_ALV-ZCOLOR = '@0A@'.    " ##

    ELSEIF GS_INFO-ZDEPRANK = 'A'.  "##

      GS_INFO_ALV-ZCOLOR = '@09@'.  " ##

    ELSE.

      GS_INFO_ALV-ZCOLOR = '@08@'.    " ##

    ENDIF.



    " ##

    PERFORM MAKE_ZDEP_NAME  USING GS_INFO-ZDEPCODE

                            CHANGING GS_INFO_ALV-ZDEP_NAME.

    " ##

    PERFORM MAKE_ZRANK_NAME USING GS_INFO-ZDEPRANK

                            CHANGING GS_INFO_ALV-ZRANK_NAME.

    " ##

    IF GS_INFO-ZGENDER ='M'.

        GS_INFO_ALV-ZGEN_NAME = '##'.

    ELSEIF GS_INFO-ZGENDER = 'F'.

        GS_INFO_ALV-ZGEN_NAME = '##'.

    ENDIF.



    APPEND GS_INFO_ALV TO GT_INFO_ALV.

  ENDLOOP.



  " #### ### ###

  LOOP AT GT_RANK INTO GS_RANK.

    CLEAR GS_RANK_ALV.

    MOVE-CORRESPONDING GS_RANK TO GS_RANK_ALV.



    " ##

    PERFORM MAKE_ZDEP_NAME  USING GS_RANK-ZDEPCODE

                            CHANGING GS_RANK_ALV-ZDEP_NAME.

    APPEND GS_RANK_ALV TO GT_RANK_ALV.

  ENDLOOP.



  " #### ### ###

  LOOP AT GT_CONTRACT INTO GS_CONTRACT.

    CLEAR GS_CONTRACT_ALV.

    MOVE-CORRESPONDING GS_CONTRACT TO GS_CONTRACT_ALV.



    " ###

    PERFORM MAKE_ZBANK_NAME USING GS_CONTRACT-ZBANKCODE

                            CHANGING GS_CONTRACT_ALV-ZBANK_NAME.



    " ##

    IF GS_CONTRACT-ZBANKCODE BETWEEN 1 AND 10.

      GS_CONTRACT_ALV-ZWAERS = 'KRW'.

    ENDIF.



    APPEND GS_CONTRACT_ALV TO GT_CONTRACT_ALV.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MAKE_ZDEP_NAME

*&---------------------------------------------------------------------*




FORM MAKE_ZDEP_NAME  USING    P_ZDEPCODE

                     CHANGING P_ZDEP_NAME.

  CASE P_ZDEPCODE.

    WHEN 'SS0001'.

      P_ZDEP_NAME = '###'.

    WHEN 'SS0002'.

      P_ZDEP_NAME = '###'.

    WHEN 'SS0003'.

      P_ZDEP_NAME = '###'.

    WHEN 'SS0004'.

      P_ZDEP_NAME = '###'.

    WHEN 'SS0005'.

      P_ZDEP_NAME = '###'.

    WHEN 'SS0006'.

      P_ZDEP_NAME = '###'.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MAKE_ZRANK_NAME

*&---------------------------------------------------------------------*




FORM MAKE_ZRANK_NAME  USING    P_ZDEPRANK

                      CHANGING P_ZRANK_NAME.

  CASE P_ZDEPRANK.

    WHEN 'A'.

      P_ZRANK_NAME = '##'.

    WHEN 'B'.

      P_ZRANK_NAME = '##'.

    WHEN 'C'.

      P_ZRANK_NAME = '##'.

    WHEN 'D'.

      P_ZRANK_NAME = '##'.

    WHEN 'E'.

      P_ZRANK_NAME = '##'.

    WHEN 'F'.

      P_ZRANK_NAME = '##'.

    WHEN 'G'.

      P_ZRANK_NAME = '##'.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MAKE_ZBANK_NAME

*&---------------------------------------------------------------------*




FORM MAKE_ZBANK_NAME  USING    P_ZBANKCODE

                      CHANGING P_ZBANK_NAME.

  CASE P_ZBANKCODE.

    WHEN '001'.

      P_ZBANK_NAME = '##'.

    WHEN '002'.

      P_ZBANK_NAME = '##'.

    WHEN '003'.

      P_ZBANK_NAME = '##'.

    WHEN '004'.

      P_ZBANK_NAME = '##'.

    WHEN '005'.

      P_ZBANK_NAME = '###'.

  ENDCASE.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CREATE_OBJECT

*&---------------------------------------------------------------------*




FORM CREATE_OBJECT .

  CREATE OBJECT GC_DOCKING

    EXPORTING

      REPID                       = SY-REPID

      DYNNR                       = SY-DYNNR

      EXTENSION                   = 2000.



  CREATE OBJECT GC_SPLITTER1

    EXPORTING

      PARENT            = GC_DOCKING

      ROWS              = 2

      COLUMNS           = 1.



  CALL METHOD GC_SPLITTER1->GET_CONTAINER

    EXPORTING

      ROW       = 2

      COLUMN    = 1

    RECEIVING

      CONTAINER = GC_CONTAINER1.



  CALL METHOD GC_SPLITTER1->GET_CONTAINER

    EXPORTING

      ROW       = 1

      COLUMN    = 1

    RECEIVING

      CONTAINER = GC_CONTAINER2_3.



  CREATE OBJECT GC_SPLITTER2

    EXPORTING

      PARENT            = GC_CONTAINER2_3

      ROWS              = 1

      COLUMNS           = 2.



  CALL METHOD GC_SPLITTER2->GET_CONTAINER

    EXPORTING

      ROW       = 1

      COLUMN    = 1

    RECEIVING

      CONTAINER = GC_CONTAINER2.



  CALL METHOD GC_SPLITTER2->GET_CONTAINER

    EXPORTING

      ROW       = 1

      COLUMN    = 2

    RECEIVING

      CONTAINER = GC_CONTAINER3.



  CREATE OBJECT GC_GRID1

    EXPORTING

      I_PARENT          = GC_CONTAINER1.



  CREATE OBJECT GC_GRID2

    EXPORTING

      I_PARENT          = GC_CONTAINER2.



  CREATE OBJECT GC_GRID3

    EXPORTING

      I_PARENT          = GC_CONTAINER3.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*




FORM FIELD_CATALOG .

  PERFORM CONTAINER1_FIELD.

  PERFORM CONTAINER2_FIELD.

  PERFORM CONTAINER3_FIELD.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CONTAINER1_FIELD

*&---------------------------------------------------------------------*




FORM CONTAINER1_FIELD .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT1.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZCOLOR'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  GS_FIELDCAT-ICON = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-KEY = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZPNAME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZDEP_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'DATBI'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'DATAB'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZRANK_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'ZGEN_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'ZEDATE'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'ZADDRESS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 11.

  GS_FIELDCAT-FIELDNAME = 'ZQDATE'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 12.

  GS_FIELDCAT-FIELDNAME = 'ZQFLAG'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CONTAINER2_FIELD

*&---------------------------------------------------------------------*




FORM CONTAINER2_FIELD .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT2.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-KEY = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZDEP_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZYEAR'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'DATBI'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'DATAB'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZRANK'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CONTAINER3_FIELD

*&---------------------------------------------------------------------*




FORM CONTAINER3_FIELD .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT3.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-KEY = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZYEAR'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'DATBI'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'DATAB'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZSALARY'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-DO_SUM = 'X'.

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-OUTPUTLEN = '15'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZBANK_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZACCOUNT'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_SORT

*&---------------------------------------------------------------------*




FORM ALV_SORT .

  CLEAR : GS_SORT, GT_SORT.

  GS_SORT-SPOS = '1'.

  GS_SORT-FIELDNAME = 'ZPERNR'.

  GS_SORT-UP = 'X'.

  APPEND GS_SORT TO GT_SORT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_LAYOUT

*&---------------------------------------------------------------------*




FORM ALV_LAYOUT .

  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.

  GS_LAYOUT-TOTALS_BEF = 'X'. " ## # ##



  CLEAR GS_VARIANT.

  GS_VARIANT-REPORT = SY-REPID.

  GS_VARIANT-USERNAME = SY-UNAME.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*




FORM ALV_DISPLAY .

  CALL METHOD GC_GRID1->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_VARIANT                    = GS_VARIANT

      IS_LAYOUT                     = GS_LAYOUT

    CHANGING

      IT_OUTTAB                     = GT_INFO_ALV

      IT_FIELDCATALOG               = GT_FIELDCAT1

      IT_SORT                       = GT_SORT.



  CALL METHOD GC_GRID2->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_VARIANT                    = GS_VARIANT

      IS_LAYOUT                     = GS_LAYOUT

    CHANGING

      IT_OUTTAB                     = GT_RANK_ALV

      IT_FIELDCATALOG               = GT_FIELDCAT2

      IT_SORT                       = GT_SORT.



  CALL METHOD GC_GRID3->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING

      IS_VARIANT                    = GS_VARIANT

      IS_LAYOUT                     = GS_LAYOUT

    CHANGING

      IT_OUTTAB                     = GT_CONTRACT_ALV

      IT_FIELDCATALOG               = GT_FIELDCAT3

      IT_SORT                       = GT_SORT.

ENDFORM.