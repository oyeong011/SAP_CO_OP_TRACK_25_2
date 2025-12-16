
*&---------------------------------------------------------------------*

*& Report ZEDR07_002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR07_002.






************************************************************************

*

*DATA : gs_zedt07 TYPE ZEDT07_001.

*

*gs_zedt07-zcode = 'SSU-01'.

*gs_zedt07-zkname = '###'.

*gs_zedt07-zename = 'DONG'.

*gs_zedt07-zgender = 'M'.

*gs_zedt07-ztel = '01011112222'.

*

*WRITE : gs_zedt07-zcode.

*WRITE :/ gs_zedt07-zkname.

*WRITE :/ gs_zedt07-zename.

*WRITE :/ gs_zedt07-zgender.

*WRITE :/ gs_zedt07-ztel.



************************************************************************

*

*DATA : BEGIN OF gs_zedt07,

*  zcode TYPE ZEDT07_001-ZCODE,

*  zkname TYPE ZEDT07_001-ZKNAME,

*  zename TYPE ZEDT07_001-ZENAME,

*  zgender TYPE ZEDT07_001-ZGENDER,

*  ztel TYPE ZEDT07_001-ZTEL,

*  END OF gs_zedt07.

*

*  gs_zedt07-zcode = 'SSU-01'.

*  gs_zedt07-zkname = '###'.

*  gs_zedt07-zename = 'DONG'.

*  gs_zedt07-zgender = 'M'.

*  gs_zedt07-ztel = '01011112222'.

*

*  WRITE : gs_zedt07-zcode.

*  WRITE :/ gs_zedt07-zkname.

*  WRITE :/ gs_zedt07-zename.

*  WRITE :/ gs_zedt07-zgender.

*  WRITE :/ gs_zedt07-ztel.



************************************************************************

*

*DATA : BEGIN OF GS_ZEDT07,

*  zcode TYPE ZCODE07,

*  zkname TYPE ZKNAME07,

*  zename TYPE ZENAME07,

*  zgender TYPE ZGUBUN07,

*  ztel TYPE ZTEL07,

*  END OF GS_ZEDT07.

*

*  GS_ZEDT07-zcode = 'SSU-01'.

*  GS_ZEDT07-zkname = '###'.

*  GS_ZEDT07-zename = 'DONG'.

*  GS_ZEDT07-zgender = 'M'.

*  GS_ZEDT07-ztel = '01011112222'.

*

*  WRITE : GS_ZEDT07-zcode.

*  WRITE :/ GS_ZEDT07-zkname.

*  WRITE :/ GS_ZEDT07-zename.

*  WRITE :/ GS_ZEDT07-zgender.

*  WRITE :/ GS_ZEDT07-ztel.



************************************************************************

*

*DATA : gs_zeds07 TYPE ZEDS07_001.

*

*gs_zeds07-zcode = 'SSU-01'.

*gs_zeds07-zkname = '###'.

*gs_zeds07-zename = 'DONG'.

*gs_zeds07-zgender = 'M'.

*gs_zeds07-ztel = '01011112222'.

*

*WRITE : gs_zeds07-zcode.

*WRITE :/ gs_zeds07-zkname.

*WRITE :/ gs_zeds07-zename.

*WRITE :/ gs_zeds07-zgender.

*WRITE :/ gs_zeds07-ztel.



*************************************************************************

*

*DATA : gs_zedg07 TYPE ZTG07_ZED07.

*DATA : gv_ztitle TYPE ZTG07_ZTITLE.

*

*gs_zedg07-zcode = 'SSU-01'.

*gs_zedg07-zkname = '###'.

*gs_zedg07-zename = 'DONG'.

*gs_zedg07-zgender = 'M'.

*gs_zedg07-ztel = '01011112222'.

*gv_ztitle = '####'.

*

*WRITE : gs_zedg07-zcode.

*WRITE :/ gs_zedg07-zkname.

*WRITE :/ gs_zedg07-zename.

*WRITE :/ gs_zedg07-zgender.

*WRITE :/ gs_zedg07-ztel.

*WRITE :/ gv_ztitle.



**************************************************************************

*

*DATA : BEGIN OF gs_name,

*  name1 TYPE c LENGTH 10,

*  name2 TYPE c LENGTH 10,

*  END OF gs_name.

*

*  gs_name-name1 = '###'.

*  gs_name-name2 = '##'.

*

*  WRITE : gs_name-name1.

*  WRITE :/ gs_name-name2.



**************************************************************************

*

*DATA : BEGIN OF gs_name,

*  name1 TYPE c LENGTH 10,

*  name2 TYPE c LENGTH 10,

*  END OF gs_name.

*

*  gs_name-name1 = '###'.

*  gs_name-name2 = '##'.

*

*  gs_name-name1 = gs_name-name2.

*

*  WRITE : gs_name-name1.

*  WRITE :/ gs_name-name2.



**************************************************************************

*

*DATA : BEGIN OF gs_name,

*  name1 TYPE c LENGTH 10,

*  name2 TYPE c LENGTH 10,

*  END OF gs_name.

*

*  gs_name-name1 = '###'.

*  gs_name-name2 = '##'.

*

*  MOVE gs_name-name2 TO gs_name-name1.

*

*  WRITE : gs_name-name1.

*  WRITE :/ gs_name-name2.



**************************************************************************

*

*DATA : BEGIN OF gs_name,

*  name1 TYPE c LENGTH 10,

*  degree1 TYPE p DECIMALS 2,

*  END OF gs_name.

*

*  gs_name-name1 = '##'.

*  gs_name-degree1 = '35.12'.

*

*  MOVE gs_name-degree1 TO gs_name-name1.

*

*  CONDENSE gs_name-name1 NO-GAPS.

*

*  WRITE : gs_name-name1.

*  WRITE :/ gs_name-degree1.



**************************************************************************

*

*DATA : gv_data1(8) VALUE 'ABCDEFGH',

*      gv_data2(8).

*

*DATA : gv_start TYPE i VALUE 2,

*      gv_length TYPE i VALUE 4.

*

*MOVE gv_data1+2(3) TO gv_data2.

*WRITE :/ gv_data2.



**************************************************************************

*

*DATA : gv_data1(8) VALUE 'ABCDEFGH',

*      gv_data2(8).

*

*DATA : gv_start TYPE i VALUE 2,

*      gv_length TYPE i VALUE 4.

*

*MOVE gv_data1+gv_start(gv_length) TO gv_data2.

*WRITE :/ gv_data2.



**************************************************************************

*

*DATA : gv_data1(8) VALUE 'ABCDEFGH',

*      gv_data2(8) VALUE  'IJKLMNOP'.

*

*DATA : gv_start TYPE i VALUE 2,

*      gv_length TYPE i VALUE 4.

*

*MOVE gv_data1+gv_start(gv_length) TO gv_data2+gv_start(gv_length).

*WRITE : gv_data2.



**************************************************************************

*

*DATA : BEGIN OF gs_name,

*  name1 TYPE c LENGTH 10,

*  name2 TYPE c LENGTH 10,

*  END OF gs_name.

*

*  gs_name-name1 = '###'.

*  gs_name-name2 = '##'.

*

*  WRITE gs_name-name2 TO gs_name-name1.

*

*  WRITE : gs_name-name1.

*  WRITE :/ gs_name-name2.



***************************************************************************

*

*DATA : BEGIN OF gs_zedt07,

*  zcode TYPE ZEDT07_001-ZCODE,

*  zkname TYPE ZEDT07_001-ZKNAME,

*  zename TYPE ZEDT07_001-ZENAME,

*  zgender TYPE ZEDT07_001-ZGENDER,

*  ztel TYPE ZEDT07_001-ZTEL,

*  END OF gs_zedt07.

*

*  DATA : BEGIN OF gs_zedt07_2,

*  zcode TYPE ZEDT07_001-ZCODE,

*  zkname TYPE ZEDT07_001-ZKNAME,

*  zename TYPE ZEDT07_001-ZENAME,

*  zgender TYPE ZEDT07_001-ZGENDER,

*  ztel TYPE ZEDT07_001-ZTEL,

*  END OF gs_zedt07_2.

*

*  gs_zedt07-zcode = 'SSU-01'.

*  gs_zedt07-zkname = '###'.

*  gs_zedt07-zename = 'DONG'.

*  gs_zedt07-zgender = 'M'.

*  gs_zedt07-ztel = '01011112222'.

*

*  MOVE-CORRESPONDING gs_zedt07 TO gs_zedt07_2.

*

*  WRITE : gs_zedt07_2-zcode.

*  WRITE :/ gs_zedt07_2-zkname.

*  WRITE :/ gs_zedt07_2-zename.

*  WRITE :/ gs_zedt07_2-zgender.

*  WRITE :/ gs_zedt07_2-ztel.



*****************************************************************************

*

*DATA : BEGIN OF gs_zedt07,

*  zcode TYPE ZEDT07_001-ZCODE,

*  zkname TYPE ZEDT07_001-ZKNAME,

*  zename TYPE ZEDT07_001-ZENAME,

*  zgender TYPE ZEDT07_001-ZGENDER,

*  ztel TYPE ZEDT07_001-ZTEL,

*  END OF gs_zedt07.

*

*  DATA : BEGIN OF gs_zedt07_2,

*  zgender TYPE ZEDT07_001-ZGENDER,

*  zcode TYPE ZEDT07_001-ZCODE,

*  zkname TYPE ZEDT07_001-ZKNAME,

*  zename TYPE ZEDT07_001-ZENAME,

*  ztel TYPE ZEDT07_001-ZTEL,

*  END OF gs_zedt07_2.

*

*  gs_zedt07-zcode = 'SSU-01'.

*  gs_zedt07-zkname = '###'.

*  gs_zedt07-zename = 'DONG'.

*  gs_zedt07-zgender = 'M'.

*  gs_zedt07-ztel = '01011112222'.

*

*  MOVE-CORRESPONDING gs_zedt07 TO gs_zedt07_2.

*

*  WRITE : gs_zedt07_2-zcode.

*  WRITE :/ gs_zedt07_2-zkname.

*  WRITE :/ gs_zedt07_2-zename.

*  WRITE :/ gs_zedt07_2-zgender.

*  WRITE :/ gs_zedt07_2-ztel.



*****************************************************************************

*

*DATA : BEGIN OF gs_zedt07,

*  zcode TYPE ZEDT07_001-ZCODE,

*  zkname TYPE ZEDT07_001-ZKNAME,

*  zename TYPE ZEDT07_001-ZENAME,

*  zgender TYPE ZEDT07_001-ZGENDER,

*  ztel TYPE ZEDT07_001-ZTEL,

*  END OF gs_zedt07.

*

*  DATA : BEGIN OF gs_zedt07_2,

*  zgender TYPE ZEDT07_001-ZGENDER,

*  zcode TYPE ZEDT07_001-ZCODE,

*  zkname TYPE ZEDT07_001-ZKNAME,

*  zename TYPE ZEDT07_001-ZENAME,

*  ztel TYPE ZEDT07_001-ZTEL,

*  END OF gs_zedt07_2.

*

*  gs_zedt07-zcode = 'SSU-01'.

*  gs_zedt07-zkname = '###'.

*  gs_zedt07-zename = 'DONG'.

*  gs_zedt07-zgender = 'M'.

*  gs_zedt07-ztel = '01011112222'.

*

*  MOVE gs_zedt07 TO gs_zedt07_2.

*

*  WRITE : gs_zedt07_2-zcode.

*  WRITE :/ gs_zedt07_2-zkname.

*  WRITE :/ gs_zedt07_2-zename.

*  WRITE :/ gs_zedt07_2-zgender.

*  WRITE :/ gs_zedt07_2-ztel.



*****************************************************************************

*

*DATA : BEGIN OF gs_zedt07,

*  zcode TYPE ZEDT07_001-ZCODE,

*  zkname TYPE ZEDT07_001-ZKNAME,

*  zename TYPE ZEDT07_001-ZENAME,

*  zgender TYPE ZEDT07_001-ZGENDER,

*  ztel TYPE ZEDT07_001-ZTEL,

*  END OF gs_zedt07.

*

*  DATA : BEGIN OF gs_zedt07_2,

*  zcode TYPE ZEDT07_001-ZCODE,

*  zkname TYPE ZEDT07_001-ZKNAME,

*  zename TYPE ZEDT07_001-ZENAME,

*  zgender TYPE ZEDT07_001-ZGENDER,

*  ztel TYPE ZEDT07_001-ZTEL,

*  END OF gs_zedt07_2.

*

*  gs_zedt07-zcode = 'SSU-01'.

*  gs_zedt07-zkname = '###'.

*  gs_zedt07-zename = 'DONG'.

*  gs_zedt07-zgender = 'M'.

*  gs_zedt07-ztel = '01011112222'.

*

*  MOVE gs_zedt07 TO gs_zedt07_2.

*

*  WRITE : gs_zedt07_2-zcode.

*  WRITE :/ gs_zedt07_2-zkname.

*  WRITE :/ gs_zedt07_2-zename.

*  WRITE :/ gs_zedt07_2-zgender.

*  WRITE :/ gs_zedt07_2-ztel.



*****************************************************************************

*

*DATA : BEGIN OF gs_zedt07,

*  zcode TYPE ZEDT07_001-ZCODE,

*  zkname TYPE ZEDT07_001-ZKNAME,

*  zename TYPE ZEDT07_001-ZENAME,

*  zgender TYPE ZEDT07_001-ZGENDER,

*  ztel TYPE ZEDT07_001-ZTEL,

*  END OF gs_zedt07.

*

*  DATA : BEGIN OF gs_zedt07_2,

*  zzzzcode TYPE ZEDT07_001-ZCODE,

*  zzzzkname TYPE ZEDT07_001-ZKNAME,

*  zzzzename TYPE ZEDT07_001-ZENAME,

*  zzzzgender TYPE ZEDT07_001-ZGENDER,

*  zzzztel TYPE ZEDT07_001-ZTEL,

*  END OF gs_zedt07_2.

*

*  gs_zedt07-zcode = 'SSU-01'.

*  gs_zedt07-zkname = '###'.

*  gs_zedt07-zename = 'DONG'.

*  gs_zedt07-zgender = 'M'.

*  gs_zedt07-ztel = '01011112222'.

*

*  MOVE gs_zedt07 TO gs_zedt07_2.

*

*  WRITE : gs_zedt07_2-zzzzcode.

*  WRITE :/ gs_zedt07_2-zzzzkname.

*  WRITE :/ gs_zedt07_2-zzzzename.

*  WRITE :/ gs_zedt07_2-zzzzgender.

*  WRITE :/ gs_zedt07_2-zzzztel.



*******************************************************************************

*

*DATA : BEGIN OF gs_zedt07,

*  zcode TYPE ZEDT07_001-ZCODE,

*  zkname TYPE ZEDT07_001-ZKNAME,

*  zename TYPE ZEDT07_001-ZENAME,

*  zgender TYPE ZEDT07_001-ZGENDER,

*  ztel TYPE ZEDT07_001-ZTEL,

*  END OF gs_zedt07.

*

*  DATA : BEGIN OF gs_zedt07_2,

*  zzzzcode TYPE ZEDT07_001-ZCODE,

*  zzzzkname TYPE ZEDT07_001-ZKNAME,

*  zzzzename TYPE ZEDT07_001-ZENAME,

*  zzzzgender TYPE ZEDT07_001-ZGENDER,

*  zzzztel TYPE ZEDT07_001-ZTEL,

*  END OF gs_zedt07_2.

*

*  gs_zedt07-zcode = 'SSU-01'.

*  gs_zedt07-zkname = '###'.

*  gs_zedt07-zename = 'DONG'.

*  gs_zedt07-zgender = 'M'.

*  gs_zedt07-ztel = '01011112222'.

*

*  MOVE-CORRESPONDING gs_zedt07 TO gs_zedt07_2.

*

*  WRITE : gs_zedt07_2-zzzzcode.

*  WRITE :/ gs_zedt07_2-zzzzkname.

*  WRITE :/ gs_zedt07_2-zzzzename.

*  WRITE :/ gs_zedt07_2-zzzzgender.

*  WRITE :/ gs_zedt07_2-zzzztel.



********************************************************************************

*

*CONSTANTS : c_rate TYPE i VALUE '100'.

*

*DATA : gv_sum1 TYPE i,

*      gv_sum2 TYPE i,

*      gv_sum3 TYPE i.

*

*gv_sum1 = '10.00'.

*gv_sum2 = '20.00'.

*gv_sum3 = '30.00'.

*

*gv_sum1 = gv_sum1 * c_rate.

*gv_sum2 = gv_sum2 * c_rate.

*gv_sum3 = gv_sum3 * c_rate.

*

*WRITE : gv_sum1.

*WRITE :/ gv_sum2.

*WRITE :/ gv_sum3.



********************************************************************************

*

*CONSTANTS : BEGIN OF c_student,

*  zcode(10) VALUE 'SSU-01',

*  zkname(10) VALUE '###',

*  zename(10) VALUE 'DONG',

*  END OF c_student.

*

*  WRITE : c_student-zcode.

*  WRITE :/ c_student-zkname.

*  WRITE :/ c_student-zename.



********************************************************************************

*

*CONSTANTS : c_num1 TYPE i VALUE '10'.

*DATA : num1 TYPE i VALUE '10'.

*

**c_num1 = c_num1 + 1.

*num1 = num1 + 1.

*

*WRITE : c_num1.

*WRITE :/ num1.



********************************************************************************

*

*STATICS lv_num TYPE i.

*

*lv_num = lv_num + 1.

*

*WRITE :/ 'STATIC Variable' , lv_num.



********************************************************************************

*

**DATA : gs_zedt07 TYPE ZTG07_ZED07.

*TABLES : zedt07_001.

*

*SELECT SINGLE * FROM ZEDT07_001.

*

*  WRITE : zedt07_001-ZCODE.

*  WRITE :/ zedt07_001-ZKNAME.

*  WRITE :/ zedt07_001-ZENAME.

*  WRITE :/ zedt07_001-ZGENDER.

*  WRITE :/ zedt07_001-ZTEL.



********************************************************************************

*

*TABLES : scarr.

*

*SELECT * FROM SCARR.

*

*  WRITE :/ scarr-CARRID, scarr-CARRNAME.

*

*  ENDSELECT.



*******************************************************************************