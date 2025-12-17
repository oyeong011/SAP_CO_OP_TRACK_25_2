
*&---------------------------------------------------------------------*

*&  Include           ZWORK25_001_CLS

*&---------------------------------------------------------------------*




CLASS LCL_EVENT_HANDLER DEFINITION.

  PUBLIC SECTION.

    METHODS:

      HANDLE_TOOLBAR        "ALV ## ## ### ##

        FOR EVENT TOOLBAR OF CL_GUI_ALV_GRID

        IMPORTING E_OBJECT E_INTERACTIVE,



      HANDLE_USER_COMMAND   "### ## ## ## ##

        FOR EVENT USER_COMMAND OF CL_GUI_ALV_GRID

        IMPORTING E_UCOMM,



      HANDLE_DATA_CHANGED   "ALV ### ## # ##

        FOR EVENT DATA_CHANGED OF CL_GUI_ALV_GRID

        IMPORTING ER_DATA_CHANGED.

ENDCLASS.



CLASS LCL_EVENT_HANDLER IMPLEMENTATION.



  METHOD HANDLE_TOOLBAR.

    "### ## ### ALV ### ##

    DATA LS_TOOLBAR TYPE STB_BUTTON.



    E_INTERACTIVE = 'X'.  "## ###



    "### ##

    CLEAR LS_TOOLBAR.

    LS_TOOLBAR-BUTN_TYPE = 3.

    APPEND LS_TOOLBAR TO E_OBJECT->MT_TOOLBAR.



    "#### ## ##

    CLEAR LS_TOOLBAR.

    LS_TOOLBAR-FUNCTION  = 'ZCUR'.

    LS_TOOLBAR-ICON      = ICON_SYSTEM_SAVE.

    LS_TOOLBAR-QUICKINFO = '####'.

    LS_TOOLBAR-TEXT      = '####'.

    APPEND LS_TOOLBAR TO E_OBJECT->MT_TOOLBAR.

  ENDMETHOD.



  METHOD HANDLE_USER_COMMAND.

    "### ## ## ##

    CASE E_UCOMM.

      WHEN 'ZCUR'.         "## ## ## ## #

        PERFORM ALV_SAVE.

    ENDCASE.

  ENDMETHOD.



  METHOD HANDLE_DATA_CHANGED.

    "ALV # # ## # ###

    PERFORM ALV_DATA_CHANGED USING ER_DATA_CHANGED.

  ENDMETHOD.



ENDCLASS.