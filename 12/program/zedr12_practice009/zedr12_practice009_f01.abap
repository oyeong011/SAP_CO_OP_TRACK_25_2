
*&---------------------------------------------------------------------*

*&  Include           ZEDR12_PRACTICE009_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SET_DATE

*&---------------------------------------------------------------------*




FORM SET_DATE .



  "### ##

CALL FUNCTION 'LAST_DAY_OF_MONTHS'

  EXPORTING

    DAY_IN                  = SY-DATUM

  IMPORTING

    LAST_DAY_OF_MONTH       = S_ZDATE-LOW.



  APPEND S_ZDATE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHECK_DATA

*&---------------------------------------------------------------------*




FORM CHECK_DATA .

  IF S_ZDATE IS INITIAL.

    MESSAGE I000.

    STOP.

  ELSE.

    IF ( S_ZDCODE IS INITIAL ) AND ( S_ZPERNR IS INITIAL ).

      MESSAGE I000.

    STOP.

    ENDIF.

  ENDIF.



  CLEAR: R_ZQFLAG, R_ZQFLAG[].



  R_ZQFLAG-SIGN = 'I'.

  R_ZQFLAG-OPTION = 'EQ'.

  R_ZQFLAG-LOW = ' '.

  APPEND R_ZQFLAG.

  IF P_ZQFLAG = 'X'.

    R_ZQFLAG-SIGN = 'I'.

    R_ZQFLAG-OPTION = 'EQ'.

    R_ZQFLAG-LOW = 'X'.

    APPEND R_ZQFLAG.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SELECT_DATA

*&---------------------------------------------------------------------*




FORM SELECT_DATA .

  "1.####

  SELECT A~ZPERNR

         B~ZPNAME

         A~ZDEPCODE

         A~DATBI      "####

         A~DATAB      "####

         A~ZDEPRANK   "####

         B~ZGENDER

         A~ZEDATE     "####

         A~ZQDATE     "####

         A~ZQFLAG     "####

         B~ZADDRESS   "##

    INTO CORRESPONDING FIELDS OF TABLE GT_WORKER

    FROM ZEDT12_102 AS A INNER JOIN ZEDT12_103 AS B

      ON A~ZPERNR = B~ZPERNR

    WHERE A~ZPERNR IN S_ZPERNR

      AND A~DATBI <= S_ZDATE-LOW

      AND A~DATAB >= S_ZDATE-LOW

      AND A~ZDEPCODE IN S_ZDCODE

      AND A~ZQFLAG IN R_ZQFLAG.






*    IF GT_WORKER[] IS INITIAL.

*      EXIT.

*    ENDIF.






  "2.####

    SELECT  ZPERNR        " ####

            ZDEPCODE      " ####

            ZYEAR         " ##

            DATBI         " ####

            DATAB         " ####

            ZRANK         " ##

    INTO CORRESPONDING FIELDS OF TABLE GT_ASSESS

    FROM ZEDT12_104

      FOR ALL ENTRIES IN GT_WORKER

    WHERE ZPERNR = GT_WORKER-ZPERNR

      AND ZDEPCODE = GT_WORKER-ZDEPCODE

      AND ZYEAR IN S_ZDATE

      AND DATBI <= S_ZDATE-LOW

      AND DATAB >= S_ZDATE-LOW .



  "3.####

    SELECT  ZPERNR        " ####

            ZYEAR         " ##

            DATBI         " ####

            DATAB         " ####

            ZSALARY       " ####

            ZBANKCODE     " ####

            ZACCOUNT      " ####

    INTO CORRESPONDING FIELDS OF TABLE GT_CONTRACT

    FROM ZEDT12_106

      FOR ALL ENTRIES IN GT_WORKER

    WHERE ZPERNR = GT_WORKER-ZPERNR

      AND ZYEAR IN S_ZDATE

      AND DATBI <= S_ZDATE-LOW

      AND DATAB >= S_ZDATE-LOW .

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATA

*&---------------------------------------------------------------------*




FORM MODIFY_DATA .

"1. ####

  LOOP AT GT_WORKER INTO GS_WORKER.

    CLEAR GS_WORKER_ALV.

    MOVE-CORRESPONDING GS_WORKER TO GS_WORKER_ALV.



    "##

    PERFORM WRITE_DEPRANK_NAME USING GS_WORKER-ZDEPRANK

          CHANGING GS_WORKER_ALV-ZDEPRANK_NAME.

    "##

    PERFORM WRITE_DEPCODE_NAME USING GS_WORKER-ZDEPCODE

          CHANGING GS_WORKER_ALV-ZDEPCODE_NAME.



    "##

    IF GS_WORKER-ZGENDER = 'M'.

      GS_WORKER_ALV-ZGENDER_NAME = '##'.

    ELSE.

      GS_WORKER_ALV-ZGENDER_NAME = '##'.

    ENDIF.



    "###

    IF GS_WORKER-ZQFLAG = 'X'.

      GS_WORKER_ALV-ZCOLOR = '@0A@'. "##

    ELSE.

      GS_WORKER_ALV-ZCOLOR = '@08@'. "##

    ENDIF.



    APPEND GS_WORKER_ALV TO GT_WORKER_ALV.



  ENDLOOP.



 "2. ####.

  LOOP AT GT_ASSESS INTO GS_ASSESS.

    CLEAR GS_ASSESS_ALV.

    MOVE-CORRESPONDING GS_ASSESS TO GS_ASSESS_ALV.

    "##

    PERFORM WRITE_DEPCODE_NAME USING GS_ASSESS-ZDEPCODE

          CHANGING GS_ASSESS_ALV-ZDEPCODE_NAME.

    APPEND GS_ASSESS_ALV TO GT_ASSESS_ALV.

  ENDLOOP.



  "3.####.

  LOOP AT GT_CONTRACT INTO GS_CONTRACT.

    CLEAR GS_CONTRACT_ALV.

    MOVE-CORRESPONDING GS_CONTRACT TO GS_CONTRACT_ALV.



    "###

    PERFORM WRITE_ZBANK_NAME USING GS_CONTRACT-ZBANKCODE

          CHANGING GS_CONTRACT_ALV-ZBANK_NAME.



    " ##

    IF GS_CONTRACT-ZBANKCODE BETWEEN 1 AND 10.

      GS_CONTRACT_ALV-ZWAERS = 'KRW'.

    ENDIF.



    APPEND GS_CONTRACT_ALV TO GT_CONTRACT_ALV.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  WRITE_DEPRANK_NAME

*&---------------------------------------------------------------------*




FORM WRITE_DEPRANK_NAME  USING    P_ZDEPRANK

                         CHANGING P_ZDEPRANK_NAME.

  CASE P_ZDEPRANK.

    WHEN 'A'.

      P_ZDEPRANK_NAME = '##'.

    WHEN 'B'.

      P_ZDEPRANK_NAME = '##'.

    WHEN 'C'.

      P_ZDEPRANK_NAME = '##'.

    WHEN 'D'.

      P_ZDEPRANK_NAME = '##'.

    WHEN 'E'.

      P_ZDEPRANK_NAME = '##'.

    WHEN 'F'.

      P_ZDEPRANK_NAME = '##'.

    WHEN 'G'.

      P_ZDEPRANK_NAME = '##'.

  ENDCASE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  WRITE_DEPCODE_NAME

*&---------------------------------------------------------------------*




FORM WRITE_DEPCODE_NAME  USING    P_ZDEPCODE

                         CHANGING P_ZDEPCODE_NAME.

  CASE P_ZDEPCODE.

      WHEN 'SS0001'.

        P_ZDEPCODE_NAME = '###'.

      WHEN 'SS0002'.

        P_ZDEPCODE_NAME = '###'.

      WHEN 'SS0003'.

        P_ZDEPCODE_NAME = '###'.

      WHEN 'SS0004'.

        P_ZDEPCODE_NAME = '###'.

      WHEN 'SS0005'.

        P_ZDEPCODE_NAME = '###'.

      WHEN 'SS0006'.

        P_ZDEPCODE_NAME = '###'.

    ENDCASE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  WRITE_ZBANK_NAME

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_CONTRACT_ZBANKCODE  text

*      <--P_GS_CONTRACT_ALV_ZBANK_NAME  text

*----------------------------------------------------------------------*




FORM WRITE_ZBANK_NAME  USING    P_ZBANKCODE

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

CREATE OBJECT GC_DOCKING

  EXPORTING




*    PARENT                      =




    REPID                       = SY-REPID

    DYNNR                       = SY-DYNNR




*    SIDE                        = DOCK_AT_LEFT




    EXTENSION                   = 2000.



CREATE OBJECT GC_SPLITTER1

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

    COLUMNS           = 1.



CALL METHOD GC_SPLITTER1->GET_CONTAINER

  EXPORTING

    ROW       = 1

    COLUMN    = 1

  RECEIVING

    CONTAINER = GC_CONTAINER1.



CALL METHOD GC_SPLITTER1->GET_CONTAINER

  EXPORTING

    ROW       = 2

    COLUMN    = 1

  RECEIVING

    CONTAINER = GC_CONTAINER2.



CREATE OBJECT GC_SPLITTER2

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




    PARENT            = GC_CONTAINER1

    ROWS              = 1

    COLUMNS           = 2.



CALL METHOD GC_SPLITTER2->GET_CONTAINER

  EXPORTING

    ROW       = 1

    COLUMN    = 1

  RECEIVING

    CONTAINER = GC_CONTAINER3.



CALL METHOD GC_SPLITTER2->GET_CONTAINER

  EXPORTING

    ROW       = 1

    COLUMN    = 2

  RECEIVING

    CONTAINER = GC_CONTAINER4.





  CREATE OBJECT GC_GRID1

    EXPORTING

      I_PARENT          = GC_CONTAINER3. "####, ##, ##, #### , ####, ##



  CREATE OBJECT GC_GRID2

    EXPORTING

      I_PARENT          = GC_CONTAINER4. "#### ## #### #### #### ### ####



  CREATE OBJECT GC_GRID3

    EXPORTING

      I_PARENT          = GC_CONTAINER2. "#### ## ## #### #### ## ## #### ## #### ####





ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG

*&---------------------------------------------------------------------*




FORM FIELD_CATALOG .

  PERFORM CONTAINER3_FIELD. "####, ##, ##, #### , ####, ##

  PERFORM CONTAINER4_FIELD. "#### ## #### #### #### ### ####

  PERFORM CONTAINER2_FIELD. "#### ## ## #### #### ## ## #### ## #### ####

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CONTAINER3_FIELD

*&---------------------------------------------------------------------*




FORM CONTAINER3_FIELD . "GS_ASSESS_ALV ####, ##, ##, #### , ####, ##

  CLEAR : GS_FIELDCAT, GT_FIELDCAT3.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-KEY = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZDEPCODE_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZYEAR'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'DATBI'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'DATAB'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZRANK'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.





ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CONTAINER4_FIELD

*&---------------------------------------------------------------------*




FORM CONTAINER4_FIELD ."GS_CONTRACT_ALV #### ## #### #### #### ### ####



  CLEAR : GS_FIELDCAT, GT_FIELDCAT4.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-KEY = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT4.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZYEAR'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT4.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'DATBI'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT4.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'DATAB'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT4.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZSALARY'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-DO_SUM = 'X'.

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-OUTPUTLEN = '16'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT4.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZBANK_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT4.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZACCOUNT'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT4.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CONTAINER2_FIELD

*&---------------------------------------------------------------------*




FORM CONTAINER2_FIELD ."GS_WORKER_ALV #### ## ## #### #### ## ## #### ## #### ####



CLEAR : GS_FIELDCAT, GT_FIELDCAT2.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZCOLOR'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-ICON = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-KEY = 'X'.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZPNAME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZDEPCODE_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'DATBI'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'DATAB'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZDEPRANK_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'ZGENDER_NAME'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'ZEDATE'.

  GS_FIELDCAT-SCRTEXT_M = '####'.

  GS_FIELDCAT-OUTPUTLEN = '10'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'ZADDRESS'.

  GS_FIELDCAT-SCRTEXT_M = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  IF P_ZQFLAG = 'X'.

    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 11.

    GS_FIELDCAT-FIELDNAME = 'ZQDATE'.

    GS_FIELDCAT-SCRTEXT_M = '####'.

    GS_FIELDCAT-OUTPUTLEN = '10'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT2.



    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 12.

    GS_FIELDCAT-FIELDNAME = 'ZQFLAG'.

    GS_FIELDCAT-SCRTEXT_M = '####'.

    GS_FIELDCAT-OUTPUTLEN = '8'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT2.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_SORT

*&---------------------------------------------------------------------*




FORM ALV_SORT .

  PERFORM CONTAINER3_SORT.

  PERFORM CONTAINER4_SORT.

  PERFORM CONTAINER2_SORT.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CONTAINER3_SORT

*&---------------------------------------------------------------------*




FORM CONTAINER3_SORT .

  GS_SORT-SPOS = 1.             " ## ## (## ####?)

  GS_SORT-FIELDNAME = 'ZPERNR'.

  GS_SORT-UP = 'X'.             " ####

  APPEND GS_SORT TO GT_SORT3.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CONTAINER4_SORT

*&---------------------------------------------------------------------*




FORM CONTAINER4_SORT .

  GS_SORT-SPOS = 1.             " ## ## (## ####?)

  GS_SORT-FIELDNAME = 'ZPERNR'.

  GS_SORT-UP = 'X'.             " ####

  APPEND GS_SORT TO GT_SORT4.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CONTAINER2_SORT

*&---------------------------------------------------------------------*




FORM CONTAINER2_SORT .

  GS_SORT-SPOS = 1.             " ## ## (## ####?)

  GS_SORT-FIELDNAME = 'ZPERNR'.

  GS_SORT-UP = 'X'.             " ####

  APPEND GS_SORT TO GT_SORT2.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  LAYOUT_SET

*&---------------------------------------------------------------------*




FORM LAYOUT_SET .

  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.          " ## ## # ### ##

  GS_LAYOUT-TOTALS_BEF = 'X'.     "### ### #(before data) # ##



  CLEAR GS_VARIANT.

  GS_VARIANT-REPORT = SY-REPID.   "VARIANT# #### ### ######

  GS_VARIANT-USERNAME = SY-UNAME. "#### ##### #### #### ###

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CALL_ALV

*&---------------------------------------------------------------------*




FORM CALL_ALV .

  CALL METHOD GC_GRID1->SET_TABLE_FOR_FIRST_DISPLAY

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

      IT_OUTTAB                     = GT_ASSESS_ALV

      IT_FIELDCATALOG               = GT_FIELDCAT3

      IT_SORT                       = GT_SORT3




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

    IT_OUTTAB                     = GT_CONTRACT_ALV

    IT_FIELDCATALOG               = GT_FIELDCAT4

    IT_SORT                       = GT_SORT4




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

    IT_OUTTAB                     = GT_WORKER_ALV

    IT_FIELDCATALOG               = GT_FIELDCAT2

    IT_SORT                       = GT_SORT2




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