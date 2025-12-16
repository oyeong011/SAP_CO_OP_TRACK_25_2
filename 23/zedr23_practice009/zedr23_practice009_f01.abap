
*&---------------------------------------------------------------------*

*&  Include           ZEDR23_PRACTICE009_F01

*&---------------------------------------------------------------------*






FORM SET_INIT.

  S_DATE-SIGN = 'I'.

  S_DATE-OPTION = 'EQ'.

  "S_DATE-LOW = SY-DATUM+0(6) && '01'.

  S_DATE-LOW = Z_LASTDAY.

  APPEND S_DATE.



ENDFORM.



FORM GET_DATE USING PV_DATE TYPE SY-DATUM

      CHANGING PV_LASTDAY TYPE SY-DATUM.

  DATA :LV_YEAR TYPE I,

        LV_MONTH TYPE I,

        LV_NEXT_MONTH TYPE SY-DATUM.



  " ### ## ### #

  LV_YEAR = PV_DATE+0(4).

  LV_MONTH = PV_DATE+4(2).



  IF LV_MONTH = 12.

    LV_NEXT_MONTH = |{ LV_YEAR + 1 }0101 |.

  ELSE.

    LV_NEXT_MONTH = |{ LV_YEAR }{ LV_MONTH + 1 WIDTH = 2 PAD = '0' }01 |.

  ENDIF.



  PV_LASTDAY = LV_NEXT_MONTH - 1.



ENDFORM.



FORM CHECK.

  IF S_DATE IS INITIAL.

    MESSAGE '##### ### ##### ###.' TYPE 'E'.

  ENDIF.



  IF S_ZPERNR IS INITIAL AND S_DEP IS INITIAL.

    MESSAGE '#### ## #### # ### ### ##### ###.' TYPE 'E'.

  ENDIF.



  IF S_DEP[] IS NOT INITIAL.

    LOOP AT S_DEP INTO DATA(line).

       READ TABLE GR_ZDEPCODE WITH KEY low = line-low TRANSPORTING NO FIELDS.

       IF SY-SUBRC <> 0.

         MESSAGE '#### ## #######.' TYPE 'E'.

       ENDIF.

    ENDLOOP.

  ENDIF.

ENDFORM.





FORM GET_DATA.



  SELECT A~ZPERNR A~ZDEPCODE A~ZQFLAG

    B~ZYEAR B~DATBI B~DATAB B~ZRANK

    INTO CORRESPONDING FIELDS OF TABLE GT_01

    FROM ZEDT23_102 AS A

    JOIN ZEDT23_104 AS B ON A~ZPERNR EQ B~ZPERNR

    WHERE A~ZPERNR IN S_ZPERNR

    AND ( B~DATBI <= S_DATE-LOW AND B~DATAB >= S_DATE-LOW )

    AND A~ZDEPCODE IN S_DEP.



  SELECT A~ZPERNR A~ZDEPCODE A~ZQDATE A~ZQFLAG

    B~ZYEAR B~DATBI B~DATAB B~ZSALARY B~ZBANKCODE B~ZACCOUNT

    INTO CORRESPONDING FIELDS OF TABLE GT_02

    FROM ZEDT23_102 AS A

    JOIN ZEDT23_106 AS B ON A~ZPERNR EQ B~ZPERNR

    WHERE A~ZPERNR IN S_ZPERNR

    AND ( B~DATBI <= S_DATE-LOW AND B~DATAB >= S_DATE-LOW )

    AND A~ZDEPCODE IN S_DEP.



  LOOP AT GT_02 INTO DATA(line).

    IF line-ZQDATE IS NOT INITIAL AND line-ZQDATE < S_DATE-LOW.

      DELETE GT_02 INDEX SY-TABIX.

    ENDIF.

  ENDLOOP.



  SELECT A~ZPERNR A~ZDEPCODE A~DATBI A~DATAB

    A~ZDEPRANK A~ZEDATE A~ZQDATE A~ZQFLAG

    B~ZPNAME B~ZGENDER B~ZADDRESS

    INTO CORRESPONDING FIELDS OF TABLE GT_03

    FROM ZEDT23_102 AS A

    JOIN ZEDT23_103 AS B ON A~ZPERNR EQ B~ZPERNR

    WHERE A~ZPERNR IN S_ZPERNR

    AND ( A~DATBI <= S_DATE-LOW AND A~DATAB >= S_DATE-LOW )

    AND A~ZDEPCODE IN S_DEP.





  IF GT_01[] IS INITIAL AND GT_02[] IS INITIAL AND GT_03[] IS INITIAL.

    MESSAGE '#### #### ####.' TYPE 'E'.

  ENDIF.



ENDFORM.





FORM REMOVE_QUIT.

  IF P_CHECK NE TRUE.

    LOOP AT GT_01 INTO DATA(line1).

      IF line1-ZQFLAG EQ TRUE.

        DELETE GT_01 INDEX SY-TABIX.

      ENDIF.

    ENDLOOP.



    LOOP AT GT_02 INTO DATA(line2).

      IF line2-ZQFLAG EQ TRUE.

        DELETE GT_02 INDEX SY-TABIX.

      ENDIF.

    ENDLOOP.



    LOOP AT GT_03 INTO DATA(line3).

      IF line3-ZQFLAG EQ TRUE.

        DELETE GT_03 INDEX SY-TABIX.

      ENDIF.

    ENDLOOP.

  ENDIF.

ENDFORM.



FORM VAL_TO_DESC.

  LOOP AT GT_01 INTO DATA(line1).

    CASE line1-ZDEPCODE.

      WHEN 'SS0001'.

        line1-ZDEPCODE_STR = '###'.

      WHEN 'SS0002'.

        line1-ZDEPCODE_STR = '###'.

      WHEN 'SS0003'.

        line1-ZDEPCODE_STR = '###'.

      WHEN 'SS0004'.

        line1-ZDEPCODE_STR = '###'.

      WHEN 'SS0005'.

        line1-ZDEPCODE_STR = '###'.

      WHEN 'SS0006'.

        line1-ZDEPCODE_STR = '###'.

    ENDCASE.



    MODIFY GT_01 FROM line1

      TRANSPORTING ZDEPCODE_STR

      WHERE ZPERNR EQ line1-ZPERNR.

  ENDLOOP.



  LOOP AT GT_02 INTO DATA(line2).

    CASE line2-ZBANKCODE.

      WHEN '001'.

        line2-ZBANKCODE_STR = '##'.

      WHEN '002'.

        line2-ZBANKCODE_STR = '##'.

      WHEN '003'.

        line2-ZBANKCODE_STR = '##'.

      WHEN '004'.

        line2-ZBANKCODE_STR = '##'.

      WHEN '005'.

        line2-ZBANKCODE_STR = '###'.

    ENDCASE.



    IF line2-ZBANKCODE <= 010 AND line2-ZBANKCODE >= 001.

      line2-ZWAERS = 'KRW'.

    ENDIF.



    MODIFY GT_02 FROM line2

      TRANSPORTING ZBANKCODE_STR ZWAERS

      WHERE ZPERNR EQ line2-ZPERNR.

  ENDLOOP.



  LOOP AT GT_03 INTO DATA(line3). "##, ##, ##

    CASE line3-ZDEPCODE.

      WHEN 'SS0001'.

        line3-ZDEPCODE_STR = '###'.

      WHEN 'SS0002'.

        line3-ZDEPCODE_STR = '###'.

      WHEN 'SS0003'.

        line3-ZDEPCODE_STR = '###'.

      WHEN 'SS0004'.

        line3-ZDEPCODE_STR = '###'.

      WHEN 'SS0005'.

        line3-ZDEPCODE_STR = '###'.

      WHEN 'SS0006'.

        line3-ZDEPCODE_STR = '###'.

    ENDCASE.



    CASE line3-ZDEPRANK.

      WHEN 'A'.

        line3-ZDEPRANK_STR = '##'.

        line3-ZLIGHT = YELLOW.

      WHEN 'B'.

        line3-ZDEPRANK_STR = '##'.

        line3-ZLIGHT = GREEN.

      WHEN 'C'.

        line3-ZDEPRANK_STR = '##'.

        line3-ZLIGHT = GREEN.

      WHEN 'D'.

        line3-ZDEPRANK_STR = '##'.

        line3-ZLIGHT = GREEN.

      WHEN 'E'.

        line3-ZDEPRANK_STR = '##'.

        line3-ZLIGHT = GREEN.

      WHEN 'F'.

        line3-ZDEPRANK_STR = '##'.

        line3-ZLIGHT = GREEN.

      WHEN 'G'.

        line3-ZDEPRANK_STR = '##'.

        line3-ZLIGHT = GREEN.

    ENDCASE.



    CASE line3-ZGENDER.

      WHEN 'M'.

        line3-ZGENDER_STR = '##'.

      WHEN 'F'.

        line3-ZGENDER_STR = '##'.

    ENDCASE.



    CASE line3-ZQFLAG.

      WHEN 'X'.

        line3-ZLIGHT = RED.

    ENDCASE.



    MODIFY GT_03 FROM line3

      TRANSPORTING ZDEPCODE_STR ZDEPRANK_STR ZGENDER_STR ZLIGHT

      WHERE ZPERNR EQ line3-ZPERNR.

  ENDLOOP.



ENDFORM.







" DOCKER

" SPLITTER -> [ GC_ROW1 ]

"               SPLITTER_ROW1 -> [ CONTAINER1 ][ CONTAINER2 ]

" SPLITTER -> [ GC_ROW2 ]



FORM CREATE_OBJECT.

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



CREATE OBJECT GC_SPLITTER

  EXPORTING




*    LINK_DYNNR        =

*    LINK_REPID        =

*    SHELLSTYLE        =

*    LEFT              =

*    TOP               =

*    WIDTH             =

*    HEIGHT            =

*    METRIC            = cntl_metric_dynpro

*    ALIGN             = 15




    PARENT            = GC_DOCKING

    ROWS              = 2

    COLUMNS           = 1




*    NO_AUTODEF_PROGID_DYNNR =

*    NAME              =

*  EXCEPTIONS

*    CNTL_ERROR        = 1

*    CNTL_SYSTEM_ERROR = 2

*    others            = 3




    .

IF SY-SUBRC <> 0.




* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




ENDIF.



CALL METHOD GC_SPLITTER->GET_CONTAINER

  EXPORTING

    ROW       = 1

    COLUMN    = 1

  RECEIVING

    CONTAINER = GC_ROW1

    .

CALL METHOD GC_SPLITTER->GET_CONTAINER

  EXPORTING

    ROW       = 2

    COLUMN    = 1

  RECEIVING

    CONTAINER = GC_ROW2

    .





"""""""""## # ##""""""""""



CREATE OBJECT GC_SPLITTER_ROW1

  EXPORTING




*    LINK_DYNNR        =

*    LINK_REPID        =

*    SHELLSTYLE        =

*    LEFT              =

*    TOP               =

*    WIDTH             =

*    HEIGHT            =

*    METRIC            = cntl_metric_dynpro

*    ALIGN             = 15




    PARENT            = GC_ROW1

    ROWS              = 1

    COLUMNS           = 2




*    NO_AUTODEF_PROGID_DYNNR =

*    NAME              =

*  EXCEPTIONS

*    CNTL_ERROR        = 1

*    CNTL_SYSTEM_ERROR = 2

*    others            = 3




    .

IF SY-SUBRC <> 0.




* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




ENDIF.



CALL METHOD GC_SPLITTER_ROW1->GET_CONTAINER

  EXPORTING

    ROW       = 1

    COLUMN    = 1

  RECEIVING

    CONTAINER = GC_CONTAINER1

    .



CALL METHOD GC_SPLITTER_ROW1->GET_CONTAINER

  EXPORTING

    ROW       = 1

    COLUMN    = 2

  RECEIVING

    CONTAINER = GC_CONTAINER2

    .



""""""""" GRID ## """"""""""""

CREATE OBJECT GC_GRID1

  EXPORTING




*    I_SHELLSTYLE      = 0

*    I_LIFETIME        =




    I_PARENT          = GC_CONTAINER1




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



CREATE OBJECT GC_GRID2

  EXPORTING




*    I_SHELLSTYLE      = 0

*    I_LIFETIME        =




    I_PARENT          = GC_CONTAINER2




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



CREATE OBJECT GC_GRID3

  EXPORTING




*    I_SHELLSTYLE      = 0

*    I_LIFETIME        =




    I_PARENT          = GC_ROW2




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













"DATA : GS_FIELDCAT TYPE LVC_S_FCAT.

"DATA : GT_FIELDCAT1 TYPE LVC_T_FCAT.

"DATA : GT_FIELDCAT2 TYPE LVC_T_FCAT.

"DATA : GT_FIELDCAT3 TYPE LVC_T_FCAT.

FORM FIELD_CATALOG.

  PERFORM CONTAINER1_FIELD.

  PERFORM CONTAINER2_FIELD.

  PERFORM GC_ROW2_FIELD.

ENDFORM.



FORM CONTAINER1_FIELD.

  CLEAR : GS_FIELDCAT, GT_FIELDCAT1.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-EMPHASIZE = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZDEPCODE_STR'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZYEAR'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'DATBI'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'DATAB'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZRANK'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.

ENDFORM.



FORM CONTAINER2_FIELD.

  CLEAR : GS_FIELDCAT, GT_FIELDCAT2.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-EMPHASIZE = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZYEAR'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'DATBI'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'DATAB'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZSALARY'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-DO_SUM = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZBANKCODE_STR'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZACCOUNT'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



ENDFORM.



FORM GC_ROW2_FIELD.

  CLEAR : GS_FIELDCAT, GT_FIELDCAT3.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZLIGHT'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-ICON = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZPNAME'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZDEPCODE_STR'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'DATBI'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'DATAB'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZDEPRANK_STR'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'ZGENDER_STR'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'ZEDATE'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'ZADDRESS'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  IF P_CHECK EQ TRUE.

     CLEAR : GS_FIELDCAT.

     GS_FIELDCAT-COL_POS = 11.

     GS_FIELDCAT-FIELDNAME = 'ZQDATE'.

     GS_FIELDCAT-COLTEXT = '####'.

     APPEND GS_FIELDCAT TO GT_FIELDCAT3.



     CLEAR : GS_FIELDCAT.

     GS_FIELDCAT-COL_POS = 12.

     GS_FIELDCAT-FIELDNAME = 'ZQFLAG'.

     GS_FIELDCAT-COLTEXT = '####'.

     APPEND GS_FIELDCAT TO GT_FIELDCAT3.

   ENDIF.



ENDFORM.



FORM ALV_LAYOUT.



  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.

  GS_LAYOUT-CWIDTH_OPT = 'X'.

  GS_LAYOUT-TOTALS_BEF = 'X'.



  CLEAR GS_VARIANT.

  GS_VARIANT-REPORT = SY-REPID.

  GS_VARIANT-USERNAME = SY-UNAME.



ENDFORM.



"DATA : GS_SORT TYPE LVC_S_SORT.

"DATA : GT_SORT1 TYPE LVC_T_SORT.

"DATA : GT_SORT2 TYPE LVC_T_SORT.

"DATA : GT_SORT3 TYPE LVC_T_SORT.

FORM ALV_SORT.

  PERFORM CONTAINER1_SORT.

  PERFORM CONTAINER2_SORT.

  PERFORM GC_ROW2_SORT.

ENDFORM.



FORM CONTAINER1_SORT.

  CLEAR : GS_SORT, GT_SORT1.

  GS_SORT-SPOS = 1.

  GS_SORT-FIELDNAME = 'ZPERNR'.

  GS_SORT-UP = 'X'.

  APPEND GS_SORT TO GT_SORT1.

ENDFORM.



FORM CONTAINER2_SORT.

  CLEAR : GS_SORT, GT_SORT2.

  GS_SORT-SPOS = 1.

  GS_SORT-FIELDNAME = 'ZPERNR'.

  GS_SORT-UP = 'X'.

  APPEND GS_SORT TO GT_SORT2.

ENDFORM.



FORM GC_ROW2_SORT.

  CLEAR : GS_SORT, GT_SORT3.

  GS_SORT-SPOS = 1.

  GS_SORT-FIELDNAME = 'ZPERNR'.

  GS_SORT-UP = 'X'.

  APPEND GS_SORT TO GT_SORT3.

ENDFORM.



"DATA : GC_GRID1 TYPE REF TO CL_GUI_ALV_GRID.

"DATA : GC_GRID2 TYPE REF TO CL_GUI_ALV_GRID.

"DATA : GC_GRID3 TYPE REF TO CL_GUI_ALV_GRID.

FORM CALL_ALV.

CALL METHOD GC_GRID1->SET_TABLE_FOR_FIRST_DISPLAY

  EXPORTING




*    I_BUFFER_ACTIVE               =

*    I_BYPASSING_BUFFER            =

*    I_CONSISTENCY_CHECK           =

*    I_STRUCTURE_NAME              =




    IS_VARIANT                    = GS_VARIANT

    I_SAVE                        = 'A'




*    I_DEFAULT                     = 'X'




    IS_LAYOUT                     = GS_LAYOUT




*    IS_PRINT                      =

*    IT_SPECIAL_GROUPS             =

*    IT_TOOLBAR_EXCLUDING          =

*    IT_HYPERLINK                  =

*    IT_ALV_GRAPHICS               =

*    IT_EXCEPT_QINFO               =

*    IR_SALV_ADAPTER               =




  CHANGING

    IT_OUTTAB                     = GT_01

    IT_FIELDCATALOG               = GT_FIELDCAT1

    IT_SORT                       = GT_SORT1




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







CALL METHOD GC_GRID2->SET_TABLE_FOR_FIRST_DISPLAY

  EXPORTING




*    I_BUFFER_ACTIVE               =

*    I_BYPASSING_BUFFER            =

*    I_CONSISTENCY_CHECK           =

*    I_STRUCTURE_NAME              =




    IS_VARIANT                    = GS_VARIANT

    I_SAVE                        = 'A'




*    I_DEFAULT                     = 'X'




    IS_LAYOUT                     = GS_LAYOUT




*    IS_PRINT                      =

*    IT_SPECIAL_GROUPS             =

*    IT_TOOLBAR_EXCLUDING          =

*    IT_HYPERLINK                  =

*    IT_ALV_GRAPHICS               =

*    IT_EXCEPT_QINFO               =

*    IR_SALV_ADAPTER               =




  CHANGING

    IT_OUTTAB                     = GT_02

    IT_FIELDCATALOG               = GT_FIELDCAT2

    IT_SORT                       = GT_SORT1




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



CALL METHOD GC_GRID3->SET_TABLE_FOR_FIRST_DISPLAY

  EXPORTING




*    I_BUFFER_ACTIVE               =

*    I_BYPASSING_BUFFER            =

*    I_CONSISTENCY_CHECK           =

*    I_STRUCTURE_NAME              =




    IS_VARIANT                    = GS_VARIANT

    I_SAVE                        = 'A'




*    I_DEFAULT                     = 'X'




    IS_LAYOUT                     = GS_LAYOUT




*    IS_PRINT                      =

*    IT_SPECIAL_GROUPS             =

*    IT_TOOLBAR_EXCLUDING          =

*    IT_HYPERLINK                  =

*    IT_ALV_GRAPHICS               =

*    IT_EXCEPT_QINFO               =

*    IR_SALV_ADAPTER               =




  CHANGING

    IT_OUTTAB                     = GT_03

    IT_FIELDCATALOG               = GT_FIELDCAT3

    IT_SORT                       = GT_SORT1




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