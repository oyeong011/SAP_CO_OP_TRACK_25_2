
*&---------------------------------------------------------------------*

*&  Include           ZMM08_002_PBO

*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*

*&      Module  STATUS_0100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0100 OUTPUT.

  SET PF-STATUS 'STATUS_0100'.

  SET TITLEBAR 'T001'.



  IF GC_DOCKING IS INITIAL.

    CREATE OBJECT GC_DOCKING

      EXPORTING

        SIDE = CL_GUI_DOCKING_CONTAINER=>DOCK_AT_BOTTOM

        RATIO = 90.



    CREATE OBJECT GC_GRID

      EXPORTING

        I_PARENT = GC_DOCKING.



    CREATE OBJECT GO_EVENT.

    SET HANDLER GO_EVENT->ON_TOOLBAR FOR GC_GRID.

    SET HANDLER GO_EVENT->ON_USER_COMMAND FOR GC_GRID.

    SET HANDLER GO_EVENT->ON_DATA_CHANGED FOR GC_GRID.



    PERFORM BUILD_FIELDCAT.



    CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

      EXPORTING

        IS_LAYOUT = GS_LAYOUT

      CHANGING

        IT_OUTTAB = GT_EKPO

        IT_FIELDCATALOG = GT_FIELDCAT.



    PERFORM CHECK_VENDOR USING GV_BUKRS GV_LIFNR.

  ENDIF.



ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  STATUS_0200  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE STATUS_0200 OUTPUT.

  SET PF-STATUS 'STATUS_0200'.

  SET TITLEBAR 'T002'.



  IF GC_DOCKING IS INITIAL.

    CREATE OBJECT GC_DOCKING

      EXPORTING

        SIDE = CL_GUI_DOCKING_CONTAINER=>DOCK_AT_BOTTOM

        RATIO = 90.



    CREATE OBJECT GC_GRID

      EXPORTING

        I_PARENT = GC_DOCKING.



    PERFORM QUERY_DATA.

    PERFORM BUILD_FIELDCAT_Q.



    CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

      EXPORTING

        IS_LAYOUT = GS_LAYOUT

      CHANGING

        IT_OUTTAB = GT_EKPO_Q

        IT_FIELDCATALOG = GT_FIELDCAT.

  ELSE.

    PERFORM QUERY_DATA.

    CALL METHOD GC_GRID->REFRESH_TABLE_DISPLAY.

  ENDIF.



ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  DISPLAY_ALV_0100  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE DISPLAY_ALV_0100 OUTPUT.



  PERFORM DISPLAY_ALV_100.



ENDMODULE.




*&---------------------------------------------------------------------*

*&      Module  DISPLAY_ALV_0200  OUTPUT

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*




MODULE DISPLAY_ALV_0200 OUTPUT.



  PERFORM DISPLAY_ALV_200.



ENDMODULE.