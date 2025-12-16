
*&---------------------------------------------------------------------*

*& Report ZEDR17_001

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT zedr17_001.






*Numeric types

*P (packed number) : ### ### ##

*I (integer) : ##, ## ## ## x

*N (numeric text field) : ### char# ##, ## ## #### ##

*

*Character types

*C (text field) : ##, ## ## ## ##

*STRING : ## ### ### Predifiened ABAP TYPE

*D (Date field) : ##, ## ## ## X

*T (Time field) : ##

*+) P, N, C ### ### ## ### #



* type p# ## ##### ### ### ## ####? -> ## ## ## #### 16#### ###.

* ## ## ##### type p length 2 decimals 2. ## type p(2) decimals 2.

*m




DATA :

  gv_num1 TYPE p VALUE '1234', " gv## g# global## ##, v# variable### ##

  gv_num2 TYPE p DECIMALS 2 VALUE '12.34',

  gv_num3 TYPE i VALUE 1234,

  gv_num4 TYPE n VALUE 1234, " n# ## ## ### value# ### # ### ## #### ##. # ## 4###

  gv_num5 TYPE n LENGTH 2 VALUE 1234,

  gv_num6 TYPE n LENGTH 3 VALUE 1234,

  gv_num7 TYPE n LENGTH 4 VALUE 1234.



WRITE :

  gv_num1, / gv_num2, / gv_num3, / gv_num4, / gv_num5, / gv_num6, / gv_num7. " /# ## ##






* #### #### ### char 1### #####, 'hi' # ## ###### ### 'h# ###




DATA gv_text1 VALUE 'hi'.

WRITE / gv_text1.






* ## ### ### ## ## ## ##




DATA gv_text2 LENGTH 3 TYPE c VALUE 'hi'.

DATA gv_text3(3) TYPE c VALUE 'hi'. " #### ## ## ##

DATA gv_text4(3) VALUE 'hi'. " type c ### ### ## ### ### c# ## ##

WRITE :  / gv_text2, / gv_text3, / gv_text4.



DATA : gv_text11 VALUE 'A'. " ## ## ### #### c# #.

DATA : gv_text22 LENGTH 3 TYPE c VALUE 'ABC'.

DATA : gv_text33(5) TYPE c VALUE 'ABCDE'. " type c# ## ##### ### (5)# ##

DATA : gv_text44 TYPE string VALUE 'ABCDE'. " type string# ###### ## ### #

DATA : gv_len TYPE i.



DATA : gv_time TYPE t. " ### ##

DATA : gv_date TYPE d. " ### ##



gv_time = sy-uzeit. " ### ### ### ##. cf) sy# [##] ## ###.

gv_date = sy-datum. " ### ### ### ##

gv_len = strlen( gv_text3 ). " gv_text3# ### ### ### ##. ### ## ## ### #### ## !!



WRITE : / gv_text11, / gv_text22, / gv_text33, / gv_text44, / gv_len, / gv_time, / gv_date, /.






*string ###. ### 3## ### ### !

*find: ## # ### 0, ### 4 ##

*replace: ## ##

*translate : #### ### ##

*shift : ## #### ### ##

*condense: (###) ## ## # #### ## (no-gaps# ## ##)

*overlay: char # # ###, ##### # #### ##

*concatenate: (###) ### ## ##

*split: (###) ## ## #### ## ##



* find




WRITE / '----find----' .

DATA : text1    TYPE string,

       text2(4) TYPE c.

text1 = 'ABAP'.

text2 = 'B'.



FIND text2 IN text1.



IF sy-subrc = 0. " ### ## ##. 0: ##, 4: ## X

  WRITE / text2.

ENDIF.






* replace




WRITE / '----replace----'.

DATA : text111    TYPE string,

       text222(4) TYPE c.

text111 = 'ABAP'.

text222 = 'BBAP'.

REPLACE text111 IN text111 WITH text222. " text1## text1# text2# ##

WRITE / text1.






* translate #### ###




WRITE / '----translate----'.

DATA : text1111    TYPE string,

       text2222(4) TYPE c.

text1111 = 'ABAP'.

text2222 = 'abap'.

TRANSLATE text1111 TO LOWER CASE.

TRANSLATE text2222 TO UPPER CASE.

WRITE / text1111.

WRITE / text2222.






* shift #### # #




WRITE / '----shift----'.

DATA: text_shift1    TYPE string,

      text_shift2(5) TYPE c.

text_shift1 = ' ABAP'.

text_shift2(5) = ' ABAP'.

SHIFT text_shift1.

WRITE : / text_shift1.

WRITE: / text_shift2.






* condense ####




WRITE / '----condense----'.

DATA : text_condense1    TYPE string,

       text_condense2(8) TYPE c,

       text_condense3(8) TYPE c.

text_condense1 = 'AB   AP'.

text_condense2 = 'AB   AP'.

text_condense3 = 'AB   AP'.



CONDENSE text_condense1. " ## ### ## ### # ## #### ##

CONDENSE text_condense2 NO-GAPS. " ## ## # ## # ## ##



WRITE  / text_condense1.

WRITE  / text_condense2.

WRITE text_condense3.






* overlay




WRITE / '----overlay----'.

DATA : text_overlay1    TYPE string,

       text_overlay2(8) TYPE c.

text_overlay1 = ' b p'.

text_overlay2 = 'aaaa'.

OVERLAY text_overlay1 WITH text_overlay2.

WRITE / text1.

WRITE / text2.






* concatenate




WRITE / '----conatenate----'.

DATA : t1    TYPE string,

       t2(4) TYPE c,

       t3(4) TYPE c.

t1 = 'ab'.

t2 = 'ap'.

CONCATENATE t1 t2 INTO t3.

WRITE / t1.

WRITE / t2.

WRITE / t3.






* slit




WRITE / '----split----'.

DATA : tt1    TYPE string,

       tt2(4) TYPE c,

       tt3(4) TYPE c.

tt1 = 'ab+ap'.

SPLIT tt1 AT '+' INTO tt2 tt3.

WRITE / tt1.

WRITE / tt2.

WRITE / tt3.






****






WRITE / '----###----'.

DATA : gv_num111 TYPE i VALUE 5,

       gv_num222 TYPE i VALUE 3,

       gv_num333 TYPE i.



gv_num333 = gv_num111 + gv_num222.

WRITE : / gv_num333.



gv_num333 = gv_num111 - gv_num222.

WRITE : / gv_num333.



gv_num333 = gv_num111 * gv_num222.

WRITE : / gv_num333.



gv_num333 = gv_num111 / gv_num222. " 1.6## #### 2# ##.

WRITE : / gv_num333.



gv_num333 = gv_num111 DIV gv_num222. " Ingeter ####, # ##

WRITE : / gv_num333.



gv_num333 = gv_num111 MOD gv_num222.  " ### ##

WRITE : / gv_num333.



gv_num333 = gv_num111 ** gv_num222.

WRITE : / gv_num333.






* ## ##




WRITE / '----## ##----'.

TYPES t_hello(20).



DATA gv_text__1 TYPE t_hello.

DATA gv_text__2 LIKE gv_text__1.



gv_text__1 = '#####'.

gv_text__2 = '#####'.



WRITE / gv_text__1.

WRITE / gv_text__2.










* ### ## ## -> ## ##




WRITE / '----structured type ##----'.



TYPES : BEGIN OF t_zedt17,

          zcode(10),

          zkname(20),

          zename(20),

        END OF t_zedt17.



DATA : gs_zedt17 TYPE t_zedt17. " ### ## ##

gs_zedt17-zcode = 'SSU-01'.

gs_zedt17-zkname = '###'.

gs_zedt17-zename = 'DONG'.



WRITE / gs_zedt17-zcode.

WRITE / gs_zedt17-zkname.

WRITE / gs_zedt17-zename.



TYPES : BEGIN OF t_zedt17_2.

    INCLUDE TYPE t_zedt17.

TYPES : title(10),

        grade(1),

END OF t_zedt17_2.



DATA : gs_zedt17_2 TYPE t_zedt17_2.



gs_zedt17_2-zcode = 'SSU-01'.

gs_zedt17_2-zkname = '###'.

gs_zedt17_2-zename = 'DONG'.

gs_zedt17_2-title = '####'.

gs_zedt17_2-grade = '3'.



WRITE : / gs_zedt17_2-zcode, / gs_zedt17_2-zkname, / gs_zedt17_2-zename, / gs_zedt17_2-title, / gs_zedt17_2-grade.