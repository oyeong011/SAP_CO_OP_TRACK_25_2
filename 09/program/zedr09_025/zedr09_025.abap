
*&---------------------------------------------------------------------*

*& Report ZEDR09_025

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR09_025.






* =====================================================================

* report EVENT



* 1. report ### ???

*   abap##### #### ##(selection screen)# ### ##(data processing)# #### #### ####.

*   ### #### #### ## '###'##.

*   1) initialization : ### ## #, ### ##

*   2) at selection-screen : #### #### ### #, ## ##

*   3) start-of-selection : ####(f8) ## #, ###### ##

*   4) end-of-selection : ### ### ### ~ ## # ### ##



* # ### ##

* 1. initialization

*   - ### #### ##, ## ##### ## #### ## ## #### ##

*   - ex) #### ### ### ####, #### ### ssu-01 ~ ssu-09# ## ## ### ## ##



* 2. at selection-screen

*   - #### ### ## #### ## ## ### ## # ####, #### ##### ## ##### ## ##

*   - ## ##

*     on field : ## ### ### ##### ## ## #### ### ###

*     on end of field : ## ## ### ## #### ### ### # (#: ##/## # ##)

*     output : ### #### ##, ## ### ## ### ####/#######/## ## #...



* 3. start-of-selection

*   - ####(f8)# ###, ## ## #### ###.

*   - ##, ######## #### #### select ### ## ###



* 4. end-of-selection

*   - select### ## #### ## ### #, ##### #### ###. write# ## ## ## ### ###



* =====================================================================





* 1. initialization




TABLES : ZEDT09_001.



DATA : GS_STUDENT LIKE ZEDT09_001.

DATA : GT_STUDENT LIKE TABLE OF ZEDT09_001.



SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME.

  SELECT-OPTIONS : S_ZCODE FOR ZEDT09_001-ZCODE.

  PARAMETERS : P_ZPERNR LIKE ZEDT09_001-ZPERNR.

  PARAMETERS : P_ZGEN LIKE ZEDT09_001-ZGENDER DEFAULT 'M'.

SELECTION-SCREEN END OF BLOCK B1.



INITIALIZATION.

S_ZCODE-LOW = 'SSU-02'.

S_ZCODE-HIGH = 'SSU-09'.

APPEND S_ZCODE.






* 2. at selection-screen <<< ### (ZEDR09_020 #### ##)

*AT SELECTION-SCREEN ON S_ZCODE. " ON ### : selection screen## #### ## ### ## ## !

*  IF S_ZCODE-LOW NE 'SSU-01'.

*    MESSAGE '##### SSU-01## #####' TYPE 'I'.

*  ENDIF.






AT SELECTION-SCREEN ON END OF S_ZCODE. "on end of field ##

  LOOP AT S_ZCODE.

    IF S_ZCODE-LOW NE 'SSU-01'.

      MESSAGE '##### SSU-01## #####' TYPE 'I'.

    ENDIF.

  ENDLOOP.






* 3. start-of-selection




START-OF-SELECTION.

  PERFORM GET_DATA.



FORM GET_DATA . "## selection-screen# ## select### ### ##

  SELECT *

  FROM ZEDT09_001

  INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT

  WHERE ZCODE IN S_ZCODE

  AND ZGENDER = P_ZGEN.

ENDFORM.






* 4. end-of-selection




END-OF-SELECTION.

  PERFORM write_data.





FORM WRITE_DATA . "GET_DATA## ### GT_STUDENT LOOP# ##

  LOOP AT GT_STUDENT INTO GS_STUDENT.

    WRITE : / GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME.

  ENDLOOP.



ENDFORM.








*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ##### SSU-01## #####