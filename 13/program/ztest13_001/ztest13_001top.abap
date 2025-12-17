
*&---------------------------------------------------------------------*

*&  Include           ZTEST13_001TOP

*&---------------------------------------------------------------------*




TABLES : EBAN, MARC , MAKT, MARA, EKKO, EKPO, EINE, EINA.






*----------------------------------------------------------------------*

*&  CLASS

*----------------------------------------------------------------------*




CLASS : LCL_EVENT_RECEIVER DEFINITION DEFERRED,

            LCL_ALV_GRID       DEFINITION DEFERRED.




*----------------------------------------------------------------------*

*&  TYPE-POOLS

*----------------------------------------------------------------------*




TYPE-POOLS ICON.

TYPE-POOLS SLIS.

TYPE-POOLS SYM.

TYPE-POOLS LINE.

TYPE-POOLS COL.




*----------------------------------------------------------------------*

* VARIANT

*----------------------------------------------------------------------*




DATA : GV_OKCODE   TYPE SY-UCOMM,

       GV_SAVEOK   TYPE SY-DATUM,

       GV_ANS,

       GV_CHG,

       GV_ERR_FLAG,

       GV_CNT      TYPE I,

       GV_CODE     TYPE SY-UCOMM,

       GT_TEXT     TYPE TABLE OF LINE,

       GS_TEXT     LIKE LINE OF GT_TEXT,

       GV_TEXT     TYPE STRING.



DATA : GV_LCHR(1000).

DATA : GT_HTML LIKE W3HTML OCCURS 100 WITH HEADER LINE,

       GT_MIME LIKE W3MIME OCCURS 100 WITH HEADER LINE.






*&--------------------------------------------------------------------*

*&  CONSTANTS

*&--------------------------------------------------------------------*




CONSTANTS : C_1 TYPE N           VALUE '1',

            C_2 TYPE N           VALUE '2',

            C_3 TYPE N           VALUE '3',

            C_4 TYPE N           VALUE '4',

            C_5 TYPE N           VALUE '5',

            C_6 TYPE N           VALUE '6',

            C_7 TYPE N           VALUE '7',

            C_8 TYPE N           VALUE '8',

            C_9 TYPE N           VALUE '9',

            C_0 TYPE N           VALUE '0',



            C_A TYPE C           VALUE 'A',

            C_B TYPE C           VALUE 'B',

            C_C TYPE C           VALUE 'C',

            C_D TYPE C           VALUE 'D',

            C_E TYPE C           VALUE 'E',

            C_F TYPE C           VALUE 'F',

            C_G TYPE C           VALUE 'G',

            C_H TYPE C           VALUE 'H',

            C_I TYPE C           VALUE 'I',

            C_J TYPE C           VALUE 'J',

            C_K TYPE C           VALUE 'K',

            C_L TYPE C           VALUE 'L',

            C_M TYPE C           VALUE 'M',

            C_N TYPE C           VALUE 'N',

            C_O TYPE C           VALUE 'O',

            C_P TYPE C           VALUE 'P',

            C_Q TYPE C           VALUE 'Q',

            C_R TYPE C           VALUE 'R',

            C_S TYPE C           VALUE 'S',

            C_T TYPE C           VALUE 'T',

            C_U TYPE C           VALUE 'U',

            C_V TYPE C           VALUE 'V',

            C_W TYPE C           VALUE 'W',

            C_X TYPE C           VALUE 'X',

            C_Y TYPE C           VALUE 'Y',

            C_Z TYPE C           VALUE 'Z'.



CONSTANTS : C_EQ(2) TYPE C       VALUE 'EQ',

            C_NE(2) TYPE C       VALUE 'NE'.



CONSTANTS : GC_SPACE  TYPE C           VALUE SPACE,

            GV_GSFCAT TYPE CHAR12      VALUE 'GS_FIELDCAT-'.



CONSTANTS : C_INSR(4) TYPE C           VALUE 'INSR',

            C_DELE(4) TYPE C           VALUE 'DELE',

            C_SAVE(4) TYPE C           VALUE 'SAVE',

            C_BACK(4) TYPE C           VALUE 'BACK',

            C_EXIT(4) TYPE C           VALUE 'EXIT',

            C_ENTR(4) TYPE C           VALUE 'ENTR',

            C_CANC(4) TYPE C           VALUE 'CANC',

            C_SALL(4) TYPE C           VALUE 'SALL',

            C_DALL(4) TYPE C           VALUE 'DALL',

            C_TEXT(4) TYPE C           VALUE 'TEXT'.



CONSTANTS : C_BTN1(4) TYPE C           VALUE 'BTN1', "####

            C_BTN2(4) TYPE C           VALUE 'BTN2'. "#####



CONSTANTS : C_LGORT_2300 TYPE LGORT_D    VALUE '2300',

            C_LGORT_1200 TYPE LGORT_D    VALUE '1200',

            C_LGORT_1293 TYPE LGORT_D    VALUE '1293',

            C_LGORT_1292 TYPE LGORT_D    VALUE '1292'.



CONSTANTS : C_KSCHL_PB00 TYPE KSCHA      VALUE 'PB00',

            C_MTART_ROH2 TYPE MTART      VALUE 'ROH2'.




*----------------------------------------------------------------------*

* Types

*----------------------------------------------------------------------*




TYPES : BEGIN OF TY_100.

TYPES : EKGRP      LIKE EINE-EKGRP,    "####

        EKORG      LIKE A017-EKORG,    "####

        LIFNR      LIKE EBAN-FLIEF,    "###

        WERKS      LIKE MARC-WERKS,    "###



        BANFN      LIKE EBAN-BANFN,    "####

        BNFPO      LIKE EBAN-BNFPO,    "######

        ICON(4),

        STATUS,

        ERMSG(100),                   "####



        EKORG_TX   LIKE T024E-EKOTX,   "######



        EKGRP_TX   LIKE T024-EKNAM,    "######



        WERKS_TX   LIKE T001W-NAME1,   "#####



        LIFNR_TX   LIKE LFA1-NAME1,    "#####

        MTART      LIKE MARA-MTART,    "####

        MTART_TX   LIKE T134T-MTBEZ,   "#### ##

        MATKL      LIKE MARA-MATKL,    "####

        MATKL_TX   LIKE T023T-WGBEZ,   "#### ##

        MATNR      LIKE MARA-MATNR,    "####

        MAKTG      LIKE MAKT-MAKTG,    "####



        EBELN      LIKE EKPO-EBELN,    "####

        EBELP      LIKE EKPO-EBELP,    "#### ##



        MINBM      LIKE EINE-MINBM,    "###### MOQ



        MENGE      LIKE EBAN-MENGE,    "#### ##

        MEINS      LIKE EBAN-MEINS,    "#### ##

        INQTY      LIKE EBAN-MENGE,    "##### Input

        BADAT      LIKE EBAN-BADAT,    "#####

        LFDAT      LIKE EBAN-LFDAT,    "#####



        KBETR      LIKE KONP-KBETR,    "####

        KONWA      LIKE KONP-KONWA,    "####



        ZZMBMSTAT  LIKE MARC-ZZMBMSTAT, "BM####

        ZZMBMTEXT  LIKE MARC-ZZMBMTEXT, "BM#### ##

        ZZMDNSTAT  LIKE MARC-ZZMDNSTAT, "DN####

        ZZMDNTEXT  LIKE MARC-ZZMDNTEXT, "DN#### ##

        MATNR2     LIKE MARC-ZZMATNR3, "####

        MINBM2     LIKE EINE-MINBM,    "###### MOQ

        MAKTG2     LIKE MAKT-MAKTG,     "#### ##

        WAERS      LIKE EBAN-WAERS,     "##



        ZZVSTAT    LIKE LFM1-ZZVSTAT,  "#####

        ZZVSTAT_TX LIKE DD07V-DDTEXT,  "### ##



        MSG(100),                       "#### ###



        LAND1      LIKE LFA1-LAND1,     "####

        WEBAZ      LIKE MARC-WEBAZ,

        PLIFZ      LIKE MARC-PLIFZ,           "EINE-APLFZ  # ##,  ######.

        MEINS2     LIKE EINA-MEINS,     "moq##



        KNTTP      TYPE KNTTP,          "## ## ##

        SAKTO      TYPE SAKTO,          "GL##

        KOSTL      TYPE KOSTL,          "#####

        SPERR      LIKE LFB1-SPERR,

        LOEVM      LIKE LFB1-LOEVM,

        LABST      LIKE MARD-LABST,    "1100/1200 ##.

        MEINS_LABST  LIKE MARA-MEINS,



        "20190930 ##

        LABST_2300 LIKE MARD-LABST, "2300##

        LABST_RES  LIKE MARD-LABST, "##(PO)# ##

        LABST_SUM  LIKE MARD-LABST, "1200 + 2300 + ##



        BSAKZ      LIKE EKKO-BSAKZ,

        BISMT      LIKE MARA-BISMT,

        FERTH      LIKE MARA-FERTH,



        BPRME      LIKE EINE-BPRME, "#### ##

        STYL       TYPE LVC_T_STYL,    " attribute ##.

        SCOL       TYPE LVC_T_SCOL.    " color

TYPES  END OF TY_100.





TYPES : BEGIN OF TY_ALV,

          O_DOCK        TYPE REF TO CL_GUI_DOCKING_CONTAINER,

          O_GRID        TYPE REF TO LCL_ALV_GRID,

          O_CONT        TYPE REF TO CL_GUI_CONTAINER,

          O_CUST        TYPE REF TO CL_GUI_CUSTOM_CONTAINER,

          O_MR_TOOLBAR  TYPE REF TO CL_GUI_TOOLBAR,

          T_FIELDCAT    TYPE LVC_T_FCAT,

          S_FIELDCAT    TYPE LVC_S_FCAT,

          S_LAYOUT      TYPE LVC_S_LAYO,

          S_SORT        TYPE LVC_S_SORT,

          T_SORT        TYPE LVC_T_SORT,

          T_DROP_DOWN   TYPE LVC_T_DROP,

          S_DROP_DOWN   TYPE LVC_S_DROP,

          T_CELLTAB     TYPE LVC_T_STYL,

          S_CELLTAB     TYPE LVC_S_STYL,

          T_EXCLUDE     TYPE UI_FUNCTIONS,

          S_TOOLBAR     TYPE STB_BUTTON,

          S_F4          TYPE LVC_S_F4,

          T_F4          TYPE LVC_T_F4,

          S_VARIANT     TYPE DISVARIANT,

          S_VARIANT_OUT TYPE DISVARIANT,

        END OF TY_ALV.





DATA : GO_100  TYPE TY_ALV.






*----------------------------------------------------------------------*

* Structure

*----------------------------------------------------------------------*




DATA : GT_DISP_100 TYPE TABLE OF TY_100 WITH HEADER LINE.





DATA : GT_EINA LIKE TABLE OF EINA WITH HEADER LINE,

       GT_EINE LIKE TABLE OF EINE WITH HEADER LINE.



DATA : GT_ZMMT0020 LIKE TABLE OF ZMMT0020 WITH HEADER LINE.






*### Itab




DATA : GT_T024E LIKE TABLE OF T024E WITH HEADER LINE, "####

       GT_T001W LIKE TABLE OF T001W WITH HEADER LINE, "###

       GT_T024  LIKE TABLE OF T024  WITH HEADER LINE, "####

       GT_LFA1  LIKE TABLE OF LFA1  WITH HEADER LINE, "###

       GT_T134T LIKE TABLE OF T134T WITH HEADER LINE, "####

       GT_T023T LIKE TABLE OF T023T WITH HEADER LINE, "####

       GT_MAKT  LIKE TABLE OF MAKT  WITH HEADER LINE. "####






*  DATA : BEGIN OF GT_LIFNR OCCURS 0,

*           LIFNR LIKE LFA1-LIFNR,

*         END OF GT_LIFNR.






DATA : BEGIN OF GT_LABST_RES OCCURS 0,

         MATNR TYPE MATNR,

         MENGE TYPE LABST,

       END OF GT_LABST_RES.



DATA : BEGIN OF GT_MOQ OCCURS 0,

         MATNR LIKE EINA-MATNR,

         LIFNR LIKE EINA-LIFNR,

         EKORG LIKE EINE-EKORG,

         WERKS LIKE EINE-WERKS,

         MINBM LIKE EINE-MINBM, "## ## ## ##

         BPRME LIKE EINE-BPRME,

         MEINS LIKE EINA-MEINS,

         INFNR LIKE EINE-INFNR,

       END OF GT_MOQ.



DATA : BEGIN OF GT_KONP OCCURS 0,

         MATNR LIKE EINA-MATNR,

         LIFNR LIKE EINA-LIFNR,

         EKORG LIKE EINE-EKORG,

         WERKS LIKE EINE-WERKS,

         KBETR LIKE KONP-KBETR,  "####

         KONWA LIKE KONP-KONWA,  "####

       END OF GT_KONP.



DATA : BEGIN OF GT_LFM1 OCCURS 0,

         EKORG LIKE LFM1-EKORG,

         LIFNR LIKE LFM1-LIFNR,




*-S #### ## ## ## 20191007 by PWC096




         WAERS LIKE LFM1-WAERS,




*-E




       END OF GT_LFM1.






*----------------------------------------------------------------------*

* BAPI

*----------------------------------------------------------------------*




DATA : GS_POHEADER  TYPE BAPIMEPOHEADER,

       GS_POHEADERX TYPE BAPIMEPOHEADERX,

       G_EBELN      TYPE EBELN,

       GV_EBELP     TYPE EBELP.



DATA : GS_RETURN_PO     TYPE BAPIRET2,

       GS_POITEM        TYPE BAPIMEPOITEM,

       GS_POITEMX       TYPE BAPIMEPOITEMX,

       GS_POACCOUNT     TYPE BAPIMEPOACCOUNT,

       GS_POACCOUNTX    TYPE BAPIMEPOACCOUNTX,

       GS_POSCHEDULE    TYPE BAPIMEPOSCHEDULE,

       GS_POSCHEDULEX   TYPE BAPIMEPOSCHEDULX,

       GS_POCOND        TYPE BAPIMEPOCOND,

       GS_POCONDX       TYPE BAPIMEPOCONDX,

       GS_POCOMPONENTS  TYPE BAPIMEPOCOMPONENT,

       GS_POCOMPONENTSX TYPE BAPIMEPOCOMPONENTX,

       GS_POSERVICES    TYPE BAPIESLLC,

       GS_POSRVACCES    LIKE BAPIESKLC,

       GS_EXTENSIONIN   TYPE BAPIPAREX.



DATA : GT_RETURN_PO     TYPE TABLE OF BAPIRET2,

       GT_POITEM        TYPE TABLE OF BAPIMEPOITEM,

       GT_POITEMX       TYPE TABLE OF BAPIMEPOITEMX,

       GT_POACCOUNT     TYPE TABLE OF BAPIMEPOACCOUNT,

       GT_POACCOUNTX    TYPE TABLE OF BAPIMEPOACCOUNTX,

       GT_POSCHEDULE    TYPE TABLE OF BAPIMEPOSCHEDULE,

       GT_POSCHEDULEX   TYPE TABLE OF BAPIMEPOSCHEDULX,

       GT_POCOND        TYPE TABLE OF BAPIMEPOCOND,

       GT_POCONDX       TYPE TABLE OF BAPIMEPOCONDX,

       GT_POCOMPONENTS  TYPE TABLE OF BAPIMEPOCOMPONENT,

       GT_POCOMPONENTSX TYPE TABLE OF BAPIMEPOCOMPONENTX,

       GT_POSERVICES    TYPE TABLE OF BAPIESLLC,

       GT_POSRVACCES    LIKE TABLE OF BAPIESKLC,

       GT_EXTENSIONIN   TYPE TABLE OF BAPIPAREX,

       GT_POHTEXT       TYPE TABLE OF BAPIMEPOTEXTHEADER WITH HEADER LINE.



DATA : GS_RETURN_PR     TYPE BAPIRET2,

       GS_PRITEM        TYPE BAPIMEREQITEMIMP,

       GS_PRITEMX       TYPE BAPIMEREQITEMX.



DATA : GT_RETURN_PR     TYPE TABLE OF BAPIRET2,

       GT_PRITEM        TYPE TABLE OF BAPIMEREQITEMIMP,

       GT_PRITEMX       TYPE TABLE OF BAPIMEREQITEMX.





  DATA : BEGIN OF GT_EKPO OCCURS 0,

           EBELN LIKE EKPO-EBELN,

           EBELP LIKE EKPO-EBELP,

           BANFN LIKE EKPO-BANFN,

           BNFPO LIKE EKPO-BNFPO,

         END OF GT_EKPO.





DATA : G_LINE_NO  TYPE BAPIESLLC-LINE_NO,

       G_EXT_LINE TYPE BAPIESLLC-EXT_LINE,

       G_PCKGNO   TYPE EBAN-PACKNO.








*----------------------------------------------------------------------*

* Ranges

*----------------------------------------------------------------------*





*----------------------------------------------------------------------*

* For Table control

*----------------------------------------------------------------------*






CONTROLS: TC_110 TYPE TABLEVIEW USING SCREEN 0110.



DATA : GV_TC_110_LINES LIKE SY-LOOPC,

       GV_CARRID       LIKE SCARR-CARRID,

       GV_CARRNAME     LIKE SCARR-CARRNAME.




*----------------------------------------------------------------------*

* Define : Objects

*----------------------------------------------------------------------*




DATA : GO_DOCKING          TYPE REF TO CL_GUI_DOCKING_CONTAINER.

DATA : GO_DOCKING2         TYPE REF TO CL_GUI_DOCKING_CONTAINER.

DATA : GO_CONT_100         TYPE REF TO CL_GUI_CONTAINER.

DATA : GO_CONT_101         TYPE REF TO CL_GUI_CONTAINER.

DATA : GO_CONT_110         TYPE REF TO CL_GUI_CONTAINER.

DATA : GO_CONT_120         TYPE REF TO CL_GUI_CONTAINER.

DATA : GO_CONT_130         TYPE REF TO CL_GUI_CONTAINER.

DATA : GO_GRID_100         TYPE REF TO CL_GUI_ALV_GRID.

DATA : GO_GRID_110         TYPE REF TO CL_GUI_ALV_GRID.

DATA : GO_GRID_120         TYPE REF TO CL_GUI_ALV_GRID.

DATA : GO_SPLIT            TYPE REF TO CL_GUI_SPLITTER_CONTAINER.

DATA : GO_SPLIT2           TYPE REF TO CL_GUI_SPLITTER_CONTAINER.

DATA : GO_EDIT_200         TYPE REF TO CL_GUI_TEXTEDIT.






*****




DATA: G_TREE             TYPE REF TO CL_GUI_ALV_TREE,

      G_HIERARCHY_HEADER TYPE TREEV_HHDR,

      G_TOOLBAR          TYPE REF TO CL_GUI_TOOLBAR,

      GT_LIST_COMMENTARY TYPE SLIS_T_LISTHEADER,

      G_LOGO             TYPE SDYDO_VALUE.



DATA : GT_FIELDCAT TYPE LVC_T_FCAT,

       GS_FIELDCAT TYPE LVC_S_FCAT,

       GS_VARIANT  TYPE DISVARIANT.

DATA : GT_STYL     TYPE LVC_T_STYL.




*DATA : gt_sort100          TYPE lvc_t_sort,

*       gt_sort300          TYPE lvc_t_sort,

*       gt_sort400          TYPE lvc_t_sort.

*DATA : gs_sort             TYPE lvc_s_sort.




DATA : GS_LAYO    TYPE LVC_S_LAYO,

       GT_EXCLUDE TYPE UI_FUNCTIONS. "Tool Bar Button##



DATA : GS_SCROLL           TYPE LVC_S_STBL.




*HTML Document Viewer




DATA : GO_DOCUMENT         TYPE REF TO CL_DD_DOCUMENT.

DATA : GO_HTML             TYPE REF TO CL_GUI_HTML_VIEWER.

CONSTANTS : GC_ALV_GRID    TYPE SDYDO_ATTRIBUTE VALUE 'ALV_GRID',

            GC_LINE_LENGTH TYPE I VALUE 72.

DATA : GO_EVENT_RECEIVER  TYPE REF TO LCL_EVENT_RECEIVER.

DATA : GT_ROW              TYPE LVC_T_ROW.

DATA : GS_ROW              TYPE LVC_S_ROW.






*---------------------------------




DATA : GT_COL TYPE LVC_T_SCOL,

       GS_COL TYPE LVC_S_SCOL.






*---------------------------------



*----------------------------------------------------------------------*

* ADD TEXT                                                         *

*----------------------------------------------------------------------*




DEFINE _ADD_TEXT_HEAD.



  call method &1->add_text

    exporting

      text         = &2

      sap_style    = cl_dd_document=>heading

      sap_fontsize = cl_dd_area=>large

      sap_color    = cl_dd_area=>list_heading_int.



  call method &1->new_line.




*list_background_inv




END-OF-DEFINITION.

DEFINE _ADD_TEXT.



  call method &1->add_text

    exporting

      text         = &2

      sap_style    = cl_dd_document=>list_background_inv

      sap_fontsize = cl_dd_area=>large

      sap_color    = cl_dd_area=>list_heading_int.



  call method &1->new_line.




*list_background_inv




END-OF-DEFINITION.




*----------------------------------------------------------------------*

* MACRO DEFINE                                                         *

*----------------------------------------------------------------------*




DEFINE __CLEAR_TAB.



  clear &1.

  refresh &1.



END-OF-DEFINITION.




*----------------------------------------------------------------------

* MACRO REFRESH ALV

*----------------------------------------------------------------------




DEFINE _REFRESHTAB.



  clear gs_scroll.

  gs_scroll-row = &3.  gs_scroll-col = &4.

  call method &1->refresh_table_display

    exporting

      i_soft_refresh = &2

      is_stable      = gs_scroll.



END-OF-DEFINITION.




*----------------------------------------------------------------------

* MACRO REFRESH ALV

*----------------------------------------------------------------------




DEFINE _ALPHA_INPUT.



  call function 'CONVERSION_EXIT_ALPHA_INPUT'

    exporting

      input  = &1

    importing

      output = &2.



END-OF-DEFINITION.




*----------------------------------------------------------------------

* confirm popup

*----------------------------------------------------------------------




DEFINE _CONFIRM2.



  clear &4.

  call function 'POPUP_TO_CONFIRM_STEP'

    exporting

      textline1 = &1

      textline2 = &2

      titel     = &3

    importing

      answer    = &4.





END-OF-DEFINITION.



DEFINE _CONFIRM.

  CALL FUNCTION 'RSOS_POPUP_TO_CONFIRM'

    EXPORTING

      titlebar      = &3

      text_question = &1

      text_button_1 = TEXT-t07

      text_button_2 = TEXT-t08

    IMPORTING

      answer        = &2.

END-OF-DEFINITION.




*----------------------------------------------------------------------

* MACRO REFRESH ALV

*----------------------------------------------------------------------




DEFINE _REFRESHTAB.



  clear gs_scroll.

  gs_scroll-row = &3.  gs_scroll-col = &4.

  call method &1->refresh_table_display

    exporting

      i_soft_refresh = &2

      is_stable      = gs_scroll.



END-OF-DEFINITION.






*----------------------------------------------------------------------

* MACRO Modify cell

*----------------------------------------------------------------------




DEFINE _MODI_CELL.



  call method &1->modify_cell

    exporting

      i_row_id    = &2

      i_fieldname = &3

      i_value     = &4.



END-OF-DEFINITION.




*----------------------------------------------------------------------

* MACRO GET cell

*----------------------------------------------------------------------




DEFINE _GET_CELL.



  call method &1->GET_CELL_VALUE

    exporting

      i_row_id    = &2

      i_fieldname = &3

      IMPORTING

      E_value     = &4.



END-OF-DEFINITION.




*----------------------------------------------------------------------

* MACRO Modify STYLE

*----------------------------------------------------------------------




DEFINE _MODI_STYLE.

  CASE &4.

    WHEN GC_1.

    call method &1->modify_STYLE

      exporting

        i_row_id    = &2

        i_fieldname = &3

        i_STYLE     = CL_GUI_ALV_GRID=>MC_STYLE_ENABLED.

    WHEN GC_2.

    call method &1->modify_STYLE

      exporting

        i_row_id    = &2

        i_fieldname = &3

        i_STYLE     = CL_GUI_ALV_GRID=>MC_STYLE_DISABLED.

   ENDCASE.



END-OF-DEFINITION.




*----------------------------------------------------------------------

* MACRO READ cell

*----------------------------------------------------------------------




DEFINE _READ_CELL.

  CASE &3.

    WHEN GC_1.

       READ TABLE &1->MT_GOOD_CELLS

               WITH KEY ROW_ID = &5

                        FIELDNAME = &2

                        STYLE = CL_GUI_ALV_GRID=>MC_STYLE_ENABLED

               TRANSPORTING NO FIELDS.

    WHEN GC_2.

       READ TABLE &1->MT_GOOD_CELLS

               WITH KEY ROW_ID = &5

                        FIELDNAME = &2

                        STYLE = CL_GUI_ALV_GRID=>MC_STYLE_DISABLED

               TRANSPORTING NO FIELDS.

   ENDCASE.

&4 = SY-SUBRC.

END-OF-DEFINITION.






*----------------------------------------------------------------------

* MACRO Message popup

*----------------------------------------------------------------------




DEFINE _MESSAGE_POPUP.

  clear &6.



  call function 'POPUP_TO_CONFIRM_STEP'

    exporting

      defaultoption  = &1

      titel          = &2

      textline1      = &3

      textline2      = &4

      cancel_display = &5

    importing

      answer         = &6.               " J# N### A##



END-OF-DEFINITION.






*----------------------------------------------------------------------

* MACRO Clear Itab

*----------------------------------------------------------------------




DEFINE _CLEAR.



  CLEAR : &1.

  REFRESH : &1.



END-OF-DEFINITION.






*----------------------------------------------------------------------

* MACRO Append Itab

*----------------------------------------------------------------------




DEFINE _APPEND.



  append : &1.

  clear : &1.



END-OF-DEFINITION.



DEFINE _COLLECT.



  collect : &1.

  clear : &1.



END-OF-DEFINITION.






*----------------------------------------------------------------------

* MACRO RANGES

*----------------------------------------------------------------------




DEFINE _RANGES.



  CLEAR : &1.

     &1-SIGN   = &2.

     &1-OPTION = &3.

     &1-LOW    = &4.

     &1-HIGH   = &5.

    COLLECT : &1.



END-OF-DEFINITION.

DEFINE _GET_APPEND.



  IF &2 is not initial.

     append : &1.

     clear : &1.

  endif.



END-OF-DEFINITION.

DEFINE _CONV.

  case &1.

    when 'I'.

      call function 'CONVERSION_EXIT_ALPHA_INPUT'

        exporting

          input  = &2

        importing

          output = &3.

    when 'O'.

      call function 'CONVERSION_EXIT_ALPHA_OUTPUT'

        exporting

          input  = &2

        importing

          output = &3.

  endcase.

END-OF-DEFINITION.



DATA : MOUNT_EX LIKE  BAPICURR-BAPICURR.



DEFINE _CONV_WAERS.

  clear : mount_ex.

  case &1.

    when 'I'.

      mount_ex = &3.

      call function 'BAPI_CURRENCY_CONV_TO_INTERNAL'

        exporting

          currency                 =  &2

          amount_external         =  mount_ex

          max_number_of_digits    = 13

       importing

         amount_internal   = &4.



    when 'O'.

      call function 'BAPI_CURRENCY_CONV_TO_EXTERNAL'

        exporting

          currency              = &2

          amount_internal       =  &3

       importing

         amount_external       =     mount_ex.



      &4 = mount_ex.



  endcase.

END-OF-DEFINITION.





DEFINE _SET_LAYOUT.



  CALL METHOD &1->SET_FRONTEND_LAYOUT

    EXPORTING

      IS_LAYOUT = &2.



END-OF-DEFINITION.