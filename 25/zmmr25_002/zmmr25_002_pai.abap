
*&---------------------------------------------------------------------*

*& Include ZMMR25_002_PAI

*&---------------------------------------------------------------------*






MODULE EXIT_COMMAND INPUT.



  OK_CODE = SY-UCOMM.



  CASE OK_CODE.

    WHEN 'BACK' OR 'CANC'.

      LEAVE TO SCREEN 0.

    WHEN 'EXIT'.

      LEAVE PROGRAM.

  ENDCASE.



  CLEAR OK_CODE.



ENDMODULE.



MODULE USER_COMMAND_0100 INPUT.



  CASE SY-UCOMM.

    WHEN 'ADD'.

      PERFORM ADD_ITEM_LINE.



    WHEN 'DEL'.

      PERFORM DELETE_ITEM_LINE.



    WHEN 'SAVE'.

      PERFORM SAVE_PO.



    WHEN 'BACK' OR 'CANC' OR 'EXIT'.

      LEAVE TO SCREEN 0.



  ENDCASE.



ENDMODULE.