
*&---------------------------------------------------------------------*

*& Report ZEDR06_029

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR06_029.



DATA : GV_VAR TYPE C VALUE 'A'.



FIELD-SYMBOLS <FS> TYPE C.



ASSIGN GV_VAR TO <FS>.



<FS> = 'B'.



WRITE :/ GV_VAR.






*&---------------------------------------------------------------------*






DATA : GV_VAR1 TYPE C VALUE 'A'.

FIELD-SYMBOLS <FS1> TYPE ANY.



ASSIGN GV_VAR1 TO <FS1>.



WRITE :/ <FS1>.



<FS1> = 'B'.



WRITE :/ GV_VAR.






*&---------------------------------------------------------------------*






DATA : GV_1 TYPE C VALUE 'A'.

DATA : GV_2 TYPE C VALUE 'B'.

DATA : GV_3 TYPE C VALUE 'C'.



DATA : GV_FNAME(10).

DATA : GV_INDEX TYPE N.



FIELD-SYMBOLS <FS2> TYPE ANY.



DO 3 TIMES.

  CLEAR GV_FNAME.

  GV_FNAME = 'GV_'.

  GV_INDEX = SY-INDEX.

  CONCATENATE GV_FNAME GV_INDEX INTO GV_FNAME.



  ASSIGN (GV_FNAME) TO <FS2>.



  WRITE :/ GV_FNAME, ':', <FS2>.

ENDDO.






*&---------------------------------------------------------------------*






DATA : BEGIN OF GS_SUM,

  MON01 TYPE DMBRT VALUE '10.00',

  MON02 TYPE DMBRT VALUE '20.00',

  MON03 TYPE DMBRT VALUE '30.00',

  MON04 TYPE DMBRT VALUE '40.00',

  MON05 TYPE DMBRT VALUE '50.00',

  MON06 TYPE DMBRT VALUE '60.00',

  END OF GS_SUM.

DATA : ZINDEX(2).

DATA : ZMON(6).



FIELD-SYMBOLS : <FS3> LIKE GS_SUM,

                <FS4> TYPE ANY.



ASSIGN GS_SUM TO <FS3>.



DO 6 TIMES.

  ZINDEX = SY-INDEX.

  CONCATENATE 'MON0' ZINDEX INTO ZMON.

  ASSIGN COMPONENT ZMON OF STRUCTURE <FS3> TO <FS4>.

  WRITE :/ <FS4>.

ENDDO.






*&---------------------------------------------------------------------*






DATA : BEGIN OF GS_STUDENT,

  ZCODE LIKE ZEDT06_001-ZCODE,

  ZKNAME LIKE ZEDT06_001-ZKNAME,

  ZENAME LIKE ZEDT06_001-ZENAME,

  END OF GS_STUDENT.

DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.

DATA : GV_ZCODE(10) VALUE 'ZCODE'.



SELECT * FROM ZEDT06_001 INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT.



FIELD-SYMBOLS <FS5> TYPE ANY TABLE.

ASSIGN GT_STUDENT TO <FS5>.



READ TABLE <FS5> WITH KEY (GV_ZCODE) = 'SSU-01' INTO GS_STUDENT.



WRITE :/ GS_STUDENT-ZCODE.

WRITE :/ GS_STUDENT-ZKNAME.

WRITE :/ GS_STUDENT-ZENAME.






*&---------------------------------------------------------------------*






DATA : BEGIN OF GS_STUDENT001,

  ZCODE LIKE ZEDT06_001-ZCODE,

  ZKNAME LIKE ZEDT06_001-ZKNAME,

  ZENAME LIKE ZEDT06_001-ZENAME,

  ZMEMO(10),

  END OF GS_STUDENT001.

DATA : GT_STUDENT001 LIKE TABLE OF GS_STUDENT001.

DATA : GV_ZCODE001(10) VALUE 'ZCODE'.



SELECT * FROM ZEDT06_001 INTO CORRESPONDING FIELDS OF TABLE GT_STUDENT001.



LOOP AT GT_STUDENT001 ASSIGNING FIELD-SYMBOL(<FS_T>).

  IF <FS_T>-ZENAME = 'KANG'.

    <FS_T>-ZMEMO = '####'.

  ENDIF.

ENDLOOP.