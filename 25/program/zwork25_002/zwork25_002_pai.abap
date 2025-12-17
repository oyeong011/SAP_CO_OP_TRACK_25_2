
*&---------------------------------------------------------------------*

*&  Include           ZWORK25_002_PAI

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  USER_COMMAND_0100  INPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE USER_COMMAND_0100 INPUT.



  " OK_CODE ## # ###

  SAVE_OK = OK_CODE.

  CLEAR OK_CODE.

  OK_CODE = SY-UCOMM.



  CASE OK_CODE.

    WHEN 'BACK' OR 'EXIT' OR 'CANC'.

      LEAVE TO SCREEN 0.



    WHEN 'PDF_DOWN'. " [PDF ####] ## ##

      PERFORM DOWNLOAD_PDF_OLE.



    WHEN OTHERS.

  ENDCASE.



ENDMODULE.