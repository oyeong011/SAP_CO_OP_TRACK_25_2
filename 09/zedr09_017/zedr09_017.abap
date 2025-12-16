
*&---------------------------------------------------------------------*

*& Report ZEDR09_017

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR09_017.






* =====================================================================

* DB TABLE ## - INSERT, UPDATE, DELETE, MODIFY 4##



* MODIFY -> INSERT + UPDATE => ### UPSERT#

* =====================================================================



* =====================================================================

* INSERT#

* - 1## ##

*    INSERT INTO <###> VALUES <###>.

* - ### ##

*    INSERT <###> FROM TABLE <######>.

*    INSERT <###> FROM TABLE <######> ACCEPTING DUPLICATE KEY.

* =====================================================================



* ###### ##




DATA : GS_STUDENT TYPE ZEDT09_001.

DATA : GT_STUDENT TYPE TABLE OF ZEDT09_001.






* KEY# #### data insert ###..




GS_STUDENT-MANDT = sy-mandt.

GS_STUDENT-ZCODE = 'SSU-27'.

GS_STUDENT-ZPERNR = '0000000027'.

GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'DO'.

GS_STUDENT-ZGENDER = 'F'.

GS_STUDENT-ZTEL = '01000001127'.






* INSERT# ### ##

* INSERT INTO ZEDT09_001 VALUES GS_STUDENT.






IF sy-subrc = 0.

  WRITE : / '### insert ##'.

ELSE.

  WRITE : / '### insert ##'.

ENDIF.








* INSERT# ## # ##




CLEAR : GS_STUDENT, GT_STUDENT.

GS_STUDENT-ZCODE = 'SSU-28'.

GS_STUDENT-ZPERNR = '0000000028'.

GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'DA'.

GS_STUDENT-ZGENDER = 'F'.

GS_STUDENT-ZTEL = '01000001128'.

APPEND GS_STUDENT TO GT_STUDENT.



CLEAR : GS_STUDENT.

GS_STUDENT-ZCODE = 'SSU-30'.

GS_STUDENT-ZPERNR = '0000000030'.

GS_STUDENT-ZKNAME = '###2'.

GS_STUDENT-ZENAME = 'CHA2'.

GS_STUDENT-ZGENDER = 'M'.

GS_STUDENT-ZTEL = '01000001130'.

APPEND GS_STUDENT TO GT_STUDENT.








* INSERT# ### ##

* INSERT ZEDT09_001 FROM TABLE GT_STUDENT.






IF sy-subrc = 0.

  WRITE : / 'insert# ### ##'.

ELSE.

  WRITE : / 'insert# ### ##'.

ENDIF.






* INSERT# -> ## # ##




CLEAR : GS_STUDENT, GT_STUDENT.

GS_STUDENT-ZCODE = 'SSU-28'.

GS_STUDENT-ZPERNR = '0000000028'. "## ## ##

GS_STUDENT-ZKNAME = '###2'.

GS_STUDENT-ZENAME = 'DA2'.

GS_STUDENT-ZGENDER = 'F'.

GS_STUDENT-ZTEL = '01000001128'.

APPEND GS_STUDENT TO GT_STUDENT.



CLEAR : GS_STUDENT.

GS_STUDENT-ZCODE = 'SSU-31'.

GS_STUDENT-ZPERNR = '0000000031'.

GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'SOO'.

GS_STUDENT-ZGENDER = 'M'.

GS_STUDENT-ZTEL = '01000001131'.

APPEND GS_STUDENT TO GT_STUDENT.








* INSERT ZEDT09_001 FROM TABLE GT_STUDENT ACCEPTING DUPLICATE KEYS. "###, #### ####, id# ## ### ## #####.






IF sy-subrc = 0.

  WRITE : / 'insert# ### ## ##'.

ELSE.

  WRITE : / 'insert# ### ## ##'.

ENDIF.










* =====================================================================

* UPDATE#

* - 1## ## ##

*    UPDATE <###> FROM wa.

* - ### ## ##

*    UPDATE <###> FROM TABLE <######>.

* - UPDATE SET####, ## ## ### ##

*    UPDATE <###> SET FIELD = '### #' WHERE <##>.

* =====================================================================




CLEAR : GS_STUDENT, GT_STUDENT.



GS_STUDENT-ZCODE = 'SSU-12'.

GS_STUDENT-ZPERNR = '0000000012'.

GS_STUDENT-ZKNAME = '### - ###'.

GS_STUDENT-ZENAME = 'JAE'.

GS_STUDENT-ZGENDER = 'M'.

" GS_STUDENT-ZTEL = '01000001121'. -> #### ZTEL ## ###, # ### ## null# update#. # #### ## ## ### ### #####.

"                                     update ~ set## ####..

APPEND GS_STUDENT TO GT_STUDENT.






* UPDATE ZEDT09_001 FROM GS_STUDENT. "UPDATE# ##






IF sy-subrc = 0.

  WRITE : / '### ## ##'.

ELSE.

  WRITE : / '### ## ##'.

ENDIF.






* UPDATE# ###




CLEAR : GS_STUDENT, GT_STUDENT.

GS_STUDENT-ZCODE = 'SSU-11'.

GS_STUDENT-ZPERNR = '0000000011'.

GS_STUDENT-ZKNAME = '## - ###'.

GS_STUDENT-ZENAME = 'YOON'.

GS_STUDENT-ZGENDER = 'F'.

GS_STUDENT-ZTEL = '01000001131'.

APPEND GS_STUDENT TO GT_STUDENT.



CLEAR : GS_STUDENT.

GS_STUDENT-ZCODE = 'SSU-12'.

GS_STUDENT-ZPERNR = '0000000012'.

GS_STUDENT-ZKNAME = '### - ###'.

GS_STUDENT-ZENAME = 'JAE'.

GS_STUDENT-ZGENDER = 'M'.

GS_STUDENT-ZTEL = '01000001121'.

APPEND GS_STUDENT TO GT_STUDENT.






* UPDATE ZEDT09_001 FROM TABLE GT_STUDENT.








IF sy-subrc = 0.

  WRITE : / '### ## ### ##'.

ELSE.

  WRITE : / '### ## ### ##'.

ENDIF.






* UPDATE SET## ###### ##

*UPDATE ZEDT09_001 SET ZKNAME = '###-####'

*WHERE ZCODE = 'SSU-31'.

*

*UPDATE ZEDT09_001 SET ZENAME = 'CHA2'

*WHERE ZCODE = 'SSU-29'.






IF sy-subrc = 0.

  WRITE : / 'update set #### ##'.

ELSE.

  WRITE : / 'update set #### ##'.

ENDIF.












* =====================================================================

* DELETE#

* - 1## ##

*    DELETE <###> FROM wa.

* - ### ## -> ####### WHERE### #### ## # ### ##

*    DELETE FROM <###> WHERE [COND]

*    DELETE <###> FROM TABLE <######>

* =====================================================================




CLEAR : GS_STUDENT, GT_STUDENT.






* ## ## -> ## ##




GS_STUDENT-ZCODE = 'SSU-31'.

GS_STUDENT-ZPERNR = '0000000031'.






* DELETE ZEDT09_001 FROM GS_STUDENT.






IF sy-subrc = 0.

  WRITE : / '### ## ## ##'.

ELSE.

  WRITE : / '### ## ## ##'.

ENDIF.






* ### ## -> by WHERE ###



*DELETE FROM ZEDT09_001 WHERE ZENAME = 'CHA2'.






IF sy-subrc = 0.

  WRITE : / '### ### ## ##'.

ELSE.

  WRITE : / '### ### ## ##'.

ENDIF.






* ## # ## -> by ######




CLEAR : GS_STUDENT, GT_STUDENT.

GS_STUDENT-ZCODE = 'SSU-27'.

GS_STUDENT-ZPERNR = '0000000027'.

APPEND GS_STUDENT TO GT_STUDENT.



GS_STUDENT-ZCODE = 'SSU-28'.

GS_STUDENT-ZPERNR = '0000000028'.

APPEND GS_STUDENT TO GT_STUDENT.






*DELETE ZEDT09_001 FROM TABLE GT_STUDENT.






IF sy-subrc = 0.

  WRITE : / '### ### ## ## - ######'.

ELSE.

  WRITE : / '### ### ## ## - ######'.

ENDIF.








* =====================================================================

* MODIFY# : INSERT# UPDATE### ##  -> <key# ##>

*            KEY## ### #### ####, UPDATE / ### INSERT

* - 1##

*    MODIFY <###> FROM wa.

* - ### ; ####### #### ### ## or ##

*    MODIFY <###> FROM TABLE <######>

* =====================================================================






CLEAR : GS_STUDENT, GT_STUDENT.



GS_STUDENT-ZCODE = 'SSU-11'.

GS_STUDENT-ZPERNR = '0000000011'.

GS_STUDENT-ZKNAME = '##'.

GS_STUDENT-ZENAME = 'YOON'.

GS_STUDENT-ZGENDER = 'F'.

GS_STUDENT-ZTEL = '01000002222'.






*MODIFY ZEDT09_001 FROM GS_STUDENT.






IF sy-subrc = 0.

  WRITE : / '### modify ##'.

ENDIF.






* modify ###




CLEAR : GS_STUDENT, GT_STUDENT.

GS_STUDENT-ZCODE = 'SSU-11'.

GS_STUDENT-ZPERNR = '0000000011'.

GS_STUDENT-ZKNAME = '##'.

GS_STUDENT-ZENAME = 'YOON'.

GS_STUDENT-ZGENDER = 'F'.

GS_STUDENT-ZTEL = '01000002233'.

APPEND GS_STUDENT TO GT_STUDENT.



GS_STUDENT-ZCODE = 'SSU-12'.

GS_STUDENT-ZPERNR = '0000000012'.

GS_STUDENT-ZKNAME = '###'.

GS_STUDENT-ZENAME = 'LEE'.

GS_STUDENT-ZGENDER = 'M'.

GS_STUDENT-ZTEL = '01000002233'.

APPEND GS_STUDENT TO GT_STUDENT.



MODIFY ZEDT09_001 FROM TABLE GT_STUDENT.



IF sy-subrc = 0.

  WRITE : / '### modify ### ##'.

ENDIF.