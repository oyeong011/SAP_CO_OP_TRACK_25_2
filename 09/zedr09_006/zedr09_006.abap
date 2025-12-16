
*&---------------------------------------------------------------------*

*& Report ZEDR09_006

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR09_006.






* =======================================================

* internal table TYPE #, standard type# #### ## # ## #

* # ## ## 2## (0908 ## # ## #)

* 1. move a to b

* 2. move-corresponding a to b

* =======================================================



* # ### ## 2## internal table ####

* ### ## -> internal table ##




DATA : BEGIN OF GS_STUDENT,

  ZCODE TYPE C LENGTH 10,

  ZKNAME TYPE C LENGTH 20,

  ZENAME TYPE C LENGTH 20,

  ZCLASS TYPE C,

END OF GS_STUDENT.



DATA : BEGIN OF GS_STUDENT2,

  ZCODE TYPE C LENGTH 10,

  ZKNAME TYPE C LENGTH 20,

  ZENAME TYPE C LENGTH 20,

  ZCLASS TYPE C,

END OF GS_STUDENT2.



DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

DATA : GT_STUDENT2 LIKE TABLE OF GS_STUDENT2.



GS_STUDENT-ZCODE = 'ssu-09'.

GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'KMJ'.



APPEND GS_STUDENT TO GT_STUDENT.






* =======================================================

* 1. move a to b

* - ## copy

*   MOVE strucuture1 TO structure2

* - ## copy

*   MOVE innertable1[] TO innertable2[]

* =======================================================






MOVE GS_STUDENT TO GS_STUDENT2. " ## copy

MOVE GT_STUDENT[] TO GT_STUDENT2. " ## copy








* =======================================================

* internal table TYPE #, standard type# #### ## # ## #

* # ## ## 2## (0908 ## # ## #)

* 1. move a to b

* 2. move-corresponding a to b << ## ###. ## ##### ## #### #####.

* =======================================================

* =======================================================

* 1. move-corresponding a to b

* - ## copy

*   MOVE-corresponding ###1 to ###2

* - ## copy

*   MOVE-corresponding ######1 to ######2

* =======================================================






DATA : BEGIN OF GS_STUDENT_MC,

  ZCODE TYPE C LENGTH 10,

  ZKNAME TYPE C LENGTH 20,

  ZENAME TYPE C LENGTH 20,

  ZCLASS TYPE C,

END OF GS_STUDENT_MC.



DATA : BEGIN OF GS_STUDENT2_MC,

  ZCODE TYPE C LENGTH 10,

  ZKNAME TYPE C LENGTH 20,

  ZENAME TYPE C LENGTH 20,

  ZCLASS TYPE C,

END OF GS_STUDENT2_MC.



DATA : GT_STUDENT_MC LIKE TABLE OF GS_STUDENT_MC.

DATA : GT_STUDENT2_MC LIKE TABLE OF GS_STUDENT2_MC.



GS_STUDENT_MC-ZCODE = 'ssu-09'.

GS_STUDENT_MC-ZKNAME = '###'.

GS_STUDENT_MC-ZENAME = 'KMJ'.



APPEND GS_STUDENT_MC TO GT_STUDENT_MC.






* ## move-corresponding  a to b# ## ### ### copy###




MOVE-CORRESPONDING GS_STUDENT_MC TO GS_STUDENT2_MC.

MOVE-CORRESPONDING GT_STUDENT_MC[] TO GT_STUDENT2_MC[].






* CLEAR : GT_STUDENT2_MC[]. "## ### ## ### #### clear

* REFRESH : GT_STUDENT2_MC[].

* FREE : GT_STUDENT2_MC[].



* break-point.



* =======================================================

* clear : internalTable# ### ###, ### ### ### ##

* 1. ##### ## internalTable## CLEAR <-- ### ##!

* 2. ##### ## internalTable## CLEAR

* =======================================================




DATA : BEGIN OF GS_STUDENT_CLEAR,

  ZCODE TYPE C LENGTH 10,

  ZKNAME TYPE C LENGTH 10,

  ZENAME TYPE C LENGTH 10,

END OF GS_STUDENT_CLEAR.



DATA : GT_STUDENT_CLEAR LIKE TABLE OF GS_STUDENT_CLEAR.






* ### ## ## # ##




GS_STUDENT_CLEAR-ZCODE = 'ssu-09'.

GS_STUDENT_CLEAR-ZKNAME = '###'.

GS_STUDENT_CLEAR-ZENAME = 'kmj'.






* innerTable body# # #### (### append##)




APPEND GS_STUDENT_CLEAR TO GT_STUDENT_CLEAR.






* BREAK-POINT. - header, body ## #### # ##.



* ##### ## internalTable# CLEAR.




CLEAR : GT_STUDENT_CLEAR. "header# ##, body# ###.






* break-point.



* =======================================================

* clear : internalTable# ### ###, ### ### ### ##

* 1. ##### ## internalTable## CLEAR

* 2. ##### ## internalTable## CLEAR <--- ### ## !

* =======================================================






DATA : BEGIN OF GT_STUDENT_CLEAR2 OCCURS 0, "#### ## internalTable

  ZCODE TYPE C LENGTH 10,

  ZKNAME TYPE C LENGTH 20,

  ZENAME TYPE C LENGTH 20,

END OF GT_STUDENT_CLEAR2.






* header## ###




GT_STUDENT_CLEAR2-ZCODE = 'ssu-09'.

GT_STUDENT_CLEAR2-ZKNAME = '###'.

GT_STUDENT_CLEAR2-ZENAME = 'kmj'.






* body## ### #




APPEND GT_STUDENT_CLEAR2.






* break-point. "header, body ### ### ##.






CLEAR GT_STUDENT_CLEAR2. "##### ## ####### header CLEAR

CLEAR GT_STUDENT_CLEAR2[]. "##### ## ####### body CLEAR






* break-point.



* =======================================================

* refresh, free

* refresh : internalTable# #### ###, CLEAR# ## ### ## X => ### CLEAR# #####, CLEAR# # ## ## #.

* free : refresh ## #, ### ### ##

* =======================================================






DATA : BEGIN OF GS_STUDENT_REFRESH, "refresh #### ### ##

  ZCODE TYPE C LENGTH 10,

  ZKNAME TYPE C LENGTH 20,

  ZENAME TYPE C LENGTH 20,

END OF GS_STUDENT_REFRESH.



DATA : GT_STUDENT_REFRESH LIKE TABLE OF GS_STUDENT_REFRESH. "## ### ####, snternalTable ##






* header ## ###




GS_STUDENT_REFRESH-ZCODE = 'ssu-09'.

GS_STUDENT_REFRESH-ZKNAME = '###'.

GS_STUDENT_REFRESH-ZENAME = 'kmj'.






* body# append# structure# ### ####




APPEND GS_STUDENT_REFRESH TO GT_STUDENT_REFRESH.






* REFRESH ## -> internalTable #### ###, ### ### X




REFRESH : GT_STUDENT_REFRESH. "internalTable# body# ##, ### ### x (### ## ###)






* break-point.



* FREE ## -> REFRESH ## ##, ### ### ## ## => ### CLEAR# ### #### ## # ## ###




FREE : GT_STUDENT_REFRESH.



break-point.