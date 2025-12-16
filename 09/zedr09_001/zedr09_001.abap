
*&---------------------------------------------------------------------*

*& Report ZEDR09_001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR09_001.






* ## 1 : Predefined ABAP Type (Numeric Type: P, I, N)

* p (packed number) : DECIMALS #### ### ## ##




DATA : gv_num1 type p VALUE '1234'.

DATA : gv_num2 type p DECIMALS 2 VALUE '12.34'.








* I (Integer) : ##, ## ## ## X




DATA : gv_num3 type i VALUE 1234.






* N (Numeric Text field) : ### C#### ##, ## ## ##




DATA : gv_num4 type N VALUE 1234.

DATA : gv_num5 type N LENGTH 2 VALUE 1234.

DATA : gv_num6 type N LENGTH 3 VALUE 1234.

DATA : gv_num7 TYPE N LENGTH 4 VALUE 1234.

DATA : gv_num8 type N length 5 value '123456'.








* P, I ## : "###", ## # ### #### ### ## + ### ##, ## ### ## ##

* N ## i "###", ## ### ## 0### ##




WRITE : gv_num1.

WRITE : / 'gv_num2 ', gv_num2.

WRITE : / gv_num3.

WRITE : / gv_num4.

WRITE : / gv_num5.

WRITE : / gv_num6.

WRITE : / gv_num7.

write : / 'gv_num8 :' , gv_num8.






* ## 2 : Predefined ABAP Type (Character Type : C, STRING, D, T)

* C : ##, ## ## ## => ###### C# ## ## ##

* STRING : ## ##

* D (Date field) : ##, ## ## ## X

* T : ##






DATA : GV_TEXT1 VALUE 'A'.

DATA : GV_TEXT2 LENGTH 3 TYPE C VALUE 'ABC'.

DATA : GV_TEXT3(3) TYPE C VALUE 'ABC'.

DATA : GV_TEXT4 TYPE STRING VALUE 'ABCDE'.

DATA : GV_LEN TYPE i.



DATA : GV_TIME TYPE T.

DATA : GV_DATE TYPE D.



GV_TIME = SY-UZEIT.

GV_DATE = SY-DATUM.



GV_LEN = STRLEN( GV_TEXT1 ).



WRITE : GV_TEXT1.

WRITE : / GV_TEXT2.

WRITE : / GV_TEXT3.

WRITE : / GV_TEXT4.

WRITE : / GV_LEN.

WRITE : / GV_TIME.

WRITE : / GV_DATE.






* ## 3 : STRING ## ## ## ##

* FIND, REPLACE, TRANSLATE, SHIFT, CONDENSE, OVERLAY, CONCATENATE, SPLIT

*WRITE / 'FIND ## ### #####.'.

*

*DATA : TEXT1(4) TYPE C,

*       TEXT2 TYPE STRING.

*

*TEXT1 = 'ABAP'.

*TEXT2 = 'F'.

*

*FIND TEXT2 IN TEXT1.

*

*write : / 'FIND ### ##' , SY-SUBRC.

* FIND ##, ### ### 0 / # ### 4



*WRITE / 'REPLACE ### #####.'.

*

*DATA : TEXT1 TYPE STRING,

*       TEXT2 LENGTH 4 TYPE C.

*

*TEXT1 = 'ABAP****'.

*TEXT2 = 'BBAP'.

*

*WRITE : / '## #', TEXT1.

*REPLACE 'ABAP' IN TEXT1 WITH TEXT2.

*WRITE : / '## #', TEXT1.



* TRANSLATE

*DATA : TEXT1 TYPE STRING,

*       TEXT2(4) TYPE C.

*

*TEXT1 = 'ABAP'.

*TEXT2 = 'abap'.

*

*TRANSLATE TEXT1 TO LOWER CASE.

*TRANSLATE TEXT2 TO UPPER CASE.

*

*WRITE : / 'text1 : ', TEXT1, ' text2 : ', text2.



* SHIFT

*DATA : TEXT1 TYPE STRING,

*       TEXT2 LENGTH 5 TYPE C.

*

*TEXT1 = ' ABAP'.

*TEXT2 = ' ABAP'.

*

*SHIFT TEXT1.

*WRITE :  'TEXT1', TEXT1, ' ,TEXT2 :', TEXT2.



* CONDENSE : ## #### ### ##





* overlay : char ### ###, ### ### #### ##.




DATA : overlay_text1 type string value ' B P',

       overlay_text2(6) type c value 'AAAA'.



overlay overlay_text1 with overlay_text2.



write : 'overlay result : ', overlay_text1, ' , overlay_text2 : ', overlay_text2.






* concatenate : ##### ## ##




DATA : concatenate_text1 length 4 type c value 'ABAP',

       concatenate_text2 type string value 'abap',

       result_text3 type string.



concatenate concatenate_text1 concatenate_text2 into result_text3.



write : / 'concatenate t1 : ', concatenate_text1, ' ,concatenate t2 : ', concatenate_text2, ' , result : ', result_text3.








* split : ## ### #### ### ##.




DATA : split_t1 type string value 'AB+AP',

       split_t2(2) type c,

       split_t3(2) type c.



split split_t1 at '+' into split_t2 split_t3.



write : / 'split_t1 : ', split_t1, ' ,split_t2 : ', split_t2, ' ,split_t3 : ', split_t3.










** ## ####, ## predefined type 3## p, i, n # i, n# ## ## *

* +, -, *, /

* DIV : integer ###

* mod : integer #### ###

* ** : ##






DATA : gv_op_num1 type i value 5,

       gv_op_num2 type i value 3,

       gv_op_num3 type i,

       gv_p_num4 type p.



gv_op_num3 = gv_op_num1 + gv_op_num2.

write : / '+ result : ', gv_op_num3.



gv_op_num3 = gv_op_num1 - gv_op_num2.

write : / '- result : ', gv_op_num3.



gv_op_num3 = gv_op_num1 * gv_op_num2.

write : / '* result : ', gv_op_num3.



gv_op_num3 = gv_op_num1 / gv_op_num2.

write : / '/ result : ', gv_op_num3.



gv_p_num4 = gv_op_num1 / gv_op_num2.

write : / '/ result2  #### #### n## i# ## p# ## # : ', gv_p_num4.



gv_op_num3 = gv_op_num1 DIV gv_op_num2.

write : / 'DIV result : ', gv_op_num3.



gv_op_num3 = gv_op_num1 MOD gv_op_num2.

write : / 'MOD result : ', gv_op_num3.



gv_op_num3 = gv_op_num1 ** gv_op_num2.

write : / '** result : ', gv_op_num3.



write : / '##### VS #####'.



DATA : num1 TYPE i value 7,

       num2 TYPE i value 3,

       result1 TYPE p DECIMALS 2,

       result2 TYPE i.



result1 = num1 / num2.

result2 = num1 DIV num2.



write : / 'result1 : ', result1.

write : / 'result2 : ', result2.








** Local Data type IN PROGRAM

** - ABAP #### '#'## Predefined ABAP ### ####, Local Type ##

** 1) TYPE ## -> ###



* T_HELLO ## ### '####'




TYPES t_hello(20) type c.






* TYPES# ## ### ###, '## ##'




DATA gv_text_lc1 TYPE t_hello.






* gv_text1 DATA ### ###, '## ##'




DATA gv_text_lc2 LIKE gv_text_lc1.




* WARING !! : DATA object# ### ### ### ## TYPE# ##, LIKE# ### #.






gv_text_lc1 = '#####'. gv_text_lc2 = '#####.'.



write : / gv_text_lc1, ' ' , gv_text_lc2.






** 2) Structured TYPE ##

** 2-1) ### ## ## -> ## ##

** 2-2) ### TYPE, Nested Type ## -> ### ## ##

** 2-3) DATA BEGIN OF ~ END OF ####, ## ### '##'## (#### ##)

** 2-4) DATA BEGIN OF, Nested TYPE ## ~ END OF ####, ### '##' ## (#### ##)



** 2-1 ) ### ## ## -> ## ##

** T_ZEDT09 - ## ## ###

** TYPES : BEGIN OF T_ZEDT09,

**   ZCODE TYPE c LENGTH 10,

**   ZKNAME TYPE c LENGTH 20,

**   ZENAME(20) TYPE c,

**   END OF T_ZEDT09.



** ##, ### ## ##

** DATA : GS_ZEDT09 TYPE T_ZEDT09.



** GS_ZEDT09-ZCODE = 'ssu-09'.

** GS_ZEDT09-ZKNAME = '###'.

** GS_ZEDT09-ZENAME = 'KIM'.



** write : / GS_ZEDT09-ZCODE.

** write : / GS_ZEDT09-ZKNAME.

** write : / GS_ZEDT09-ZENAME.



** 2-2) ### type, nested type ## -> ### ## ##

* ### '##' ## -> #######

*TYPES : BEGIN OF T_ZEDT09_2,

*  ZCODE(10) TYPE c,

*  ZKNAME TYPE c LENGTH 20,

*  ZENAME TYPE string,

*  END OF T_ZEDT09_2.



* ### 'nested' ## ## -> ####### + ####

*TYPES : BEGIN OF T_ZEDT09_nested,

*  INCLUDE TYPE T_ZEDT09_2.

*  TYPES : TITLE TYPE C LENGTH 10,

*          GRADE TYPE C LENGTH 1,

*  END OF T_ZEDT09_nested.



* ### 'nested' '##' ##

* 1) ## ###

* TYPES: BEGIN OF t_zedt09,            "#### ###

*          zcode  TYPE c LENGTH 10,

*          zkname TYPE c LENGTH 20,

*          zename TYPE c LENGTH 20,

*        END OF t_zedt09.



* 2) nested ### (include + ## ##)

* TYPES: BEGIN OF t_zedt09_2.        "#### ### + ####

*          INCLUDE TYPE t_zedt09.

*          TYPES : title  TYPE c LENGTH 20,

*                  grade  TYPE c LENGTH 1,

* END OF t_zedt09_2.



* 3) ## ## # ##

* DATA gs_zedt09 TYPE t_zedt09_2.



* gs_zedt09-zcode = 'ssu-09'.

* gs_zedt09-zkname = '###'.

* gs_zedt09-zename = 'kmj'.

* gs_zedt09-title  = '#######'.

* gs_zedt09-grade  = '4'.



* WRITE: / gs_zedt09-zcode,

*        / gs_zedt09-zkname,

*        / gs_zedt09-zename,

*        / gs_zedt09-title,

*        / gs_zedt09-grade.

* ### ## ### ## ##



* ### DATA ### ##

* DATA : BEGIN OF GS_ZEDT09, "#### ###

*   ZCODE TYPE C LENGTH 10,

*   ZKNAME TYPE C LENGTH 20,

*   ZENAME TYPE C LENGTH 20,

*   END OF GS_ZEDT09.



* GS_ZEDT09-ZCODE = 'ssu-09'.

* GS_ZEDT09-ZKNAME = '###'.

* GS_ZEDT09-ZENAME = 'KIMMINJI'.



* WRITE / GS_ZEDT09-ZCODE.

* WRITE / GS_ZEDT09-ZKNAME.

* WRITE / GS_ZEDT09-ZENAME.



* ### nested ##, ### ## ##



* ### DATA ## ##




DATA : BEGIN OF GS_ZEDT09, "#### ###

  ZCODE TYPE C LENGTH 10,

  ZKNAME TYPE C LENGTH 20,

  ZENAME TYPE C LENGTH 20,

END OF GS_ZEDT09.






* ### nested DATA ## ##




DATA : BEGIN OF GS_ZEDT09_02. "#### ### + ####

  INCLUDE STRUCTURE GS_ZEDT09.

  DATA : TITLE TYPE C LENGTH 10,

          GRADE TYPE C LENGTH 1,

  END OF GS_ZEDT09_02.



GS_ZEDT09_02-ZCODE = 'ssu-09'.

GS_ZEDT09_02-ZKNAME = '###'.

GS_ZEDT09_02-ZENAME = 'KIM'.

GS_ZEDT09_02-TITLE = 'software'.

GS_ZEDT09_02-GRADE = '4'.



WRITE : / GS_ZEDT09_02-ZCODE.

WRITE : / GS_ZEDT09_02-ZKNAME.

WRITE : / GS_ZEDT09_02-ZENAME.

WRITE : / GS_ZEDT09_02-TITLE.

WRITE : / GS_ZEDT09_02-GRADE.