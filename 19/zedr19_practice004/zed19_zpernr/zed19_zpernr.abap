
FUNCTION ZED19_ZPERNR.




*"----------------------------------------------------------------------

*"*"Local Interface:

*"  IMPORTING

*"     REFERENCE(I_LOW_CODE) TYPE  C DEFAULT 'SSU-90'

*"     REFERENCE(I_HIGH_CODE) TYPE  C DEFAULT 'SSU-99'

*"     REFERENCE(I_COMMIT) TYPE  ABAP_BOOL

*"  EXPORTING

*"     REFERENCE(E_CNT_SEL) TYPE  I

*"     REFERENCE(E_CNT_UPD) TYPE  I

*"     REFERENCE(E_MESSAGE) TYPE  STRING

*"  TABLES

*"      T_ZEDT19_0001 STRUCTURE  ZEDT19_0001

*"  CHANGING

*"     REFERENCE(P_ZEDT19_0001) TYPE  ZEDT19_0001

*"  EXCEPTIONS

*"      BAD_RANGE

*"----------------------------------------------------------------------




*
Global data declarations



*
Global data declarations


  "--- ## ###/######

  DATA: gs_student TYPE zedt19_0001,

        gt_student TYPE STANDARD TABLE OF zedt19_0001.



  "--- 1) RANGE ## (SSU-90 ~ SSU-99)

  RANGES gr_zcode FOR zedt19_0001-zcode.

  CLEAR gr_zcode.

  gr_zcode-sign   = 'I'.

  gr_zcode-option = 'BT'.

  gr_zcode-low    = i_low_code.

  gr_zcode-high   = i_high_code.

  APPEND gr_zcode.



  "--- 2) ## ##

  SELECT *

    FROM zedt00_001

    INTO CORRESPONDING FIELDS OF TABLE gt_student

    WHERE zcode IN gr_zcode.



  e_cnt_sel = lines( gt_student ).

  CLEAR e_cnt_upd.



  IF e_cnt_sel = 0.

    e_message = '## ## #### ####.'.

    RETURN.

  ENDIF.



  "--- 3) ZPERNR 10## 0##

  LOOP AT gt_student INTO gs_student.

    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'

      EXPORTING  input  = gs_student-zpernr

      IMPORTING  output = gs_student-zpernr.



    MODIFY gt_student FROM gs_student INDEX sy-tabix.

    CLEAR gs_student.

  ENDLOOP.



  "--- 4) ## ### ##(## MODIFY)

  MODIFY zedt19_0001 FROM TABLE gt_student.

  e_cnt_upd = sy-dbcnt.



  "--- 5) ## (##)

  IF i_commit = abap_true.

    COMMIT WORK AND WAIT.

  ENDIF.



  "--- 6) ###

  e_message = |sel={ e_cnt_sel } upd={ e_cnt_upd }|.



ENDFUNCTION.