
*&---------------------------------------------------------------------*

*&  Include           ZWORK02_002_PAI

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0100  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0100 INPUT.

  CASE: OK_CODE.

    WHEN 'EPDF'.

      CLEAR GV_CANCEL_FLAG.

      CLEAR GV_FOLDER_PATH.

      PERFORM GET_PATH. "## ##



      PERFORM DOWNLOAD_TEMPLATE. "## ### ####

      IF GV_CANCEL_FLAG = 'X'.

        EXIT.

      ENDIF.



      PERFORM INIT_EXCEL_OLE. "## OLE ###

      CHECK SY-SUBRC = 0.



      PERFORM FILL_EXCEL_DATA. "### # ##



      PERFORM SET_PAGE. "### ##



      PERFORM EXPORT_PDF. "PDF ##



      PERFORM CLEANUP_EXCEL_OLE. "OLE ##



      PERFORM DELETE_TEMPLATE. "### ##

  ENDCASE.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  EXIT_COMMANT  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE EXIT_COMMANT INPUT.

  CASE OK_CODE.

    WHEN 'BACK' OR 'CANC'.

      LEAVE TO SCREEN 0.

    WHEN 'EXIT'.

      LEAVE PROGRAM.

    ENDCASE.

ENDMODULE.