
*&---------------------------------------------------------------------*

*& Report  ZEDR00_001

*&---------------------------------------------------------------------*

*& ABAP ## ### ## # ## ## ##

*&---------------------------------------------------------------------*




report ZEDR00_001 MESSAGE-ID ZMED05.






*&---------------------------------------------------------------------*

*& Part 1. ABAP ## ### ## ## (Data Type Specification)

*&---------------------------------------------------------------------*

*

* ## ### ##(DATA)## ##, ## ### #### ### ### #### ###.

* ABAP# ##### #### #### ### ####.

*

*

* "--- 1. ## ## (Character Types) ---"

*

* DATA gv_c     TYPE c LENGTH 10.  " C: ## ## ##. 'ABC'# ### 7## #### #####. ## ### #####.

* DATA gv_string TYPE string.         " STRING: ## ## ##. 'ABC'# ### ### 3# ##, # ### ### ### #####.

* DATA gv_d     TYPE d.              " D: ## ##. 'YYYYMMDD' #### 8## #####.

* DATA gv_t     TYPE t.              " T: ## ##. 'HHMMSS' #### 6## #####.

*

*

* "--- 2. ## ## (Numeric Types) ---"

*

* DATA gv_i     TYPE i.              " I: ##(Integer). #### ## ### #####.

* DATA gv_p     TYPE p DECIMALS 2. " P: #### #### ##(Packed Number). DECIMALS# ### #### #### ###.

* DATA gv_n     TYPE n LENGTH 8.   " N: ##### #### '##'(Numeric Text). ### #### '00012345'## ## 0## ## # #####.

*



*&---------------------------------------------------------------------*

*& 1. ### ## (FIND)

*&---------------------------------------------------------------------*

*DATA : text1 TYPE string,      " text1 ### ### ## ## ### ## ##

* text2(4) TYPE c.        " text2 ## ### ## 4## ## ## ## ## ##

*

*text1 = 'ABAP'.                " text1 ### 'ABAP'### ## ##

*text2 = 'B'.                   " text2 ### 'B'## ## ##

*

*FIND text2 IN text1.           " text1('ABAP') ### text2('B')# ####.

*

*IF sy-subrc = 0.               " ## ####(sy-subrc ### ### 0## ##), ## ### #####.

*ENDIF.

* WRITE text2.                 " text2 ### #('B')# ### #####.

*




"*---------------------------------------------------------------------*

"* ### #####? (Where is this used?) #

"* `FIND` ### ## #### ### ### #### ### ### # ## #####.

"* ## ##, #### ### ### ### '@' ### ### #### ###,

"* ## ## ### '\' ### ### ## #### ### ## # ######.

"*---------------------------------------------------------------------*








*&---------------------------------------------------------------------*

*& 2. ### ## (REPLACE)

*&---------------------------------------------------------------------*

*DATA : text1 TYPE string,      " text1 ### ### ## ## ### ## ##

* text2(10) TYPE c,      " text2 ## ### ## 10## ## ## ## ## ##

* text3(10) TYPE c.      " text3 ## ### ## 10## ## ## ## ## ##

*

*text1 = 'ABAP'.                " text1 ### 'ABAP' ## ## (## ##)

*text2 = 'BBbP'.                " text2 ### 'BBbP' ## ## (## ##)

*text3 = 'AAPP ABAP'.           " text3 ### 'AAPP ABAP' ## ## (## ##)

*

*REPLACE text1 IN text3 WITH text2. " text3 ### text1('ABAP')# ## text2('BBbP')# ####.

*WRITE : text3.                 " ### ## text3# ## #('AAPP BBbP')# #####.

*




"*---------------------------------------------------------------------*

"* ### #####? (Where is this used?) #

"* `REPLACE`# ## ### ## ### ## ### # ## #####.

"* ## ##, ### ## #### '###'## ### ## '###'# ####,

"* ### ## ### ### ### ## ##### ##### ## # #####.

"*---------------------------------------------------------------------*








*&---------------------------------------------------------------------*

*& 3. #### ## (TRANSLATE)

*&---------------------------------------------------------------------*

*DATA : text1 TYPE string,      " text1 ### ### ## ## ### ## ##

* text2(4) TYPE c.        " text2 ## ### ## 4## ## ## ## ## ##

*

*text1 = 'ABAP'.                " text1 ### ### 'ABAP'# ##

*text2 = 'abap'.                " text2 ### ### 'abap'# ##

*

*TRANSLATE text1 TO LOWER CASE. " text1 ### ### ## #### #####. ('ABAP' -> 'abap')

*TRANSLATE text2 TO UPPER CASE. " text2 ### ### ## #### #####. ('abap' -> 'ABAP')

*

*WRITE : text1.                 " #### ## text1('abap')# #####.

*WRITE : / text2.               " ## ###, #### ## text2('ABAP')# #####.

*




"*---------------------------------------------------------------------*

"* ### #####? (Where is this used?) #

"* #### #### ## ## ### #### ####### ### ### ####

"* #### # # ## #####. ### #### DB ### ## #### ####

"* ####, #### #### ## # ## ## ### ### # ####.








*&---------------------------------------------------------------------*

*& 4. ### ## ## (SHIFT)

*&---------------------------------------------------------------------*

*DATA : text1 TYPE string,      " text1 ### ### ## ## ### ## ##

* text2(5) TYPE c.        " text2 ## ### ## 5## ## ## ## ## ##

*

*text1 = ' ABAP'.               " text1 ### ## ### ## ' ABAP'# ##

*text2 = ' ABAP'.               " text2 #### #### ' ABAP'# ##

*

*SHIFT text1.                   " text1# # # ### ## #### #### #### ####.

*WRITE : text1.                 " ### ### text1('ABAP')# #####.

*WRITE :/ text2.                " ## ###, ## ### ### text2(' ABAP')# #####.

*




"*---------------------------------------------------------------------*

"* ### #####? (Where is this used?) #

"* SAP ###### ### ### '000123'## ## '0'# ### #### ### ####.

"* # #### ## ##### ## #, `SHIFT ... DELETING LEADING '0'` ### ####

"* ## ## #### '0'## #### ### # ####.

"*---------------------------------------------------------------------*








*&---------------------------------------------------------------------*

*& 5. ### #### (OVERLAY)

*&---------------------------------------------------------------------*

*DATA : text1 TYPE string,      " text1 ### ### ## ## ### ## ##

* text2(8) TYPE c.        " text2 ## ### ## 8## ## ## ## ## ##

*

*text1 = ' B P'.                " text1# ### ### ' B P'# ## (## ##)

*text2 = 'AAAA'.                " text2# 'AAAA'# ## (### ##)

*

*OVERLAY text1 WITH text2.      " text1# ## #### text2# ### #### #####.

*

*WRITE : text1.                 " ## ##('ABAP')# #####.

*WRITE :/ text2.                " ## ## ### text2('AAAA')# #####.

*




"*---------------------------------------------------------------------*

"* ### #####? (Where is this used?) #

"* ####### ######### '______-_______' # ## ### ##(Mask)# ## #,

"* ### ### ###(-)# ### ## ## #### ## ## ####

"* ## ### ## # ### # ####.

"*---------------------------------------------------------------------*








*&---------------------------------------------------------------------*

*& 6. ### ### (CONCATENATE)

*&---------------------------------------------------------------------*

*DATA  : text1 TYPE string,      " text1 ### ### ## ## ### ## ##

* text2(4) TYPE c,        " text2 ## ### ## 4## ## ## ## ## ##

* text3(4) TYPE c.        " text3 ## ### ## 4## ## ## ## ## ##

*

*text1 = 'AB'.                  " text1# 'AB'# ##

*text2 = 'AP'.                  " text2# 'AP'# ##

*

*CONCATENATE text1 text2 INTO text3. " text1# text2# ###('ABAP') text3# #####.

*

*WRITE : text1.                 " text1('AB')# #####.

*WRITE : / text2.               " # ### text2('AP')# #####.

*WRITE : / text3.               " # ### ### ### text3('ABAP')# #####.

*




"*---------------------------------------------------------------------*

"* ### #####? (Where is this used?) #

"* ####### '#' ### '##' ### ## ####,

"* #### '###'## ### '##'## ### ### # ## #### #####.

"*---------------------------------------------------------------------*








*&---------------------------------------------------------------------*

*& 7. ### ### (SPLIT)

*&---------------------------------------------------------------------*

*DATA : text1 TYPE string,      " text1 ### ### ## ## ### ## ##

* text2(4) TYPE c,        " text2 ## ### ## 4## ## ## ## ## ##

* text3(4) TYPE c.        " text3 ## ### ## 4## ## ## ## ## ##

*

*text1 = 'AB+AP'.               " text1# '+'# ### 'AB+AP'# ##

*SPLIT text1 AT '+' INTO text2 text3. " text1# '+' #### ##, #### text2, #### text3# #####.

*

*WRITE : text1.                 " ### text1('AB+AP')# #####.

*WRITE : / text2.               " #### text2('AB')# #####.

*WRITE : / text3.               " #### text3('AP')# #####.

*




"*---------------------------------------------------------------------*

"* ### #####? (Where is this used?) #

"* '###-###-###'## ##### ### ## #####

"* '###', '###', '###'# ## ## #### ### ### # # #####.

"*---------------------------------------------------------------------*








*&---------------------------------------------------------------------*

*& 8. ####

*&---------------------------------------------------------------------*

*DATA : gv_num1 TYPE i VALUE 5,      " ### ## gv_num1# #### # 5# ##

* gv_num2 TYPE i VALUE 3,      " ### ## gv_num2# #### # 3# ##

* gv_num3 TYPE i.              " ### ## gv_num3# ### ### ## ##

*

*gv_num3 = gv_num1 + gv_num2.   " 5 + 3 # ##(8)# gv_num3# ##

*WRITE : gv_num3.               " 8# ##

*

*gv_num3 = gv_num1 - gv_num2.   " 5 - 3 # ##(2)# gv_num3# ##

*WRITE :/ gv_num3.              " # ### 2# ##

*

*gv_num3 = gv_num1 / gv_num2.   " 5 / 3 # ##(1.66...)# P### #### ##### gv_num3# ## (2)

*WRITE : / gv_num3.             " # ### 2# ##

*

*gv_num3 = gv_num1 * gv_num2.   " 5 * 3 # ##(15)# gv_num3# ##

*WRITE : / gv_num3.             " # ### 15# ##

*

*gv_num3 = gv_num1 DIV gv_num2. " 5 ### 3# ## #(1)# gv_num3# ##

*WRITE : / gv_num3.             " # ### 1# ##

*

*gv_num3 = gv_num1 MOD gv_num2. " 5 ### 3# ###(2)# gv_num3# ##

*WRITE : / gv_num3.             " # ### 2# ##

*

*gv_num3 = gv_num1 ** gv_num2.  " 5# 3##(125)# ### gv_num3# ##

*WRITE : / gv_num3.             " # ### 125# ##

*




"*---------------------------------------------------------------------*

"* ### #####? (Where is this used?) #

"* ## ## ### #####. ### '##'# '##'# ### '###'# #####,

"* ## #### ### ### ## '## ##'# ### # ## ## ##### ### ####.

"*---------------------------------------------------------------------*








*&---------------------------------------------------------------------*

*& 9. ## ## ## (TYPES)

*&---------------------------------------------------------------------*

*TYPES t_hello(20) TYPE c.      " t_hello## ### '20## ##' ### ## #####.

*

*DATA gv_text1 TYPE t_hello.     " ### ## t_hello #### gv_text1 ### #####.

*DATA gv_text2 LIKE gv_text1.    " gv_text1 ### ### #### gv_text2 ### #####.

*

*gv_text1 = '#####'.         " gv_text1# ## #####.

*gv_text2 = '#####'.         " gv_text2# ## #####.

*

*WRITE : gv_text1.              " '#####'# #####.

*WRITE : / gv_text2.            " # ### '#####'# #####.

*




"*---------------------------------------------------------------------*

"* ### #####? (Where is this used?) #

"* #### ### ## ### ### ### ### ##### ## # #####.

"* ## ##, '####' ### ## `TYPES T_POSTCODE(5) TYPE C.`# #####,

"* ### ## ####, ## ## #### ### ### # ### #### ## ## # ####.

"*---------------------------------------------------------------------*








*&---------------------------------------------------------------------*

*& 10. ## ### ## ## (TYPES BEGIN OF)

*&---------------------------------------------------------------------*

*TYPES : BEGIN OF t_zedt00,      " t_zedt00 ### ### ### ### ## ##

* zcode  TYPE c LENGTH 10,      " ## ##

* zkname TYPE c LENGTH 20,      " #### ##

* zename TYPE c LENGTH 20,      " #### ##

*END OF t_zedt00.               " ### ## ## #

*

*DATA : gs_zedt00 TYPE t_zedt00. " ### ### t_zedt00 #### gs_zedt00 ### ### ##

*

*gs_zedt00-zcode = 'SSU-01'.    " ### ### ## ### ## ##

*gs_zedt00-zkname = '###'.   " ### ### #### ### ## ##

*gs_zedt00-zename = 'DONG'.     " ### ### #### ### ## ##

*

*WRITE : / gs_zedt00-zcode.     " ## ### ## ##

*WRITE : / gs_zedt00-zkname.   " #### ### ## ##

*WRITE : / gs_zedt00-zename.   " #### ### ## ##

*




"*---------------------------------------------------------------------*

"* ### #####? (Where is this used?) #

"* ## ## #### ### ##(###)## ### ## # #####.

"* ######## ### '## ##' # #(##, ##, ## #)# #####,

"* ### ## ## #### ### ### ### # ## #####.

"*---------------------------------------------------------------------*








*&---------------------------------------------------------------------*

*& 11. Nested(##) ### ## ##

*&---------------------------------------------------------------------*

*TYPES : BEGIN OF t_zedt00,      " t_zedt00 (## ## ##) ### ### ##

* zcode  TYPE c LENGTH 10,

* zkname TYPE c LENGTH 20,

* zename TYPE c LENGTH 20,

*END OF t_zedt00.

*

*TYPES : BEGIN OF t_zedt00_2.   " t_zedt00_2 (## ## ##) ### ### ## ##

* INCLUDE TYPE t_zedt00.        " ### ## t_zedt00 #### ### ######.

* title  TYPE c LENGTH 10,      " ## ### ## (TYPES: # ## ## ####)

* grade  TYPE c LENGTH 1,      " ## ### ##

*END OF t_zedt00_2.             " ### ## ## #

*

*DATA : gs_zedt00 TYPE t_zedt00_2. " ### t_zedt00_2 #### ### ### ##

*

*gs_zedt00-zcode = 'SSU-01'.    " ## ## ### # ##

*gs_zedt00-zkname = '###'.   " ## ## ### # ##

*gs_zedt00-zename = 'DONG'.     " ## ## ### # ##

*gs_zedt00-title = '####'.   " ## ## ### # ##

*gs_zedt00-grade = '3'.         " ## ## ### # ##

*

*WRITE : / gs_zedt00-zcode.     " ## ### ## ##

*WRITE : / gs_zedt00-zkname.

*WRITE : / gs_zedt00-zename.

*WRITE : / gs_zedt00-title.

*WRITE : / gs_zedt00-grade.

*




"*---------------------------------------------------------------------*

"* ### #####? (Where is this used?) #

"* ## ###### ##### #### '## ##' #### ## #, ## #######

"* # ## ### # ## ### # #### #### ## # #####.

"* ## ### #### `INCLUDE`# ## #### ##### ##### ## ######.

"*---------------------------------------------------------------------*








*&---------------------------------------------------------------------*

*& 12. ### ## ## ## (DATA BEGIN OF)

*&---------------------------------------------------------------------*

*DATA : BEGIN OF gs_zedt00,      " gs_zedt00 ### ### ### ### ## ## ##

*  zcode  TYPE c LENGTH 10,      " ## ##

*  zkname TYPE c LENGTH 20,      " #### ##

*  zename TYPE c LENGTH 20,      " #### ##

*END OF gs_zedt00.              " ### ## ## #

*

*gs_zedt00-zcode = 'SSU-01'.    " ### ### ## ### ## ##

*gs_zedt00-zkname = '###'.   " ### ### #### ### ## ##

*gs_zedt00-zename = 'DONG'.     " ### ### #### ### ## ##

*

*WRITE : / gs_zedt00-zcode.     " ## ### ## ##

*WRITE : / gs_zedt00-zkname.   " #### ### ## ##

*WRITE : / gs_zedt00-zename.   " #### ### ## ##

*




"*---------------------------------------------------------------------*

"* ### #####? (Where is this used?) #

"* `TYPES`# ### ## ### ## ##, ## ###### # # ## ###

"* ### ### ### ### ## # #####. ### ##### ### ####.

"*---------------------------------------------------------------------*






*&---------------------------------------------------------------------*

*& ## ##: ### ## ##

*&---------------------------------------------------------------------*

*

* 1. FIND: ## ### ## ## ## ### ### **##**###.

* - **[## #####]** `FIND [## ##] IN [## ##].`

* `IN` ## ## ## ### '## ##'# ### ####, ### ### ## `sy-subrc`# #####. (0## ##)

*

*

* 2. REPLACE: ## ### ## ## ### ## ### **##**###.

* - **[## #####]** `REPLACE [## ##] IN [## ##] WITH [# ##].`

* `IN` ## ## ## ### '## ##'# #### '# ##'## ###, `IN` ## ## ## ## #####.

*

*

* 3. TRANSLATE: ### ### **### ## ###**# ## #####.

* - **[## #####]** `TRANSLATE [## ##] TO UPPER CASE.` ## `TO LOWER CASE.`

* `TO` ## ### CASE# '## ##' ### ## ### #####.

*

*

* 4. SHIFT: ### # ## **#### ## ##**# #####.

* - **[## #####]** `SHIFT [## ##].` (##: # # ## 1# ##)

* `SHIFT [## ##] LEFT DELETING LEADING '0'.` # ## `DELETING LEADING` ### ## # ##### #### ## ### ## ### # ####.

*

*

* 5. OVERLAY: # #### **##(space) ####** ## #### ### #####.

* - **[## #####]** `OVERLAY [## ##] WITH [### ##].`

* '## ##' ### ### ## ## ### ##, ### ### '### ##'# ### #### ## ####.

*

*

* 6. CONCATENATE: ## #### #### **### ####.**

* - **[## #####]** `CONCATENATE [##1] [##2] ... INTO [## ##].`

* ## ### ### #### ## ## ## ### `INTO` ## ## '## ##'# #####.

*

*

* 7. SPLIT: ### #### ## ## #### **## #### ####.**

* - **[## #####]** `SPLIT [## ##] AT [## ##] INTO [## ##1] [## ##2] ... .`

* `AT` ## '## ##'# #### '## ##'# ##, `INTO` ## #### #### ### ####.

*

*

* 8. TYPES: #### ### ### **### ### ##(###)**# ## #####.

* - **[## #####]** `TYPES [## ##](##) TYPE [## ##].` (## ##)

* `TYPES: BEGIN OF [### ## ##], ... END OF [### ## ##].` (### ##)

* `DATA` ## # #### # ## ### '#'# ####.

*

*

* 9. DATA BEGIN OF: ### ## ## ## ##, **### ##(##)**# ## #####.

* - **[## #####]** `DATA: BEGIN OF [### ## ##], ... END OF [### ## ##].`

* `TYPES` ## ##, ## ####### ### ### '##'# ## ### # #####.







*DATA : BEGIN OF GS_NAME,

*  NAME1 TYPE C LENGTH 10,

*  NAME2 TYPE C LENGTH 10,

*  END OF GS_NAME.

*

*GS_NAME-NAME1 = '###'.

*GS_NAME-NAME2 = '##'.

*

*MOVE GS_NAME-NAME2 TO GS_NAME-NAME1.

*

*WRITE : GS_NAME-NAME1.

*WRITE : / GS_NAME-NAME2.





*DATA : GV_DATA1(8) VALUE 'ABCDEFGH',

*        GV_DATA2(8).

*

*MOVE GV_DATA1+2(3) TO GV_DATA2.

*

*WRITE / GV_DATA2.





*DATA : BEGIN OF GS_NAME,

*  NAME1 TYPE C LENGTH 10,

*  DEGREE1 TYPE P DECIMALS 2,

*  END OF GS_NAME.

*

*GS_NAME-NAME1 = '##'.

*GS_NAME-DEGREE1 = '35.12'.

*

*MOVE GS_NAME-DEGREE1 TO GS_NAME-NAME1.

*

*CONDENSE GS_NAME-NAME1 NO-GAPS.

*

*WRITE : GS_NAME-NAME1.

*WRITE : / GS_NAME-DEGREE1.



*DATA : TEXT1(8) TYPE C,

*      TEXT2(8) TYPE C.

*

*TEXT1 = 'AB     AP'.

*TEXT2 = 'AB  AP'.

*

*CONDENSE TEXT1.

*CONDENSE TEXT2 NO-GAPS.

*

*WRITE / TEXT1.

*WRITE / TEXT2.





*DATA : GV_DATA1(8) VALUE 'ABCDEFGH',

*      GV_DATA2(8).

*DATA : GV_START TYPE I VALUE 2,

*      GV_LENGTH TYPE I VALUE 4.

*

*MOVE GV_DATA1+2(3) TO GV_DATA2.

*WRITE : / GV_DATA2.





*DATA : GV_DATA1(8) VALUE 'ABCDEFGH',

*      GV_DATA2(8).

*

*DATA : GV_START TYPE I VALUE 2,

*      GV_LENGTH TYPE I VALUE 4.

*

*MOVE GV_DATA1+GV_START(GV_LENGTH) TO GV_DATA2.

*WRITE / GV_DATA2.





*DATA : BEGIN OF GS_NAME,

*  NAME1 TYPE C LENGTH 10,

*  NAME2 TYPE C LENGTH 10,

*  END OF GS_NAME.

*

*GS_NAME-NAME1 = '###'.

*GS_NAME-NAME2 = '##'.

*

*WRITE GS_NAME-NAME2 TO GS_NAME-NAME1.

*

*WRITE : GS_NAME-NAME1.





*

*DATA : BEGIN OF GS_ZEDT00,

*  ZCODE TYPE ZEDT00_001-ZCODE,

*  ZKNAME TYPE ZEDT00_001-ZKNAME,

*  ZENAME TYPE ZEDT00_001-ZENAME,

*  ZGENDER TYPE ZEDT00_001-ZGENDER,

*  ZTEL TYPE ZEDT00_001-ZTEL,

*  END OF GS_ZEDT00.

*

*DATA : BEGIN OF GS_ZEDT00_2,

*  ZCODE TYPE ZEDT00_001-ZCODE,

*  ZKNAME TYPE ZEDT00_001-ZKNAME,

*  ZENAME TYPE ZEDT00_001-ZENAME,

*  ZGENDER TYPE ZEDT00_001-ZGENDER,

*  ZTEL TYPE ZEDT00_001-ZGENDER,

*  END OF GS_ZEDT00_2.

*

*GS_ZEDT00-ZCODE = 'SSU-01'.

*GS_ZEDT00-ZKNAME = '###'.

*GS_ZEDT00-ZENAME = 'DONG'.

*GS_ZEDT00-ZTEL = '01011112222'.

*

*MOVE-CORRESPONDING GS_ZEDT00 TO GS_ZEDT00_2.

*

*WRITE : / GS_ZEDT00_2-ZCODE.

*WRITE : / GS_ZEDT00_2-ZKNAME.

*WRITE : / GS_ZEDT00_2-ZENAME.





*DATA : BEGIN OF GS_ZEDT00,

*  ZCODE TYPE ZEDT00_001-ZCODE,

*  ZKNAME TYPE ZEDT00_001-ZKNAME,

*  ZENAME TYPE ZEDT00_001-ZENAME,

*  ZGENDER TYPE ZEDT00_001-ZGENDER,

*  ZTEL TYPE ZEDT00_001-ZTEL,

*  END OF GS_ZEDT00.

*

*DATA : BEGIN OF GS_ZEDT00_2,

*  ZGENDER TYPE ZEDT00_001-ZGENDER,

*  ZCODE TYPE ZEDT00_001-ZCODE,

*  ZKNAME TYPE ZEDT00_001-ZKNAME,

*  ZENAME TYPE ZEDT00_001-ZENAME,

*  ZTEL TYPE ZEDT00_001-ZTEL,

*  END OF GS_ZEDT00_2.

*

* GS_ZEDT00-ZCODE = 'SSU-01'.

*  GS_ZEDT00-ZKNAME = '###'.

*  GS_ZEDT00-ZENAME = 'DONG'.

*  GS_ZEDT00-ZGENDER = 'M'.

*  GS_ZEDT00-ZTEL = '01011112222'.

*

*  MOVE-CORRESPONDING GS_ZEDT00 TO GS_ZEDT00_2.

*

*  WRITE : / GS_ZEDT00_2-ZCODE.

*  WRITE : / GS_ZEDT00_2-ZKNAME.

*  WRITE : / GS_ZEDT00_2-ZENAME.

*  WRITE : / GS_ZEDT00_2-ZGENDER.

*  WRITE : / GS_ZEDT00_2-ZTEL.



*DATA : BEGIN OF GS_ZEDT00,

*  ZCODE TYPE ZEDT00_001-ZCODE,

*  ZKNAME TYPE ZEDT00_001-ZKNAME,

*  ZENAME TYPE ZEDT00_001-ZENAME,

*  ZGENDER TYPE ZEDT00_001-ZGENDER,

*  ZTEL TYPE ZEDT00_001-ZTEL,

*  END OF GS_ZEDT00.

*

*

*DATA : BEGIN OF GS_ZEDT00_2,

*  ZZCODE TYPE ZEDT00_001-ZCODE,

*  ZZKNAME TYPE ZEDT00_001-ZKNAME,

*  ZZENAME TYPE ZEDT00_001-ZENAME,

*  ZZGENDER TYPE ZEDT00_001-ZGENDER,

*  ZZTEL TYPE ZEDT00_001-ZTEL,

*  END OF GS_ZEDT00_2.

*

*  GS_ZEDT00-ZCODE = 'SSU-01'.

*  GS_ZEDT00-ZKNAME = '###'.

*  GS_ZEDT00-ZENAME = 'DONG'.

*  GS_ZEDT00-ZGENDER = 'M'.

*  GS_ZEDT00-ZTEL = '01011112222'.

*

*

* MOVE-CORRESPONDING GS_ZEDT00 TO GS_ZEDT00_2.

*

*  WRITE : / GS_ZEDT00_2-ZZCODE.

*  WRITE : / GS_ZEDT00_2-ZZKNAME.

*  WRITE : / GS_ZEDT00_2-ZZENAME.

*  WRITE : / GS_ZEDT00_2-ZZGENDER.

*  WRITE : / GS_ZEDT00_2-ZZTEL.







**CONSTANTS : BEGIN OF C_STUDENT,

**  ZCODE(10) VALUE 'SSU-01',

**  ZKNAME(10) VALUE '###',

**  ZENAME(10) VALUE 'DONG',

**  END OF C_STUDENT.

**

**  WRITE : / C_STUDENT-ZCODE.

**  WRITE : / C_STUDENT-ZENAME.

**  WRITE : / C_STUDENT-ZKNAME.

*

*

*





*CONSTANTS : C_NUM1 TYPE N LENGTH 2 VALUE '10'.

*DATA : NUM1 TYPE C LENGTH 3 VALUE '10'.

*

*NUM1 = NUM1 + '91':.

*

*WRITE :/ C_NUM1.

*WRITE :/ NUM1.



*

*

*STATICS LV_NUM TYPE I.

*LV_NUM = LV_NUM + 1.

*WRITE l /





*TABLES : ZEDT00_001.

*SELECT SINGLE * FROM ZEDT00_001.

*

*  WRITE : / ZEDT00_001-ZCODE.

*  WRITE : / ZEDT00_001-ZKNAME.

*  WRITE : / ZEDT00_001-ZENAME.

*  WRITE : / ZEDT00_001-ZGENDER.

*  WRITE : / ZEDT00_001-ZTEL.





*DATA : GS_ZEDT00 TYPE ZEDT00_001.

*

*  GS_ZEDT00-ZCODE = 'SSU-01'.

*  GS_ZEDT00-ZKNAME = '###'.

*  GS_ZEDT00-ZENAME = 'DONG'.

*  GS_ZEDT00-ZGENDER = 'M'.

*  GS_ZEDT00-ZTEL = '01011112222'.

*

*  WRITE : / GS_ZEDT00-ZCODE.

*  WRITE : / GS_ZEDT00-ZKNAME.

*  WRITE : / GS_ZEDT00-ZENAME.

*  WRITE : / GS_ZEDT00-ZGENDER.

*  WRITE : / GS_ZEDT00-ZTEL.





*DATA : BEGIN OF GS_ZEDT00,

*  ZCODE TYPE ZEDT00_001-ZCODE,

*  ZKNAME TYPE ZEDT00_001-ZKNAME,

*  ZENAME TYPE ZEDT00_001-ZENAME,

*  ZGENDER TYPE ZEDT00_001-ZGENDER,

*  ZTEL TYPE ZEDT00_001-ZTEL,

*  END OF GS_ZEDT00.

*

*  GS_ZEDT00-ZCODE = 'SSU-01'.

*  GS_ZEDT00-ZKNAME = '###'.

*  GS_ZEDT00-ZENAME = 'DONG'.

*  GS_ZEDT00-ZGENDER = 'M'.

*  GS_ZEDT00-ZTEL = '01011112222'.

*  WRITE : / GS_ZEDT00-ZCODE.

*  WRITE : / GS_ZEDT00-ZKNAME.

*  WRITE : / GS_ZEDT00-ZENAME.

*  WRITE : / GS_ZEDT00-ZGENDER.

*  WRITE : / GS_ZEDT00-ZTEL.







*DATA : BEGIN OF GS_ZEDT00,

*  ZCODE TYPE ZCODE00,

*  ZKNAME TYPE ZKNAME00,

*  ZENAME TYPE ZENAME00,

*  ZGENDER TYPE ZGENDER00,

*  ZTEL TYPE ZTEL00,

*  END OF GS_ZEDT00.

*

*

*  GS_ZEDT00-ZCODE = 'SSU-01'.

*  GS_ZEDT00-ZKNAME = '###'.

*  GS_ZEDT00-ZENAME = 'DONG'.

*  GS_ZEDT00-ZGENDER = 'M'.

*  GS_ZEDT00-ZTEL = '01011112222'.

*

*

*  WRITE : / GS_ZEDT00-ZCODE.

*  WRITE : / GS_ZEDT00-ZKNAME.

*  WRITE : / GS_ZEDT00-ZENAME.

*  WRITE : / GS_ZEDT00-ZGENDER.

*  WRITE : / GS_ZEDT00-ZTEL.





*DATA : GS_ZEDG00 TYPE ZTG00_ZED00.

*DATA : GV_ZTITLE TYPE ZTG00_ZTITLE.

*

*GS_ZEDG00-ZCODE = 'SSU-01'.

*GS_ZEDG00-ZKNAME = '###'.

*GS_ZEDG00-ZENAME = 'DONG'.

*GS_ZEDG00-ZGENDER = 'M'.

*GS_ZEDG00-ZTEL = '01011112222'.

*GV_ZTITLE = '####'.

*

*WRITE : / GS_ZEDG00-ZCODE.

*WRITE : / GS_ZEDG00-ZKNAME.

*WRITE : / GS_ZEDG00-ZENAME.

*WRITE : / GS_ZEDG00-ZGENDER.

*WRITE : / GS_ZEDG00-ZTEL.

*WRITE : / GV_ZTITLE.







*DATA : GV_ZCODE TYPE ZCODE00.

*DATA : GV_ZCODE2 TYPE ZEDT00_001-ZCODE.

*

*DATA : GS_ZEDT00 TYPE ZEDT00_001.

*

*DATA : GT_ZEDT00 TYPE TABLE OF ZEDT00_001.

*

*

*WRITE







*TYPES : BEGIN OF GS_USER,

*  NAME TYPE C LENGTH 10,

*  AGE TYPE I,

*  CITY TYPE C LENGTH 20,

*  END OF GS_USER.

*

*

*  DATA : GV_DATA TYPE STRING VALUE ' ### , 30, ##'.

*

*

*  DATA

*

*  SPLIT GV_DATA AT '







*DATA: GV_USER_INFO TYPE STRING VALUE 'USER01/HONG GILDONG/SEOUL'.

*

*

*TYPES :  BEGIN OF T_USER,

*  ID TYPE C LENGTH 10,

*  NAME TYPE C LENGTH 20,

*  CITY TYPE C LENGTH 20,

*  END OF T_USER.

*

*  DATA : GS_USER TYPE T_USER.

*

*  SPLIT GV_USER_INFO AT '/' INTO GS_USER-ID GS_USER-NAME GS_USER-CITY.

*

*

*  WRITE GS_USER-ID.

*  WRITE / GS_USER-NAME.

*  WRITE / GS_USER-CITY.





*

*DATA : GV_PRICE TYPE P DECIMALS 2 VALUE '99.99',

*      GV_TEXT_PRICE(10) TYPE C.

*MOVE GV_PRICE TO GV_TEXT_PRICE.

*

*FIND '.' IN GV_TEXT_PRICE.

*

*IF SY-SUBRC = 0.

*  WRITE '#####'.

*ELSE.

*  WRITE '### ###'.

*ENDIF.



*TABLES : SCARR.

*

*SELECT SINGLE CARRNAME

*  INTO SCARR-CARRNAME

*  FROM SCARR

*  WHERE CARRID = 'AA'.

*

*

*IF SY-SUBRC = 0.

*  WRITE: SCARR-CARRNAME.

*ENDIF.



*

*DATA : GV_NAME(10) TYPE C VALUE '###',

*      GV_DEPT(10) TYPE C VALUE '###',

*      GV_POS(10) TYPE C VALUE '##',

*      GV_RESULT TYPE STRING.

*

*

*GV_RESULT = |[{ GV_DEPT }] { GV_NAME }({ GV_POS })|.

*

*WRITE: GV_RESULT.





*DATA GS_ZEDT00 TYPE ZEDT00_001.

*DATA : GT_ZEDT00 TYPE TABLE OF ZEDT00_001.

*

*GS_ZEDT00-ZCODE = 'SSU-01'.

*GS_ZEDT00-ZPERNR = '0000000001'.

*GS_ZEDT00-ZKNAME = '###'.

*GS_ZEDT00-ZENAME = 'DONG'.

*GS_ZEDT00-ZGENDER = 'M'.

*GS_ZEDT00-ZTEL = '01011112222'.

*

*BREAK-POINT.

*

*APPEND GS_ZEDT00 TO GT_ZEDT00.





*DATA GS_ZEDT00 TYPE ZEDT00_001.

*DATA : GT_ZEDT00 TYPE TABLE OF ZEDT00_001.

*

*GS_ZEDT00-ZCODE = 'SSU-01'.

*GS_ZEDT00-ZPERNR = '0000000001'.

*GS_ZEDT00-ZKNAME = '###'.

*GS_ZEDT00-ZENAME = 'DONG'.

*GS_ZEDT00-ZGENDER = 'M'.

*GS_ZEDT00-ZTEL = '01011112222'.

*

*APPEND GS_ZEDT00 TO GT_ZEDT00.

*

*BREAK-POINT.







*DATA : GS_ZEDT00 TYPE ZEDT00_001.

*DATA : GT_ZEDT00 TYPE TABLE OF ZEDT00_001.

*

*

*GS_ZEDT00-ZCODE = 'SSU-01'.

*GS_ZEDT00-ZPERNR = '0000000001'.

*GS_ZEDT00-ZKNAME = '###'.

*GS_ZEDT00-ZENAME = 'DONG'.

*GS_ZEDT00-ZGENDER = 'M'.

*GS_ZEDT00-ZTEL = '01011112222'.

*

*APPEND GS_ZEDT00 TO GT_ZEDT00.

*

*GS_ZEDT00-ZCODE = 'SSU-02'.

*GS_ZEDT00-ZPERNR = '0000000001'.

*GS_ZEDT00-ZKNAME = '###'.

*GS_ZEDT00-ZENAME = 'DONG'.

*GS_ZEDT00-ZGENDER = 'M'.

*GS_ZEDT00-ZTEL = '01011112222'.

*

*APPEND GS_ZEDT00 TO GT_ZEDT00.

*

*

*BREAK-POINT.





*

*DATA : BEGIN OF GS_STUDENT,

*  ZPERNR TYPE ZEDT00_001-ZPERNR,

*  ZCODE TYPE ZEDT00_001-ZCODE,

*  ZKNAME TYPE ZEDT00_001-ZKNAME,

*  ZENAME TYPE ZEDT00_001-ZENAME,

*  ZGENDER TYPE ZEDT00_001-ZGENDER,

*  ZTEL TYPE ZEDT00_001-ZTEL,

*  ZMNAME TYPE ZEDT00_002-ZMNAME,

*  END OF GS_STUDENT.

*

* DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

*

* GS_STUDENT-ZCODE = 'SSU-00'.

* GS_STUDENT-ZPERNR = '0000000001'.

* GS_STUDENT-ZKNAME =  '###'.

* GS_STUDENT-ZENAME = 'DONG'.

* GS_STUDENT-ZGENDER = 'M'.

* GS_STUDENT-ZTEL = '01011112222'.

* GS_STUDENT-ZMNAME = '####'.

*

*

* APPEND GS_STUDENT TO GT_STUDENT.





*DATA : BEGIN OF GS_STUDENT,

*  ZCODE TYPE C LENGTH 10,

*  ZKNAME TYPE C LENGTH 10,

*  ZENAME TYPE C LENGTH 10,

*  ZCLASS TYPE C,

*  END OF GS_STUDENT.

*

* DATA : BEGIN OF GS_STUDENT2,

*  ZCODE TYPE C LENGTH 10,

*  ZKNAME TYPE C LENGTH 10,

*  ZENAME TYPE C LENGTH 10,

*  ZCLASS TYPE C,

*  END OF GS_STUDENT2.

*

*

*  DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

*  DATA : GT_STUDENT2 LIKE TABLE OF GS_STUDENT.

*

*  GS_STUDENT-ZCODE = 'SSU-01'.

*  GS_STUDENT-ZKNAME = '###'.

*  GS_STUDENT-ZENAME = 'DONG'.

*

*  GS_STUDENT2-ZCODE = 'SSU-01'.

*  GS_STUDENT2-ZKNAME = '###'.

*  GS_STUDENT2-ZENAME = 'DONG'.

*

* APPEND GS_STUDENT TO GT_STUDENT.

* APPEND GS_STUDENT TO GT_STUDENT2.

*

* BREAK-POINT.







*

*DATA : BEGIN OF GS_STUDENT,

*  ZCODE TYPE C LENGTH 10,

*  ZKNAME TYPE C LENGTH 10,

*  ZENAME TYPE C LENGTH 10,

*  END OF GS_STUDENT.

*

*

*  DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

*  DATA : GT_STUDENT2 LIKE TABLE OF GS_STUDENT.

*

*  GS_STUDENT-ZCODE = 'SSU-01'.

*  GS_STUDENT-ZKNAME = '###'.

*  GS_STUDENT-ZENAME = 'DONG'.

*

*

* APPEND GS_STUDENT TO GT_STUDENT.

*

* MOVE GT_STUDENT[] TO GT_STUDENT2[].

*

*

* BREAK-POINT.

















*DATA : BEGIN OF GT_STUDENT OCCURS 0,

*  ZCODE TYPE C LENGTH 10,

*  ZKNAME TYPE C LENGTH 10,

*  ZENAME TYPE C LENGTH 10,

*  END OF GT_STUDENT.

*

*DATA : BEGIN OF GT_STUDENT2 OCCURS 0,

*  ZCODE TYPE C LENGTH 10,

*  ZKNAME TYPE C LENGTH 10,

*  ZENAME TYPE C LENGTH 10,

*  END OF GT_STUDENT2.

*

*

*  GT_STUDENT-ZCODE = 'SSU-01'.

*  GT_STUDENT-ZKNAME = '###'.

*  GT_STUDENT-ZENAME = 'DONG'.

*

*

* APPEND GT_STUDENT TO GT_STUDENT.

*

* MOVE GT_STUDENT[] TO GT_STUDENT2[].

*

*

* BREAK-POINT.





*

*DATA : BEGIN OF GT_STUDENT OCCURS 0,

*  ZCODE TYPE C LENGTH 10,

*  ZKNAME TYPE C LENGTH 10,

*  ZENAME TYPE C LENGTH 10,

*  END OF GT_STUDENT.

*

*DATA : BEGIN OF GT_STUDENT2 OCCURS 0,

*  ZCLASS TYPE C,

*  ZCODE TYPE C LENGTH 10,

*  ZKNAME TYPE C LENGTH 10,

*  ZENAME TYPE C LENGTH 10,

*  END OF GT_STUDENT2.

*

*

*  GT_STUDENT-ZCODE = 'SSU-01'.

*  GT_STUDENT-ZKNAME = '###'.

*  GT_STUDENT-ZENAME = 'DONG'.

*

*

* APPEND GT_STUDENT.

*

* MOVE-CORRESPONDING GT_STUDENT TO GT_STUDENT2.

*

*APPEND GT_STUDENT2.

*

* BREAK-POINT.







*DATA : BEGIN OF GT_STUDENT OCCURS 0,

*  ZCODE TYPE C LENGTH 10,

*  ZKNAME TYPE C LENGTH 10,

*  ZENAME TYPE C LENGTH 10,

*  END OF GT_STUDENT.

*

*DATA : BEGIN OF GT_STUDENT2 OCCURS 0,

*  ZCLASS TYPE C,

*  ZCODE TYPE C LENGTH 10,

*  ZKNAME TYPE C LENGTH 10,

*  ZENAME TYPE C LENGTH 10,

*  END OF GT_STUDENT2.

*

*

*  GT_STUDENT-ZCODE = 'SSU-01'.

*  GT_STUDENT-ZKNAME = '###'.

*  GT_STUDENT-ZENAME = 'DONG'.

*

*

* APPEND GT_STUDENT.

*

* MOVE-CORRESPONDING GT_STUDENT[] TO GT_STUDENT2[].

*

* BREAK-POINT.









*DATA : BEGIN OF GS_STUDENT,

*  ZCODE TYPE C LENGTH 10,

*  ZKNAME TYPE C LENGTH 10,

*  ZENAME TYPE C LENGTH 10,

*  END OF GS_STUDENT.

*

*DATA GT_STUDENT LIKE TABLE OF GS_STUDENT.

*

*  GS_STUDENT-ZCODE = 'SSU-01'.

*  GS_STUDENT-ZKNAME = '###'.

*  GS_STUDENT-ZENAME = 'DONG'.

*

*

*APPEND GS_STUDENT TO GT_STUDENT.

*

*CLEAR : GS_STUDENT.

*

*BREAK-POINT.









*DATA : BEGIN OF GS_STUDENT,

*  ZCODE TYPE C LENGTH 10,

*  ZKNAME TYPE C LENGTH 10,

*  ZENAME TYPE C LENGTH 10,

*  END OF GS_STUDENT.

*

*DATA GT_STUDENT LIKE TABLE OF GS_STUDENT.

*

*GS_STUDENT-ZCODE = 'SSU-01'.

*GS_STUDENT-ZKNAME = '###'.

*GS_STUDENT-ZENAME = 'DONG'.

*

*APPEND GS_STUDENT TO GT_STUDENT.

*

*BREAK-POINT.

*

*CLEAR : GT_STUDENT.

*

*BREAK-POINT.





*

*DATA : BEGIN OF GT_STUDENT OCCURS 0,

*  ZCODE  TYPE C LENGTH 10,

*  ZKNAME  TYPE C LENGTH 10,

*  ZENAME TYPE C LENGTH 10,

*  END OF GT_STUDENT.

*

* GT_STUDENT-ZCODE = 'SSU-01'.

* GT_STUDENT-ZKNAME = '###'.

* GT_STUDENT-ZENAME = 'DONG'.

*

*APPEND GT_STUDENT.

*

*CLEAR : GT_STUDENT.

*

* BREAK-POINT.





*DATA : BEGIN OF GT_STUDENT OCCURS 0,

*  ZCODE TYPE C LENGTH 10,

*  ZKNAME TYPE C LENGTH 10,

*  ZENAME TYPE C LENGTH 10,

*  END OF GT_STUDENT.

*

* GT_STUDENT-ZCODE = 'SSU-01'.

* GT_STUDENT-ZKNAME = '###'.

* GT_STUDENT-ZENAME = 'DONG'.

*

*APPEND GT_STUDENT.

*

*BREAK-POINT.

*

*FREE : GT_STUDENT.

*

*BREAK-POINT.







*DATA: BEGIN OF GS_EMP,

*  EMP_ID TYPE C LENGTH 8,

*  EMP_NAME TYPE C LENGTH 10,

*  GRADE TYPE C LENGTH 1,

*  END OF GS_EMP.

*

* DATA : GT_EMPLOYEES LIKE TABLE OF GS_EMP.

* DATA : GT_EXCELLENT LIKE TABLE OF GS_EMP.

*

*CLEAR : GS_EMP.

*GS_EMP-EMP_ID = 'EMP-001'.

*GS_EMP-EMP_NAME = '###'.

*GS_EMP-GRADE = 'A'.

*

*APPEND GS_EMP TO GT_EMPLOYEES.

*

*CLEAR : GS_EMP.

*GS_EMP-EMP_ID    = 'EMP-002'.

*GS_EMP-EMP_NAME  = '###'.

*GS_EMP-GRADE     = 'C'.

*

*APPEND GS_EMP TO GT_EMPLOYEES.

*

*CLEAR : GS_EMP.

*GS_EMP-EMP_ID   = 'EMP-003'.

*GS_EMP-EMP_NAME = '###'.

*GS_EMP-GRADE    = 'B'.

*

*APPEND GS_EMP TO GT_EMPLOYEES.

*

*CLEAR : GS_EMP.

*GS_EMP-EMP_ID   = 'EMP-004'.

*GS_EMP-EMP_NAME = '###'.

*GS_EMP-GRADE    = 'A'.

*

*APPEND GS_EMP TO GT_EMPLOYEES.

*

*CLEAR : GS_EMP.

*GS_EMP-EMP_ID   = 'EMP-000'.

*GS_EMP-EMP_NAME = '###'.

*GS_EMP-GRADE    = 'A'.

*

*APPEND GS_EMP TO GT_EMPLOYEES.





*

*DATA : BEGIN OF GS_STUDENT,

*  ZCODE TYPE C LENGTH 10,

*  ZKNAME TYPE C LENGTH 10,

*  ZENAME TYPE C LENGTH 10,

*  END OF GS_STUDENT.

*

*

*  DATA : GT_STUDEN  LIKE TABLE OF GS_STUDENT.

*

* GS_STUDENT-ZCODE

* GS_STUDENT-ZKNAME

* GS_STUDENT-ZENAME

*

*

*

*

*

*





*

*DATA : BEGIN OF GS_STUDENT,

*  ZPERNR LIKE ZEDT00_001-ZPERNR,

*  ZCODE LIKE ZEDT00_001-ZCODE,

*  ZKNAME LIKE ZEDT00_001-ZKNAME,

*  ZENAME LIKE ZEDT00_001-ZENAME,

*  ZGENDER LIKE ZEDT00_001-ZGENDER,

*  ZTEL LIKE ZEDT00_001-ZTEL,

*  END OF GS_STUDENT.

*

* DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

*

* GS_STUDENT-ZPERNR = '0000000001'.

* GS_STUDENT-ZCODE = 'SSU-01'.

* GS_STUDENT-ZKNAME = '###'.

* GS_STUDENT-ZENAME = 'DONG'.

* GS_STUDENT-ZGENDER = 'M'.

* GS_STUDENT-ZTEL = '01011112222'.







*DATA : BEGIN OF GS_STUDENT,

*  ZCODE TYPE C LENGTH 10,

*  ZKNAME TYPE C LENGTH 10,

*  ZENAME TYPE C LENGTH 10,

*  END OF GS_STUDENT.

*

*

*  DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

*

*  GS_STUDENT-ZCODE = 'SSU-02'.

*  GS_STUDENT-ZKNAME = '###'.

*  GS_STUDENT-ZENAME = 'LEE'.

*  APPEND GS_STUDENT TO GT_STUDENT.

*

*  GS_STUDENT-ZCODE = 'SSU-01'.

*  GS_STUDENT-ZKNAME = '###'.

*  GS_STUDENT-ZENAME = 'DONG'.

*  APPEND GS_STUDENT TO GT_STUDENT.

*

*

*  GS_STUDENT-ZCODE = 'SSU-03'.

*  GS_STUDENT-ZKNAME = '###'.

*  GS_STUDENT-ZENAME = 'SONG'.

*  APPEND GS_STUDENT TO GT_STUDENT.

*  BREAK-POINT.

*

*  SORT GT_STUDENT.

*  BREAK-POINT.





*

*DATA : BEGIN OF GS_STUDENT,

*  ZCODE TYPE C LENGTH 10,

*  ZKNAME TYPE C LENGTH 10,

*  ZENAME TYPE C LENGTH 10,

*  END OF GS_STUDENT.

*

*

*  DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

*

*  GS_STUDENT-ZCODE = 'SSU-02'.

*  GS_STUDENT-ZKNAME = '###'.

*  GS_STUDENT-ZENAME = 'LEE'.

*  APPEND GS_STUDENT TO GT_STUDENT.

*

*  GS_STUDENT-ZCODE = 'SSU-01'.

*  GS_STUDENT-ZKNAME = '###'.

*  GS_STUDENT-ZENAME = 'DONG'.

*  APPEND GS_STUDENT TO GT_STUDENT.

*

*

*  GS_STUDENT-ZCODE = 'SSU-03'.

*  GS_STUDENT-ZKNAME = '###'.

*  GS_STUDENT-ZENAME = 'SONG'.

*  APPEND GS_STUDENT TO GT_STUDENT.

*  BREAK-POINT.

*

*  SORT GT_STUDENT DESCENDING.

*  BREAK-POINT.







*DATA : BEGIN OF GS_STUDENT,

*  ZCODE TYPE C LENGTH 10,

*  ZKNAME TYPE C LENGTH 10,

*  ZENAME TYPE C LENGTH 10,

*  END OF GS_STUDENT.

*

*

*  DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

*

*  GS_STUDENT-ZCODE = 'SSU-02'.

*  GS_STUDENT-ZKNAME = '###'.

*  GS_STUDENT-ZENAME = 'LEE'.

*  APPEND GS_STUDENT TO GT_STUDENT.

*

*  GS_STUDENT-ZCODE = 'SSU-01'.

*  GS_STUDENT-ZKNAME = '###'.

*  GS_STUDENT-ZENAME = 'DONG'.

*  APPEND GS_STUDENT TO GT_STUDENT.

*

*

*  GS_STUDENT-ZCODE = 'SSU-03'.

*  GS_STUDENT-ZKNAME = '###'.

*  GS_STUDENT-ZENAME = 'SONG'.

*  APPEND GS_STUDENT TO GT_STUDENT.

*  BREAK-POINT.

*

*  SORT GT_STUDENT BY ZKNAME.

*  BREAK-POINT.





*DATA : BEGIN OF GS_STUDENT,

*  ZCODE TYPE C LENGTH 10,

*  ZKNAME TYPE C LENGTH 10,

*  ZENAME TYPE C LENGTH 10,

*  END OF GS_STUDENT.

*

*

*  DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

*

*  GS_STUDENT-ZCODE = 'SSU-02'.

*  GS_STUDENT-ZKNAME = '###'.

*  GS_STUDENT-ZENAME = 'LEE'.

*  APPEND GS_STUDENT TO GT_STUDENT.

*

*  GS_STUDENT-ZCODE = 'SSU-01'.

*  GS_STUDENT-ZKNAME = '###'.

*  GS_STUDENT-ZENAME = 'DONG'.

*  APPEND GS_STUDENT TO GT_STUDENT.

*

*

*  GS_STUDENT-ZCODE = 'SSU-03'.

*  GS_STUDENT-ZKNAME = '###'.

*  GS_STUDENT-ZENAME = 'SONG'.

*  APPEND GS_STUDENT TO GT_STUDENT.

*  BREAK-POINT.

*

*  SORT GT_STUDENT BY ZKNAME DESCENDING.

*  BREAK-POINT.



*

*DATA : BEGIN OF GS_LINE,

*  COL1 TYPE C,

*  END OF GS_LINE.

*

*

* DATA : GT_LINE LIKE TABLE OF GS_LINE.

*

* DATA : GV_LINE TYPE I.

*

* GS_LINE-COL1 = SY-INDEX.

* APPEND GS_LINE TO GT_LINE.

*

* GS_LINE-COL1 = '2'.

* APPEND GS_LINE TO GT_LINE.

*

*

* GS_LINE-COL1 = '3'.

* APPEND GS_LINE TO GT_LINE.

*

*DESCRIBE TABLE GT_LINE LINES GV_LINE.

*

* WRITE : GV_LINE.









*DATA : BEGIN OF GS_STUDENT,

*  ZCODE TYPE C LENGTH 10,

*  ZKNAME TYPE C LENGTH 10,

*  ZENAME TYPE C LENGTH 10,

*  END OF GS_STUDENT.

*

*

*  DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

*

*CLEAR : GS_STUDENT.

*  GS_STUDENT-ZCODE = 'SSU-02'.

*  GS_STUDENT-ZKNAME = '###'.

*  GS_STUDENT-ZENAME = 'LEE'.

*  APPEND GS_STUDENT TO GT_STUDENT.

*

*CLEAR : GS_STUDENT.

*  GS_STUDENT-ZCODE = 'SSU-01'.

*  GS_STUDENT-ZKNAME = '###'.

*  GS_STUDENT-ZENAME = 'DONG'.

*  APPEND GS_STUDENT TO GT_STUDENT.

*

*

*CLEAR : GS_STUDENT.

*  GS_STUDENT-ZCODE = 'SSU-03'.

*  GS_STUDENT-ZKNAME = '###'.

*  GS_STUDENT-ZENAME = 'SONG'.

*  APPEND GS_STUDENT TO GT_STUDENT.

*

*  BREAK-POINT.





*

*DATA : BEGIN OF GS_STUDENT,

*  ZCODE TYPE C LENGTH 10,

*  ZKNAME TYPE C LENGTH 10,

*  ZENAME TYPE C LENGTH 10,

*  END OF GS_STUDENT.

*

*

*  DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

*

*CLEAR : GS_STUDENT.

*  GS_STUDENT-ZCODE = 'SSU-02'.

*  GS_STUDENT-ZKNAME = '###'.

*  GS_STUDENT-ZENAME = 'LEE'.

*  INSERT GS_STUDENT INTO TABLE GT_STUDENT.

*

*CLEAR : GS_STUDENT.

*  GS_STUDENT-ZCODE = 'SSU-01'.

*  GS_STUDENT-ZKNAME = '###'.

*  GS_STUDENT-ZENAME = 'DONG'.

*  INSERT GS_STUDENT INTO TABLE GT_STUDENT.

*

*

*CLEAR : GS_STUDENT.

*  GS_STUDENT-ZCODE = 'SSU-03'.

*  GS_STUDENT-ZKNAME = '###'.

*  GS_STUDENT-ZENAME = 'SONG'.

*  INSERT GS_STUDENT INTO TABLE GT_STUDENT.

*

*  BREAK-POINT.











*DATA : BEGIN OF GS_STUDENT,

*  ZCODE TYPE C LENGTH 10,

*  ZKNAME TYPE C LENGTH 10,

*  ZENAME TYPE C LENGTH 10,

*  END OF GS_STUDENT.

*

*

*  DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

*

*CLEAR : GS_STUDENT.

*  GS_STUDENT-ZCODE = 'SSU-02'.

*  GS_STUDENT-ZKNAME = '###'.

*  GS_STUDENT-ZENAME = 'LEE'.

*  INSERT GS_STUDENT INTO TABLE GT_STUDENT.

*

*CLEAR : GS_STUDENT.

*  GS_STUDENT-ZCODE = 'SSU-01'.

*  GS_STUDENT-ZKNAME = '###'.

*  GS_STUDENT-ZENAME = 'DONG'.

*  INSERT GS_STUDENT INTO TABLE GT_STUDENT.

*

*

*CLEAR : GS_STUDENT.

*  GS_STUDENT-ZCODE = 'SSU-03'.

*  GS_STUDENT-ZKNAME = '###'.

*  GS_STUDENT-ZENAME = 'SONG'.

*  INSERT GS_STUDENT INTO GT_STUDENT INDEX 2.

*

*  BREAK-POINT.





*

*DATA : BEGIN OF GS_STUDENT,

*  ZCODE TYPE C LENGTH 10,

*  ZKNAME TYPE C LENGTH 10,

*  ZENAME TYPE C LENGTH 10,

*  END OF GS_STUDENT.

*

*

*  DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

*

*CLEAR : GS_STUDENT.

*  GS_STUDENT-ZCODE = 'SSU-02'.

*  GS_STUDENT-ZKNAME = '###'.

*  GS_STUDENT-ZENAME = 'LEE'.

*  COLLECT GS_STUDENT INTO GT_STUDENT.

*

*CLEAR : GS_STUDENT.

*  GS_STUDENT-ZCODE = 'SSU-01'.

*  GS_STUDENT-ZKNAME = '###'.

*  GS_STUDENT-ZENAME = 'DONG'.

*  COLLECT GS_STUDENT INTO GT_STUDENT.

*

*

*CLEAR : GS_STUDENT.

*  GS_STUDENT-ZCODE = 'SSU-03'.

*  GS_STUDENT-ZKNAME = '###'.

*  GS_STUDENT-ZENAME = 'SONG'.

*    COLLECT GS_STUDENT INTO GT_STUDENT.

*

*  BREAK-POINT.









*

*DATA : BEGIN OF GS_STUDENT,

*  ZCODE TYPE C LENGTH 10,

*  ZKNAME TYPE C LENGTH 10,

*  ZENAME TYPE C LENGTH 10,

*  ZSUM TYPE I,

*  END OF GS_STUDENT.

*

*

*  DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

*

*CLEAR : GS_STUDENT.

*  GS_STUDENT-ZCODE = 'SSU-02'.

*  GS_STUDENT-ZKNAME = '###'.

*  GS_STUDENT-ZENAME = 'LEE'.

*  GS_STUDENT-ZSUM = '10000'.

*  COLLECT GS_STUDENT INTO GT_STUDENT.

*

*CLEAR : GS_STUDENT.

*  GS_STUDENT-ZCODE = 'SSU-02'.

*  GS_STUDENT-ZKNAME = '###'.

*  GS_STUDENT-ZENAME = 'LEEE'.

*  GS_STUDENT-ZSUM = '10000'.

*  COLLECT GS_STUDENT INTO GT_STUDENT.

*

*

*CLEAR : GS_STUDENT.

*  GS_STUDENT-ZCODE = 'SSU-03'.

*  GS_STUDENT-ZKNAME = '###'.

*  GS_STUDENT-ZENAME = 'SONG'.

*  GS_STUDENT-ZSUM = '10000'.

*    COLLECT GS_STUDENT INTO GT_STUDENT.

*

*    BREAK-POINT.







*DATA : BEGIN OF GS_STUDENT,

*  ZPERNR   LIKE ZEDT00_001-ZPERNR,

*  ZCODE    LIKE ZEDT00_001-ZCODE,

*  ZKNAME   LIKE ZEDT00_001-ZKNAME,

*  ZENAME   LIKE ZEDT00_001-ZENAME,

*  ZGENDER  LIKE ZEDT00_001-ZGENDER,

*  ZGNAME  TYPE C LENGTH 4,

*  ZTEL     LIKE ZEDT00_001-ZTEL,

*  END OF GS_STUDENT.

*

*  DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

*

*  CLEAR : GS_STUDENT, GT_STUDENT.

*

*  GS_STUDENT-ZPERNR     = '0000000001'.

*  GS_STUDENT-ZCODE     = 'SSU-01'.

*  GS_STUDENT-ZKNAME     = '###'.

*  GS_STUDENT-ZENAME     = 'DONG'.

*  GS_STUDENT-ZGENDER     = 'M'.

*  GS_STUDENT-ZTEL     = '01011112222'.

*

*

*  IF GS_STUDENT-ZGENDER = 'M'.

*    GS_STUDENT-ZGNAME = '##'.

*  ENDIF.

*

*  APPEND GS_STUDENT TO GT_STUDENT.

*

*  CLEAR : GS_STUDENT.

*

*

*  BREAK-POINT.



*DATA : BEGIN OF GS_STUDENT,

*  ZPERNR   LIKE ZEDT00_001-ZPERNR,

*  ZCODE    LIKE ZEDT00_001-ZCODE,

*  ZKNAME   LIKE ZEDT00_001-ZKNAME,

*  ZENAME   LIKE ZEDT00_001-ZENAME,

*  ZGENDER  LIKE ZEDT00_001-ZGENDER,

*  ZGNAME  TYPE C LENGTH 4,

*  ZTEL     LIKE ZEDT00_001-ZTEL,

*  END OF GS_STUDENT.

*

*  DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

*

*  CLEAR : GS_STUDENT, GT_STUDENT.

*

*  GS_STUDENT-ZPERNR     = '0000000001'.

*  GS_STUDENT-ZCODE     = 'SSU-01'.

*  GS_STUDENT-ZKNAME     = '###'.

*  GS_STUDENT-ZENAME     = 'DONG'.

*  GS_STUDENT-ZGENDER     = 'F'.

*  GS_STUDENT-ZTEL     = '01011112222'.

*

*

*  IF GS_STUDENT-ZGENDER = 'M'.

*    GS_STUDENT-ZGNAME = '##'.

*  ENDIF.

*

*

*

*  BREAK-POINT.

*

*  APPEND GS_STUDENT TO GT_STUDENT.

*

*  CLEAR : GS_STUDENT.

*

*

*

*

*  BREAK-POINT.







*DATA : BEGIN OF GS_STUDENT,

*  ZPERNR   LIKE ZEDT00_001-ZPERNR,

*  ZCODE    LIKE ZEDT00_001-ZCODE,

*  ZKNAME   LIKE ZEDT00_001-ZKNAME,

*  ZENAME   LIKE ZEDT00_001-ZENAME,

*  ZGENDER  LIKE ZEDT00_001-ZGENDER,

*  ZGNAME  TYPE C LENGTH 4,

*  ZTEL     LIKE ZEDT00_001-ZTEL,

*  END OF GS_STUDENT.

*

*  DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

*

*  CLEAR : GS_STUDENT, GT_STUDENT.

*

*  GS_STUDENT-ZPERNR = '0000000001'.

*  GS_STUDENT-ZCODE = 'SSU-01'.

*  GS_STUDENT-ZKNAME = '###'.

*  GS_STUDENT-ZENAME = 'DONG'.

*  GS_STUDENT-ZGENDER = 'M'.

*  GS_STUDENT-ZTEL = '01011112222'.

*

*  IF GS_STUDENT-ZGENDER = 'M'.

*    GS_STUDENT-ZGNAME = '##'.

*  ELSE.

*    GS_STUDENT-ZGNAME = '##'.

*  ENDIF.

*

*  APPEND GS_STUDENT TO GT_STUDENT.

*

*  CLEAR : GS_STUDENT.

*

*  BREAK-POINT.





*

*DATA : BEGIN OF GS_STUDENT,

*  ZPERNR   LIKE ZEDT00_001-ZPERNR,

*  ZCODE    LIKE ZEDT00_001-ZCODE,

*  ZKNAME   LIKE ZEDT00_001-ZKNAME,

*  ZENAME   LIKE ZEDT00_001-ZENAME,

*  ZGENDER  LIKE ZEDT00_001-ZGENDER,

*  ZGNAME  TYPE C LENGTH 4,

*  ZTEL     LIKE ZEDT00_001-ZTEL,

*  END OF GS_STUDENT.

*

*  DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

*

*  CLEAR : GS_STUDENT, GT_STUDENT.

*

*  GS_STUDENT-ZPERNR = '0000000001'.

*  GS_STUDENT-ZCODE = 'SSU-01'.

*  GS_STUDENT-ZKNAME = '###'.

*  GS_STUDENT-ZENAME = 'DONG'.

*  GS_STUDENT-ZGENDER = 'M'.

*  GS_STUDENT-ZTEL = '01011112222'.

*

*  IF GS_STUDENT-ZGENDER = 'M'.

*    GS_STUDENT-ZGNAME = '##'.

*  ELSEIF GS_STUDENT-ZGENDER = 'F'.

*    GS_STUDENT-ZGNAME = '##'.

*  ELSE.

*    GS_STUDENT-ZGNAME = '##'.

*  ENDIF.

*

*  APPEND GS_STUDENT TO GT_STUDENT.

*

*  CLEAR : GS_STUDENT.

*

*  BREAK-POINT.







*DATA : BEGIN OF GS_STUDENT,

*  ZPERNR   LIKE ZEDT00_001-ZPERNR,

*  ZCODE    LIKE ZEDT00_001-ZCODE,

*  ZKNAME   LIKE ZEDT00_001-ZKNAME,

*  ZENAME   LIKE ZEDT00_001-ZENAME,

*  ZGENDER  LIKE ZEDT00_001-ZGENDER,

*  ZGNAME  TYPE C LENGTH 4,

*  ZTEL     LIKE ZEDT00_001-ZTEL,

*  END OF GS_STUDENT.

*

*  DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

*

*  CLEAR : GS_STUDENT, GT_STUDENT.

*

*  GS_STUDENT-ZPERNR = '0000000001'.

*  GS_STUDENT-ZCODE = 'SSU-01'.

*  GS_STUDENT-ZKNAME = '###'.

*  GS_STUDENT-ZENAME = 'DONG'.

*  GS_STUDENT-ZGENDER = 'M'.

*  GS_STUDENT-ZTEL = '01011112222'.

*

*

*

*  IF ( GS_STUDENT-ZGENDER = 'M' ) AND ( GS_STUDENT-ZKNAME = '###' ) .

*    GS_STUDENT-ZGNAME = '##'.

*  ENDIF.

*

*  APPEND GS_STUDENT TO GT_STUDENT.

*  CLEAR : GS_STUDENT.







*

*DATA : BEGIN OF GS_STUDENT,

*  ZPERNR   LIKE ZEDT00_001-ZPERNR,

*  ZCODE    LIKE ZEDT00_001-ZCODE,

*  ZKNAME   LIKE ZEDT00_001-ZKNAME,

*  ZENAME   LIKE ZEDT00_001-ZENAME,

*  ZGENDER  LIKE ZEDT00_001-ZGENDER,

*  ZGNAME  TYPE C LENGTH 4,

*  ZTEL     LIKE ZEDT00_001-ZTEL,

*  END OF GS_STUDENT.

*

*  DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

*

*  CLEAR : GS_STUDENT, GT_STUDENT.

*

*  GS_STUDENT-ZPERNR = '0000000001'.

*  GS_STUDENT-ZCODE = 'SSU-01'.

*  GS_STUDENT-ZKNAME = '###'.

*  GS_STUDENT-ZENAME = 'DONG'.

*  GS_STUDENT-ZGENDER = 'M'.

*  GS_STUDENT-ZTEL = '01011112222'.

*

*

*

*  IF ( GS_STUDENT-ZGENDER = 'M' ) OR ( GS_STUDENT-ZKNAME = '###' ) .

*    GS_STUDENT-ZGNAME = '##'.

*  ENDIF.

*

*  APPEND GS_STUDENT TO GT_STUDENT.

*  CLEAR : GS_STUDENT.





*

*DATA : VAL1 TYPE I,

*      VAL2 TYPE I,

*      VAL3 TYPE I.

*

*VAL1 = 100.

*VAL2 = 120.

*

*IF VAL1 > VAL2.

*  WRITE : 'VAL1 WIN'.

*ELSE.

*  WRITE : 'VAL2 WIN'.

*ENDIF.

*

*VAL3 = 130.

*

*

*IF ( VAL1 < VAL2 ) AND ( VAL1 < VAL3 ).

*  WRITE : / 'VAL1 MIN'.

*ENDIF.

*

*

*IF VAL1 > VAL2.

*  WRITE : / 'VAL1 WIN'.

*ELSE.

*  WRITE : / 'VAL2 WIN'.

*ENDIF.







*DATA : BEGIN OF GS_STUDENT,

*  ZPERNR   LIKE ZEDT00_001-ZPERNR,

*  ZCODE    LIKE ZEDT00_001-ZCODE,

*  ZKNAME   LIKE ZEDT00_001-ZKNAME,

*  ZENAME   LIKE ZEDT00_001-ZENAME,

*  ZGENDER  LIKE ZEDT00_001-ZGENDER,

*  ZGNAME  TYPE C LENGTH 4,

*  ZTEL     LIKE ZEDT00_001-ZTEL,

*  END OF GS_STUDENT.

*

*DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

*

*CLEAR : GS_STUDENT, GT_STUDENT.

*

*GS_STUDENT-ZPERNR = '0000000001'.

*GS_STUDENT-ZCODE = 'SSU-01'.

*GS_STUDENT-ZKNAME = '###'.

*GS_STUDENT-ZENAME = 'DONG'.

*GS_STUDENT-ZGENDER = 'M'.

*GS_STUDENT-ZTEL = '01011112222'.

*APPEND GS_STUDENT TO GT_STUDENT.

*

*

*CLEAR : GS_STUDENT.

*

*GS_STUDENT-ZPERNR = '0000000002'.

*GS_STUDENT-ZCODE = 'SSU-02'.

*GS_STUDENT-ZKNAME = '###'.

*GS_STUDENT-ZENAME = 'HOON'.

*GS_STUDENT-ZGENDER = 'M'.

*GS_STUDENT-ZTEL = '01022223333'.

*APPEND GS_STUDENT TO GT_STUDENT.

*

*CLEAR : GS_STUDENT.

*

*GS_STUDENT-ZPERNR = '0000000003'.

*GS_STUDENT-ZCODE = 'SSU-03'.

*GS_STUDENT-ZKNAME = '###'.

*GS_STUDENT-ZENAME = 'SON'.

*GS_STUDENT-ZGENDER = 'F'.

*GS_STUDENT-ZTEL = '01033334444'.

*APPEND GS_STUDENT TO GT_STUDENT.

*

*

*

*CLEAR : GS_STUDENT.

*LOOP AT GT_STUDENT INTO GS_STUDENT.

*  IF GS_STUDENT-ZGENDER = 'M'.

*    GS_STUDENT-ZGNAME = '##'.

*  ELSEIF GS_STUDENT-ZGENDER = 'F'.

*    GS_STUDENT-ZGENDER = '##'.

*  ELSE.

*    GS_STUDENT-ZGNAME = '##'.

*  ENDIF.

*

*  CLEAR : GS_STUDENT.

*ENDLOOP.

*

*CLEAR : GS_STUDENT.

*

*BREAK-POINT.







*DATA : BEGIN OF GS_STUDENT,

*  ZPERNR   LIKE ZEDT00_001-ZPERNR,

*  ZCODE    LIKE ZEDT00_001-ZCODE,

*  ZKNAME   LIKE ZEDT00_001-ZKNAME,

*  ZENAME   LIKE ZEDT00_001-ZENAME,

*  ZGENDER  LIKE ZEDT00_001-ZGENDER,

*  ZGNAME  TYPE C LENGTH 4,

*  ZTEL     LIKE ZEDT00_001-ZTEL,

*  END OF GS_STUDENT.

*

*DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

*

*CLEAR : GS_STUDENT, GT_STUDENT.

*

*GS_STUDENT-ZPERNR = '0000000001'.

*GS_STUDENT-ZCODE = 'SSU-01'.

*GS_STUDENT-ZKNAME = '###'.

*GS_STUDENT-ZENAME = 'DONG'.

*GS_STUDENT-ZGENDER = 'M'.

*GS_STUDENT-ZTEL = '01011112222'.

*APPEND GS_STUDENT TO GT_STUDENT.

*

*

*CLEAR : GS_STUDENT.

*

*GS_STUDENT-ZPERNR = '0000000002'.

*GS_STUDENT-ZCODE = 'SSU-02'.

*GS_STUDENT-ZKNAME = '###'.

*GS_STUDENT-ZENAME = 'HOON'.

*GS_STUDENT-ZGENDER = 'M'.

*GS_STUDENT-ZTEL = '01022223333'.

*APPEND GS_STUDENT TO GT_STUDENT.

*

*CLEAR : GS_STUDENT.

*

*GS_STUDENT-ZPERNR = '0000000003'.

*GS_STUDENT-ZCODE = 'SSU-03'.

*GS_STUDENT-ZKNAME = '###'.

*GS_STUDENT-ZENAME = 'SON'.

*GS_STUDENT-ZGENDER = 'F'.

*GS_STUDENT-ZTEL = '01033334444'.

*APPEND GS_STUDENT TO GT_STUDENT.

*

*

*

*CLEAR : GS_STUDENT.

*LOOP AT GT_STUDENT INTO GS_STUDENT WHERE ZGENDER = 'F'.

*  IF GS_STUDENT-ZGENDER = 'M'.

*    GS_STUDENT-ZGNAME = '##'.

*  ELSEIF GS_STUDENT-ZGENDER = 'F'.

*    GS_STUDENT-ZGNAME = '##'.

*  ELSE.

*    GS_STUDENT-ZGNAME = '##'.

*

*  ENDIF.

*

*  BREAK-POINT.

*  CLEAR : GS_STUDENT.

*ENDLOOP.

*

*CLEAR : GS_STUDENT.

*

*BREAK-POINT.





*

*

*DATA : BEGIN OF GS_STUDENT,

*  ZPERNR   LIKE ZEDT00_001-ZPERNR,

*  ZCODE    LIKE ZEDT00_001-ZCODE,

*  ZKNAME   LIKE ZEDT00_001-ZKNAME,

*  ZENAME   LIKE ZEDT00_001-ZENAME,

*  ZGENDER  LIKE ZEDT00_001-ZGENDER,

*  ZGNAME  TYPE C LENGTH 4,

*  ZTEL     LIKE ZEDT00_001-ZTEL,

*  END OF GS_STUDENT.

*

*DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

*

*CLEAR : GS_STUDENT, GT_STUDENT.

*

*GS_STUDENT-ZPERNR = '0000000001'.

*GS_STUDENT-ZCODE = 'SSU-01'.

*GS_STUDENT-ZKNAME = '###'.

*GS_STUDENT-ZENAME = 'DONG'.

*GS_STUDENT-ZGENDER = 'M'.

*GS_STUDENT-ZTEL = '01011112222'.

*APPEND GS_STUDENT TO GT_STUDENT.

*

*

*CLEAR : GS_STUDENT.

*

*GS_STUDENT-ZPERNR = '0000000002'.

*GS_STUDENT-ZCODE = 'SSU-02'.

*GS_STUDENT-ZKNAME = '###'.

*GS_STUDENT-ZENAME = 'HOON'.

*GS_STUDENT-ZGENDER = 'M'.

*GS_STUDENT-ZTEL = '01022223333'.

*APPEND GS_STUDENT TO GT_STUDENT.

*

*CLEAR : GS_STUDENT.

*

*GS_STUDENT-ZPERNR = '0000000003'.

*GS_STUDENT-ZCODE = 'SSU-03'.

*GS_STUDENT-ZKNAME = '###'.

*GS_STUDENT-ZENAME = 'SON'.

*GS_STUDENT-ZGENDER = 'F'.

*GS_STUDENT-ZTEL = '01033334444'.

*APPEND GS_STUDENT TO GT_STUDENT.

*

*

*

*CLEAR : GS_STUDENT.

*LOOP AT GT_STUDENT INTO GS_STUDENT FROM 2 TO 3.

*  IF GS_STUDENT-ZGENDER = 'M'.

*    GS_STUDENT-ZGNAME = '##'.

*  ELSEIF GS_STUDENT-ZGENDER = 'F'.

*    GS_STUDENT-ZGNAME = '##'.

*  ELSE.

*    GS_STUDENT-ZGNAME = '##'.

*

*  ENDIF.

*

*  BREAK-POINT.

*  CLEAR : GS_STUDENT.

*ENDLOOP.

*

*CLEAR : GS_STUDENT.

*

*BREAK-POINT.











*DATA : BEGIN OF GS_STUDENT,

*  ZPERNR   LIKE ZEDT00_001-ZPERNR,

*  ZCODE    LIKE ZEDT00_001-ZCODE,

*  ZKNAME   LIKE ZEDT00_001-ZKNAME,

*  ZENAME   LIKE ZEDT00_001-ZENAME,

*  ZGENDER  LIKE ZEDT00_001-ZGENDER,

*  ZGNAME  TYPE C LENGTH 4,

*  ZTEL     LIKE ZEDT00_001-ZTEL,

*  END OF GS_STUDENT.

*

*DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT WITH NON-UNIQUE KEY ZCODE.

*

*CLEAR : GS_STUDENT, GT_STUDENT.

*

*GS_STUDENT-ZPERNR = '0000000001'.

*GS_STUDENT-ZCODE = 'SSU-01'.

*GS_STUDENT-ZKNAME = '###'.

*GS_STUDENT-ZENAME = 'DONG'.

*GS_STUDENT-ZGENDER = 'M'.

*GS_STUDENT-ZTEL = '01011112222'.

*APPEND GS_STUDENT TO GT_STUDENT.

*

*GS_STUDENT-ZENAME = 'KANG'.

*GS_STUDENT-ZGENDER = 'F'.

*

*MODIFY TABLE GT_STUDENT FROM GS_STUDENT.

*

*BREAK-POINT.



*

*DATA : BEGIN OF GS_STUDENT,

*  ZPERNR   LIKE ZEDT00_001-ZPERNR,

*  ZCODE    LIKE ZEDT00_001-ZCODE,

*  ZKNAME   LIKE ZEDT00_001-ZKNAME,

*  ZENAME   LIKE ZEDT00_001-ZENAME,

*  ZGENDER  LIKE ZEDT00_001-ZGENDER,

*  ZGNAME  TYPE C LENGTH 4,

*  ZTEL     LIKE ZEDT00_001-ZTEL,

*  END OF GS_STUDENT.

*

*DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT WITH NON-UNIQUE KEY ZCODE.

*

*CLEAR : GS_STUDENT, GT_STUDENT.

*

*GS_STUDENT-ZPERNR = '0000000001'.

*GS_STUDENT-ZCODE = 'SSU-01'.

*GS_STUDENT-ZKNAME = '###'.

*GS_STUDENT-ZENAME = 'DONG'.

*GS_STUDENT-ZGENDER = 'M'.

*GS_STUDENT-ZTEL = '01011112222'.

*APPEND GS_STUDENT TO GT_STUDENT.

*

*CLEAR : GS_STUDENT.

*

*LOOP AT GT_STUDENT INTO GS_STUDENT.

*  IF GS_STUDENT-ZGENDER NE 'M'.

*    DELETE TABLE GT_STUDENT FROM GS_STUDENT.

*

*    IF SY-SUBRC = 0.

*    ELSE.

*      WRITE : / '## ##'.

*    ENDIF.

*   ELSE.

*     WRITE: /GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME, GS_STUDENT-ZGENDER.

*   ENDIF.

*ENDLOOP.







*

*DATA : BEGIN OF GS_STUDENT,

*  ZPERNR   LIKE ZEDT00_001-ZPERNR,

*  ZCODE    LIKE ZEDT00_001-ZCODE,

*  ZKNAME   LIKE ZEDT00_001-ZKNAME,

*  ZENAME   LIKE ZEDT00_001-ZENAME,

*  ZGENDER  LIKE ZEDT00_001-ZGENDER,

*  ZGNAME  TYPE C LENGTH 4,

*  ZTEL     LIKE ZEDT00_001-ZTEL,

*  END OF GS_STUDENT.

*

*DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT WITH NON-UNIQUE KEY ZCODE.

*

*CLEAR : GS_STUDENT, GT_STUDENT.

*

*GS_STUDENT-ZPERNR = '0000000001'.

*GS_STUDENT-ZCODE = 'SSU-01'.

*GS_STUDENT-ZKNAME = '###'.

*GS_STUDENT-ZENAME = 'DONG'.

*GS_STUDENT-ZGENDER = 'M'.

*GS_STUDENT-ZTEL = '01011112222'.

*APPEND GS_STUDENT TO GT_STUDENT.

*

*GS_STUDENT-ZENAME = 'KANG'.

*GS_STUDENT-ZGENDER = 'F'.

*

*MODIFY TABLE GT_STUDENT FROM GS_STUDENT

*TRANSPORTING ZGENDER WHERE ZCODE == GS_STUDENT-ZCODE.

*

*

*BREAK-POINT.







*

*DATA : BEGIN OF GS_STUDENT,

*  ZPERNR   LIKE ZEDT00_001-ZPERNR,

*  ZCODE    LIKE ZEDT00_001-ZCODE,

*  ZKNAME   LIKE ZEDT00_001-ZKNAME,

*  ZENAME   LIKE ZEDT00_001-ZENAME,

*  ZGENDER  LIKE ZEDT00_001-ZGENDER,

*  ZGNAME  TYPE C LENGTH 4,

*  ZTEL     LIKE ZEDT00_001-ZTEL,

*  END OF GS_STUDENT.

*

*DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

*

*CLEAR : GS_STUDENT, GT_STUDENT.

*

*GS_STUDENT-ZPERNR = '0000000001'.

*GS_STUDENT-ZCODE = 'SSU-01'.

*GS_STUDENT-ZKNAME = '###'.

*GS_STUDENT-ZENAME = 'DONG'.

*GS_STUDENT-ZGENDER = 'M'.

*GS_STUDENT-ZTEL = '01011112222'.

*APPEND GS_STUDENT TO GT_STUDENT.

*

*

*CLEAR : GS_STUDENT.

*

*GS_STUDENT-ZPERNR = '0000000002'.

*GS_STUDENT-ZCODE = 'SSU-02'.

*GS_STUDENT-ZKNAME = '###'.

*GS_STUDENT-ZENAME = 'HOON'.

*GS_STUDENT-ZGENDER = 'M'.

*GS_STUDENT-ZTEL = '01022223333'.

*APPEND GS_STUDENT TO GT_STUDENT.

*

*CLEAR : GS_STUDENT.

*

*GS_STUDENT-ZPERNR = '0000000003'.

*GS_STUDENT-ZCODE = 'SSU-03'.

*GS_STUDENT-ZKNAME = '###'.

*GS_STUDENT-ZENAME = 'SON'.

*GS_STUDENT-ZGENDER = 'F'.

*GS_STUDENT-ZTEL = '01033334444'.

*APPEND GS_STUDENT TO GT_STUDENT.

*

*

*

*CLEAR : GS_STUDENT.

*LOOP AT GT_STUDENT INTO GS_STUDENT.

*  IF GS_STUDENT-ZGENDER = 'M'.

*    GS_STUDENT-ZGNAME = '##'.

*  ELSEIF GS_STUDENT-ZGENDER = 'F'.

*    GS_STUDENT-ZGNAME = '##'.

*  ELSE.

*    GS_STUDENT-ZGNAME = '##'.

*  ENDIF.

*

*  MODIFY GT_STUDENT FROM GS_STUDENT

*  TRANSPORTING ZGNAME WHERE ZCODE = GS_STUDENT-ZCODE.

*

*  CLEAR GS_STUDENT.

*

*ENDLOOP.

*

*

*BREAK-POINT.







*

*DATA : BEGIN OF GS_STUDENT,

*  ZPERNR   LIKE ZEDT00_001-ZPERNR,

*  ZCODE    LIKE ZEDT00_001-ZCODE,

*  ZKNAME   LIKE ZEDT00_001-ZKNAME,

*  ZENAME   LIKE ZEDT00_001-ZENAME,

*  ZGENDER  LIKE ZEDT00_001-ZGENDER,

*  ZGNAME  TYPE C LENGTH 4,

*  ZTEL     LIKE ZEDT00_001-ZTEL,

*  END OF GS_STUDENT.

*

*DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

*

*CLEAR : GS_STUDENT, GT_STUDENT.

*

*GS_STUDENT-ZPERNR = '0000000001'.

*GS_STUDENT-ZCODE = 'SSU-01'.

*GS_STUDENT-ZKNAME = '###'.

*GS_STUDENT-ZENAME = 'DONG'.

*GS_STUDENT-ZGENDER = 'M'.

*GS_STUDENT-ZTEL = '01011112222'.

*APPEND GS_STUDENT TO GT_STUDENT.

*

*

*CLEAR : GS_STUDENT.

*

*GS_STUDENT-ZPERNR = '0000000002'.

*GS_STUDENT-ZCODE = 'SSU-02'.

*GS_STUDENT-ZKNAME = '###'.

*GS_STUDENT-ZENAME = 'HOON'.

*GS_STUDENT-ZGENDER = 'M'.

*GS_STUDENT-ZTEL = '01022223333'.

*APPEND GS_STUDENT TO GT_STUDENT.

*

*CLEAR : GS_STUDENT.

*

*GS_STUDENT-ZPERNR = '0000000003'.

*GS_STUDENT-ZCODE = 'SSU-03'.

*GS_STUDENT-ZKNAME = '###'.

*GS_STUDENT-ZENAME = 'SON'.

*GS_STUDENT-ZGENDER = 'F'.

*GS_STUDENT-ZTEL = '01033334444'.

*APPEND GS_STUDENT TO GT_STUDENT.

*

*

*

*CLEAR : GS_STUDENT.

*

*LOOP AT GT_STUDENT INTO GS_STUDENT.

*  IF GS_STUDENT-ZGENDER = 'M'.

*    GS_STUDENT-ZGNAME = '##'.

*  ELSEIF GS_STUDENT-ZGENDER = 'F'.

*    GS_STUDENT-ZGNAME = '##'.

*  ELSE.

*    GS_STUDENT-ZGNAME = '##'.

*  ENDIF.

*

*  MODIFY GT_STUDENT FROM GS_STUDENT INDEX SY-TABIX.

*

*  CLEAR GS_STUDENT.

*

*ENDLOOP.

*

*

*BREAK-POINT.



*

*data : GS_STUDENT type ZEDT00_001.

*data : GT_STUDENT like table of GS_STUDENT with non-unique key ZGENDER.

*clear : GS_STUDENT, GT_STUDENT.

*

*GS_STUDENT-ZPERNR = '0000000001'.

*GS_STUDENT-ZCODE = 'ssu-01'.

*GS_STUDENT-ZKNAME = '###'.

*GS_STUDENT-ZENAME = 'dong'.

*GS_STUDENT-ZGENDER = 'm'.

*GS_STUDENT-ZTEL = '01011112222'.

*append GS_STUDENT to GT_STUDENT.

*

*

*clear : GS_STUDENT.

*

*GS_STUDENT-ZPERNR = '0000000002'.

*GS_STUDENT-ZCODE = 'ssu-02'.

*GS_STUDENT-ZKNAME = '###'.

*GS_STUDENT-ZENAME = 'hoon'.

*GS_STUDENT-ZGENDER = 'm'.

*GS_STUDENT-ZTEL = '01022223333'.

*append GS_STUDENT to GT_STUDENT.

*

*clear : GS_STUDENT.

*

*GS_STUDENT-ZPERNR = '0000000003'.

*GS_STUDENT-ZCODE = 'ssu-03'.

*GS_STUDENT-ZKNAME = '###'.

*GS_STUDENT-ZENAME = 'son'.

*GS_STUDENT-ZGENDER = 'f'.

*GS_STUDENT-ZTEL = '01033334444'.

*append GS_STUDENT to GT_STUDENT.

*

*clear : GS_STUDENT.

*

*

*delete table GT_STUDENT with table key ZGENDER = 'f'.

*

*if SY-SUBRC = 0.

*  loop at GT_STUDENT into GS_STUDENT.

*    write : / GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME, GS_STUDENT.

*  endloop.

*endif.

*







*LOOP AT GT_STUDENT INTO GS_STUDENT.

*  IF GS_STUDENT-ZGENDER NE 'M'.

*    DELETE TABLE GT_STUDENT FROM GS_STUDENT.

*

*    IF SY-SUBRC = 0.

*    ELSE.

*      WRITE : / '####'.

*    ENDIF.

*  ELSE.

*    WRITE : / GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME, GS_STUDENT-ZGENDER.

*  ENDIF.

*ENDLOOP.





*

*

*

*DATA : GS_STUDENT TYPE ZEDT00_001.

*DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

*

*

*CLEAR : GS_STUDENT, GT_STUDENT.

*

*GS_STUDENT-ZPERNR = '0000000001'.

*GS_STUDENT-ZCODE = 'SSU-01'.

*GS_STUDENT-ZKNAME = '###'.

*GS_STUDENT-ZENAME = 'DONG'.

*GS_STUDENT-ZGENDER = 'M'.

*GS_STUDENT-ZTEL = '01011112222'.

*APPEND GS_STUDENT TO GT_STUDENT.

*

*

*CLEAR : GS_STUDENT.

*

*GS_STUDENT-ZPERNR = '0000000002'.

*GS_STUDENT-ZCODE = 'SSU-02'.

*GS_STUDENT-ZKNAME = '###'.

*GS_STUDENT-ZENAME = 'HOON'.

*GS_STUDENT-ZGENDER = 'M'.

*GS_STUDENT-ZTEL = '01022223333'.

*APPEND GS_STUDENT TO GT_STUDENT.

*

*CLEAR : GS_STUDENT.

*

*GS_STUDENT-ZPERNR = '0000000003'.

*GS_STUDENT-ZCODE = 'SSU-03'.

*GS_STUDENT-ZKNAME = '###'.

*GS_STUDENT-ZENAME = 'SON'.

*GS_STUDENT-ZGENDER = 'F'.

*GS_STUDENT-ZTEL = '01033334444'.

*APPEND GS_STUDENT TO GT_STUDENT.

*

*

*DELETE GT_STUDENT WHERE ZGENDER = 'F'.

*

*IF SY-SUBRC = 0.

*  LOOP AT GT_STUDENT INTO GS_STUDENT.

*    WRITE : / GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME, GS_STUDENT-ZGENDER.

*  ENDLOOP.

*ENDIF.







*

*DATA : GS_STUDENT TYPE ZEDT00_001.

*DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

*

*

*CLEAR : GS_STUDENT, GT_STUDENT.

*

*GS_STUDENT-ZPERNR = '0000000001'.

*GS_STUDENT-ZCODE = 'SSU-01'.

*GS_STUDENT-ZKNAME = '###'.

*GS_STUDENT-ZENAME = 'DONG'.

*GS_STUDENT-ZGENDER = 'M'.

*GS_STUDENT-ZTEL = '01011112222'.

*APPEND GS_STUDENT TO GT_STUDENT.

*

*

*CLEAR : GS_STUDENT.

*GS_STUDENT-ZPERNR = '0000000001'.

*GS_STUDENT-ZCODE = 'SSU-01'.

*GS_STUDENT-ZKNAME = '###'.

*GS_STUDENT-ZENAME = 'DONG'.

*GS_STUDENT-ZGENDER = 'M'.

*GS_STUDENT-ZTEL = '01011112222'.

*APPEND GS_STUDENT TO GT_STUDENT.

*

*

*CLEAR : GS_STUDENT.

*

*GS_STUDENT-ZPERNR = '0000000001'.

*GS_STUDENT-ZCODE = 'SSU-01'.

*GS_STUDENT-ZKNAME = '##'.

*GS_STUDENT-ZENAME = 'SON'.

*GS_STUDENT-ZGENDER = 'F'.

*GS_STUDENT-ZTEL = '01033334444'.

*APPEND GS_STUDENT TO GT_STUDENT.

*

*

*CLEAR : GS_STUDENT.

*

*GS_STUDENT-ZPERNR = '0000000003'.

*GS_STUDENT-ZCODE = 'SSU-03'.

*GS_STUDENT-ZKNAME = '###'.

*GS_STUDENT-ZENAME = 'SON'.

*GS_STUDENT-ZGENDER = 'F'.

*GS_STUDENT-ZTEL = '01033334444'.

*APPEND GS_STUDENT TO GT_STUDENT.

*

*SORT GT_STUDENT.

*

*DELETE ADJACENT DUPLICATES FROM GT_STUDENT COMPARING ZCODE.

*

*IF SY-SUBRC = 0.

*  LOOP AT GT_STUDENT INTO GS_STUDENT.

*    WRITE : / GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME, GS_STUDENT-ZGENDER.

*  ENDLOOP.

*ENDIF.



*

*DATA : BEGIN OF GS_STUDENT,

*  ZPERNR LIKE ZEDT00_001-ZPERNR,

*  ZCODE LIKE ZEDT00_001-ZCODE,

*  ZKNAME LIKE ZEDT00_001-ZKNAME,

*  ZENAME LIKE ZEDT00_001-ZENAME,

*  ZGENDER LIKE ZEDT00_001-ZGENDER,

*  ZGNAME TYPE C LENGTH 10,

*  ZTEL LIKE ZEDT00_001-ZTEL,

*  END OF GS_STUDENT.

*

*DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

*

*

*CLEAR : GS_STUDENT.

*GS_STUDENT-ZPERNR = '0000000001'.

*GS_STUDENT-ZCODE = 'SSU-01'.

*GS_STUDENT-ZKNAME = '###'.

*GS_STUDENT-ZENAME = 'DONG'.

*GS_STUDENT-ZGENDER = 'F'.

*GS_STUDENT-ZTEL = '01011112222'.

*APPEND GS_STUDENT TO GT_STUDENT.

*

*CLEAR : GS_STUDENT.

*GS_STUDENT-ZPERNR = '0000000001'.

*GS_STUDENT-ZCODE = 'SSU-01'.

*GS_STUDENT-ZKNAME = '###'.

*GS_STUDENT-ZENAME = 'DONG'.

*GS_STUDENT-ZGENDER = 'A'.

*GS_STUDENT-ZTEL = '01011112222'.

*APPEND GS_STUDENT TO GT_STUDENT.

*

*CLEAR : GS_STUDENT.

*GS_STUDENT-ZPERNR = '0000000001'.

*GS_STUDENT-ZCODE = 'SSU-01'.

*GS_STUDENT-ZKNAME = '###'.

*GS_STUDENT-ZENAME = 'DONG'.

*GS_STUDENT-ZGENDER = 'M'.

*GS_STUDENT-ZTEL = '01011112222'.

*APPEND GS_STUDENT TO GT_STUDENT.

*

*CLEAR : GS_STUDENT.

*GS_STUDENT-ZPERNR = '0000000001'.

*GS_STUDENT-ZCODE = 'SSU-01'.

*GS_STUDENT-ZKNAME = '###'.

*GS_STUDENT-ZENAME = 'KANG'.

*GS_STUDENT-ZGENDER = 'M'.

*GS_STUDENT-ZTEL = '01011112222'.

*APPEND GS_STUDENT TO GT_STUDENT.

*

*

*CLEAR : GS_STUDENT.

*

*GS_STUDENT-ZPERNR = '0000000002'.

*GS_STUDENT-ZCODE = 'SSU-02'.

*GS_STUDENT-ZKNAME = '###'.

*GS_STUDENT-ZENAME = 'HOON'.

*GS_STUDENT-ZGENDER = 'M'.

*GS_STUDENT-ZTEL = '01022223333'.

*APPEND GS_STUDENT TO GT_STUDENT.

*

*CLEAR : GS_STUDENT.

*

*GS_STUDENT-ZPERNR = '0000000003'.

*GS_STUDENT-ZCODE = 'SSU-03'.

*GS_STUDENT-ZKNAME = '###'.

*GS_STUDENT-ZENAME = 'SON'.

*GS_STUDENT-ZGENDER = 'F'.

*GS_STUDENT-ZTEL = '01033334444'.

*APPEND GS_STUDENT TO GT_STUDENT.

*

*CLEAR : GS_STUDENT.

*SORT GT_STUDENT BY ZCODE ZKNAME ZENAME ZGENDER.

*

*LOOP AT GT_STUDENT INTO GS_STUDENT.

*  GS_STUDENT-ZGNAME = '####'.

*

*  AT END OF ZENAME.

*    GS_STUDENT-ZCODE = 'SSU-04'.

*    GS_STUDENT-ZGNAME = '####'.

*    GS_STUDENT-ZKNAME = '###'.

*  ENDAT.

*

*  CLEAR : GS_STUDENT.

*ENDLOOP.



*

*LOOP AT GT_STUDENT INTO GS_STUDENT.

*    GS_STUDENT-ZGNAME = '####'.

*

*  AT LAST.

*    GS_STUDENT-ZGNAME = '####'.

*  ENDAT.

*

*ENDLOOP.

*

*DATA : GS_STUDENT TYPE ZEDT00_001.

*DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

*

*DATA : BEGIN OF GS_MAJOR,

*  ZCODE LIKE ZEDT00_001-ZCODE,

*  ZPERNR LIKE ZEDT00_001-ZPERNR,

*  ZKNAME LIKE ZEDT00_001-ZKNAME,

*  ZMNAME LIKE ZEDT00_004-ZMNAME,

*  END OF GS_MAJOR.

*

*  DATA : GT_MAJOR LIKE TABLE OF GS_MAJOR WITH NON-UNIQUE KEY ZCODE.

*

*  CLEAR : GS_STUDENT, GT_STUDENT, GS_MAJOR, GT_MAJOR.

*

*  GS_STUDENT-ZPERNR = '0000000001'.

*  GS_STUDENT-ZCODE = 'SSU-01'.

*  GS_STUDENT-ZENAME = 'DONG'.

*  GS_STUDENT-ZGENDER = 'M'.

*  GS_STUDENT-ZTEL = '01011112222'.

*  APPEND GS_STUDENT TO GT_STUDENT.

*

*

*CLEAR : GS_STUDENT.

*  GS_STUDENT-ZPERNR = '0000000002'.

*  GS_STUDENT-ZCODE = 'SSU-02'.

*  GS_STUDENT-ZENAME = 'HOON'.

*  GS_STUDENT-ZGENDER = 'M'.

*  GS_STUDENT-ZTEL = '01011112222'.

*  APPEND GS_STUDENT TO GT_STUDENT.

*

*

*  CLEAR : GS_STUDENT.

*  GS_STUDENT-ZPERNR = '0000000003'.

*  GS_STUDENT-ZCODE = 'SSU-03'.

*  GS_STUDENT-ZENAME = 'HYUN'.

*  GS_STUDENT-ZGENDER = 'M'.

*  GS_STUDENT-ZTEL = '01011112222'.

*  APPEND GS_STUDENT TO GT_STUDENT.

*

*  CLEAR : GS_STUDENT.

*  GS_STUDENT-ZPERNR = '0000000004'.

*  GS_STUDENT-ZCODE = 'SSU-04'.

*  GS_STUDENT-ZENAME = 'JENNIE'.

*  GS_STUDENT-ZGENDER = 'F'.

*  GS_STUDENT-ZTEL = '01011112222'.

*  APPEND GS_STUDENT TO GT_STUDENT.

*

*

*  GS_MAJOR-ZPERNR = '0000000001'.

*  GS_MAJOR-ZCODE = 'SSU-01'.

*  GS_MAJOR-ZKNAME = '###'.

*  GS_MAJOR-ZMNAME = '####'.

*

*  APPEND GS_MAJOR TO GT_MAJOR.

*

*  CLEAR : GS_MAJOR.

*  GS_MAJOR-ZPERNR = '0000000002'.

*  GS_MAJOR-ZCODE = 'SSU-02'.

*  GS_MAJOR-ZKNAME = '###'.

*  GS_MAJOR-ZMNAME = '#####'.

*

*  APPEND GS_MAJOR TO GT_MAJOR.

*

*

*  CLEAR : GS_MAJOR.

*  GS_MAJOR-ZPERNR = '0000000003'.

*  GS_MAJOR-ZCODE = 'SSU-03'.

*  GS_MAJOR-ZKNAME = '##'.

*  GS_MAJOR-ZMNAME = '######'.

*

*  APPEND GS_MAJOR TO GT_MAJOR.

*

*  CLEAR : GS_MAJOR.

*  GS_MAJOR-ZPERNR = '0000000004'.

*  GS_MAJOR-ZCODE = 'SSU-04'.

*  GS_MAJOR-ZKNAME = '##'.

*  GS_MAJOR-ZMNAME = '####'.

*

*  APPEND GS_MAJOR TO GT_MAJOR.





*  LOOP AT GT_STUDENT INTO GS_STUDENT.

*    CLEAR : GS_MAJOR.

*    MOVE-CORRESPONDING GS_STUDENT TO GS_MAJOR.

*    READ TABLE GT_MAJOR FROM GS_MAJOR INTO GS_MAJOR.

*

*    IF SY-SUBRC = 0.

*      WRITE : / GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME, GS_MAJOR-ZMNAME.

*    ELSE.

*      WRITE : /'#### #########'.

*    ENDIF.

*ENDLOOP.

*

*

*LOOP AT GT_STUDENT INTO GS_STUDENT.

*  CLEAR : GS_MAJOR.

*  MOVE-CORRESPONDING GS_STUDENT TO GS_MAJOR.

*  READ TABLE GT_MAJOR WITH TABLE KEY ZCODE = GS_STUDENT-ZCODE INTO GS_MAJOR.

*

*  IF SY-SUBRC = 0.

*    WRITE : / GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME, GS_MAJOR-ZMNAME.

*  ELSE.

*    WRITE : / '#### ### #####.'.

*  ENDIF.

*  ENDLOOP.



*



*LOOP AT GT_STUDENT INTO GS_STUDENT.

*  CLEAR : GS_MAJOR.

*

*  MOVE-CORRESPONDING GS_STUDENT TO GS_MAJOR.

*  READ TABLE GT_MAJOR WITH KEY ZCODE = GS_STUDENT-ZCODE

*  INTO GS_MAJOR.

*

*  IF SY-SUBRC = 0.

*    WRITE : / GS_STUDENT-ZCODE, GS_MAJOR-ZKNAME, GS_MAJOR-ZMNAME.

*  ELSE.

*    WRITE : / '#### #### #####.'.

*  ENDIF.

*  ENDLOOP.





*LOOP AT GT_STUDENT INTO GS_STUDENT.

*  CLEAR : GS_MAJOR.

*  MOVE-CORRESPONDING GS_STUDENT TO GS_MAJOR.

*  READ TABLE GT_MAJOR WITH KEY ZCODE = GS_STUDENT-ZCODE INTO GS_MAJOR.

*

*  IF SY-SUBRC = 0.

*    GS_STUDENT-ZKNAME = GS_MAJOR-ZKNAME.

*    WRITE : / GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME, GS_MAJOR-ZMNAME.

*  ELSE.

*    WRITE : / '#### #### #####.'.

*   ENDIF.

*  ENDLOOP.





*LOOP AT GT_STUDENT INTO GS_STUDENT.

*  CLEAR : GS_MAJOR.

*  MOVE-CORRESPONDING GS_STUDENT TO GS_MAJOR.

*

*  READ TABLE GT_MAJOR WITH KEY ZCODE = GS_STUDENT-ZCODE INTO GS_MAJOR

*  TRANSPORTING ZMNAME.

*

*  IF SY-SUBRC = 0.

*    GS_STUDENT-ZKNAME = GS_MAJOR-ZKNAME.

*    WRITE  : / GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME, GS_MAJOR-ZMNAME.

*   ELSE.

*     WRITE : / '#### #### #####.'.

*     ENDIF.

*     ENDLOOP.



*

*SORT GT_STUDENT.

*

*LOOP AT GT_STUDENT INTO GS_STUDENT.

*  CLEAR : GS_MAJOR.

*  MOVE-CORRESPONDING GS_STUDENT TO GS_MAJOR.

*

*  READ TABLE GT_MAJOR INTO GS_MAJOR INDEX SY-TABIX.

*  IF SY-SUBRC = 0.

*    GS_STUDENT-ZKNAME = GS_MAJOR-ZKNAME.

*    WRITE : / GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME, GS_MAJOR-ZMNAME.

*  ELSE.

*    WRITE : / '#### #### #####'.

*  ENDIF.

*ENDLOOP.





*

*SORT GT_MAJOR.

*

*LOOP AT GT_STUDENT INTO GS_STUDENT.

*  CLEAR : GS_MAJOR.

*  MOVE-CORRESPONDING GS_STUDENT TO GS_MAJOR.

*

*  READ TABLE GT_MAJOR WITH KEY ZCODE = GS_STUDENT-ZCODE INTO GS_MAJOR BINARY SEARCH.

*

*  IF SY-SUBRC = 0.

*    WRITE : / GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME, GS_MAJOR-ZMNAME.

*  ELSE.

*    WRITE : / '#### #########.'.

*  ENDIF.

*ENDLOOP.

*

*DATA : LV_NUM TYPE I,

*      LV_SUM TYPE I.

*

*LV_NUM = 5.

*

*DO LV_NUM TIMES.

*  ADD SY-INDEX TO LV_SUM.

*  WRITE : / SY-INDEX.

*  ENDDO.

*

*  WRITE : /'INDEX## : ', LV_SUM.





*LV_NUM = 5.

*DO LV_NUM TIMES.

*  IF SY-INDEX = '3'.

*    EXIT.

*  ENDIF.

*

*  ADD SY-INDEX TO LV_SUM.

*  WRITE : / SY-INDEX.

*  ENDDO.

*

*  WRITE : / 'INDEX ##: ', LV_SUM.





*DO LV_NUM TIMES.

*  CHECK SY-INDEX = '3'.

*

*  ADD SY-INDEX TO LV_SUM.

*  WRITE : / SY-INDEX.

*

*  ENDDO.

*

*  WRITE : / 'INDEX##: ', LV_SUM.



*

*DATA : GV_NUM TYPE I,

*      GV_CHECK TYPE C.

*

*GV_NUM = 5.

*WHILE GV_NUM = 5.

*  GV_CHECK = 'X'.

*  ENDWHILE.

*

*  IF GV_CHECK = 'X'.

*    WRITE : / '#######.'.

*  ENDIF.












" ### ## ## #### INCLUDE TYPE# ## ### ## ### ### ##




*DATA : BEGIN OF GS_STUDENT.

*  INCLUDE TYPE ZEDT00_001.

*  DATA : END OF GS_STUDENT.

*DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

*

*SELECT * FROM ZEDT00_001

*  INTO  CORRESPONDING FIELDS OF TABLE GT_STUDENT.

*

*LOOP AT GT_STUDENT INTO GS_STUDENT.

*  IF GS_STUDENT-ZTEL CS '-'.

*    CONTINUE.

*  ELSE.

*    GS_STUDENT-ZTEL = |{ GS_STUDENT-ZTEL(3) }-{ GS_STUDENT-ZTEL+3(4) }-{ GS_STUDENT-ZTEL+7(4) }|.

*    GS_STUDENT-ZTEL = CONDENSE(GS_STUDENT-ZTEL).

*    MODIFY GT_STUDENT FROM GS_STUDENT.

*    MODIFY ZEDT00_001 FROM GS_STUDENT.

*  ENDIF.

*

*ENDLOOP.

*

*LOOP AT GT_STUDENT INTO GS_STUDENT.

*  WRITE : / GS_STUDENT-ZCODE, GS_STUDENT-ZPERNR, GS_STUDENT-ZKNAME, GS_STUDENT-ZENAME, GS_STUDENT-ZTEL.

*ENDLOOP.





*

*CLEAR  : GS_STUDENT, GT_STUDENT.

*GS_STUDENT-ZCODE = 'SSU-11'.

*GS_STUDENT-ZPERNR = '0000000011'.

*GS_STUDENT-ZKNAME = '##'.

*GS_STUDENT-ZENAME = 'AH'.

*GS_STUDENT-ZGENDER = 'F'.

*GS_STUDENT-ZTEL = '01000002222'.

*

*APPEND GS_STUDENT TO GT_STUDENT.

*

*CLEAR  : GS_STUDENT.

*GS_STUDENT-ZCODE = 'SSU-12'.

*GS_STUDENT-ZPERNR = '0000000012'.

*GS_STUDENT-ZKNAME = '###'.

*GS_STUDENT-ZENAME = 'DO'.

*GS_STUDENT-ZGENDER = 'F'.

*GS_STUDENT-ZTEL = '01011112222'.

*

*APPEND GS_STUDENT TO GT_STUDENT.

*

*CLEAR  : GS_STUDENT.

*

*GS_STUDENT-ZCODE = 'SSU-15'.

*GS_STUDENT-ZPERNR = '0000000015'.



*MODIFY ZEDT00_001 FROM GS_STUDENT.

*MODIFY ZEDT00_001 FROM TABLE GT_STUDENT.





*DELETE ZEDT00_001 FROM GS_STUDENT.

*DELETE ZEDT00_001 FROM TABLE GT_STUDENT.

*DELETE FROM ZEDT00_001 WHERE ZTEL = '01000002222'.



*UPDATE ZEDT00_001 FROM GS_STUDENT.

*UPDATE ZEDT00_001 FROM TABLE GT_STUDENT.

*UPDATE ZEDT00_001 SET ZENAME = 'JUNG' WHERE ZCODE = 'SSU-03'.



*

*IF SY-SUBRC = 0.

**  WRITE : /'##### ##'.

**  WRITE : / '### ## ##'.

*  WRITE : / '### ## ##'.

*ELSE.

*  WRITE : / '##'.

*ENDIF.

**

*APPEND GS_STUDENT TO GT_STUDENT.

*

*

*

*CLEAR : GS_STUDENT.

*GS_STUDENT-MANDT = SY-MANDT.

*GS_STUDENT-ZCODE = 'SSU-29'.

*GS_STUDENT-ZPERNR = '0000000029'.

*GS_STUDENT-ZKNAME = '###'.

*GS_STUDENT-ZENAME = 'DO'.

*GS_STUDENT-ZGENDER = 'F'.

*GS_STUDENT-ZTEL = '01011112222'.

*

*APPEND GS_STUDENT TO GT_STUDENT.

*

*INSERT ZEDT00_001 FROM TABLE GT_STUDENT ACCEPTING DUPLICATE KEYS.

*

*IF SY-SUBRC  = 0.

*  WRITE : / '##'.

*ELSE.

*  WRITE : / '##'.

*ENDIF.



*DATA : BEGIN OF GS_SCARR,

*  CARRID LIKE SCARR-CARRID,

*  CARRNAME LIKE SCARR-CARRNAME,

*  END OF GS_SCARR.

*

*DATA: GT_SCARR LIKE TABLE OF GS_SCARR.



*SELECT CARRID CARRNAME INTO (GS_SCARR-CARRID, GS_SCARR-CARRNAME)

*  FROM SCARR

*  WHERE CARRID = 'AA'.

*

*  WRITE : / GS_SCARR-CARRID, GS_SCARR-CARRNAME.

*ENDSELECT.



*

*SELECT SINGLE CARRID CARRNAME INTO ( GS_SCARR-CARRID, GS_SCARR-CARRNAME )

*  FROM SCARR

*  WHERE CARRID = 'AA'.

*

*  WRITE : / GS_SCARR-CARRID, GS_SCARR-CARRNAME.

*

*SELECT CARRID

*        CARRNAME

*        FROM SCARR

*        INTO TABLE GT_SCARR

*        WHERE CARRID = 'AA'.



*SELECT CARRID

*  CARRNAME

*  FROM SCARR

*  INTO CORRESPONDING FIELDS OF TABLE GT_SCARR

*  WHERE CARRID = 'AA'.

*

*

*SELECT CARRID

*        CARRNAME

*        FROM SCARR

*        APPENDING CORRESPONDING FIELDS OF TABLE GT_SCARR

*        WHERE CARRID  = 'AB'.



*

*SELECT CARRID

*        CARRNAME

*        FROM SCARR

*        INTO CORRESPONDING FIELDS OF TABLE GT_SCARR

*        WHERE CARRID BETWEEN 'AA' AND 'AB'.





*SELECT CARRID

*        CARRNAME

*        FROM SCARR

*        INTO CORRESPONDING FIELDS OF TABLE GT_SCARR

*        WHERE CARRID IN ( 'AA', 'AC' ).



*SELECT CARRID

*        CARRNAME

*        FROM SCARR

*        INTO CORRESPONDING FIELDS OF TABLE GT_SCARR

*        WHERE CARRID BETWEEN 'AA' AND 'AB'.

*



*SELECT CARRID

*        CARRNAME

*        FROM SCARR

*        INTO CORRESPONDING FIELDS OF TABLE GT_SCARR

*        WHERE CARRID LIKE 'A%'.

*

*SELECT CARRID

*        CARRNAME

*        FROM SCARR

*        INTO CORRESPONDING FIELDS OF TABLE GT_SCARR

*        WHERE CARRID IN ( 'AA', 'AC' ).



*RANGES GR_SCARR FOR SCARR-CARRID.

*CLEAR : GR_SCARR.



*DATA : BEGIN OF GS_SCARR,

*  ZCHECK TYPE C,

*  CARRID LIKE SCARR-CARRNAME,

*  CARRNAME LIKE SCARR-CARRNAME,

*  END OF GS_SCARR.

*DATA : GT_SCARR LIKE TABLE OF GS_SCARR.







*GR_SCARR-SIGN = 'I'.

*GR_SCARR-OPTION = 'EQ'.

*GR_SCARR-LOW = 'AA'.

*APPEND GR_SCARR.

*

*GR_SCARR-LOW = 'AC'.

*APPEND GR_SCARR.

*

*DATA : BEGIN OF GS_SCARR.

*  INCLUDE TYPE SCARR.

*DATA :END OF GS_SCARR.

*DATA : GT_SCARR LIKE TABLE OF GS_SCARR.

*

*SELECT * FROM SCARR

*    INTO CORRESPONDING FIELDS OF TABLE GT_SCARR

*    WHERE CARRID IN GR_SCARR.



*

*SELECT CARRID

*        CARRNAME

*        FROM SCARR

*        INTO CORRESPONDING FIELDS OF TABLE GT_SCARR

*        WHERE CARRID IN GR_SCARR.





*DATA : BEGIN OF GS_SFLIGHT,

*  CARRID TYPE SFLIGHT-CARRID,

*  CONNID TYPE SFLIGHT-CONNID,

**  GV_SUM TYPE I,

**  PRICE TYPE SFLIGHT-PRICE,

*  CARRNAME TYPE SCARR-CARRNAME,

*  END OF GS_SFLIGHT.

*DATA : GT_SFLIGHT LIKE TABLE OF GS_SFLIGHT.



*SELECT CARRID

*        CONNID

*        AVG( PRICE ) AS GV_SUM

*        INTO CORRESPONDING FIELDS OF TABLE GT_SFLIGHT

*        FROM SFLIGHT GROUP BY CARRID CONNID

*        HAVING AVG( PRICE ) > 1000

*        ORDER BY GV_SUM.





*SELECT CARRID

*        CONNID

*        PRICE

*        INTO CORRESPONDING FIELDS OF TABLE GT_SFLIGHT

*  FROM SFLIGHT AS A

*  WHERE CARRID IN ( SELECT CARRID

*                      FROM SFLIGHT

*                      WHERE CARRID = A~CARRID

*                      AND CONNID = A~CONNID )

*  AND CARRID = 'AA'

*  AND CONNID LIKE '00%'.



*

*SELECT A~CARRID

*        A~CONNID

*        B~CARRNAME

*        INTO CORRESPONDING FIELDS OF TABLE GT_SFLIGHT

*        FROM SFLIGHT AS A

*        INNER JOIN SCARR AS B

*        ON A~CARRID = B~CARRID

*        WHERE A~CARRID = 'AA'.

*





*SELECT A~CARRID

*        A~CONNID

*        B~CARRNAME

*        INTO CORRESPONDING FIELDS OF TABLE GT_SFLIGHT

*        FROM SFLIGHT AS A

*        LEFT OUTER JOIN SCARR AS B

*        ON A~CARRID = B~CARRID

*        WHERE A~CARRID = 'AA'.



*

*DATA : BEGIN OF GS_SPFLI,

*    CARRID TYPE SPFLI-CARRID,

*    CONNID TYPE SPFLI-CONNID,

*    END OF GS_SPFLI.

*DATA : GT_SPFLI LIKE TABLE OF GS_SPFLI.



*

*DATA : BEGIN OF GS_SFLIGHT,

*  CARRID TYPE SFLIGHT-CARRID,

*  CONNID TYPE SFLIGHT-CONNID,

*  FLDATE TYPE SFLIGHT-FLDATE,

*  PRICE TYPE SFLIGHT-PRICE,

*  END OF GS_SFLIGHT.

*DATA : GT_SFLIGHT LIKE TABLE OF GS_SFLIGHT.

*

*SELECT CARRID

*       CONNID

*   FROM  SPFLI

*    INTO CORRESPONDING FIELDS OF TABLE GT_SPFLI

*    WHERE CARRID LIKE 'A%'.

*

*

*

*IF GT_SPFLI IS NOT INITIAL.

*  SELECT CARRID

*          CONNID

*          FLDATE

*          PRICE

*     FROM SFLIGHT

*     INTO CORRESPONDING FIELDS OF TABLE GT_SFLIGHT

*      FOR ALL ENTRIES IN GT_SPFLI

*      WHERE CARRID = GT_SPFLI-CARRID

*      AND CONNID = GT_SPFLI-CONNID.

*    ENDIF.





*SELECT CARRID

*       CONNID

*       FLDATE

*   FROM SFLIGHT

*   INTO CORRESPONDING FIELDS OF TABLE GT_SFLIGHT

*    FOR ALL ENTRIES IN GT_SPFLI

*    WHERE CARRID = GT_SPFLI-CARRID

*    AND CONNID = GT_SPFLI-CONNID.





*LOOP AT GT_SFLIGHT INTO GS_SFLIGHT.

*  WRITE : / GS_SFLIGHT-CARRID, GS_SFLIGHT-CONNID, GS_SFLIGHT-FLDATE, GS_SFLIGHT-PRICE.

*ENDLOOP.





*PARAMETERS : P_ZCODE LIKE ZEDT00_001-ZCODE.

*PARAMETERS : P_ZPERNR TYPE C LENGTH 10 NO-DISPLAY.

*PARAMETERS : P_ZGEN LIKE ZEDT00_001-ZGENDER DEFAULT 'M'.

*PARAMETERS : P_R1 RADIOBUTTON GROUP R1 DEFAULT 'X'.

*PARAMETERS : P_R2 RADIOBUTTON GROUP R1.

*PARAMETERS : Z_CHECK AS CHECKBOX DEFAULT 'X'.

*

*IF P_R1 = 'X'.

*  WRITE : / '#### ##'.

*ELSE.

*  WRITE : / '## ##'.

*ENDIF.





*SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

*  PARAMETERS : P_ZCODE LIKE ZEDT00_001-ZCODE.

*  PARAMETERS : P_ZPERNR TYPE C LENGTH 10 NO-DISPLAY.

*  PARAMETERS : P_ZGEN LIKE ZEDT00_001-ZGENDER DEFAULT 'M'.

*SELECTION-SCREEN END OF BLOCK B1.

*

*SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

*  PARAMETERS : P_R1 RADIOBUTTON GROUP R1 DEFAULT 'X'.

*  PARAMETERS : P_R2 RADIOBUTTON GROUP R1.

*  PARAMETERS : Z_CHECK AS CHECKBOX DEFAULT 'X'.

*SELECTION-SCREEN END OF BLOCK B2.

*

*SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

*  PARAMETERS : P_ZCODE LIKE ZEDT00_001-ZCODE.

*  PARAMETERS : P_ZPERNR TYPE C LENGTH 10 NO-DISPLAY.

*  PARAMETERS : P_ZGEN LIKE ZEDT00_001-ZGENDER DEFAULT 'X'.

*SELECTION-SCREEN END OF BLOCK B1.

*

*SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

*  SELECTION-SCREEN BEGIN OF LINE.

*  PARAMETERS : P_R1 RADIOBUTTON GROUP R1 DEFAULT 'X'.

*  SELECTION-SCREEN POSITION 3.

*  SELECTION-SCREEN COMMENT (10) FOR FIELD P_R1.

*  PARAMETERS : P_R2 RADIOBUTTON GROUP R1.

*  SELECTION-SCREEN POSITION 20.

*  SELECTION-SCREEN COMMENT (10) FOR FIELD P_R2.

*  SELECTION-SCREEN END OF LINE.

*SELECTION-SCREEN END OF BLOCK B2.





*

*DATA : GS_STUDENT TYPE ZEDT00_001.

*DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

*

*SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

*  PARAMETERS : P_ZCODE LIKE ZEDT00_001-ZCODE.

*  PARAMETERS : P_ZPERNR TYPE C LENGTH 10 NO-DISPLAY.

*  PARAMETERS : P_ZGEN LIKE ZEDT00_001-ZGENDER DEFAULT 'M'.

*SELECTION-SCREEN END OF BLOCK B1.

*

*SELECT * FROM ZEDT00_001

*  INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT

*  WHERE ZCODE = P_ZCODE

*  AND ZGENDER = P_ZGEN.

*

*IF GT_STUDENT[] IS NOT INITIAL.

*  WRITE : / '### ##'.

*ELSE.

*  WRITE : /  '### ##'.

*ENDIF.





*TABLES : ZEDT00_001.

*

*DATA : BEGIN OF GS_STUDENT.

*  INCLUDE TYPE ZEDT00_001.

*  DATA : END OF GS_STUDENT.

*DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

*

*SELECT-OPTIONS : S_ZCODE FOR ZEDT00_001-ZCODE.

*PARAMETERS : P_ZGEN LIKE ZEDT00_001-ZGENDER.





*TABLES : ZEDT00_001.

*

*DATA : BEGIN OF GS_STUDENT.

*  INCLUDE TYPE ZEDT00_001.

*  DATA : END OF GS_STUDENT.

*  DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.



*SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

*  SELECT-OPTIONS : S_ZCODE FOR ZEDT00_001-ZCODE.

*  SELECTION-SCREEN END OF BLOCK B1.





*SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

*    SELECT-OPTIONS : S_ZCODE FOR ZEDT00_001-ZCODE.

*SELECTION-SCREEN END OF BLOCK B1.

*SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

*      PARAMETERS : P_ZGEN LIKE ZEDT00_001-ZGENDER.

*SELECTION-SCREEN END OF BLOCK B2.

*







*SELECT-OPTIONS : S_ZCODE FOR ZEDT00_001-ZCODE DEFAULT 'SSU-01'.

*PARAMETERS : P_ZGEN LIKE ZEDT00_001-ZGENDER.

**

*SELECT-OPTIONS S_ZCODE FOR ZEDT00_001-ZCODE DEFAULT 'SSU-01' SIGN E OPTION EQ.

*SELECT-OPTIONS : S_ZCODE FOR ZEDT00_001-ZCODE DEFAULT 'SSU-01' TO 'SSU-99' SIGN I OPTION BT.

*SELECT-OPTIONS : S_ZCODE FOR ZEDT00_001-ZCODE DEFAULT 'SSU-01' NO INTERVALS NO-EXTENSION.

*

*SELECT-OPTIONS : S_ZCODE FOR ZEDT00_001-ZCODE DEFAULT 'SSU-01' VISIBLE LENGTH 3.

*PARAMETERS : P_ZGEN LIKE ZEDT00_001-ZGENDER.



*SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

*  SELECT-OPTIONS : S_ZCODE FOR ZEDT00_001-ZCODE.

*  PARAMETERS : P_ZPERNR LIKE ZEDT00_001-ZPERNR MODIF ID M1.

*  PARAMETERS : P_ZGEN LIKE ZEDT05_001-ZGENDER MATCHCODE OBJECT ZSH00_001 MODIF ID M2.

*SELECTION-SCREEN END OF BLOCK B1.

*SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME.

**  PARAMETERS : P_CH1 AS CHECKBOX DEFAULT 'X' MODIF ID M1.

**  PARAMETERS : P_CH2 AS CHECKBOX MODIF ID M2.

*  PARAMETERS : P_R1 RADIOBUTTON GROUP R1 DEFAULT 'X' USER-COMMAND UC1.

*  PARAMETERS : P_R2 RADIOBUTTON GROUP R1.

*SELECTION-SCREEN END OF BLOCK B2.

*

**AT SELECTION-SCREEN OUTPUT.

**  LOOP AT SCREEN.

**    IF SCREEN-GROUP1 = 'M2'.

***    IF SCREEN-NAME = 'P_CH2'.

***      SCREEN-INPUT ='0'.

***      SCREEN-ACTIVE = '0'.

***      SCREEN-REQUIRED = '1'.

**      SCREEN-OUTPUT = '0'.

**      MODIFY SCREEN.

**    ENDIF.

**ENDLOOP.

*

*AT SELECTION-SCREEN OUTPUT.

*  LOOP AT SCREEN.

**     IF SCREEN-GROUP1 = 'M2'.

**       SCREEN-DISPLAY_3D = '1'.

**     ENDIF.

**     MODIFY SCREEN.

*

*    IF SCREEN-GROUP1 = 'M2'.

*      IF P_R1 = 'X'.

*        SCREEN-ACTIVE = '1'.

*      ELSEIF P_R2 = 'X'.

*        SCREEN-ACTIVE = '0'.

*      ENDIF.

*    ENDIF.

*    MODIFY SCREEN.

*  ENDLOOP.

*

*

*SELECT * FROM ZEDT00_001

*  INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT

*  WHERE ZCODE IN S_ZCODE.

**  AND ZGENDER = P_ZGEN.

*

*IF GT_STUDENT[] IS NOT INITIAL.

*  CLEAR : GS_STUDENT.

*  LOOP AT GT_STUDENT INTO GS_STUDENT.

*    WRITE: / GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME.

*  ENDLOOP.

*ELSE.

*  WRITE : / '### ##'.

*ENDIF.



*DATA : BEGIN OF GS_STUDENT.

*  INCLUDE TYPE ZEDT05_001.

*DATA: END OF GS_STUDENT.

*DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

*DATA : GV_FLAG.

*

*SELECT SINGLE * FROM ZEDT05_001

*  INTO GS_STUDENT WHERE ZCODE = 'SSU-01'.

*

*PERFORM DELETE_DATA USING GS_STUDENT.

*PERFORM INSERT_DATA ON COMMIT.

*

*IF GV_FLAG = 'X'.

*  COMMIT WORK.

*ENDIF.

**&---------------------------------------------------------------------*

**&      Form  DELETE_DATA

**&---------------------------------------------------------------------*

**       text

**----------------------------------------------------------------------*

**      -->P_GS_STUDENT  text

**----------------------------------------------------------------------*

*form DELETE_DATA using PS_STUDENT.

*  DELETE ZEDT05_001 FROM PS_STUDENT.

*  IF SY-SUBRC = 0.

*    GV_FLAG = 'X'.

*  ENDIF.

*endform.

**&---------------------------------------------------------------------*

**&      Form  INSERT_DATA

**&---------------------------------------------------------------------*

**       text

**----------------------------------------------------------------------*

**  -->  p1        text

**  <--  p2        text

**----------------------------------------------------------------------*

*form INSERT_DATA .

*  INSERT ZEDT05_001 FROM GS_STUDENT.

*endform.


















TABLES : ZEDT05_001.



DATA : BEGIN OF GS_STUDENT.

  include structure
ZEDT05_001
.

  DATA : END OF GS_STUDENT.

DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.



SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS : S_ZCODE FOR ZEDT05_001-ZCODE.

  PARAMETERS : P_ZPERNR LIKE ZEDT05_001.

  PARAMETERS : P_ZGEN LIKE ZEDT05_001-ZGENDER DEFAULT 'M' MODIF ID SC1.

SELECTION-SCREEN END OF BLOCK B1.



INITIALIZATION.

S_ZCODE-LOW = 'SSU-02'.

S_ZCODE-HIGH = 'SSU-99'.

S_ZCODE-SIGN = 'I'.

S_ZCODE-OPTION = 'BT'.

APPEND S_ZCODE.








*AT SELECTION-SCREEN ON END OF S_ZCODE.




AT SELECTION-SCREEN OUTPUT.




*  LOOP AT S_ZCODE.

*    IF S_ZCODE-LOW NE 'SSU-01'.

*      MESSAGE '##### SSU-01## #####' TYPE 'E'.

*    ENDIF.






  LOOP AT SCREEN.

    IF SCREEN-GROUP1 = 'SC1'.

      SCREEN-INPUT = 0.

    ENDIF.

    MODIFY SCREEN.

  ENDLOOP.





IF S_ZCODE IS INITIAL.

  MESSAGE E000.

ENDIF.







START-OF-SELECTION.

  PERFORM GET_DATA.



IF GT_STUDENT IS INITIAL.

  MESSAGE I001.

  EXIT.

ENDIF.



FORM GET_DATA.





    SELECT * FROM ZEDT05_001

      INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT

      WHERE ZCODE IN S_ZCODE.




*      AND ZGENDER = P_ZGEN.



*

*

*  CASE GS_STUDENT-ZCODE.

*    WHEN 'SSU-01'.

*      GS_STUDENT-ZCODE = 'SSU-01'.

*    WHEN 'SSU-02'.

*      GS_STUDENT-ZCODE = 'SSU-02'.

*  ENDCASE.






ENDFORM.