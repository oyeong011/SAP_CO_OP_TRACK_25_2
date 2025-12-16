
*&---------------------------------------------------------------------*

*& Report ZEDR25_003

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR25_003.



DATA : BEGIN OF gs_name,

    name1 type C length 10,

    name2 type C length 10,

 end of gs_name.



gs_name-name1 = '###'.

gs_name-name2 = '##'.



gs_name-name1 = gs_name-name2.



write : gs_name-name1.

write : / gs_name-name2.





gs_name-name1 = '###'.

gs_name-name2 = '##'.



move gs_name-name2 to gs_name-name1.



write : / gs_name-name1.

write : / gs_name-name2.



DATA : BEGIN OF gs_name_1,

    name1 type C length 10,

    degree type P decimals 2,

 end of gs_name_1.



 gs_name_1-name1 = '##'.

 gs_name_1-degree = '30.1'.



 move gs_name_1-degree to gs_name_1-name1.



 condense gs_name_1-name1 no-gaps.



 write : / gs_name_1-name1.

 write : / gs_name_1-degree.



 "DATA : gv_data1(8) value '123456768', gv_data2(8).

 "DATA : gv_start type I value 2, gv_length type I value 4.



 "move gv_data1+2(3) to gv_data2.

 "write : / gv_data2.



 DATA : gv_data1(8) value '123456768', gv_data2(8) value 'qwertyui'.

 DATA : gv_start type I value 2, gv_length type I value 4.

 move gv_data1+gv_start(gv_length) to gv_data2+gv_start(gv_length).

 write : / gv_data2.



DATA : BEGIN OF gs_name_3,

    name1T type C length 10,

    name2T type C length 10,

 end of gs_name_3.



gs_name_3-name1T = '###'.

gs_name_3-name2T = '##'.



write gs_name_3-name2T to gs_name_3-name1T.



write : / gs_name_3-name1T.

write : / gs_name_3-name2T.






*DATA : BEGIN OF GS_ZEDT25,

*  ZCODE TYPE ZEDT25_001-ZCODE,

*  ZKNAME TYPE ZEDT25_001-ZKNAME,

*  ZENAME TYPE ZEDT25_001-ZENAME,

*  ZGENDER TYPE ZEDT25_001-ZGENDER,

*  ZTEL TYPE ZEDT25_001-ZTEL,

*  END OF GS_ZEDT25.

*

*DATA : BEGIN OF GS_ZEDT25_2,

*  ZZCODE TYPE ZEDT25_001-ZCODE,

*  ZZKNAME TYPE ZEDT25_001-ZKNAME,

*  ZZENAME TYPE ZEDT25_001-ZENAME,

*  ZZGENDER TYPE ZEDT25_001-ZGENDER,

*  ZZTEL TYPE ZEDT25_001-ZTEL,

*  END OF GS_ZEDT25_2.

*

*

*GS_ZEDT25-ZCODE = 'SSU-01'.

*GS_ZEDT25-ZKNAME = '###'.

*GS_ZEDT25-ZENAME = 'DONG'.

*GS_ZEDT25-ZGENDER = 'M'.

*GS_ZEDT25-ZTEL = '01011112222'.

*

*MOVE-CORRESPONDING GS_ZEDT25 TO GS_ZEDT25_2.

*

*WRITE :/ GS_ZEDT25_2-ZZCODE.

*WRITE :/ GS_ZEDT25_2-ZZKNAME.

*WRITE :/ GS_ZEDT25_2-ZZENAME.

*WRITE :/ GS_ZEDT25_2-ZZGENDER.

*WRITE :/ GS_ZEDT25_2-ZZTEL.





*DATA : BEGIN OF GS_ZEDT25,

*  ZCODE TYPE ZEDT25_001-ZCODE,

*  ZKNAME TYPE ZEDT25_001-ZKNAME,

*  ZENAME TYPE ZEDT25_001-ZENAME,

*  ZGENDER TYPE ZEDT25_001-ZGENDER,

*  ZTEL TYPE ZEDT25_001-ZTEL,

*  END OF GS_ZEDT25.

*

*" ## ### ###

*DATA : BEGIN OF GS_ZEDT25_2,

*  ZGENDER type ZEDT25_001-ZGENDER,

*  ZZCODE TYPE ZEDT25_001-ZCODE,

*  ZZKNAME TYPE ZEDT25_001-ZKNAME,

*  ZZENAME TYPE ZEDT25_001-ZENAME,

*  ZZGENDER TYPE ZEDT25_001-ZGENDER,

*  ZZTEL TYPE ZEDT25_001-ZTEL,

*  END OF GS_ZEDT25_2.

*

*

*GS_ZEDT25-ZCODE = 'SSU-01'.

*GS_ZEDT25-ZKNAME = '###'.

*GS_ZEDT25-ZENAME = 'DONG'.

*GS_ZEDT25-ZGENDER = 'M'.

*GS_ZEDT25-ZTEL = '01011112222'.

*

*MOVE-CORRESPONDING GS_ZEDT25 TO GS_ZEDT25_2.

*

*WRITE :/ GS_ZEDT25_2-ZZCODE.

*WRITE :/ GS_ZEDT25_2-ZZKNAME.

*WRITE :/ GS_ZEDT25_2-ZZENAME.

*WRITE :/ GS_ZEDT25_2-ZZGENDER.

*WRITE :/ GS_ZEDT25_2-ZZTEL.






DATA : BEGIN OF GS_ZEDT25,

  ZCODE TYPE ZEDT25_001-ZCODE,

  ZKNAME TYPE ZEDT25_001-ZKNAME,

  ZENAME TYPE ZEDT25_001-ZENAME,

  ZGENDER TYPE ZEDT25_001-ZGENDER,

  ZTEL TYPE ZEDT25_001-ZTEL,

  END OF GS_ZEDT25.



" ## ### ###

DATA : BEGIN OF GS_ZEDT25_2,

  ZGENDER type ZEDT25_001-ZGENDER,

  ZZCODE TYPE ZEDT25_001-ZCODE,

  ZZKNAME TYPE ZEDT25_001-ZKNAME,

  ZZENAME TYPE ZEDT25_001-ZENAME,

  ZZGENDER TYPE ZEDT25_001-ZGENDER,

  ZZTEL TYPE ZEDT25_001-ZTEL,

  END OF GS_ZEDT25_2.





GS_ZEDT25-ZCODE = 'SSU-01'.

GS_ZEDT25-ZKNAME = '###'.

GS_ZEDT25-ZENAME = 'DONG'.

GS_ZEDT25-ZGENDER = 'M'.

GS_ZEDT25-ZTEL = '01011112222'.



MOVE GS_ZEDT25 TO GS_ZEDT25_2.





constants : c_r type I value '100'.



DATA : gv_sum1 type I, gv_sum2 type I, gv_sum3 type I.



gv_sum1 = '10.00'.

gv_sum2 = '10.00'.

gv_sum3 = '10.00'.



gv_sum1 = gv_sum1 * c_r.

gv_sum2 = gv_sum2 * c_r.

gv_sum3 = gv_sum3 * c_r.





write : / gv_sum1.

write : / gv_sum2.

write : / gv_sum3.



constants : begin of c_stu,

   zcode(10) value 'ssu-25',

   zkname(10) value 'dd',

   zename(10) value 'dong',

  end of c_stu.



write :/ c_stu-zcode.

write :/ c_stu-zkname.

write :/ c_stu-zename.



CONSTANTS : C_NUM1 TYPE I VALUE '10'.

DATA : NUM1 TYPE I VALUE '10'.



NUM1 = NUM1 + 1.



WRITE :/ C_NUM1.

WRITE :/ NUM1.








*STATICS lv_num TYPE i.

*

*lv_num = lv_num + 1.

*

*WRITE :/ 'STATIC Variable : ', lv_num.








TABLES : ZEDT25_001.



SELECT SINGLE * FROM ZEDT25_001.



WRITE :/ ZEDT25_001-ZCODE.

WRITE :/ ZEDT25_001-ZKNAME.

WRITE :/ ZEDT25_001-ZENAME.

WRITE :/ ZEDT25_001-ZGENDER.

WRITE :/ ZEDT25_001-ZTEL.





TABLES : SCARR.



SELECT * FROM SCARR.



  WRITE : / SCARR-CARRID, SCARR-CARRNAME.



ENDSELECT.