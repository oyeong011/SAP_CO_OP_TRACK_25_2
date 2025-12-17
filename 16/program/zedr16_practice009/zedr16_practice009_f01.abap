
*&---------------------------------------------------------------------*

*&  Include           ZEDR16_PRACTICE009_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  SET_DEFAULT_DATE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_DEFAULT_DATE .



  S_ZDATE-LOW = SY-DATUM(6) && '01'.

  S_ZDATE-SIGN = 'I'.

  S_ZDATE-OPTION = 'EQ'.



  CALL FUNCTION 'LAST_DAY_OF_MONTHS'

    EXPORTING

      DAY_IN            = S_ZDATE-LOW

    IMPORTING

      LAST_DAY_OF_MONTH = S_ZDATE-LOW




*   EXCEPTIONS

*     DAY_IN_NO_DATE    = 1

*     OTHERS            = 2




    .

  IF SY-SUBRC <> 0.




* Implement suitable error handling here




  ENDIF.



  APPEND S_ZDATE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_RANGE_TABLE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_RANGE_TABLE .



  CLEAR GR_ZQFLAG.

  CLEAR GR_ZQFLAG[].



  GR_ZQFLAG-SIGN = 'I'.

  GR_ZQFLAG-OPTION = 'EQ'.

  GR_ZQFLAG-LOW = ' '.

  APPEND GR_ZQFLAG.



  IF P_QUIT = 'X'.

    GR_ZQFLAG-LOW = 'X'.

    APPEND GR_ZQFLAG.

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






*  DATA : BEGIN OF GS_EMP,

*         ZPERNR   TYPE ZEDT16_102-ZPERNR, "####

*         ZPNAME   TYPE ZEDT16_103-ZPNAME, "##

*         ZDEPCODE TYPE ZEDT16_102-ZDEPCODE, "####

*         DATBI    TYPE ZEDT16_102-DATBI, "####

*         DATAB    TYPE ZEDT16_102-DATAB, "####

*         ZDEPRANK TYPE ZEDT16_102-ZDEPRANK, "####

*         ZGENDER  TYPE ZEDT16_103-ZGENDER, "####

*         ZEDATE   TYPE ZEDT16_102-ZEDATE, "####

*         ZADDRESS TYPE ZEDT16_103-ZADDRESS, "##

*         ZQDATE   TYPE ZEDT16_102-ZQDATE, "####

*         ZQFLAG   TYPE ZEDT16_102-ZQFLAG, "####

*       END OF GS_EMP.

*DATA : GT_EMP LIKE TABLE OF GS_EMP.



*SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

*SELECT-OPTIONS : S_ZPERNR FOR ZEDT16_102-ZPERNR. " ####

*SELECT-OPTIONS : S_ZDATE FOR ZEDT16_102-DATBI NO INTERVALS NO-EXTENSION. " ####

*PARAMETERS : P_ZDEP LIKE ZEDT16_102-ZDEPCODE MODIF ID M1. " ##### ###### # ## # # ### #### # #.

*SELECT-OPTIONS : S_ZDEP FOR ZEDT16_102-ZDEPCODE NO INTERVALS NO-EXTENSION. " ####

*SELECTION-SCREEN END OF BLOCK B1.

*

*SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

*PARAMETERS : P_QUIT AS CHECKBOX. " #####

*SELECTION-SCREEN END OF BLOCK B2.






  SELECT A~ZPERNR

    B~ZPNAME

    A~ZDEPCODE

    A~DATBI

    A~DATAB

    A~ZDEPRANK

    B~ZGENDER

    A~ZEDATE

    B~ZADDRESS

    A~ZQDATE

    A~ZQFLAG

    INTO CORRESPONDING FIELDS OF TABLE GT_EMP

    FROM ZEDT16_102 AS A INNER JOIN ZEDT16_103 AS B

    ON A~ZPERNR = B~ZPERNR

    WHERE A~ZPERNR IN S_ZPERNR

    AND A~ZDEPCODE IN S_ZDEP

    AND ( A~DATBI <= S_ZDATE-LOW AND A~DATAB >= S_ZDATE-LOW )

    AND A~ZQFLAG IN GR_ZQFLAG.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_EVAL

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_EVAL .






*DATA : BEGIN OF GS_EVAL_ALV,

*         ZPERNR   TYPE ZEDT16_104-ZPERNR, "####

*         ZDEPCODE TYPE ZEDT16_104-ZDEPCODE, "####

*         ZDEPNAME TYPE CHAR20, "###

*         ZYEAR    TYPE ZEDT16_104-ZYEAR, "##

*         DATBI    TYPE ZEDT16_104-DATBI, "####

*         DATAB    TYPE ZEDT16_104-DATAB, "####

*         ZRANK    TYPE ZEDT16_104-ZRANK, "##

*       END OF GS_EVAL_ALV.

*DATA : GT_EVAL_ALV LIKE TABLE OF GS_EVAL_ALV.






  SELECT * FROM ZEDT16_104

    INTO CORRESPONDING FIELDS OF TABLE GT_EVAL

    FOR ALL ENTRIES IN GT_EMP

    WHERE ZPERNR = GT_EMP-ZPERNR

    AND ZYEAR = S_ZDATE-LOW+0(4)

    AND ( DATBI <= S_ZDATE-LOW AND DATAB >= S_ZDATE-LOW ).



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  GET_CONTRACT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM GET_CONTRACT .






*DATA : BEGIN OF GS_EVAL_ALV,

*         ZPERNR   TYPE ZEDT16_104-ZPERNR, "####

*         ZDEPCODE TYPE ZEDT16_104-ZDEPCODE, "####

*         ZDEPNAME TYPE CHAR20, "###

*         ZYEAR    TYPE ZEDT16_104-ZYEAR, "##

*         DATBI    TYPE ZEDT16_104-DATBI, "####

*         DATAB    TYPE ZEDT16_104-DATAB, "####

*         ZRANK    TYPE ZEDT16_104-ZRANK, "##

*       END OF GS_EVAL_ALV.

*DATA : GT_EVAL_ALV LIKE TABLE OF GS_EVAL_ALV.






  SELECT * FROM ZEDT16_106

    INTO CORRESPONDING FIELDS OF TABLE GT_CONTRACT

    FOR ALL ENTRIES IN GT_EMP

    WHERE ZPERNR = GT_EMP-ZPERNR

    AND ZYEAR = S_ZDATE-LOW+0(4)

    AND ( DATBI <= S_ZDATE-LOW AND DATAB >= S_ZDATE-LOW ).



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_EMP

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_EMP .






*  DATA : BEGIN OF GS_EMP_ALV,

*         ICON         TYPE CHAR4, "###

*         ZPERNR       TYPE ZEDT16_102-ZPERNR, "####

*         ZPNAME       TYPE ZEDT16_103-ZPNAME, "##

*         ZDEPCODE     TYPE ZEDT16_102-ZDEPCODE, "####

*         ZDEPNAME     TYPE CHAR20, "###

*         DATBI        TYPE ZEDT16_102-DATBI, "####

*         DATAB        TYPE ZEDT16_102-DATAB, "####

*         ZDEPRANK     TYPE ZEDT16_102-ZDEPRANK, "####

*         ZDEPRANKNAME TYPE CHAR20, "#####

*         ZGENDER      TYPE ZEDT16_103-ZGENDER, "####

*         ZGENDERNAME  TYPE CHAR20, "###

*         ZEDATE       TYPE ZEDT16_102-ZEDATE, "####

*         ZADDRESS     TYPE ZEDT16_103-ZADDRESS, "##

*         ZQDATE       TYPE ZEDT16_102-ZQDATE, "####

*         ZQFLAG       TYPE ZEDT16_102-ZQFLAG, "####

*       END OF GS_EMP_ALV.

*DATA : GT_EMP_ALV LIKE TABLE OF GS_EMP_ALV.






  CLEAR GS_EMP.

  CLEAR GS_EMP_ALV.



  " ###, ZDEPNAME(###), ZDEPRANKNAME(#####), ZGENDERNAME(###)

  LOOP AT GT_EMP INTO GS_EMP.

    MOVE-CORRESPONDING GS_EMP TO GS_EMP_ALV.



    " ###

    IF GS_EMP-ZQFLAG = 'X'.

      GS_EMP_ALV-ICON = '@0A@'.

    ELSE.

      IF GS_EMP-ZDEPRANK = 'A'.

        GS_EMP_ALV-ICON = '@09@'.

      ELSE.

        GS_EMP_ALV-ICON = '@08@'.

      ENDIF.

    ENDIF.



    " ZDEPNAME(###)

    PERFORM CHANGING_ZDEPCODE USING GS_EMP-ZDEPCODE

          CHANGING GS_EMP_ALV-ZDEPNAME.



    " ZDEPRANKNAME(#####)

    PERFORM CHANGING_ZDEPRANK USING GS_EMP-ZDEPRANK

          CHANGING GS_EMP_ALV-ZDEPRANKNAME.



    " ZGENDERNAME(###)

    PERFORM CHANGING_ZGENDER USING GS_EMP-ZGENDER

          CHANGING GS_EMP_ALV-ZGENDERNAME.



    APPEND GS_EMP_ALV TO GT_EMP_ALV.

    CLEAR : GS_EMP.

    CLEAR : GS_EMP_ALV.



  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_EVAL

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_EVAL .






*  DATA : BEGIN OF GS_EVAL_ALV,

*         ZPERNR   TYPE ZEDT16_104-ZPERNR, "####

*         ZDEPCODE TYPE ZEDT16_104-ZDEPCODE, "####

*         ZDEPNAME TYPE CHAR20, "###

*         ZYEAR    TYPE ZEDT16_104-ZYEAR, "##

*         DATBI    TYPE ZEDT16_104-DATBI, "####

*         DATAB    TYPE ZEDT16_104-DATAB, "####

*         ZRANK    TYPE ZEDT16_104-ZRANK, "##

*       END OF GS_EVAL_ALV.

*DATA : GT_EVAL_ALV LIKE TABLE OF GS_EVAL_ALV.






  CLEAR GS_EVAL.

  CLEAR GS_EVAL_ALV.



  " ZDEPNAME(###)

  LOOP AT GT_EVAL INTO GS_EVAL.

    MOVE-CORRESPONDING GS_EVAL TO GS_EVAL_ALV.



    " ZDEPNAME(###)

    PERFORM CHANGING_ZDEPCODE USING GS_EVAL-ZDEPCODE

          CHANGING GS_EVAL_ALV-ZDEPNAME.



    APPEND GS_EVAL_ALV TO GT_EVAL_ALV.

    CLEAR : GS_EVAL.

    CLEAR : GS_EVAL_ALV.



  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_CONTRACT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_CONTRACT .






*  DATA : BEGIN OF GS_CONTRACT_ALV,

*         ZPERNR    TYPE ZEDT16_106-ZPERNR, "####

*         ZYEAR     TYPE ZEDT16_106-ZYEAR, "##

*         DATBI     TYPE ZEDT16_106-DATBI, "####

*         DATAB     TYPE ZEDT16_106-DATAB, "####

*         ZSALARY   TYPE ZEDT16_106-ZSALARY, "####

*         ZBANKCODE TYPE ZEDT16_106-ZBANKCODE, "####

*         ZBANKNAME TYPE CHAR20, "###

*         ZACCOUNT  TYPE ZEDT16_106-ZACCOUNT, "####

*       END OF GS_CONTRACT_ALV.

*DATA : GT_CONTRACT_ALV LIKE TABLE OF GS_CONTRACT_ALV.






  CLEAR GS_CONTRACT.

  CLEAR GS_CONTRACT_ALV.



  " ZBANKNAME(###), "ZWAERS(##)



  LOOP AT GT_CONTRACT INTO GS_CONTRACT.

    MOVE-CORRESPONDING GS_CONTRACT TO GS_CONTRACT_ALV.



    " ZBANKNAME(###)

    PERFORM CHANGING_ZBANKCODE USING GS_CONTRACT-ZBANKCODE

          CHANGING GS_CONTRACT_ALV-ZBANKNAME.



    IF GS_CONTRACT-ZBANKCODE BETWEEN '001' AND '010'.

      GS_CONTRACT_ALV-ZWAERS = 'KRW'.

    ENDIF.



    APPEND GS_CONTRACT_ALV TO GT_CONTRACT_ALV.

    CLEAR : GS_CONTRACT.

    CLEAR : GS_CONTRACT_ALV.



  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHANGING_ZDEPCODE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_EMP_ZDEPCODE  text

*      <--P_GS_EMP_ALV_ZDEPNAME  text

*----------------------------------------------------------------------*




FORM CHANGING_ZDEPCODE  USING    P_GS_EMP_ZDEPCODE

                        CHANGING P_GS_EMP_ALV_ZDEPNAME.



  CASE P_GS_EMP_ZDEPCODE.

    WHEN 'SS0001'.

      P_GS_EMP_ALV_ZDEPNAME = '###'.

    WHEN 'SS0002'.

      P_GS_EMP_ALV_ZDEPNAME = '###'.

    WHEN 'SS0003'.

      P_GS_EMP_ALV_ZDEPNAME = '###'.

    WHEN 'SS0004'.

      P_GS_EMP_ALV_ZDEPNAME = '###'.

    WHEN 'SS0005'.

      P_GS_EMP_ALV_ZDEPNAME = '###'.

    WHEN 'SS0006'.

      P_GS_EMP_ALV_ZDEPNAME = '###'.

  ENDCASE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHANGING_ZDEPRANK

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_EMP_ZDEPRANK  text

*      <--P_GS_EMP_ALV_ZDEPRANKNAME  text

*----------------------------------------------------------------------*




FORM CHANGING_ZDEPRANK  USING    P_GS_EMP_ZDEPRANK

                        CHANGING P_GS_EMP_ALV_ZDEPRANKNAME.



  CASE P_GS_EMP_ZDEPRANK.

    WHEN 'A'.

      P_GS_EMP_ALV_ZDEPRANKNAME = '##'.

    WHEN 'B'.

      P_GS_EMP_ALV_ZDEPRANKNAME = '##'.

    WHEN 'C'.

      P_GS_EMP_ALV_ZDEPRANKNAME = '##'.

    WHEN 'D'.

      P_GS_EMP_ALV_ZDEPRANKNAME = '##'.

    WHEN 'E'.

      P_GS_EMP_ALV_ZDEPRANKNAME = '##'.

    WHEN 'F'.

      P_GS_EMP_ALV_ZDEPRANKNAME = '##'.

    WHEN 'G'.

      P_GS_EMP_ALV_ZDEPRANKNAME = '##'.

  ENDCASE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHANGING_ZGENDER

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_EMP_ZGENDER  text

*      <--P_GS_EMP_ALV_ZGENDERNAME  text

*----------------------------------------------------------------------*




FORM CHANGING_ZGENDER  USING    P_GS_EMP_ZGENDER

                       CHANGING P_GS_EMP_ALV_ZGENDERNAME.



  IF P_GS_EMP_ZGENDER = 'M'.

    P_GS_EMP_ALV_ZGENDERNAME = '##'.

  ELSEIF P_GS_EMP_ZGENDER = 'F'.

    P_GS_EMP_ALV_ZGENDERNAME = '##'.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  CHANGING_ZBANKCODE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_CONTRACT_ZBANKCODE  text

*      <--P_GS_CONTRACT_ALV_ZBANKNAME  text

*----------------------------------------------------------------------*




FORM CHANGING_ZBANKCODE  USING    P_GS_CONTRACT_ZBANKCODE

                         CHANGING P_GS_CONTRACT_ALV_ZBANKNAME.



  CASE P_GS_CONTRACT_ZBANKCODE.

    WHEN '001'.

      P_GS_CONTRACT_ALV_ZBANKNAME = '####'.

    WHEN '002'.

      P_GS_CONTRACT_ALV_ZBANKNAME = '####'.

    WHEN '003'.

      P_GS_CONTRACT_ALV_ZBANKNAME = '####'.

    WHEN '004'.

      P_GS_CONTRACT_ALV_ZBANKNAME = '####'.

    WHEN '005'.

      P_GS_CONTRACT_ALV_ZBANKNAME = '#####'.

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






*  DATA : GC_DOCKING TYPE REF TO CL_GUI_DOCKING_CONTAINER.

*

*   # ## SPLIT

*  DATA : GC_SPLITTER1 TYPE REF TO CL_GUI_SPLITTER_CONTAINER.

*

*  DATA : GC_CONTAINER1 TYPE REF TO CL_GUI_CONTAINER.

*  DATA : GC_CONTAINER2 TYPE REF TO CL_GUI_CONTAINER.

*

*   ### ## ### SPLIT

*  DATA : GC_SPLITTER2 TYPE REF TO CL_GUI_SPLITTER_CONTAINER.

*

*  DATA : GC_CONTAINER3 TYPE REF TO CL_GUI_CONTAINER.

*  DATA : GC_CONTAINER4 TYPE REF TO CL_GUI_CONTAINER.

*

*   GRID

*  DATA : GC_GRID1 TYPE REF TO CL_GUI_ALV_GRID.

*  DATA : GC_GRID2 TYPE REF TO CL_GUI_ALV_GRID.

*  DATA : GC_GRID3 TYPE REF TO CL_GUI_ALV_GRID.






  CREATE OBJECT GC_DOCKING

    EXPORTING




*     PARENT    =




      REPID     = SY-REPID

      DYNNR     = SY-DYNNR




*     SIDE      = DOCK_AT_LEFT




      EXTENSION = 2000




*     STYLE     =

*     LIFETIME  = lifetime_default

*     CAPTION   =

*     METRIC    = 0

*     RATIO     =

*     NO_AUTODEF_PROGID_DYNNR     =

*     NAME      =

*  EXCEPTIONS

*     CNTL_ERROR                  = 1

*     CNTL_SYSTEM_ERROR           = 2

*     CREATE_ERROR                = 3

*     LIFETIME_ERROR              = 4

*     LIFETIME_DYNPRO_DYNPRO_LINK = 5

*     OTHERS    = 6




    .

  IF SY-SUBRC <> 0.




* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.



  CREATE OBJECT GC_SPLITTER1

    EXPORTING




*     LINK_DYNNR        =

*     LINK_REPID        =

*     SHELLSTYLE        =

*     LEFT    =

*     TOP     =

*     WIDTH   =

*     HEIGHT  =

*     METRIC  = cntl_metric_dynpro

*     ALIGN   = 15




      PARENT  = GC_DOCKING

      ROWS    = 2

      COLUMNS = 1




*     NO_AUTODEF_PROGID_DYNNR =

*     NAME    =

*    EXCEPTIONS

*     CNTL_ERROR        = 1

*     CNTL_SYSTEM_ERROR = 2

*     OTHERS  = 3




    .

  IF SY-SUBRC <> 0.




*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.



  CALL METHOD GC_SPLITTER1->GET_CONTAINER

    EXPORTING

      ROW       = 1

      COLUMN    = 1

    RECEIVING

      CONTAINER = GC_CONTAINER1.



  CALL METHOD GC_SPLITTER1->GET_CONTAINER

    EXPORTING

      ROW       = 2

      COLUMN    = 1

    RECEIVING

      CONTAINER = GC_CONTAINER2.



  CREATE OBJECT GC_SPLITTER2

    EXPORTING




*     LINK_DYNNR        =

*     LINK_REPID        =

*     SHELLSTYLE        =

*     LEFT    =

*     TOP     =

*     WIDTH   =

*     HEIGHT  =

*     METRIC  = cntl_metric_dynpro

*     ALIGN   = 15




      PARENT  = GC_CONTAINER1

      ROWS    = 1

      COLUMNS = 2




*     NO_AUTODEF_PROGID_DYNNR =

*     NAME    =

*    EXCEPTIONS

*     CNTL_ERROR        = 1

*     CNTL_SYSTEM_ERROR = 2

*     OTHERS  = 3




    .

  IF SY-SUBRC <> 0.




*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.



  CALL METHOD GC_SPLITTER2->GET_CONTAINER

    EXPORTING

      ROW       = 1

      COLUMN    = 1

    RECEIVING

      CONTAINER = GC_CONTAINER3.



  CALL METHOD GC_SPLITTER2->GET_CONTAINER

    EXPORTING

      ROW       = 1

      COLUMN    = 2

    RECEIVING

      CONTAINER = GC_CONTAINER4.



  CREATE OBJECT GC_GRID1

    EXPORTING




*     I_SHELLSTYLE      = 0

*     I_LIFETIME        =




      I_PARENT = GC_CONTAINER2




*     I_APPL_EVENTS     = space

*     I_PARENTDBG       =

*     I_APPLOGPARENT    =

*     I_GRAPHICSPARENT  =

*     I_NAME   =

*     I_FCAT_COMPLETE   = SPACE

*      EXCEPTIONS

*     ERROR_CNTL_CREATE = 1

*     ERROR_CNTL_INIT   = 2

*     ERROR_CNTL_LINK   = 3

*     ERROR_DP_CREATE   = 4

*     OTHERS   = 5




    .

  IF SY-SUBRC <> 0.




*     MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*                WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.



  CREATE OBJECT GC_GRID2

    EXPORTING




*     I_SHELLSTYLE      = 0

*     I_LIFETIME        =




      I_PARENT = GC_CONTAINER3




*     I_APPL_EVENTS     = space

*     I_PARENTDBG       =

*     I_APPLOGPARENT    =

*     I_GRAPHICSPARENT  =

*     I_NAME   =

*     I_FCAT_COMPLETE   = SPACE

*      EXCEPTIONS

*     ERROR_CNTL_CREATE = 1

*     ERROR_CNTL_INIT   = 2

*     ERROR_CNTL_LINK   = 3

*     ERROR_DP_CREATE   = 4

*     OTHERS   = 5




    .

  IF SY-SUBRC <> 0.




*     MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*                WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.



  CREATE OBJECT GC_GRID3

    EXPORTING




*     I_SHELLSTYLE      = 0

*     I_LIFETIME        =




      I_PARENT = GC_CONTAINER4




*     I_APPL_EVENTS     = space

*     I_PARENTDBG       =

*     I_APPLOGPARENT    =

*     I_GRAPHICSPARENT  =

*     I_NAME   =

*     I_FCAT_COMPLETE   = SPACE

*      EXCEPTIONS

*     ERROR_CNTL_CREATE = 1

*     ERROR_CNTL_INIT   = 2

*     ERROR_CNTL_LINK   = 3

*     ERROR_DP_CREATE   = 4

*     OTHERS   = 5




    .

  IF SY-SUBRC <> 0.




*     MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*                WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG1

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG1 .




*  *  DATA : BEGIN OF GS_EMP_ALV,

*         ICON         TYPE CHAR4, "###

*         ZPERNR       TYPE ZEDT16_102-ZPERNR, "####

*         ZPNAME       TYPE ZEDT16_103-ZPNAME, "##

*         ZDEPCODE     TYPE ZEDT16_102-ZDEPCODE, "####

*         ZDEPNAME     TYPE CHAR20, "###

*         DATBI        TYPE ZEDT16_102-DATBI, "####

*         DATAB        TYPE ZEDT16_102-DATAB, "####

*         ZDEPRANK     TYPE ZEDT16_102-ZDEPRANK, "####

*         ZDEPRANKNAME TYPE CHAR20, "#####

*         ZGENDER      TYPE ZEDT16_103-ZGENDER, "####

*         ZGENDERNAME  TYPE CHAR20, "###

*         ZEDATE       TYPE ZEDT16_102-ZEDATE, "####

*         ZADDRESS     TYPE ZEDT16_103-ZADDRESS, "##

*         ZQDATE       TYPE ZEDT16_102-ZQDATE, "####

*         ZQFLAG       TYPE ZEDT16_102-ZQFLAG, "####

*       END OF GS_EMP_ALV.

*DATA : GT_EMP_ALV LIKE TABLE OF GS_EMP_ALV.




  CLEAR : GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ICON'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-ICON = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-KEY = 'X'.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZPNAME'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZDEPNAME'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'DATBI'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'DATAB'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZDEPRANKNAME'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'ZGENDERNAME'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 9.

  GS_FIELDCAT-FIELDNAME = 'ZEDATE'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 10.

  GS_FIELDCAT-FIELDNAME = 'ZADDRESS'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  IF P_QUIT = 'X'.

    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 11.

    GS_FIELDCAT-FIELDNAME = 'ZQDATE'.

    GS_FIELDCAT-COLTEXT = '####'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT1.



    CLEAR : GS_FIELDCAT.

    GS_FIELDCAT-COL_POS = 12.

    GS_FIELDCAT-FIELDNAME = 'ZQFLAG'.

    GS_FIELDCAT-COLTEXT = '####'.

    APPEND GS_FIELDCAT TO GT_FIELDCAT1.

  ENDIF.









ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG2

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG2 .






*  *DATA : BEGIN OF GS_EVAL_ALV,

*         ZPERNR   TYPE ZEDT16_104-ZPERNR, "####

*         ZDEPCODE TYPE ZEDT16_104-ZDEPCODE, "####

*         ZDEPNAME TYPE CHAR20, "###

*         ZYEAR    TYPE ZEDT16_104-ZYEAR, "##

*         DATBI    TYPE ZEDT16_104-DATBI, "####

*         DATAB    TYPE ZEDT16_104-DATAB, "####

*         ZRANK    TYPE ZEDT16_104-ZRANK, "##

*       END OF GS_EVAL_ALV.

*DATA : GT_EVAL_ALV LIKE TABLE OF GS_EVAL_ALV.






  CLEAR : GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-KEY = 'X'.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZDEPNAME'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZYEAR'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'DATBI'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'DATAB'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZRANK'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  FIELD_CATALOG3

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM FIELD_CATALOG3 .






*  DATA : BEGIN OF GS_CONTRACT_ALV,

*         ZPERNR    TYPE ZEDT16_106-ZPERNR, "####

*         ZYEAR     TYPE ZEDT16_106-ZYEAR, "##

*         DATBI     TYPE ZEDT16_106-DATBI, "####

*         DATAB     TYPE ZEDT16_106-DATAB, "####

*         ZSALARY   TYPE ZEDT16_106-ZSALARY, "####

*         ZBANKCODE TYPE ZEDT16_106-ZBANKCODE, "####

*         ZBANKNAME TYPE CHAR20, "###

*         ZACCOUNT  TYPE ZEDT16_106-ZACCOUNT, "####

*       END OF GS_CONTRACT_ALV.

*DATA : GT_CONTRACT_ALV LIKE TABLE OF GS_CONTRACT_ALV.






  CLEAR : GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-KEY = 'X'.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZYEAR'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'DATBI'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'DATAB'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 5.

  GS_FIELDCAT-FIELDNAME = 'ZSALARY'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-DO_SUM = 'X'.

  GS_FIELDCAT-CFIELDNAME = 'ZWAERS'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZWAERS'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-NO_OUT = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

  GS_FIELDCAT-FIELDNAME = 'ZBANKNAME'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'ZACCOUNT'.

  GS_FIELDCAT-COLTEXT = '####'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



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

  GS_LAYOUT-TOTALS_BEF = 'X'.



  CLEAR GS_VARIANT.

  GS_VARIANT-REPORT = SY-REPID.

  GS_VARIANT-USERNAME = SY-UNAME.



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



  CLEAR : GS_SORT.

  CLEAR: GT_SORT.

  GS_SORT-SPOS = 1.

  GS_SORT-FIELDNAME = 'ZPERNR'.

  GS_SORT-UP = 'X'.

  APPEND GS_SORT TO GT_SORT

  .

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



  CALL METHOD GC_GRID1->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING




*     I_BUFFER_ACTIVE =

*     I_BYPASSING_BUFFER            =

*     I_CONSISTENCY_CHECK           =

*     I_STRUCTURE_NAME              =




      IS_VARIANT      = GS_VARIANT

      I_SAVE          = 'A'




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

      IT_OUTTAB       = GT_EMP_ALV

      IT_FIELDCATALOG = GT_FIELDCAT1

      IT_SORT         = GT_SORT




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



  CALL METHOD GC_GRID2->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING




*     I_BUFFER_ACTIVE =

*     I_BYPASSING_BUFFER            =

*     I_CONSISTENCY_CHECK           =

*     I_STRUCTURE_NAME              =




      IS_VARIANT      = GS_VARIANT

      I_SAVE          = 'A'




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

      IT_OUTTAB       = GT_EVAL_ALV

      IT_FIELDCATALOG = GT_FIELDCAT2

      IT_SORT         = GT_SORT




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



  CALL METHOD GC_GRID3->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING




*     I_BUFFER_ACTIVE =

*     I_BYPASSING_BUFFER            =

*     I_CONSISTENCY_CHECK           =

*     I_STRUCTURE_NAME              =




      IS_VARIANT      = GS_VARIANT

      I_SAVE          = 'A'




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

      IT_OUTTAB       = GT_CONTRACT_ALV

      IT_FIELDCATALOG = GT_FIELDCAT3

      IT_SORT         = GT_SORT




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

*&      Form  CHECK_INITIAL_INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM CHECK_INITIAL_INPUT .






*  *SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

*SELECT-OPTIONS : S_ZPERNR FOR ZEDT16_102-ZPERNR. " ####

*SELECT-OPTIONS : S_ZDATE FOR ZEDT16_102-DATBI NO INTERVALS NO-EXTENSION. " ####

*PARAMETERS : P_ZDEP LIKE ZEDT16_102-ZDEPCODE MODIF ID M1. " ##### ###### # ## # # ### #### # #.

*SELECT-OPTIONS : S_ZDEP FOR ZEDT16_102-ZDEPCODE NO INTERVALS NO-EXTENSION. " ####

*SELECTION-SCREEN END OF BLOCK B1.






  IF S_ZDATE IS INITIAL.

    MESSAGE I000.

    STOP.

  ENDIF.



  IF S_ZPERNR IS INITIAL AND S_ZDEP IS INITIAL.

    MESSAGE I000.

    STOP.

  ENDIF.



ENDFORM.