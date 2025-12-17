
*&---------------------------------------------------------------------*

*& Report ZEDR25_000

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*






REPORT zedr25_000.



DATA: lt_student TYPE TABLE OF zedt25_001,

      ls_student TYPE zedt25_001.



FORM add_student USING p_code p_pernr p_kname p_ename p_gender p_tel.

  CLEAR ls_student.



  ls_student-mandt   = sy-mandt.

  ls_student-zcode   = p_code.

  ls_student-zpernr  = p_pernr.

  ls_student-zkname  = p_kname.

  ls_student-zename  = p_ename.

  ls_student-zgender = p_gender.

  ls_student-ztel    = p_tel.



  ls_student-crdate  = sy-datum.

  ls_student-crzeit  = sy-uzeit.

  ls_student-cname   = sy-uname.



  APPEND ls_student TO lt_student.

ENDFORM.



START-OF-SELECTION.






* 1) ## ### ##




  DELETE FROM zedt25_001.






* 2) # ### ##




  PERFORM add_student USING 'SSU-01' '0000000001' '###'  'HOON'   'M' '010-1111-1111'.

  PERFORM add_student USING 'SSU-02' '0000000002' '###'  'SEO'    'M' '010-2222-2222'.

  PERFORM add_student USING 'SSU-03' '0000000003' '##'    'HYUN'   'M' '010-3333-3333'.

  PERFORM add_student USING 'SSU-04' '0000000004' '##'    'BIN'    'M' '010-4444-4444'.

  PERFORM add_student USING 'SSU-05' '0000000005' '##'    'YOON'   'F' '010-5555-5555'.

  PERFORM add_student USING 'SSU-06' '0000000006' '##'    'TAE'    'F' '010-6666-6666'.

  PERFORM add_student USING 'SSU-07' '0000000007' '###'  'DA'     'F' '010-7777-7777'.

  PERFORM add_student USING 'SSU-08' '0000000008' '##'    'SU'     'F' '010-8888-8888'.

  PERFORM add_student USING 'SSU-09' '0000000009' '###'  'LEE'    'F' '010-9999-9999'.

  PERFORM add_student USING 'SSU-10' '0000000010' '###'  'JEON'   'F' '111-0000-0000'.

  PERFORM add_student USING 'SSU-11' '0000000011' '###'  'JO'     'M' '111-1111-1111'.

  PERFORM add_student USING 'SSU-12' '0000000012' '###'  'KO'     'F' '111-2222-2222'.

  PERFORM add_student USING 'SSU-13' '0000000013' '##'    'JUNG'   'M' '111-3333-3333'.

  PERFORM add_student USING 'SSU-14' '0000000014' '###'  'YJUNG'  'F' '111-4444-4444'.

  PERFORM add_student USING 'SSU-15' '0000000015' '###'  'HYE'    'F' '111-5555-5555'.

  PERFORM add_student USING 'SSU-16' '0000000016' '###'  'LIM'    'F' '111-6666-6666'.

  PERFORM add_student USING 'SSU-17' '0000000017' '###'  'DO'     'M' '111-7777-7777'.

  PERFORM add_student USING 'SSU-18' '0000000018' '##'    'JENNY'  'F' '111-8888-8888'.

  PERFORM add_student USING 'SSU-19' '0000000019' '###'  'HAN'    'F' '111-9999-9999'.

  PERFORM add_student USING 'SSU-20' '0000000020' '###'  'CHA'    'M' '212-0000-0000'.

  PERFORM add_student USING 'SSU-21' '0000000021' '###'  'PARK'   'F' '212-1111-1111'.

  PERFORM add_student USING 'SSU-22' '0000000022' '###'  'SEUNG'  'M' '212-2222-2222'.

  PERFORM add_student USING 'SSU-23' '0000000023' '###'  'SOO'    'M' '212-3333-3333'.

  PERFORM add_student USING 'SSU-24' '0000000024' '###'  'HA'     'M' '212-4444-4444'.

  PERFORM add_student USING 'SSU-25' '0000000025' '###'  'RI'     'F' '212-5555-5555'.






* 3) DB Insert




  INSERT zedt25_001 FROM TABLE lt_student.

  IF sy-subrc = 0.

    COMMIT WORK.

    WRITE: / '25# ## ### ## Insert ##'.

  ELSE.

    WRITE: / 'Insert ##, SY-SUBRC=', sy-subrc.

  ENDIF.