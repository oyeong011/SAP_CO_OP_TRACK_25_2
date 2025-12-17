
*&---------------------------------------------------------------------*

*&  Include           ZWORK05_002_CLS

*&---------------------------------------------------------------------*






" #### ### ### ##

CLASS lcl_event_handler DEFINITION.

  PUBLIC SECTION.

    METHODS: handle_toolbar

               FOR EVENT toolbar OF cl_gui_alv_grid

               IMPORTING e_object e_interactive,



             handle_user_command

               FOR EVENT user_command OF cl_gui_alv_grid

               IMPORTING e_ucomm.

ENDCLASS.



" #### ##

CLASS lcl_event_handler IMPLEMENTATION.



  METHOD handle_toolbar.

    DATA: ls_toolbar TYPE stb_button.



    " ### ##

    CLEAR ls_toolbar.

    MOVE 3 TO ls_toolbar-butn_type.

    APPEND ls_toolbar TO e_object->mt_toolbar.



    " PDF #### ## ##

    CLEAR ls_toolbar.

    MOVE 'PDF_DOWN' TO ls_toolbar-function.

    MOVE '@49@' TO ls_toolbar-icon.

    MOVE 'PDF ####' TO ls_toolbar-quickinfo.

    MOVE 'PDF' TO ls_toolbar-text.

    MOVE ' ' TO ls_toolbar-disabled.

    APPEND ls_toolbar TO e_object->mt_toolbar.

  ENDMETHOD.



  METHOD handle_user_command.

    CASE e_ucomm.

      WHEN 'PDF_DOWN'.

        PERFORM pdf_download.

      WHEN OTHERS.

    ENDCASE.

  ENDMETHOD.



ENDCLASS.