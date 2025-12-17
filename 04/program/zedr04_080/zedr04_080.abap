
*&---------------------------------------------------------------------*

*& Report ZEDR04_080

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR04_080.



" 1. ## ----------

DATA GV_VAR TYPE C VALUE 'A'.






*FIELD-SYMBOLS <FS> TYPE C.




FIELD-SYMBOLS <FS> TYPE ANY.  " ## ## ##. (## ## ##)



ASSIGN GV_VAR TO <FS>.  " ## ##



<FS> = 'B'.             " # ## # ## ## ##



WRITE / GV_VAR.





" 2. ## ## ----------

DATA GV_1 VALUE 'A'.

DATA GV_2 VALUE 'B'.

DATA GV_3 VALUE 'C'.



DATA GV_FNAME(10).

DATA GV_INDEX TYPE N.



FIELD-SYMBOLS <FS0> TYPE ANY.   " ## ## ##



DO 3 TIMES.

  CLEAR GV_FNAME.

  GV_FNAME = 'GV_'.

  GV_INDEX = SY-INDEX.

  CONCATENATE GV_FNAME GV_INDEX INTO GV_FNAME.  " GV_FNAME = 'GV_1'. (## 1###)



  ASSIGN (GV_FNAME) TO <FS0>. " ## ##.

                              " ASSIGN GV_1 TO <FS2>

                              " ### ## ### ## ## ### ### #### ###(ZEDR04_070 ##)



  WRITE : / GV_FNAME, ':', <FS0>.   " GV_1 : A

ENDDO.





" 3. ### ## ----------

DATA : BEGIN OF GS_SUM,

  MON01 TYPE DMBTR VALUE '10.00',

  MON02 TYPE DMBTR VALUE '20.00',

  MON03 TYPE DMBTR VALUE '30.00',

  MON04 TYPE DMBTR VALUE '40.00',

  MON05 TYPE DMBTR VALUE '50.00',

  MON06 TYPE DMBTR VALUE '60.00',

  END OF GS_SUM.

DATA ZINDEX(2).

DATA ZMON(6).



FIELD-SYMBOLS : <FS1> LIKE GS_SUM,  " ### ## ## ##(## ### #### TYPE ANY # #)

                <FS2> TYPE ANY.

ASSIGN GS_SUM TO <FS1>. " ### ##



DO 6 TIMES.

  ZINDEX = SY-INDEX.

  CONCATENATE 'MON0' ZINDEX INTO ZMON. " ZMON = 'ZMON01'.

  ASSIGN COMPONENT ZMON OF STRUCTURE <FS1> TO <FS2>. " <FS1># 'ZMON01' ### <FS2># ##

  WRITE / <FS2>.

ENDDO.





" 4. ### ### ## ----------

DATA : BEGIN OF GS_STUDENT,

  ZCODE LIKE ZEDT04_001-ZCODE,

  ZKNAME LIKE ZEDT04_001-ZKNAME,

  ZENAME LIKE ZEDT04_001-ZENAME,

  ZMEMO(10),

  END OF GS_STUDENT.

DATA GT_STUDENT LIKE TABLE OF GS_STUDENT.

DATA GV_ZCODE(10) VALUE 'ZCODE'.



SELECT * FROM ZEDT04_001 INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT.



FIELD-SYMBOLS <FS4> TYPE ANY TABLE.   " ### ### ## ## ##

ASSIGN GT_STUDENT TO <FS4>.



  " 4-1. #### ### ##

READ TABLE <FS4> WITH KEY (GV_ZCODE) = 'SSU-01' INTO GS_STUDENT.  " TYPE ANY TABLE### ZCODE## ## ##

WRITE : / GS_STUDENT-ZCODE, GS_STUDENT-ZKNAME, GS_STUDENT-ZENAME.



  " 4-2. ## ## ### ##

FIELD-SYMBOLS: <FS_GS_STUDENT> TYPE ANY.

READ TABLE <FS4> WITH KEY (GV_ZCODE) = 'SSU-01' ASSIGNING <FS_GS_STUDENT>.

WRITE / <FS_GS_STUDENT>.



" 5. LOOP# ### ## ## ##

LOOP AT GT_STUDENT ASSIGNING FIELD-SYMBOL(<FS_T>).  " ### #### <FS_T> ##

  IF <FS_T>-ZENAME = 'LEE'.

    <FS_T>-ZMEMO = '####'.

  ENDIF.

ENDLOOP.