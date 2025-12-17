
*&---------------------------------------------------------------------*

*& Include ZMM10_MIGO_CLS

*&---------------------------------------------------------------------*




CLASS LCL_EVENT_HANDLER DEFINITION.

  PUBLIC SECTION.

    " 1. ## ###### ###

    METHODS HANDLE_TOOLBAR

                  FOR EVENT TOOLBAR OF CL_GUI_ALV_GRID

      IMPORTING E_OBJECT E_INTERACTIVE.



    " 2. ## ##(## ###) ###

    METHODS HANDLE_USER_COMMAND

                  FOR EVENT USER_COMMAND OF CL_GUI_ALV_GRID

      IMPORTING E_UCOMM.

ENDCLASS.

CLASS LCL_EVENT_HANDLER IMPLEMENTATION.



  METHOD HANDLE_TOOLBAR.

    DATA: LS_TOOLBAR TYPE STB_BUTTON.



    " ###

    CLEAR LS_TOOLBAR.

    LS_TOOLBAR-BUTN_TYPE = 3.

    INSERT LS_TOOLBAR INTO E_OBJECT->MT_TOOLBAR INDEX 1.



    " 1. [## ##] ## (## ### ##)

    IF R_CREA = 'X'.

      CLEAR LS_TOOLBAR.

      LS_TOOLBAR-FUNCTION  = 'POST_GR'.

      LS_TOOLBAR-ICON      = ICON_SYSTEM_SAVE.

      LS_TOOLBAR-TEXT      = '##(Post)'.

      LS_TOOLBAR-QUICKINFO = '## ## ##'.

      INSERT LS_TOOLBAR INTO E_OBJECT->MT_TOOLBAR INDEX 2.

    ENDIF.



    " 2. [## ##] ## (## ### ## ##) - NEW

    IF R_DISP = 'X'.

      CLEAR LS_TOOLBAR.

      LS_TOOLBAR-FUNCTION  = 'CANCEL_GR'.      " ## ##

      LS_TOOLBAR-ICON      = ICON_DELETE.      " ## ###

      LS_TOOLBAR-TEXT      = '## ##'.

      LS_TOOLBAR-QUICKINFO = '## ## ## ##'.

      INSERT LS_TOOLBAR INTO E_OBJECT->MT_TOOLBAR INDEX 2.

    ENDIF.



  ENDMETHOD.



  METHOD HANDLE_USER_COMMAND.

    DATA: LV_ANSWER TYPE C.



    CASE E_UCOMM.

      WHEN 'POST_GR'.

        " (## ## ##)

        IF GO_ALV IS BOUND.

          CALL METHOD GO_ALV->CHECK_CHANGED_DATA.

        ENDIF.

        PERFORM HANDLE_POST_GR. " (## ### Form## ## ##)



        " [##] ## ## ## ## # - NEW

      WHEN 'CANCEL_GR'.

        IF GO_ALV IS BOUND.

          CALL METHOD GO_ALV->CHECK_CHANGED_DATA.

        ENDIF.



        PERFORM CANCEL_DATA. " ## ## ##

    ENDCASE.

  ENDMETHOD.



ENDCLASS.