
*&---------------------------------------------------------------------*

*&  Include           ZMM10_ME21N_CLS

*&---------------------------------------------------------------------*




CLASS LCL_EVENT_HANDLER DEFINITION.

  PUBLIC SECTION.

    METHODS HANDLE_TOOLBAR

                  FOR EVENT TOOLBAR OF CL_GUI_ALV_GRID

      IMPORTING E_OBJECT E_INTERACTIVE.

    METHODS HANDLE_USER_COMMAND

                  FOR EVENT USER_COMMAND OF CL_GUI_ALV_GRID

      IMPORTING E_UCOMM.

    METHODS HANDLE_ON_F4 FOR EVENT ONF4 OF CL_GUI_ALV_GRID

      IMPORTING E_FIELDNAME

                  E_FIELDVALUE

                  ES_ROW_NO

                  ER_EVENT_DATA

                  ET_BAD_CELLS

                  E_DISPLAY.

ENDCLASS.



CLASS LCL_EVENT_HANDLER IMPLEMENTATION.



  METHOD HANDLE_TOOLBAR.

    DATA: LS_TOOLBAR TYPE STB_BUTTON.



    " (1) ####+ ##

    CLEAR LS_TOOLBAR.

    LS_TOOLBAR-FUNCTION  = 'ADD_ROW'.      " ## ## ## (## ##)

    LS_TOOLBAR-ICON      = ICON_INSERT_ROW. " ### (SAP ## ###)

    LS_TOOLBAR-TEXT      = '####+'.      " ## ##

    LS_TOOLBAR-QUICKINFO = '## #####'. " ### ### # ##

    INSERT LS_TOOLBAR INTO E_OBJECT->MT_TOOLBAR INDEX 1.



    " (2) ####- ##

    CLEAR LS_TOOLBAR.

    LS_TOOLBAR-FUNCTION  = 'DEL_ROW'.

    LS_TOOLBAR-ICON      = ICON_DELETE_ROW.

    LS_TOOLBAR-TEXT      = '####-'.

    LS_TOOLBAR-QUICKINFO = '### ## #####'.

    INSERT LS_TOOLBAR INTO E_OBJECT->MT_TOOLBAR INDEX 2.



    " ### ## (##)

    CLEAR LS_TOOLBAR.

    LS_TOOLBAR-BUTN_TYPE = 3. " Separator

    INSERT LS_TOOLBAR INTO E_OBJECT->MT_TOOLBAR INDEX 3.



    " (3) PO## ##

    CLEAR LS_TOOLBAR.

    LS_TOOLBAR-FUNCTION  = 'CREATE_PO'.

    LS_TOOLBAR-ICON      = ICON_GENERATE.

    IF PR_CREA = 'X'.

      LS_TOOLBAR-TEXT      = 'PO##'.

      LS_TOOLBAR-QUICKINFO = 'PO# #####'.

    ELSE.

      LS_TOOLBAR-TEXT      = 'PO##'.

      LS_TOOLBAR-QUICKINFO = 'PO# #####.'.

    ENDIF.

    INSERT LS_TOOLBAR INTO E_OBJECT->MT_TOOLBAR INDEX 4.



  ENDMETHOD.



  " 2. ## ## # ## ##

  METHOD HANDLE_USER_COMMAND.

    PERFORM HANDLE_USER_COMMAND USING E_UCOMM.

  ENDMETHOD.



  METHOD HANDLE_ON_F4.



    DATA: LT_RETURN TYPE TABLE OF DDSHRETVAL,

          LS_RETURN TYPE DDSHRETVAL.

    DATA: LV_MATNR TYPE ZMARA10-MATNR,

          LS_MARA  TYPE ZMARA10.



    DATA: LS_STABLE TYPE LVC_S_STBL.

    FIELD-SYMBOLS: <FS_OUTTAB> TYPE ANY, " ALV ### ### ##

                   <FS_VALUE>  TYPE ANY.



    " 1. F4 #### ### ### MATNR## ##

    IF E_FIELDNAME = 'MATNR'.



      " 2. ## ## (#### ### ##)

      " TABNAME/FIELDNAME# ## #### ### ### # # ####,

      " ### SEARCHHELP# # ## #### #### ## #####.

      CALL FUNCTION 'F4IF_FIELD_VALUE_REQUEST'

        EXPORTING

          TABNAME           = ''             " ##### ### ####

          FIELDNAME         = ''             " ##### ### ###

          SEARCHHELP        = 'ZSH10_MATNR'  " ### ####

          VALUE             = ''             " ###

        TABLES

          RETURN_TAB        = LT_RETURN

        EXCEPTIONS

          FIELD_NOT_FOUND   = 1

          NO_HELP_FOR_FIELD = 2

          INCONSISTENT_HELP = 3

          NO_VALUES_FOUND   = 4

          OTHERS            = 5.



      IF SY-SUBRC = 0 AND LT_RETURN IS NOT INITIAL.



        " 3. ### #### ####

        READ TABLE LT_RETURN INTO LS_RETURN WITH KEY FIELDNAME = 'MATNR'.

        IF SY-SUBRC = 0.

          CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'

            EXPORTING

              INPUT  = LS_RETURN-FIELDVAL

            IMPORTING

              OUTPUT = LV_MATNR.



          " 4. [##] ###(MATKTX) ##

          " ## A: #### EXP# ##### lt_return## 'MATKTX'# ##

          " ## B: DB## ## ## (## ###)

          SELECT SINGLE *

            INTO LS_MARA

            FROM ZMARA10

           WHERE MATNR = LV_MATNR.



          " 5. ALV ### ### ### ####

          " e_row_no-row_id# #### ## ## ####.

          READ TABLE GT_ITEM ASSIGNING <FS_OUTTAB> INDEX ES_ROW_NO-ROW_ID.

          IF SY-SUBRC = 0.



            " ####(MATNR) ##

            ASSIGN COMPONENT 'MATNR' OF STRUCTURE <FS_OUTTAB> TO <FS_VALUE>.

            IF SY-SUBRC = 0.

              <FS_VALUE> = LV_MATNR.

            ENDIF.



            " ###(MATKTX) ## ##

            ASSIGN COMPONENT 'MAKTX' OF STRUCTURE <FS_OUTTAB> TO <FS_VALUE>.

            IF SY-SUBRC = 0.

              <FS_VALUE> = LS_MARA-MATKTX.

            ENDIF.



            " ### ## ### ##

            ASSIGN COMPONENT 'LGORT' OF STRUCTURE <FS_OUTTAB> TO <FS_VALUE>.

            IF SY-SUBRC = 0.

              <FS_VALUE> = LS_MARA-LGORT.

            ENDIF.



            ASSIGN COMPONENT 'WERKS' OF STRUCTURE <FS_OUTTAB> TO <FS_VALUE>.

            IF SY-SUBRC = 0.

              <FS_VALUE> = LS_MARA-WERKS.

            ENDIF.



            " ### ###.

            ASSIGN COMPONENT 'NETPR' OF STRUCTURE <FS_OUTTAB> TO <FS_VALUE>.

            IF SY-SUBRC = 0.

              <FS_VALUE> = LS_MARA-STPRS.

            ENDIF.

          ENDIF.



          " 6. ### ### ## ## (SAP ## F4 ## ##)

          ER_EVENT_DATA->M_EVENT_HANDLED = 'X'.



          " 7. ## ## (## ## ##)

          LS_STABLE-ROW = 'X'.

          LS_STABLE-COL = 'X'.

          GO_ALV_ITEM->REFRESH_TABLE_DISPLAY( EXPORTING IS_STABLE = LS_STABLE ).



        ENDIF.

      ENDIF.

    ENDIF.



  ENDMETHOD.

ENDCLASS.



DATA: GO_EVENT_HANDLER TYPE REF TO LCL_EVENT_HANDLER.