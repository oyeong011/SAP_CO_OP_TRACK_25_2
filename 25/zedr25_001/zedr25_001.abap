
*&---------------------------------------------------------------------*

*& Report ZEDR25_001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR25_001.

DATA : gv_num1 type p VALUE '1234'.

DATA : gv_num2 type p DECIMALS 2 VALUE '12.34'.



DATA : gv_num3 type i value 1234.



DATA : gv_num4 type N value 1234.

DATA : gv_num5 type N length 2 value 1234.

DATA : gv_num6 type N length 3 value 1234.

DATA : gv_num7 type N length 5 value 1234.



write : gv_num1.

write :/ gv_num2.

write :/ gv_num3.

write :/ gv_num4.

write :/ gv_num5.

write :/ gv_num6.

write :/ gv_num7.





DATA : gv_next1 value 'A'.

DATA : gv_next2 length 2 type C value 'ABC'.

DATA : gv_next3(5) type C value 'ABCDE'.

DATA : gv_next4 type STRING value 'ABCDE'.

DATA : gv_len type i.



DATA : gv_time type T.



DATA : gv_date type D.



gv_time = SY-UZEIT.

gv_date = SY-DATUM.

gv_len = STRLEN( gv_next3 ).



write : gv_next1.

write :/ gv_next2.

write :/ gv_next3.

write :/ gv_next4.

write :/ gv_len.

write :/ gv_time.

write :/ gv_date.



DATA : text1 type string, text2(4) type C.



text1 = 'ABAP'.

text2 = 'B'.



find text2 in text1.



if SY-SUBRC = 0.

  write :/ text2.

  endif.



DATA : text11 type string, text22(4) type C.



text11 = 'ABAP'.

text22 = 'BBAP'.



replace text11 in text11 with text22.

write : / text11. "### # #### ###"





DATA : text33 type string, text44(4) type C.



text33 = 'ABAP'.

text44 = 'abap'.

translate text33 to lower case.

translate text44 to upper case.



write :/ text33.

write :/ text44.



DATA : text55 type string, text66(5) type C.



text55 = '  55'.

text66 = '66'.



shift text55. "#### ## ##"

write :/ text55.

write :/ text66.



"## : DATA : <- ###"

DATA : text77 type string, text88(8) type C, text99 type C.



text77 = 'AB  AP'.

text88 = 'AB  AP'.

text99 = 'AB  AP'.



condense text77.

condense text88 NO-GAPS.



write :/ text77.

write :/ text88.

write :/ text99.



 DATA : overlayTest1 type string, overlayTest2(8) type C.



 overlayTest1 = ' B P'.

 overlayTest2 = 'AAAA'.



 overlay overlayTest1 with overlayTest2.



 write :/ overlayTest1.

 write :/ overlayTest2.





DATA : ConcateTEXT1 TYPE STRING, ConcateTEXT2(4) TYPE C, ConcateTEXT3(4) TYPE C.



ConcateTEXT1 = 'AB'.

ConcateTEXT2 = 'AP'.

CONCATENATE ConcateTEXT1 ConcateTEXT2 INTO ConcateTEXT3.

WRITE : / ConcateTEXT1.

WRITE :/ ConcateTEXT2.

WRITE :/ ConcateTEXT3.





DATA : SplitText1 type string, SplitText2(4) type C, SplitText3(4) type C.



SplitText1 = 'AB+CD'.

split SplitText1 at '+' into SplitText2 SplitText3. "## ,(##) ## ##"



WRITE : / SplitText1.

WRITE :/ SplitText2.

WRITE :/ SplitText3.





DATA : gv_num9 type i value 5, gv_num99 type i value 3, gv_num999 type i.



gv_num999 = gv_num9 + gv_num99.

write : gv_num999.



gv_num999 = gv_num9 - gv_num99.

write : gv_num999.



gv_num999 = gv_num9 * gv_num99.

write : gv_num999.



gv_num999 = gv_num9 / gv_num99.

write : gv_num999.



gv_num999 = gv_num9 DIV gv_num99.

write : gv_num999.



gv_num999 = gv_num9 MOD gv_num99.

write : gv_num999.



gv_num999 = gv_num9 ** gv_num99.

write : gv_num999.



types T_hello(20) type C.



"# ## ## ## data# ## #"

DATA gv_nextT type T_hello.

DATA gv_nextTT like gv_nextT.



gv_nextT = '#####'.

gv_nextTT = '#####'.



write :/ gv_nextT.

write :/ gv_nextTT.






*## ### ## ## *






TYPES: BEGIN OF t_zedt25,

         zcode  TYPE c LENGTH 10,

         zkname TYPE c LENGTH 20,

         zename TYPE c LENGTH 20,

       END OF t_zedt25.



DATA gs_zedt25 TYPE t_zedt25.



gs_zedt25-zcode  = 'SSU-25'.

gs_zedt25-zkname = '###'.

gs_zedt25-zename = 'choi'.



WRITE: / gs_zedt25-zcode.

WRITE: / gs_zedt25-zkname.

WRITE: / gs_zedt25-zename.



TYPES: BEGIN OF t_zedt25_2,

         INCLUDE TYPE t_zedt25,

         title TYPE c LENGTH 10,

         grade TYPE c LENGTH 1,

       END OF t_zedt25_2.



DATA gs_zedt25_2 TYPE t_zedt25_2.   "### ###



gs_zedt25_2-zcode  = 'SSU-01'.

gs_zedt25_2-zkname = '###'.

gs_zedt25_2-zename = 'DONG'.

gs_zedt25_2-title  = '####'.

gs_zedt25_2-grade  = '3'.



WRITE: / gs_zedt25_2-zcode,

       / gs_zedt25_2-zkname,

       / gs_zedt25_2-zename,

       / gs_zedt25_2-title,

       / gs_zedt25_2-grade.