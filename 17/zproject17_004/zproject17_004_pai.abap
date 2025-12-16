
*&---------------------------------------------------------------------*

*&  Include           ZPROJECT17_004_PAI

*&---------------------------------------------------------------------*




MODULE user_command_0100 INPUT.



  gv_code = ok_code.

  CLEAR ok_code.



  CASE gv_code.

    WHEN 'BACK' OR 'EXIT' OR 'CANC'.

      LEAVE TO SCREEN 0.

    WHEN 'SAVE'.

      PERFORM create_invoice_document.

    WHEN OTHERS.

  ENDCASE.







ENDMODULE.



MODULE user_command_0200 INPUT.



  gv_code = ok_code.

  CLEAR ok_code.



  CASE gv_code.

    WHEN 'BACK' OR 'EXIT' OR 'CANC'.

      LEAVE TO SCREEN 0.

    WHEN 'C_IV'.

       PERFORM cancel_invoice_document_0200.

    WHEN OTHERS.

  ENDCASE.







ENDMODULE.