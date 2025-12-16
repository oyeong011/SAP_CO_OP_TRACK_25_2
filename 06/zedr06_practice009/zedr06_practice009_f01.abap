
*&---------------------------------------------------------------------*

*&  Include           ZEDR06_PRACTICE009_F01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Form  INIT_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM INIT_DATA .

  CLEAR : S_DATE, S_DATE[].



  IF S_DATE[] IS INITIAL.

    S_DATE-LOW = SY-DATUM(6) && '01'.

    S_DATE-SIGN = 'I'.

    S_DATE-OPTION = 'EQ'.



    CALL FUNCTION 'LAST_DAY_OF_MONTHS'

      EXPORTING

        DAY_IN                  = S_DATE-LOW

     IMPORTING

       LAST_DAY_OF_MONTH       = S_DATE-LOW.



     APPEND S_DATE.



     R_ZQFLAG-SIGN = 'I'.

     R_ZQFLAG-OPTION = 'EQ'.

     IF P_CH1 = C_X.

       R_ZQFLAG-LOW = 'X'.

     ELSE.

       R_ZQFLAG-LOW = ' '.

     ENDIF.



  ELSE.

    MESSAGE E000.

  ENDIF.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  VAILD_CHECK_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM VAILD_CHECK_DATA .



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

  " #### ###

  SELECT

    A~ZPERNR,     " ####

    A~ZDEPCODE,   " ####

    A~DATBI,      " ####_FR

    A~DATAB,      " ####_TO

    A~ZDEPRANK,   " ####

    A~ZEDATE,     " ####

    A~ZQDATE,     " ####

    A~ZQFLAG,     " ####

    B~ZPNAME,     " ####

    B~ZGENDER,    " ##

    B~ZADDRESS    " ##

  FROM ZEDT06_102 AS A

  INNER JOIN ZEDT06_103 AS B ON A~ZPERNR = B~ZPERNR

  WHERE A~ZPERNR IN @S_PERNR

  AND A~DATBI <= @S_DATE-LOW AND @S_DATE-LOW <= A~DATAB

  AND A~ZDEPCODE IN @S_DEP

  AND A~ZQFLAG IN @R_ZQFLAG

  INTO CORRESPONDING FIELDS OF TABLE @GT_EMP_INFO.



  IF GT_EMP_INFO[] IS NOT INITIAL.

    " ####

    SELECT * FROM ZEDT06_104

      INTO CORRESPONDING FIELDS OF TABLE @GT_EMP_EVALUATE

      FOR ALL ENTRIES IN @GT_EMP_INFO

      WHERE ZPERNR = @GT_EMP_INFO-ZPERNR

      AND ZDEPCODE = @GT_EMP_INFO-ZDEPCODE

      AND ZYEAR = @S_DATE-LOW+0(4)

      AND DATBI <= @S_DATE-LOW AND DATAB >= @S_DATE-LOW.



    " ####

    SELECT * FROM ZEDT06_106

      INTO CORRESPONDING FIELDS OF TABLE @GT_EMP_SALARY

      FOR ALL ENTRIES IN @GT_EMP_INFO

      WHERE ZPERNR = @GT_EMP_INFO-ZPERNR

      AND ZYEAR = @S_DATE-LOW+0(4)

      AND DATBI <= @S_DATE-LOW AND DATAB >= @S_DATE-LOW.

  ENDIF.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  MODIFY_DATE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM MODIFY_DATE .

  PERFORM MODIFY_EMP_INFO.

  PERFORM MODIFY_EMP_EVALUATE.

  PERFORM MODIFY_EMP_SALARY.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_DEPCODE_NAME

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_EMP_INFO_ZDEPCODE  text

*      <--P_GS_EMP_INFO_ALV_ZDEPCODE_NAME  text

*----------------------------------------------------------------------*




FORM MODIFY_EMP_INFO.

    CLEAR : GS_EMP_INFO.

  CLEAR : GS_EMP_INFO_ALV, GT_EMP_INFO_ALV.



  LOOP AT GT_EMP_INFO INTO GS_EMP_INFO.

    MOVE-CORRESPONDING GS_EMP_INFO TO GS_EMP_INFO_ALV.



    " #### -> ####(#) ##

    PERFORM SET_DEPCODE_NAME USING GS_EMP_INFO-ZDEPCODE

                             CHANGING GS_EMP_INFO_ALV-ZDEPCODE_NAME.

    " #### -> ####(#) ##

    PERFORM SET_ZDEPRANK_NAME USING GS_EMP_INFO-ZDEPRANK

                              CHANGING GS_EMP_INFO_ALV-ZDEPRANK_NAME.

    " ## -> ##(#) ##

    PERFORM SET_ZGENDER_NAME USING GS_EMP_INFO-ZGENDER

                             CHANGING GS_EMP_INFO_ALV-ZGENDER_NAME.



    IF GS_EMP_INFO-ZQFLAG IS NOT INITIAL.

      GS_EMP_INFO_ALV-ICON = '@0A@'.

    ELSEIF GS_EMP_INFO-ZDEPRANK = 'A'.

      GS_EMP_INFO_ALV-ICON = '@09@'.

    ELSE.

      GS_EMP_INFO_ALV-ICON = '@08@'.

    ENDIF.



    APPEND GS_EMP_INFO_ALV TO GT_EMP_INFO_ALV.

    CLEAR : GS_EMP_INFO, GS_EMP_INFO_ALV.

  ENDLOOP.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_DEPCODE_NAME

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_EMP_INFO_ZDEPCODE  text

*      <--P_GS_EMP_INFO_ALV_ZDEPCODE_NAME  text

*----------------------------------------------------------------------*




FORM MODIFY_EMP_EVALUATE.



  LOOP AT GT_EMP_EVALUATE INTO GS_EMP_EVALUATE.

    MOVE-CORRESPONDING GS_EMP_EVALUATE TO GS_EMP_EVALUATE_ALV.



    " #### ##

    PERFORM SET_DEPCODE_NAME USING GS_EMP_EVALUATE-ZDEPCODE

                             CHANGING GS_EMP_EVALUATE_ALV-ZDEPCODE_NAME.



    APPEND GS_EMP_EVALUATE_ALV TO GT_EMP_EVALUATE_ALV.

    CLEAR : GS_EMP_EVALUATE, GS_EMP_EVALUATE_ALV.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_DEPCODE_NAME

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_EMP_INFO_ZDEPCODE  text

*      <--P_GS_EMP_INFO_ALV_ZDEPCODE_NAME  text

*----------------------------------------------------------------------*




FORM MODIFY_EMP_SALARY.



  LOOP AT GT_EMP_SALARY INTO GS_EMP_SALARY.

    MOVE-CORRESPONDING GS_EMP_SALARY TO GS_EMP_SALARY_ALV.



    " #### ##

    PERFORM SET_ZBANKCODE_NAME USING GS_EMP_SALARY-ZBANKCODE

                             CHANGING GS_EMP_SALARY_ALV-ZBANKCODE_NAME.



    APPEND GS_EMP_SALARY_ALV TO GT_EMP_SALARY_ALV.

    CLEAR : GS_EMP_SALARY, GS_EMP_SALARY_ALV.

  ENDLOOP.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_DEPCODE_NAME

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_EMP_INFO_ZDEPCODE  text

*      <--P_GS_EMP_INFO_ALV_ZDEPCODE_NAME  text

*----------------------------------------------------------------------*




FORM SET_DEPCODE_NAME  USING    P_GS_EMP_INFO_ZDEPCODE

                       CHANGING P_GS_EMP_INFO_ALV_ZDEPCODE_N.



  CASE P_GS_EMP_INFO_ZDEPCODE.

    WHEN 'SS0001'.

      P_GS_EMP_INFO_ALV_ZDEPCODE_N = '###'.

    WHEN 'SS0002'.

      P_GS_EMP_INFO_ALV_ZDEPCODE_N = '###'.

    WHEN 'SS0003'.

      P_GS_EMP_INFO_ALV_ZDEPCODE_N = '###'.

    WHEN 'SS0004'.

      P_GS_EMP_INFO_ALV_ZDEPCODE_N = '###'.

    WHEN 'SS0005'.

      P_GS_EMP_INFO_ALV_ZDEPCODE_N = '###'.

    WHEN 'SS0006'.

      P_GS_EMP_INFO_ALV_ZDEPCODE_N = '###'.

  ENDCASE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_ZDEPRANK_NAME

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_EMP_INFO_ZDEPRANK_NAME  text

*      <--P_GS_EMP_INFO_AVL_ZDEPRANK_NAME  text

*----------------------------------------------------------------------*




FORM SET_ZDEPRANK_NAME  USING    P_GS_EMP_INFO_ZDEPRANK_NAME

                        CHANGING P_GS_EMP_INFO_AVL_ZDEPRANK_N.



  CASE P_GS_EMP_INFO_ZDEPRANK_NAME.

    WHEN 'A'.

      P_GS_EMP_INFO_AVL_ZDEPRANK_N = '##'.

    WHEN 'B'.

      P_GS_EMP_INFO_AVL_ZDEPRANK_N = '##'.

    WHEN 'C'.

      P_GS_EMP_INFO_AVL_ZDEPRANK_N = '##'.

    WHEN 'D'.

      P_GS_EMP_INFO_AVL_ZDEPRANK_N = '##'.

    WHEN 'E'.

      P_GS_EMP_INFO_AVL_ZDEPRANK_N = '##'.

    WHEN 'F'.

      P_GS_EMP_INFO_AVL_ZDEPRANK_N = '##'.

    WHEN 'G'.

      P_GS_EMP_INFO_AVL_ZDEPRANK_N = '##'.

  ENDCASE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_ZGENDER_NAME

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_EMP_INFO_ZGENDER  text

*      <--P_GS_EMP_INFO_ALV_ZGENDER_NAME  text

*----------------------------------------------------------------------*




FORM SET_ZGENDER_NAME  USING    P_GS_EMP_INFO_ZGENDER

                       CHANGING P_GS_EMP_INFO_ALV_ZGENDER_N.



  CASE P_GS_EMP_INFO_ZGENDER.

    WHEN 'M'.

      P_GS_EMP_INFO_ALV_ZGENDER_N = '##'.

    WHEN 'F'.

      P_GS_EMP_INFO_ALV_ZGENDER_N = '##'.

  ENDCASE.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_ZBANKCODE_NAME

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_GS_EMP_SALARY_ZBANKCODE  text

*      <--P_GS_EMP_SALARY_ALV_ZBANKCODE_NA  text

*----------------------------------------------------------------------*




FORM SET_ZBANKCODE_NAME  USING    P_GS_EMP_SALARY_ZBANKCODE

                         CHANGING P_GS_EMP_SALARY_ALV_ZBANK.

  CASE P_GS_EMP_SALARY_ZBANKCODE.

    WHEN '001'.

      P_GS_EMP_SALARY_ALV_ZBANK = '##'.

    WHEN '002'.

      P_GS_EMP_SALARY_ALV_ZBANK = '##'.

    WHEN '003'.

      P_GS_EMP_SALARY_ALV_ZBANK = '##'.

    WHEN '004'.

      P_GS_EMP_SALARY_ALV_ZBANK = '##'.

    WHEN '005'.

      P_GS_EMP_SALARY_ALV_ZBANK = '###'.

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



  CREATE OBJECT GC_DOCKING " ## ## ##

    EXPORTING




*      PARENT                      =




      REPID                       = SY-REPID

      DYNNR                       = SY-DYNNR

      EXTENSION                   = 2000.



  CREATE OBJECT GC_SPLITTER1 " ####1 ## ##

    EXPORTING

      PARENT            = GC_DOCKING

      ROWS              = 2

      COLUMNS           = 1.



  CALL METHOD GC_SPLITTER1->GET_CONTAINER " ####1 ## ##.

    EXPORTING

      ROW       = 2

      COLUMN    = 1

    RECEIVING

      CONTAINER = GC_CONTAINER1.



  CALL METHOD GC_SPLITTER1->GET_CONTAINER " #### ## ### ####2 ##.

    EXPORTING

      ROW       = 1

      COLUMN    = 1

    RECEIVING

      CONTAINER = GC_CONTAINER2.



  CREATE OBJECT GC_SPLITTER2 " ####2 ## ##

    EXPORTING

      PARENT            = GC_CONTAINER2

      ROWS              = 1

      COLUMNS           = 2.



  CALL METHOD GC_SPLITTER2->GET_CONTAINER " ####3 ## ##.

    EXPORTING

      ROW       = 1

      COLUMN    = 1

    RECEIVING

      CONTAINER = GC_CONTAINER3.



  CALL METHOD GC_SPLITTER2->GET_CONTAINER " ####4 ## ##.

    EXPORTING

      ROW       = 1

      COLUMN    = 2

    RECEIVING

      CONTAINER = GC_CONTAINER4.



  CREATE OBJECT GC_GRID1 " ##### ###1 ##

    EXPORTING

      I_PARENT          = GC_CONTAINER1.



  CREATE OBJECT GC_GRID2 " ##### ###2 ##

    EXPORTING

      I_PARENT          = GC_CONTAINER3.



  CREATE OBJECT GC_GRID3 " ##### ###3 ##

    EXPORTING

      I_PARENT          = GC_CONTAINER4.



ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_FIELDCAT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_FIELDCAT .

  PERFORM SET_FIELDCAT1_IN_GRID1.

  PERFORM SET_FIELDCAT2_IN_GRID2.

  PERFORM SET_FIELDCAT3_IN_GRID3.

ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  ALV_DISPLAY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM ALV_DISPLAY .

CALL METHOD GC_GRID1->SET_TABLE_FOR_FIRST_DISPLAY




*  EXPORTING

*    IS_VARIANT                    =

*    I_SAVE                        =

*    I_DEFAULT                     = 'X'

*    IS_LAYOUT                     =




  CHANGING

    IT_OUTTAB                     = GT_EMP_INFO_ALV

    IT_FIELDCATALOG               = GT_FIELDCAT1.




*    IT_SORT                       =






CALL METHOD GC_GRID2->SET_TABLE_FOR_FIRST_DISPLAY




*  EXPORTING

*    IS_VARIANT                    =

*    I_SAVE                        =

*    I_DEFAULT                     = 'X'

*    IS_LAYOUT                     =




  CHANGING

    IT_OUTTAB                     = GT_EMP_EVALUATE_ALV

    IT_FIELDCATALOG               = GT_FIELDCAT2.




*    IT_SORT                       =






CALL METHOD GC_GRID3->SET_TABLE_FOR_FIRST_DISPLAY

  EXPORTING




*    IS_VARIANT                    =

*    I_SAVE                        =

*    I_DEFAULT                     = 'X'




    IS_LAYOUT                     = GS_LAYOUT

  CHANGING

    IT_OUTTAB                     = GT_EMP_SALARY_ALV

    IT_FIELDCATALOG               = GT_FIELDCAT3.




*    IT_SORT                       =








ENDFORM.




*&---------------------------------------------------------------------*

*&      Form  SET_FIELDCAT1_IN_CONTAINER1

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_FIELDCAT1_IN_GRID1 .

  CLEAR : GS_FIELDCAT, GT_FIELDCAT1.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ICON'.

  GS_FIELDCAT-COLTEXT = '##'.

  GS_FIELDCAT-ICON = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-KEY = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 3.

  GS_FIELDCAT-FIELDNAME = 'ZPNAME'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 4.

  GS_FIELDCAT-FIELDNAME = 'ZDEPCODE_NAME'.

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

  GS_FIELDCAT-FIELDNAME = 'ZDEPRANK_NAME'.

  GS_FIELDCAT-COLTEXT = '##'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT1.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 8.

  GS_FIELDCAT-FIELDNAME = 'ZGENDER_NAME'.

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



  IF P_CH1 = C_X.

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

*&      Form  SET_FIELDCAT2_IN_GRID2

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_FIELDCAT2_IN_GRID2 .

CLEAR : GS_FIELDCAT, GT_FIELDCAT2.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-KEY = 'X'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT2.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 2.

  GS_FIELDCAT-FIELDNAME = 'ZDEPCODE_NAME'.

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

*&      Form  SET_FIELDCAT3_IN_GRID3

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




FORM SET_FIELDCAT3_IN_GRID3 .

CLEAR : GS_FIELDCAT, GT_FIELDCAT3.

  GS_FIELDCAT-COL_POS = 1.

  GS_FIELDCAT-FIELDNAME = 'ZPERNR'.

  GS_FIELDCAT-COLTEXT = '####'.

  GS_FIELDCAT-KEY = 'X'.

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

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 6.

  GS_FIELDCAT-FIELDNAME = 'ZBANKCODE_NAME'.

  GS_FIELDCAT-COLTEXT = '###'.

  APPEND GS_FIELDCAT TO GT_FIELDCAT3.



  CLEAR : GS_FIELDCAT.

  GS_FIELDCAT-COL_POS = 7.

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



  GS_LAYOUT-ZEBRA = 'X'.     "### ## ###

  GS_LAYOUT-TOTALS_BEF = 'X'."### ## ###



ENDFORM.