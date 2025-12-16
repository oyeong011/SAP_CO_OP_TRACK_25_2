
*&---------------------------------------------------------------------*

*& Report ZEDR14_003

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR14_003.






* MOVE A TO B (1)




DATA : BEGIN OF GS_NAME,

  NAME1 TYPE C LENGTH 10,

  NAME2 TYPE C LENGTH 10,

  END OF GS_NAME.



GS_NAME-NAME1 = '###'.

GS_NAME-NAME2 = '##'.



GS_NAME-NAME1 = GS_NAME-NAME2.



WRITE :/ GS_NAME-NAME1.

WRITE :/ GS_NAME-NAME2.

WRITE :/ .






*&---------------------------------------------------------------------*



* MOVE A TO B (2)




GS_NAME-NAME1 = '###'.

GS_NAME-NAME2 = '##'.



MOVE GS_NAME-NAME2 TO GS_NAME-NAME1.



WRITE :/ GS_NAME-NAME1.

WRITE :/ GS_NAME-NAME2.

WRITE :/ .






*&---------------------------------------------------------------------*



* MOVE A TO B (3)




DATA : BEGIN OF GS_NAME_2,

  NAME1 TYPE C LENGTH 10,

  DEGREE1 TYPE P DECIMALS 2,

  END OF GS_NAME_2.



GS_NAME_2-NAME1 = '##'.

GS_NAME_2-DEGREE1 = '35.12'.



MOVE GS_NAME_2-DEGREE1 TO GS_NAME_2-NAME1.

CONDENSE GS_NAME_2-NAME1 NO-GAPS.



WRITE :/ GS_NAME_2-NAME1.

WRITE :/ GS_NAME_2-DEGREE1.

WRITE :/ .






*&---------------------------------------------------------------------*



* OFFSET# ### ##




DATA : GV_DATA1(8) VALUE 'ABCDEFGH',

       GV_DATA2(8).

DATA : GV_START TYPE I VALUE 2,

       GV_LENGTH TYPE I VALUE 4.



MOVE GV_DATA1+2(3) TO GV_DATA2.

WRITE :/ GV_DATA2.



MOVE GV_DATA1+GV_START(GV_LENGTH) TO GV_DATA2.

WRITE :/ GV_DATA2.

WRITE :/ .






*&---------------------------------------------------------------------*



* WRITE A TO B




DATA : BEGIN OF GS_NAME_3,

  NAME1 TYPE C LENGTH 10,

  NAME2 TYPE C LENGTH 10,

  END OF GS_NAME_3.



GS_NAME_3-NAME1 = '###'.

GS_NAME_3-NAME2 = '##'.



WRITE GS_NAME_3-NAME2 TO GS_NAME_3-NAME1.



WRITE :/ GS_NAME-NAME1.

WRITE :/ GS_NAME-NAME2.

WRITE :/ .






*&---------------------------------------------------------------------*



* MOVE CORRESPONDING




DATA : BEGIN OF GS_ZEDT14,

  ZCODE TYPE ZEDT14_001-ZCODE,

  ZKNAME TYPE ZEDT14_001-ZKNAME,

  ZENAME TYPE ZEDT14_001-ZENAME,

  ZGENDER TYPE ZEDT14_001-ZGENDER,

  ZTEL TYPE ZEDT14_001-ZTEL,

  END OF GS_ZEDT14.



DATA : BEGIN OF GS_ZEDT14_2,

  ZCODE TYPE ZEDT14_001-ZCODE,

  ZKNAME TYPE ZEDT14_001-ZKNAME,

  ZENAME TYPE ZEDT14_001-ZENAME,

  ZGENDER TYPE ZEDT14_001-ZGENDER,

  ZTEL TYPE ZEDT14_001-ZTEL,

  END OF GS_ZEDT14_2.



GS_ZEDT14-ZCODE = 'SSU-01'.

GS_ZEDT14-ZKNAME = '###'.

GS_ZEDT14-ZENAME = 'DONG'.

GS_ZEDT14-ZGENDER = 'M'.

GS_ZEDT14-ZTEL = '010-1111-2222'.



MOVE-CORRESPONDING GS_ZEDT14 TO GS_ZEDT14_2.



WRITE :/ GS_ZEDT14_2-ZCODE.

WRITE :/ GS_ZEDT14_2-ZKNAME.

WRITE :/ GS_ZEDT14_2-ZENAME.

WRITE :/ GS_ZEDT14_2-ZGENDER.

WRITE :/ GS_ZEDT14_2-ZTEL.

WRITE :/ .






*&---------------------------------------------------------------------*



* CONSTANTS




CONSTANTS : C_RATE TYPE I VALUE '100'.

DATA : GV_SUM1 TYPE I,

       GV_SUM2 TYPE I,

       GV_SUM3 TYPE I.



GV_SUM1 = '10.00'.

GV_SUM2 = '20.00'.

GV_SUM3 = '30.00'.



GV_SUM1 = GV_SUM1 * C_RATE.

GV_SUM2 = GV_SUM2 * C_RATE.

GV_SUM3 = GV_SUM3 * C_RATE.



WRITE :/ GV_SUM1.

WRITE :/ GV_SUM2.

WRITE :/ GV_SUM3.

WRITE :/ .






*&---------------------------------------------------------------------*



* ### ##




CONSTANTS : BEGIN OF C_STUDENT,

  ZCODE(10) VALUE 'SSU-01',

  ZKNAME(10) VALUE '###',

  ZENAME(10) VALUE 'DONG',

  END OF C_STUDENT.



WRITE :/ C_STUDENT-ZCODE.

WRITE :/ C_STUDENT-ZKNAME.

WRITE :/ C_STUDENT-ZENAME.






*&---------------------------------------------------------------------*



* ## vs ##




CONSTANTS : C_NUM1 TYPE I VALUE '10'.

DATA : NUM1 TYPE I VALUE '10'.



NUM1 = NUM1 + 1.

WRITE :/ NUM1.



"C_NUM1 = C_NUM1 + 1.

WRITE :/ C_NUM1.

WRITE :/ .






*&---------------------------------------------------------------------*



* STATICS




"STATICS lv_num TYPE i.



"lv_num = lv_num + 1.

"WRITE :/ 'static variable: ', lv_num.






*&---------------------------------------------------------------------*



* TABLES




TABLES : ZEDT14_001.



SELECT SINGLE * FROM ZEDT14_001.



WRITE : ZEDT14_001-ZCODE.

WRITE : ZEDT14_001-ZKNAME.

WRITE : ZEDT14_001-ZENAME.

WRITE : ZEDT14_001-ZGENDER.

WRITE : ZEDT14_001-ZTEL.