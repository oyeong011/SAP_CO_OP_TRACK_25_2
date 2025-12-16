
*&---------------------------------------------------------------------*

*&  Include           ZEDR07_020_O01

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  SET_ALV  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE SET_ALV OUTPUT.



  PERFORM create_object.

  PERFORM field_catalog.

  PERFORM alv_layout.

  PERFORM alv_sort.

  PERFORM call_alv.



ENDMODULE.






*&---------------------------------------------------------------------*

*&      Module  STATUS_0100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0100 OUTPUT.

  SET PF-STATUS 'STATUS 0100'.

  SET TITLEBAR 'T100'.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  EXIT_COMMNAD  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE EXIT_COMMNAD INPUT.



CASE ok_code.

    WHEN 'BACK' or 'CANC'.

      LEAVE TO SCREEN 0.

    WHEN 'EXIT'.

      LEAVE PROGRAM.

    ENDCASE.

ENDMODULE.



MODULE USER_COMMAND_0100 INPUT.

  CASE OK_CODE.

    WHEN 'APND'.

      CLEAR GS_STUDENT.

      GS_STUDENT-ZCODE = 'SSU-30'.

      GS_STUDENT-ZPERNR = '0000000030'.

      GS_STUDENT-ZKNAME = '###'.

      GS_STUDENT-ZENAME = 'MI'.

      GS_STUDENT-ZGENDER = 'F'.

      APPEND GS_STUDENT TO GT_STUDENT.

      ENDCASE.

      ENDMODULE.