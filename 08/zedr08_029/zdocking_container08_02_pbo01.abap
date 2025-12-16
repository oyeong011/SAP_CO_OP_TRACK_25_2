
*&---------------------------------------------------------------------*

*&  Include           ZDOCKING_CONTAINER08_02_PBO01

*&---------------------------------------------------------------------*






MODULE SET_ALV OUTPUT.



  IF GC_DOCKING IS INITIAL.

    PERFORM CREATE_OBJECT.

    PERFORM FIELD_CATALOG.

    PERFORM ALV_LAYOUT.

    PERFORM ALV_SORT.

    PERFORM CLASS_EVENT.

    PERFORM ALV_DISPLAY.

  ELSE.

    PERFORM REFRESH.

  ENDIF.



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

    WHEN 'SAVE'.

      MODIFY ZEDT08_001 FROM TABLE GT_STUDENT2.



      LOOP AT GT_STUDENT INTO GS_STUDENT.

        MOVE-CORRESPONDING GS_STUDENT TO GS_SAVE.

        APPEND GS_SAVE TO GT_SAVE.

      ENDLOOP.



      MODIFY ZEDT08_001 FROM TABLE GT_SAVE.



      IF SY-SUBRC = 0.

        MESSAGE '####' TYPE 'I'.

      ELSE.

        MESSAGE '####' TYPE 'I'.

      ENDIF.

  ENDCASE.



ENDMODULE.