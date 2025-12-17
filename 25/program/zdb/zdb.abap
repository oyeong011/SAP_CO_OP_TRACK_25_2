
*&---------------------------------------------------------------------*

*& Report ZDUMMY_DATA_INSERT_25

*&---------------------------------------------------------------------*

*& PO 4500000001 ## ## ## ### INSERT ####

*& ## ##: SE38 # ## # F8 ##

*&---------------------------------------------------------------------*




REPORT zdummy_data_insert_25.



DATA: lv_answer TYPE c.



START-OF-SELECTION.



  " ## ##

  CALL FUNCTION 'POPUP_TO_CONFIRM'

    EXPORTING

      titlebar              = '## ### INSERT ##'

      text_question         = '## ## #### INSERT######?'

      text_button_1         = '#'

      text_button_2         = '###'

      display_cancel_button = ''

    IMPORTING

      answer                = lv_answer.



  IF lv_answer <> '1'.

    MESSAGE '#######.' TYPE 'S'.

    RETURN.

  ENDIF.



  "====================================================================

  " 1. #### ### INSERT (ZEDT25_ZTERM)

  "====================================================================

  " M001 ##### ## ## ##

  DATA: ls_zterm TYPE zedt25_zterm.



  SELECT SINGLE *

    FROM zedt25_zterm

    INTO ls_zterm

    WHERE zterm = 'M001'.



  IF sy-subrc <> 0.

    ls_zterm-mandt = sy-mandt.

    ls_zterm-zterm = 'M001'.

    ls_zterm-text  = '30# ## ##'.



    INSERT zedt25_zterm FROM ls_zterm.

    IF sy-subrc = 0.

      WRITE: / '# #### M001 INSERT ##'.

    ELSE.

      WRITE: / '# #### INSERT ##:', sy-subrc.

    ENDIF.

  ELSE.

    WRITE: / '- #### M001 ## ## (##)'.

  ENDIF.



  "====================================================================

  " 2. ## ## INSERT (ZEDT25_ZRBKP)

  "====================================================================

  DATA: ls_rbkp TYPE zedt25_zrbkp.



  " ## ##

  SELECT SINGLE *

    FROM zedt25_zrbkp

    INTO ls_rbkp

    WHERE belnr = '5000000001'

      AND gjahr = '2024'.



  IF sy-subrc = 0.

    WRITE: / '- ## ## 5000000001 ## ## (##)'.

  ELSE.

    CLEAR ls_rbkp.

    ls_rbkp-mandt = sy-mandt.

    ls_rbkp-belnr = '5000000001'.

    ls_rbkp-gjahr = '2024'.

    ls_rbkp-blart = 'RE'.

    ls_rbkp-bldat = '20241201'.

    ls_rbkp-budat = '20241201'.

    ls_rbkp-bukrs = '1000'.

    ls_rbkp-lifnr = '1000000005'.

    ls_rbkp-waers = 'USD'.

    ls_rbkp-zterm = 'M001'.

    ls_rbkp-bktxt = '4500000001####'.

    ls_rbkp-xmwst = 'X'.

    ls_rbkp-mwskz = 'V1'.

    ls_rbkp-wmwst = '200.00'.

    ls_rbkp-rmwwr = '2200.00'.

    ls_rbkp-ebeln = '4500000001'.

    ls_rbkp-werks = '1000'.



    INSERT zedt25_zrbkp FROM ls_rbkp.

    IF sy-subrc = 0.

      WRITE: / '# ## ## 5000000001 INSERT ##'.

    ELSE.

      WRITE: / '# ## ## INSERT ##:', sy-subrc.

    ENDIF.

  ENDIF.



  "====================================================================

  " 3. ## ### INSERT (ZEDT25_ZRSEG)

  "====================================================================

  DATA: ls_rseg TYPE zedt25_zrseg.



  " ## ##

  SELECT SINGLE *

    FROM zedt25_zrseg

    INTO ls_rseg

    WHERE belnr = '5000000001'

      AND gjahr = '2024'

      AND buzei = '000001'.



  IF sy-subrc = 0.

    WRITE: / '- ## ### 5000000001-000001 ## ## (##)'.

  ELSE.

    CLEAR ls_rseg.

    ls_rseg-mandt = sy-mandt.

    ls_rseg-belnr = '5000000001'.

    ls_rseg-gjahr = '2024'.

    ls_rseg-buzei = '000001'.

    ls_rseg-ebeln = '4500000001'.

    ls_rseg-ebelp = '00010'.

    ls_rseg-matnr = '7'.

    ls_rseg-bukrs = '1000'.

    ls_rseg-txz01 = '###(FRON...)'.

    ls_rseg-werks = '1000'.

    ls_rseg-lgort = '2000'.

    ls_rseg-shkzg = 'S'.

    ls_rseg-menge = '10.000'.

    ls_rseg-meins = 'EA'.

    ls_rseg-bstme = 'EA'.

    ls_rseg-bpmng = '10.000'.

    ls_rseg-wrbtr = '2000.00'.

    ls_rseg-mwskz = 'V1'.

    ls_rseg-wmwst = '200.00'.

    ls_rseg-waers = 'USD'.

    ls_rseg-sgtxt = '4500000001####'.



    INSERT zedt25_zrseg FROM ls_rseg.

    IF sy-subrc = 0.

      WRITE: / '# ## ### 000001 INSERT ##'.

    ELSE.

      WRITE: / '# ## ### INSERT ##:', sy-subrc.

    ENDIF.

  ENDIF.



  "====================================================================

  " ##

  "====================================================================

  SKIP 1.

  WRITE: / '===================================='.

  WRITE: / '## ### INSERT ##!'.

  WRITE: / '===================================='.

  SKIP 1.

  WRITE: / '## ##:'.

  WRITE: / '1. SE16N # ZEDT25_ZRBKP # BELNR = 5000000001'.

  WRITE: / '2. SE16N # ZEDT25_ZRSEG # BELNR = 5000000001'.

  SKIP 1.

  WRITE: / '#### ##:'.

  WRITE: / '- SE38 # ZMM25_004 ##'.

  WRITE: / '- PO: 4500000001, ###: 1000'.

  WRITE: / '- [## ##] ## # F8'.



  COMMIT WORK.








*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   #######.