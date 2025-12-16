
*&---------------------------------------------------------------------*

*& Report ZEDR25_PRACTICE004

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*






REPORT zedr25_practice004.



DATA: gt_student TYPE TABLE OF zedt25_001,

      gs_student TYPE zedt25_001.



RANGES: gr_zcode FOR zedt25_001-zcode.



INITIALIZATION.



  gr_zcode-sign   = 'I'.

  gr_zcode-option = 'BT'.

  gr_zcode-low    = 'SSU-90'.

  gr_zcode-high   = 'SSU-99'.

  APPEND gr_zcode.



START-OF-SELECTION.



  PERFORM get_data.

  PERFORM convert_pernr.

  PERFORM update_database.





FORM get_data.



  SELECT *

    FROM zedt00_001

    INTO CORRESPONDING FIELDS OF TABLE gt_student

    WHERE zcode IN gr_zcode.



ENDFORM.



FORM convert_pernr.



  DATA: lv_output TYPE zedt25_001-zpernr.



  LOOP AT gt_student INTO gs_student.



    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'

      EXPORTING

        input  = gs_student-zpernr

      IMPORTING

        output = lv_output.



    gs_student-zpernr = lv_output.

    MODIFY gt_student FROM gs_student INDEX sy-tabix.



  ENDLOOP.



ENDFORM.



FORM update_database.



  CHECK gt_student IS NOT INITIAL.



  MODIFY zedt25_001 FROM TABLE gt_student.



  IF sy-subrc = 0.

    COMMIT WORK.

    WRITE: / '##!'.

  ELSE.

    ROLLBACK WORK.

    WRITE: / '##'.

  ENDIF.



ENDFORM.