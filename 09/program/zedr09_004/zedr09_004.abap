
*&---------------------------------------------------------------------*

*& Report ZEDR09_004

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR09_004.






* DATA object# #### ##

* 1. Constants

* 2. STATICS

* 3. TABLES





* 1. Constants

* - ###### ## #### ## ### #### ####

* - ## ### ###, ####### !####!

* - ####, ##### 2## ## ##

* - ### #### ##### #### #### ###.



* - Constants ; ###### ## #### ## #### ##### # ## ## => '####'# ## #




CONSTANTS : C_RATE type i value 100.



DATA : GV_SUM1 type i, GV_SUM2 type i, GV_SUM3 type i.



GV_SUM1 = '10.00'. "1000### ##### ##

GV_SUM2 = '20.00'. "2000### ##### ##

GV_SUM3 = '30.00'. "3000### ##### ##






* #### ### ## ###### ####.




GV_SUM1 = GV_SUM1 * C_RATE.

GV_SUM2 = GV_SUM2 * C_RATE.

GV_SUM3 = GV_SUM3 * C_RATE.



write : / GV_SUM1.

write : / GV_SUM2.

write : / GV_SUM3.






* - Constants : '### ##'# ## #.




CONSTANTS : BEGIN OF C_STUDENT,

  ZCODE(10) VALUE 'ssu-09',

  ZKNAME(10) value '###',

  ZENAME(10) value 'kim',

  END OF C_STUDENT.



WRITE : / C_STUDENT-ZCODE.

WRITE : / C_STUDENT-ZKNAME.

WRITE : / C_STUDENT-ZENAME.






* C_STUDENT-ZKNAME = '###2'. -> ###### #### (#####!)

* C_RATE = C_RATE * 10. -> ##### ##### ####!



* 2. Statics

* - ## '##' ### ### ##### ##.

* - #### subroutin(form, function)## #### local####, '###'## ### ## ##.

* - ## # statics# ### local ###, ##### ### ### ## ####.



* - Statics# form, functions ### ### ##.

* - ## ## 0## #### DATA# ##, STATICS# ## ## ####.








FORM demo.

  DATA : lv_data TYPE i.

  STATICS : lv_stat TYPE i.



  lv_data = lv_data + 1.

  lv_stat = lv_stat + 1.



    WRITE: / 'DATA :', lv_data,

         / 'STATICS :', lv_stat.



ENDFORM.



START-OF-SELECTION.

  PERFORM demo.   " # ## ##

  PERFORM demo.   " # ## ##

  PERFORM demo.   " # ## ##






* 3. tabless

* - ## ### ## ## #####, tables #### ## ###### #### ## ### ### ### # ### ### #.

* - TABLES zedt09_001.

*   ## ## TABLES# ### ####, #### ### ## #### ##(=###)# ## work area(####)# #### #####.

*   #, ##### ### #### ### ### ### ### #### ##.






TABLES : ZEDT09_001.



SELECT SINGLE * FROM ZEDT09_001.



break-point.



WRITE : / ZEDT09_001-ZCODE.

WRITE : / ZEDT09_001-ZKNAME.

WRITE : / ZEDT09_001-ZENAME.

WRITE : / ZEDT09_001-ZGENDER.

WRITE : / ZEDT09_001-ZTEL.






* - ## SCARR# ## #### ### ### #####.




TABLES : SCARR.

SELECT * FROM SCARR.

  WRITE : / SCARR-CARRID, SCARR-CARRNAME.

ENDSELECT.