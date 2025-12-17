
*&---------------------------------------------------------------------*

*&  Include           ZDOCKING_CONTAINER11_F01

*&---------------------------------------------------------------------*






FORM CREATE_OBJECT.



  CREATE OBJECT GC_DOCKING

    EXPORTING




*      PARENT                      =




      REPID                       = SY-REPID

      DYNNR                       = SY-DYNNR




*      SIDE                        = DOCK_AT_LEFT




      EXTENSION                   = 2000




*      STYLE                       =

*      LIFETIME                    = lifetime_default

*      CAPTION                     =

*      METRIC                      = 0

*      RATIO                       =

*      NO_AUTODEF_PROGID_DYNNR     =

*      NAME                        =

*    EXCEPTIONS

*      CNTL_ERROR                  = 1

*      CNTL_SYSTEM_ERROR           = 2

*      CREATE_ERROR                = 3

*      LIFETIME_ERROR              = 4

*      LIFETIME_DYNPRO_DYNPRO_LINK = 5

*      others                      = 6




      .

  IF SY-SUBRC <> 0.




*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*              WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  ENDIF.









CREATE OBJECT GC_GRID

  EXPORTING




*    I_SHELLSTYLE      = 0

*    I_LIFETIME        =




    I_PARENT          = GC_DOCKING




*    I_APPL_EVENTS     = space

*    I_PARENTDBG       =

*    I_APPLOGPARENT    =

*    I_GRAPHICSPARENT  =

*    I_NAME            =

*    I_FCAT_COMPLETE   = SPACE

*  EXCEPTIONS

*    ERROR_CNTL_CREATE = 1

*    ERROR_CNTL_INIT   = 2

*    ERROR_CNTL_LINK   = 3

*    ERROR_DP_CREATE   = 4

*    others            = 5




    .

IF SY-SUBRC <> 0.




* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO

*            WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




ENDIF.



ENDFORM.



FORM ALV_DISPLAY.

  CALL METHOD GC_GRID->SET_TABLE_FOR_FIRST_DISPLAY

    EXPORTING




*      I_BUFFER_ACTIVE               =

*      I_BYPASSING_BUFFER            =

*      I_CONSISTENCY_CHECK           =

*      I_STRUCTURE_NAME              =




      IS_VARIANT                    = GS_VARIANT

      I_SAVE                        = 'A'




*      I_DEFAULT                     = 'X'




      IS_LAYOUT                     = GS_LAYOUT




*      IS_PRINT                      =

*      IT_SPECIAL_GROUPS             =

*      IT_TOOLBAR_EXCLUDING          =

*      IT_HYPERLINK                  =

*      IT_ALV_GRAPHICS               =

*      IT_EXCEPT_QINFO               =

*      IR_SALV_ADAPTER               =




    CHANGING

      IT_OUTTAB                     = GT_STUDENT

      IT_FIELDCATALOG               = GT_FIELDCAT

      IT_SORT                       = GT_SORT




*      IT_FILTER                     =

*    EXCEPTIONS

*      INVALID_PARAMETER_COMBINATION = 1

*      PROGRAM_ERROR                 = 2

*      TOO_MANY_LINES                = 3

*      others                        = 4




          .

  IF SY-SUBRC <> 0.




*   Implement suitable error handling here




  ENDIF.





  ENDFORM.



  FORM SET_INIT .



ENDFORM.

FORM FIELD_CATALOG .

  CLEAR : gs_fieldcat.



  gs_fieldcat-col_pos = 1.

  gs_fieldcat-fieldname = 'ZCODE'.

  gs_fieldcat-coltext = '####'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.



  gs_fieldcat-col_pos = 2.

  gs_fieldcat-fieldname = 'ZPERNR'.

  gs_fieldcat-coltext = '####'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.



  gs_fieldcat-col_pos = 3.

  gs_fieldcat-fieldname = 'ZKNAME'.

  gs_fieldcat-coltext = '####'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.



  gs_fieldcat-col_pos = 4.

  gs_fieldcat-fieldname = 'ZENAME'.

  gs_fieldcat-coltext = '####'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.



  gs_fieldcat-col_pos = 5.

  gs_fieldcat-fieldname = 'ZGENDER'.

  gs_fieldcat-coltext = '##'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.



  gs_fieldcat-col_pos = 6.

  gs_fieldcat-fieldname = 'ZSUM'.

  gs_fieldcat-coltext = '#'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.



  gs_fieldcat-col_pos = 7.

  gs_fieldcat-fieldname = 'ZMAJOR'.

  gs_fieldcat-coltext = '####'.

  APPEND gs_fieldcat TO gt_fieldcat.



  CLEAR : gs_fieldcat.



  gs_fieldcat-col_pos = 8.

  gs_fieldcat-fieldname = 'ZMNAME'.

  gs_fieldcat-coltext = '###'.

  APPEND gs_fieldcat TO gt_fieldcat.





ENDFORM.





FORM ALV_LAYOUT .

  CLEAR GS_LAYOUT.

  GS_LAYOUT-ZEBRA = 'X'.



  CLEAR GS_VARIANT.

  GS_VARIANT-REPORT = SY-REPID.

  GS_VARIANT-USERNAME = SY-UNAME.

ENDFORM.

FORM ALV_SORT .



ENDFORM.



FORM CALL_ALV .

  PERFORM alv_display.

ENDFORM.



FORM GET_DATA .

  SELECT

    a~zcode, a~zpernr, a~zkname, a~zename, a~zgender,

    b~zsum, b~zmajor, b~zmname



  FROM zedt11_001 as a

    LEFT OUTER JOIN zedt11_002 as b

    ON a~zpernr = b~zpernr



  WHERE

    a~ZPERNR IN @S_zPERNR



  INTO CORRESPONDING FIELDS OF TABLE @gt_student.



  BREAK-POINT.

ENDFORM.