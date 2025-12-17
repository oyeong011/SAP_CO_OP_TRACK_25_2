
*&---------------------------------------------------------------------*

*& Report ZEDR09_PRACTICE004

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR09_PRACTICE004.



"1. range table# ####, zedt00_001## zcode: ssu-90 ~ ssu-99# # ####



DATA : GT_ZEDT09_001 TYPE TABLE OF ZEDT09_001,

       GS_ZEDT09_001 LIKE LINE OF GT_ZEDT09_001,

       GV_LENGTH     TYPE I,

       GT_FIXED      TYPE TABLE OF ZEDT09_001. "#### ### ## ## ######



RANGES : GR_ZCODE FOR ZEDT00_001-ZCODE.



CLEAR : GR_ZCODE.



GR_ZCODE-SIGN = 'I'.

GR_ZCODE-OPTION = 'BT'.

GR_ZCODE-LOW = 'SSU-90'.

GR_ZCODE-HIGH = 'SSU-99'.

APPEND GR_ZCODE.



SELECT *

FROM ZEDT00_001

INTO CORRESPONDING FIELDS OF TABLE GT_ZEDT09_001 "gt_zedt09_001 #### ssu90~ssu99## ##

WHERE ZCODE IN GR_ZCODE.





"2. zpernr### #### #### 10### ## ##, #### ## 0# ## ### ## ##

LOOP AT GT_ZEDT09_001 INTO GS_ZEDT09_001.



  GV_LENGTH = STRLEN( GS_ZEDT09_001-ZPERNR ).



  IF GV_LENGTH <> 10.

    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'  "#### ##### ## ## ### 0## #### ##

      EXPORTING

        INPUT         = GS_ZEDT09_001-ZPERNR

      IMPORTING

        OUTPUT        = GS_ZEDT09_001-ZPERNR

              .

    APPEND GS_ZEDT09_001 TO GT_FIXED. "0# ### zpernr# gt_fixed# ###



  ENDIF.



ENDLOOP.



"3. insert# zedt09_001(#####)# ## #####



"#### ### ##

DELETE ZEDT09_001 FROM TABLE GT_FIXED.



 INSERT ZEDT09_001 FROM TABLE GT_FIXED.



IF SY-SUBRC = 0.

  WRITE : 'INSERT# ######'.

ELSE.

  WRITE : 'INSERT# ######'.

ENDIF.