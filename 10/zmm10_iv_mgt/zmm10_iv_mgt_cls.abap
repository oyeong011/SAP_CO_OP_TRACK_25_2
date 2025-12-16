
*&---------------------------------------------------------------------*

*& Include          ZMM10_IV_MGT_CL

*&---------------------------------------------------------------------*




CLASS LCL_EVENT_HANDLER DEFINITION.

  PUBLIC SECTION.

    METHODS: HANDLE_TOOLBAR FOR EVENT TOOLBAR OF CL_GUI_ALV_GRID

      IMPORTING E_OBJECT,



      HANDLE_USER_COMMAND FOR EVENT USER_COMMAND OF CL_GUI_ALV_GRID

        IMPORTING E_UCOMM,



      HANDLE_DATA_CHANGED FOR EVENT DATA_CHANGED OF CL_GUI_ALV_GRID

        IMPORTING ER_DATA_CHANGED.

ENDCLASS.



CLASS LCL_EVENT_HANDLER IMPLEMENTATION.

  " 1. ### ## ## ##

  METHOD HANDLE_TOOLBAR.

    DATA: LS_TOOLBAR TYPE STB_BUTTON.

    " ## ### ## ## ## ###

    IF R_CREA = 'X'.

      CLEAR LS_TOOLBAR.

      LS_TOOLBAR-BUTN_TYPE = 3. " ###

      INSERT LS_TOOLBAR INTO E_OBJECT->MT_TOOLBAR INDEX 1.



      CLEAR LS_TOOLBAR.

      LS_TOOLBAR-FUNCTION  = 'SAVE'.

      LS_TOOLBAR-ICON      = ICON_SYSTEM_SAVE.

      LS_TOOLBAR-TEXT      = '##(Post)'.

      LS_TOOLBAR-QUICKINFO = '## ##'.

      INSERT LS_TOOLBAR INTO E_OBJECT->MT_TOOLBAR INDEX 2.

    ENDIF.

    " 2. [## ##] ## ## ## (## ##)

    IF R_DISP = 'X'.

      CLEAR LS_TOOLBAR.

      LS_TOOLBAR-BUTN_TYPE = 3. " ###

      INSERT LS_TOOLBAR INTO E_OBJECT->MT_TOOLBAR INDEX 1.



      CLEAR LS_TOOLBAR.

      LS_TOOLBAR-FUNCTION  = 'CANCEL'.

      LS_TOOLBAR-ICON      = ICON_DELETE.

      LS_TOOLBAR-TEXT      = '## ##'.

      LS_TOOLBAR-QUICKINFO = '### ## ##'.

      INSERT LS_TOOLBAR INTO E_OBJECT->MT_TOOLBAR INDEX 2.

    ENDIF.

  ENDMETHOD.

  " 2. ## ## # ## ##

  METHOD HANDLE_USER_COMMAND.

    CASE E_UCOMM.

      WHEN 'SAVE'.

        PERFORM SAVE_DATA.

      WHEN 'CANCEL'.   " <--- [##] ## ## ##

        PERFORM CANCEL_DATA.

    ENDCASE.

  ENDMETHOD.

  " [##] ### ## # ## ## ##

  METHOD HANDLE_DATA_CHANGED.

    DATA: LS_MOD_CELL TYPE LVC_S_MODI,

          LS_DATA     LIKE LINE OF GT_DATA,

          LV_KBETR    TYPE ZEDT10_MWSKZ-KBETR, " ##

          LV_MWSTS    TYPE ZEDT10_BSIK-MWSTS,  " ### ##

          LV_DMBTR    TYPE ZEDT10_RBKP-DMBTR.  " ### ###



    " ### ### ## ### ##

    LOOP AT ER_DATA_CHANGED->MT_GOOD_CELLS INTO LS_MOD_CELL.



      " 1. ####(MWSKZ)# ##### #

      IF LS_MOD_CELL-FIELDNAME = 'MWSKZ'.



        " ## ### ### #### ###

        READ TABLE GT_DATA INTO LS_DATA INDEX LS_MOD_CELL-ROW_ID.

        IF SY-SUBRC = 0.



          " (1) ### ##### ##### ## ##

          " LS_MOD_CELL-VALUE## #### ## ### ## ####

          SELECT SINGLE KBETR INTO LV_KBETR

            FROM ZEDT10_MWSKZ

           WHERE MWSKZ = LS_MOD_CELL-VALUE.



          IF SY-SUBRC <> 0.

            LV_KBETR = 0. " ### ### 0%

          ENDIF.



          " (2) ## # ### ###

          " ##: #### * (## / 100)

          LV_MWSTS = LS_DATA-WRBTR * ( LV_KBETR / 100 ).

          LV_DMBTR = LS_DATA-WRBTR + LV_MWSTS.



          " (3) ALV ### # ## ## (MODIFY_CELL ##)

          " ##(MWSTS) ##

          CALL METHOD ER_DATA_CHANGED->MODIFY_CELL

            EXPORTING

              I_ROW_ID    = LS_MOD_CELL-ROW_ID

              I_FIELDNAME = 'MWSTS'

              I_VALUE     = LV_MWSTS.



          " ###(DMBTR) ##

          CALL METHOD ER_DATA_CHANGED->MODIFY_CELL

            EXPORTING

              I_ROW_ID    = LS_MOD_CELL-ROW_ID

              I_FIELDNAME = 'DMBTR'

              I_VALUE     = LV_DMBTR.



          " (4) ## ### ###(GT_DATA)# #### (## ### ##)

          LS_DATA-MWSKZ = LS_MOD_CELL-VALUE.

          LS_DATA-MWSTS = LV_MWSTS.

          LS_DATA-DMBTR = LV_DMBTR.

          MODIFY GT_DATA FROM LS_DATA INDEX LS_MOD_CELL-ROW_ID.



        ENDIF.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.