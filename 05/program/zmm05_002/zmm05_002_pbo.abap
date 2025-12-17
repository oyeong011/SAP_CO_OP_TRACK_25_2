
*&---------------------------------------------------------------------*

*&  Include           ZMM05_002_PBO

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  STATUS_0100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0100 OUTPUT.

  " ## ### ## ### ### ##

  DATA: LT_EXCLUDE TYPE TABLE OF SY-UCOMM.



  REFRESH LT_EXCLUDE.



  IF R_VIEW = 'X'.

    APPEND 'ADD'    TO LT_EXCLUDE.  " # ## ## ##

    APPEND 'REMOVE' TO LT_EXCLUDE.  " # ## ## ##

    APPEND 'SAVE'   TO LT_EXCLUDE.  " ## ## ## (GC_SAVE)

  ENDIF.



  SET PF-STATUS '0100' EXCLUDING LT_EXCLUDE.

  SET TITLEBAR '0100'.



  LOOP AT SCREEN.

    IF SCREEN-NAME CS 'GS_HEADER'.

      SCREEN-INPUT = 0.

      MODIFY SCREEN.

    ENDIF.

  ENDLOOP.

ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  CREATE_ALV_OBJECT  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




module CREATE_ALV_OBJECT output.

  IF GO_CONTAINER IS INITIAL.

    CREATE OBJECT GO_CONTAINER

      EXPORTING

          CONTAINER_NAME = 'CC_ALV'.



    CREATE OBJECT GO_GRID

      EXPORTING

        I_PARENT = GO_CONTAINER.

    PERFORM SET_ALV_LATOUT.



    GS_LAYOUT-NO_TOOLBAR = 'X'.



    PERFORM SET_ALV_FIELDCAT.

    PERFORM REGIST_EVENT.





    CALL METHOD GO_GRID->SET_TABLE_FOR_FIRST_DISPLAY

      EXPORTING

        IS_LAYOUT = GS_LAYOUT

      CHANGING

        IT_OUTTAB = GT_ITEM

        IT_FIELDCATALOG = GT_FCAT.

    CALL METHOD GO_GRID->SET_READY_FOR_INPUT

      EXPORTING

        I_READY_FOR_INPUT = 1.



  ELSE.

    CALL METHOD GO_GRID->REFRESH_TABLE_DISPLAY.

  ENDIF.

endmodule.