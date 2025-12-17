
*&---------------------------------------------------------------------*

*& Report ZEDR09_015

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR09_015.






* =====================================================================

* INTERNAL TABLE ## ## 5##

* ## 5## ## # 4## ## ## ###, ## # ### ## # ## !!!



* 1. ## READ ## : ### ## ####, ## ##

* 2. TABLE KEY ## : 1## ## ##. #### READ ## ###### ## ## ###, ## ##

* 3. WORK AREA ## : ### #### ##, COMPARING / TRANSPORTING #### ##,### ##

* 4. INDEX ## : ## ## ##, ## ##

* 5. BINARY SEARCH : ## ### ## ##, ## ## (####)



* =====================================================================






"###### #### ###### ##

DATA : GS_STUDENT TYPE ZEDT09_001.

DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.





" #### #### ###### ##

DATA : BEGIN OF GS_MAJOR,

  ZCODE TYPE ZEDT09_001-ZCODE, "####

  ZPERNR TYPE ZEDT09_001-ZPERNR, "####

  ZMNAME TYPE ZEDT09_002-ZMNAME, "###

END OF GS_MAJOR.



" ## READ ### ######## # ##! (####, SYNTAX ### #### READ# ###!) <- 1#### ## ####, 2#### ## #

DATA : GT_MAJOR LIKE TABLE OF GS_MAJOR WITH NON-UNIQUE KEY ZCODE.



CLEAR : GS_STUDENT, GT_STUDENT, GS_MAJOR, GT_MAJOR.






* ## ## ####### #### ##




GS_STUDENT-ZPERNR = '0000000001'.

GS_STUDENT-ZCODE = 'SSU-01'.

GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'DONG'.

GS_STUDENT-ZGENDER = 'M'.

GS_STUDENT-ZTEL = '01011112222'.

APPEND GS_STUDENT TO GT_STUDENT.



CLEAR : GS_STUDENT.

GS_STUDENT-ZPERNR = '0000000002'.

GS_STUDENT-ZCODE = 'SSU-02'.

GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'HOON'.

GS_STUDENT-ZGENDER = 'M'.

GS_STUDENT-ZTEL = '01011112223'.

APPEND GS_STUDENT TO GT_STUDENT.



GS_STUDENT-ZPERNR = '0000000003'.

GS_STUDENT-ZCODE = 'SSU-03'.

GS_STUDENT-ZKNAME = '##'.

GS_STUDENT-ZENAME = 'BIN'.

GS_STUDENT-ZGENDER = 'M'.

GS_STUDENT-ZTEL = '01011112224'.

APPEND GS_STUDENT TO GT_STUDENT.



GS_STUDENT-ZPERNR = '0000000004'.

GS_STUDENT-ZCODE = 'SSU-04'.

GS_STUDENT-ZKNAME = '##'.

GS_STUDENT-ZENAME = 'JENNY'.

GS_STUDENT-ZGENDER = 'F'.

GS_STUDENT-ZTEL = '01011112225'.

APPEND GS_STUDENT TO GT_STUDENT.



GS_STUDENT-ZPERNR = '0000000005'.

GS_STUDENT-ZCODE = 'SSU-05'.

GS_STUDENT-ZKNAME = '##'.

GS_STUDENT-ZENAME = 'KOOK'.

GS_STUDENT-ZGENDER = 'M'.

GS_STUDENT-ZTEL = '01011112226'.

APPEND GS_STUDENT TO GT_STUDENT.








* # ###### ## ### ##




GS_MAJOR-ZCODE = 'SSU-01'.

GS_MAJOR-ZPERNR = '0000000001'.

GS_MAJOR-ZMNAME = '####'.

APPEND GS_MAJOR TO GT_MAJOR.



GS_MAJOR-ZCODE = 'SSU-02'.

GS_MAJOR-ZPERNR = '0000000002'.

GS_MAJOR-ZMNAME = '#####'.

APPEND GS_MAJOR TO GT_MAJOR.



GS_MAJOR-ZCODE = 'SSU-03'.

GS_MAJOR-ZPERNR = '0000000003'.

GS_MAJOR-ZMNAME = '######'.

APPEND GS_MAJOR TO GT_MAJOR.



GS_MAJOR-ZCODE = 'SSU-04'.

GS_MAJOR-ZPERNR = '0000000004'.

GS_MAJOR-ZMNAME = '####'.

APPEND GS_MAJOR TO GT_MAJOR.



GS_MAJOR-ZCODE = 'SSU-05'.

GS_MAJOR-ZPERNR = '0000000005'.

GS_MAJOR-ZMNAME = '#####'.

APPEND GS_MAJOR TO GT_MAJOR.








* 1. ## READ ##

* READ TABLE itab FROM wa INTO result.

* -> itab ######## ## ##, ##### wa(workArea)# ### key###.

* -> #, itab ######## ## wa# ## ### ## ###, result# #####.

* -> # ## ###, READ ## & ## # SY-SUBRC = 0








CLEAR : GS_STUDENT.





LOOP AT GT_STUDENT INTO GS_STUDENT.

  CLEAR : GS_MAJOR.

  MOVE-CORRESPONDING GS_STUDENT TO GS_MAJOR. "## ## GS_STUDENT# ## GS_MAJOR# #### # (ZCODE, ZPERNR) ##



  READ TABLE GT_MAJOR FROM GS_MAJOR INTO GS_MAJOR.

  "GT_MAJOR ########, GS_MAJOR key(ZCODE)# ### ## ###, GS_MAJOR# ## #



  IF SY-SUBRC = 0.

     WRITE : / GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME, GS_MAJOR-ZMNAME.

  ELSE.

     WRITE : / '#### #### #####.'.

  ENDIF.



  CLEAR : GS_STUDENT.

ENDLOOP.








* 2. TABLE KEY ##



* READ TABLE itab WITH TABLE KEY ## ( INTO RESUlT )

* itab######## #### ## ##, TABLE KEY ### ## ##, RESULT# ## ##.

* 1# ## #####, #### READ ## #### ### # ## ## ### 1# ## syntax ### ##!!






WRITE : / , / , '2# ##'.



CLEAR : GS_STUDENT.

LOOP AT GT_STUDENT INTO GS_STUDENT.

  CLEAR : GS_MAJOR.

" MOVE-CORRESPONDING GS_STUDENT TO GS_MAJOR.



  " GS_MAJOR# ZMNAME ### #### ### ###.

  READ TABLE GT_MAJOR WITH TABLE KEY ZCODE = GS_STUDENT-ZCODE

  INTO GS_MAJOR.



  IF SY-SUBRC = 0.

    WRITE : / GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME, GS_MAJOR-ZMNAME.

  ELSE.

    WRITE : / '#### #### #####.'.

  ENDIF.



  CLEAR : GS_STUDENT.

ENDLOOP.










* 3. WORK AREA ## : ### #### ##, COMPARING / TRANSPORTING #### ##,### ##

* READ TABLE itab WITH KEY (##) INTO ws.

* - #####? ### # ###..(f1, f2..)

* - ####? ### ## # # ###, "wa"# ##



* - COMPARING ##

* - TRANSPORTING ##

* -> # ## ### ### ### ### !!






WRITE : / , / , '3# ##'.

CLEAR : GS_STUDENT.

LOOP AT GT_STUDENT INTO GS_STUDENT.

  CLEAR : GS_MAJOR.



  READ TABLE GT_MAJOR WITH KEY ZCODE = GS_STUDENT-ZCODE "# ## ## #, ### READ

  INTO GS_MAJOR.



  IF SY-SUBRC = 0.

    WRITE : / GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME, GS_MAJOR-ZMNAME.

  ELSE.

    WRITE : / '#### #### #####.'.

  ENDIF.

ENDLOOP.



WRITE : / , / , '3# ## -2'.

LOOP AT GT_STUDENT INTO GS_STUDENT.

  CLEAR : GS_MAJOR.



  READ TABLE GT_MAJOR WITH KEY ZCODE = GS_STUDENT-ZCODE "#### # # ### 2# ### ##, Comma## ## # ### READ

                               ZPERNR = GS_STUDENT-ZPERNR

  INTO GS_MAJOR.



  IF SY-SUBRC = 0.

    WRITE : / GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME, GS_MAJOR-ZMNAME.

  ELSE.

    WRITE : / '#### #### #####.'.

  ENDIF.

ENDLOOP.






* 3. WORK AREA ## : ### #### ##, COMPARING / TRANSPORTING #### ##,### ##

* READ TABLE itab WITH KEY (##) INTO ws.

* - #####? ### # ###..(f1, f2..)

* - ####? ### ## # # ###, "wa"# ##



* - COMPARING ## (NEW !!)

*   READ TABLE itab WITH KEY (##) INTO ws COMPARING f1.

*   -> ## ## + # ## ### ### ##!

*   -> #, ## READ# ## # ### work area# ##,

*      work Area# ## ##(f1)# ### ## "##"### ##!

*   -> #### ## ###, SY-SUBRC = 0# ##, ## ## ### 2 ##



* - TRANSPORTING ##

*   READ TABLE itab WITH KEY (##) INTO ws TRANSPORTING f1.

*   -> COMPARING# ### '##', TRANSPORTING# ### '## ###'. #, #### ### ## ##.

*   -> #, # ### #### ##, ### ### Work Area# ###.



* - COMPARING ##




WRITE : / , / , '4# ##'.

CLEAR : GS_STUDENT.

LOOP AT GT_STUDENT INTO GS_STUDENT.

  MOVE-CORRESPONDING GS_STUDENT TO GS_MAJOR.



  READ TABLE GT_MAJOR WITH KEY ZCODE = GS_STUDENT-ZCODE INTO GS_MAJOR

  COMPARING ZCODE.

  "#, READ TABLE# ## GT_MAJOR ######## ## # #### GS_MAJOR# ### # (# ## ### ##)

  "GS_MAJOR# GT_MAJOR# ZCODE# ### ## # ##





  IF SY-SUBRC = 0.

    WRITE : / GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME, GS_MAJOR-ZMNAME.

  ELSE.

    WRITE : / '#### #### #####.'.

  ENDIF.



  CLEAR : GS_STUDENT.

ENDLOOP.






* - TRANSPORTING ## : (#####) READ# ###, # # ### ## ##, ### ### ### ##!




WRITE : / , / , '5# ##'.

CLEAR : GS_STUDENT.



LOOP AT GT_STUDENT INTO GS_STUDENT.

  CLEAR : GS_MAJOR.



  READ TABLE GT_MAJOR WITH KEY ZCODE = GS_STUDENT-ZCODE INTO GS_MAJOR

  TRANSPORTING ZMNAME.



  IF SY-SUBRC = 0.

    WRITE : / GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME, GS_MAJOR-ZMNAME.

  ELSE.

    WRITE : / '#### #### #####.'.

  ENDIF.



  CLEAR : GS_STUDENT.

ENDLOOP.








* 4. INDEX <- ## #!! # ### # !!



* READ TABLE itab INTO wa INDEX n

* -> itab### ## n## '#'# ### ##, ## wa# ### ###!

* -> INDEX# n# ######, ### ### ##### ##### ##### SORT ## !!






WRITE : / , / , '6# ##'.

CLEAR : GS_STUDENT.



SORT GT_STUDENT BY ZCODE.

SORT GT_MAJOR BY ZCODE.

LOOP AT GT_STUDENT INTO GS_STUDENT.

  CLEAR : GS_MAJOR.



  READ TABLE GT_MAJOR INTO GS_MAJOR INDEX SY-TABIX

  TRANSPORTING ZMNAME.



  IF SY-SUBRC = 0.

    WRITE : / GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME, GS_MAJOR-ZMNAME.

  ELSE.

    WRITE : / '#### #### #####.'.

  ENDIF.

  CLEAR : GS_STUDENT.

ENDLOOP.








* 5. Binary Search






WRITE : / , / , '7# ##'.




* READ TABLE itab WITH KEY (##) INTO wa BINARY SEARCH.




LOOP AT GT_STUDENT INTO GS_STUDENT.

  CLEAR : GS_MAJOR.

  MOVE-CORRESPONDING GS_STUDENT TO GS_MAJOR.



  READ TABLE GT_MAJOR WITH KEY ZCODE = GS_STUDENT-ZCODE INTO GS_MAJOR

  BINARY SEARCH.



  IF SY-SUBRC = 0.

    WRITE : / GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME, GS_MAJOR-ZMNAME.

  ELSE.

    WRITE : / '#### #### #####.'.

  ENDIF.

  CLEAR : GS_STUDENT.

ENDLOOP.