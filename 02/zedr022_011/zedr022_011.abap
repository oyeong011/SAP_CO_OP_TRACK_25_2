
*&---------------------------------------------------------------------*

*& Report ZEDR022_011

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR022_001.






*DATA : BEGIN OF GS_STUDENT.

*  INCLUDE TYPE ZEDT022_001.

*  DATA : END OF GS_STUDENT.

*DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.



* 1. Single linse ##

*INSERT INTO <TABLE> VALUES WA

*INSERT <TABLE> FROM WA



*GS_STUDENT-MANDT = SY-MANDT.

*GS_STUDENT-ZCODE = 'SSU-11'.

*GS_STUDENT-ZPERNR = '0000000011'.

*GS_STUDENT-ZKNAME = '##'.

*GS_STUDENT-ZENAME = 'YOON'.

*GS_STUDENT-ZGENDER = 'F'.

*GS_STUDENT-ZTEL = '01000002222'.



*CLEAR : GS_STUDENT, GT_STUDENT.

*GS_STUDENT-MANDT = SY-MANDT.

*GS_STUDENT-ZCODE = 'SSU-12'.

*GS_STUDENT-ZPERNR = '0000000012'.

*GS_STUDENT-ZKNAME = '###'.

*GS_STUDENT-ZENAME = 'JAE'.

*GS_STUDENT-ZGENDER = 'M'.

*GS_STUDENT-ZTEL = '01000002222'.



*CLEAR : GS_STUDENT.

*GS_STUDENT-MANDT = SY-MANDT.

*GS_STUDENT-ZCODE = 'SSU-13'.

*GS_STUDENT-ZPERNR = '0000000013'.

*GS_STUDENT-ZKNAME = '###'.

*GS_STUDENT-ZENAME = 'CHA'.

*GS_STUDENT-ZGENDER = 'M'.

*GS_STUDENT-ZTEL = '01000003333'.



*INSERT INTO ZEDT022_001 VALUES GS_STUDENT.



*2. Serveral lines : ####### ## ## # ## #### ##

*INSERT <TABLE> FROM TABLE ITAB

*INSERT <TABLE> FROM TABLE ITAB ACCEPTING DUPLICATE KEYS

*INSERT ZEDT022_001 FROM TABLE GT_STUDENT ACCEPTING DUPLICATE KEYS.



*UPDATE ZEDT022_001 SET ZENAME = 'JUNG'

*WHERE ZCODE = 'SSU-03'.

*Single line : #### ### ## ##, wa# #### ###### #### WA# #### ## ### ## ##



*MODIFY ZEDT022_001 FROM GS_STUDENT.

*UPDATE+INSERT # ### # ## #### MODIFY## # ### ## ### ### ## # ####, ### ## #### ####



*select : ##

*INTO : #### ### #### ### ####, # ### ABAP ###### ##

* single line : ######## ### ## #### # #

* select single carrname from scarr into l_carrname.

*where carrid = 'aa'.

* several lines : ######## ## ## ##

*select carrname from scarr into table gt_scarr

*where carrid = 'aa'.






DATA : BEGIN OF GS_SCARR,

  ZCHECK TYPE C,

  CARRID LIKE SCARR-CARRID,

  CARRNAME LIKE SCARR-CARRNAME,

  END OF GS_SCARR.

DATA : GT_SCARR LIKE TABLE OF GS_SCARR.






*into ## ### # # ### ## ### ## ## ###, ## ### ### ## #

*SELECT CARRID CARRNAME INTO (GS_SCARR-CARRID, GS_SCARR-CARRNAME )

*  FROM SCARR

*  WHERE CARRID = 'AA'.

*

*  WRITE :/ GS_SCARR-CARRID, GS_SCARR-CARRNAME.

*ENDSELECT.






SELECT CARRID

       CARRNAME

  FROM SCARR

  INTO TABLE GT_SCARR

  WHERE CARRID = 'AA'.



 LOOP AT GT_SCARR INTO GS_SCARR.

   WRITE :/ GS_SCARR-CARRID, GS_SCARR-CARRNAME.

 ENDLOOP.