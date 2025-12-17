
*&---------------------------------------------------------------------*

*& Report ZEDR05_PRACTICE003

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR05_PRACTICE003 LINE-SIZE 200.








*

*1. ### ## #### ##### #### ##### ## ## # # ### ##

*2. RANGE### ## 1# ## ####

*4. ### ### #### ### ## ####

*6.CONSTANTS# ## 1# ## ####

*

*#### ## ##

*1. ##### ## ## ### ### ##### ## ## #### #### ## ### ## ### ####

*3. #### #### ## ###, ####, ## ### , ###### ### ##

*4. ## ### ##KRW# ##

*5. ZEDT00_101-ZFLAG# X### ###### ## ## # ### ####

*6. ###### #### ### ### ####(R1), ####(R1, R2), ####(R2) ## ####

*(### # ## ### ## ### ### ##)

*7. ###### ### #### ### ### ## , #### #### #### #### ( ##### ####or####### #### ## ##)





*0. ##### ZEDT00_100, ##### ZEDT00_101##### #### (### ## ### ###)




tables ZEDT05_100.

tables ZEDT05_101.



constants: C_RETURN type C value 'X',  "## ###

           C_KRW(3) type C value 'KRW'. "####

DATA : ZRET_FG TYPE C.



" ### ### ##



types: begin of TY_SEL_OUTPUT,

          ZORDNO   type ZEDT05_100-ZORDNO,    "####

          ZIDCODE  type ZEDT05_100-ZIDCODE,   "##ID

          ZMATNR   type ZEDT05_100-ZMATNR,    "####

          ZMATNAME type ZEDT05_100-ZMATNAME,    "###

          ZMTART   type ZEDT05_100-ZMTART,    "####

          ZMTART_TXT   type STRING,    "#### ###

          ZVOLUM   type ZEDT05_100-ZVOLUM,    "##

          VRKME    type ZEDT05_100-VRKME,    "##

          ZNSAMT   type ZEDT05_100-ZNSAMT,    "####

          ZSLAMT   type ZEDT05_100-ZSLAMT,    "####

         ZDCAMT    type ZEDT05_100-ZDCAMT,    "####

        ZSALE_FG   type ZEDT05_100-ZSALE_FG,  "####

      ZSALE_FG_TXT TYPE STRING,               "#### ## ##

         ZJDATE    type ZEDT05_100-ZJDATE,    "####

         ZRET_FG   type ZEDT05_100-ZRET_FG,    "####

         ZRET_FG_TXT   type STRING,            "#### ## ##

         ZRDATE    type ZEDT05_100-ZRDATE,    "####

       end of TY_SEL_OUTPUT.



types: begin of TY_DEL_OUTPUT,

          ZORDNO   type ZEDT05_100-ZORDNO,    "####

          ZIDCODE  type ZEDT05_100-ZIDCODE,   "##ID

          ZMATNR   type ZEDT05_100-ZMATNR,    "####

          ZMATNAME type ZEDT05_100-ZMATNAME,    "###

          ZMTART   type ZEDT05_100-ZMTART,    "####

          ZMTART_TXT   type STRING,    "#### ###

          ZVOLUM   type ZEDT05_100-ZVOLUM,    "##

          VRKME    type ZEDT05_100-VRKME,    "##

          ZNSAMT   type ZEDT05_100-ZNSAMT,    "####

          ZSLAMT   type ZEDT05_100-ZSLAMT,    "####

         ZDFLAG    type ZEDT05_101-ZDFLAG,    "####

         ZDFLAG_TXT    type STRING,           "####

         ZDGUBUN   type ZEDT05_101-ZDGUBUN,    "####

        ZDGUBUN_TXT   type STRING,              "#### ####

         ZDDATE    type ZEDT05_101-ZDDATE,    "####

        ZRDATE    type ZEDT05_101-ZRDATE,    "####

        ZFLAG TYPE ZEDT05_101-ZFLAG,

       end of TY_DEL_OUTPUT.








*5. ## ### #### ### ## ### #### #### (### ### ### ## ## ##)




data : GS_ZEDT100 type ZEDT05_100,

       GS_ZEDT101 type ZEDT05_101,

       GT_ZEDT100 like table of GS_ZEDT100,

       GT_ZEDT101 like table of GS_ZEDT101.

data :GS_OUT100 type TY_SEL_OUTPUT,

      GS_OUT101 type TY_DEL_OUTPUT,

      GT_OUT101 type table of TY_DEL_OUTPUT,

      GT_OUT100 type table of TY_SEL_OUTPUT.





selection-screen begin of block B1 with frame.

  select-options S_ZORDNO for ZEDT05_100-ZORDNO.

  SELECT-OPTIONS P_IDCODE FOR ZEDT05_100-ZIDCODE NO INTERVALS NO-EXTENSION.

  select-options S_ZMATNR for ZEDT05_100-ZMATNR.




*  3. ##### ##### ## default# ###### ##, ### ### 01.01~ ### ## ## ### ### ## FIX




  select-options S_ZJDATE for ZEDT05_100-ZJDATE modif id G1.

  select-options S_ZDDATE for ZEDT05_101-ZDDATE modif id G2.

selection-screen end of block B1.



selection-screen begin of block B2 with frame.






*1. ##### ###### #### ####, ## ID, ####, ####






  parameters : P_ORBT radiobutton group R1 default 'X' user-command CMD.




*##### ###### #### ####, ## ID, ####, #### ##### ### ##






  parameters : P_DELI radiobutton group R1.

selection-screen end of block B2.



selection-screen begin of block B3 with frame.






*2. ####### ##### ##### X## ##




  parameters : P_REF as checkbox default 'X'.



selection-screen end of block B3.








*3. INITIALIZATION# START-OF-SELECTION# ### ####

*3. ##### ##### ## default# ###### ##,




"### ### 01.01~ ### ## ## ### ### ## FIX



initialization.




*0. ##### 2025.#.## ####




  perform DATEFORMATEER.



at selection-screen output.

  perform RADIOCONTROL.












*4. ### ### #### ### ## ####

*5. ## ### #### ### ## ### #### #### (### ### ### ## ## ##)





*3. INITIALIZATION# START-OF-SELECTION# ### ####




start-of-selection.



  perform RADIO_CONDITION.





form RADIOCONTROL .

  "1. ##### ###### #### ####, ## ID, ####, ####






*##### ###### #### ####, ## ID, ####, #### ##### ### ##






  if P_ORBT = 'X'.

    loop at screen.

      if SCREEN-GROUP1 = 'G1'.

        SCREEN-ACTIVE = 1.

      endif.

      if SCREEN-GROUP1 = 'G2'.

        SCREEN-ACTIVE = 0.

      endif.

      modify screen.

    endloop.

  elseif P_DELI = 'X'.

    loop at screen.

      if SCREEN-GROUP1 = 'G2'.

        SCREEN-ACTIVE = 1.

      endif.

      if SCREEN-GROUP1 = 'G1'.

        SCREEN-ACTIVE = 0.

      endif.

      modify screen.

    endloop.

  endif.

endform.




*0. ##### 2025.#.## ####




form DATEFORMATEER .

  data: LV_YEAR(4) type C,

        LV_FIRST   type SY-DATUM,

        LV_LAST    type SY-DATUM.



  "### ## ## ##

  call function 'RP_LAST_DAY_OF_MONTHS'

    exporting

      DAY_IN            = SY-DATUM

    importing

      LAST_DAY_OF_MONTH = LV_LAST.



  " ## ### ##

  LV_YEAR = SY-DATUM(4).

  concatenate LV_YEAR SY-DATUM+4(2) into LV_FIRST.

  concatenate LV_FIRST '01' into LV_FIRST.



  S_ZDDATE-SIGN = 'I'.

  S_ZDDATE-OPTION = 'BT'.

  S_ZDDATE-LOW = LV_FIRST.

  S_ZDDATE-HIGH = LV_LAST.

  append S_ZDDATE.



  S_ZJDATE-SIGN = 'I'.

  S_ZJDATE-OPTION = 'BT'.

  S_ZJDATE-LOW = LV_FIRST.

  S_ZJDATE-HIGH = LV_LAST.

  append S_ZJDATE.





endform.








* ## #### #### ### ## ## ##




form RADIO_CONDITION .




* ### ### ##,#### ##




  DATA : LV_TYPE TYPE C LENGTH 10.



  if P_ORBT = 'X'.

    LV_TYPE = 'ORDER'.

  elseif P_DELI = 'X'.

    LV_TYPE = 'DELIVERY'.

  endif.



  IF P_REF = 'X'.

    ZRET_FG = 'X'.

  ENDIF.






* ## ### ## ##




  PERFORM COMMON_PS USING LV_TYPE.




* ### #### ##




  PERFORM MOVE_TO_OUTPUT USING LV_TYPE.



  PERFORM DISPLAY USING LV_TYPE.

endform.




*&---------------------------------------------------------------------*

*&      Form  COMMON_PS

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_LV_TYPE  text

*----------------------------------------------------------------------*



* ## ### ##






form COMMON_PS using P_TYPE TYPE C.

  PERFORM SELECT_DATA USING P_TYPE.



  IF P_REF IS INITIAL.

    PERFORM FILTER_RETURN_DATA USING P_TYPE ZRET_FG.

  ENDIF.








*  PERFORM FILTER_OPTION_DATA USING P_TYPE.






endform.




*&---------------------------------------------------------------------*

*&      Form  SELECT_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_P_TYPE  text

*----------------------------------------------------------------------*



* #### ### ##






form SELECT_DATA  using  P_TYPE.

  CASE P_TYPE.

    WHEN 'ORDER'.

      SELECT * FROM ZEDT05_100

      INTO TABLE GT_ZEDT100

      WHERE ZORDNO IN S_ZORDNO

      AND ZJDATE IN S_ZJDATE

      AND ZMATNR IN S_ZMATNR

      AND ZIDCODE IN P_IDCODE.

    WHEN 'DELIVERY'.

      SELECT * FROM ZEDT05_101

      INTO TABLE GT_ZEDT101

      WHERE ZORDNO IN S_ZORDNO

      AND ZDDATE IN S_ZDDATE

      AND ZMATNR IN S_ZMATNR

      AND ZIDCODE IN P_IDCODE.

   ENDCASE.

endform.




*&---------------------------------------------------------------------*

*&      Form  FILTER_RETURN_DATA

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*      -->P_P_TYPE  text

*----------------------------------------------------------------------*





*4. ###### ### ## #### ##### ### ### ##




form FILTER_RETURN_DATA  using  P_TYPE ZRET_FG.

  CASE P_TYPE.

    WHEN 'ORDER'.

      DELETE GT_ZEDT100 WHERE ZRET_FG = C_RETURN.

    WHEN 'DELIVERY'.

      DELETE GT_ZEDT101 WHERE ZFLAG = C_RETURN.

  ENDCASE.

endform.



form MOVE_TO_OUTPUT  using    LV_TYPE.

  CASE LV_TYPE.

    WHEN 'ORDER'.

      LOOP AT GT_ZEDT100 INTO GS_ZEDT100.

        MOVE-CORRESPONDING GS_ZEDT100 TO GS_OUT100.

        APPEND GS_OUT100 TO GT_OUT100.

        CLEAR GS_OUT100.

        ENDLOOP.

    WHEN 'DELIVERY'.

        LOOP AT GT_ZEDT101 INTO GS_ZEDT101.

          MOVE-CORRESPONDING GS_ZEDT101 TO GS_OUT101.

          APPEND GS_OUT101 TO GT_OUT101.

          CLEAR GS_OUT101.

        ENDLOOP.

  ENDCASE.



endform.

form DISPLAY  using    LV_TYPE.



  DATA: LV_LENGTH TYPE I.



  CASE LV_TYPE.

    WHEN 'ORDER'.

      PERFORM DISPLAY_HEAEDR USING LV_TYPE ZRET_FG.

      PERFORM CONVERT_DATA USING LV_TYPE ZRET_FG.

    WHEN 'DELIVERY'.

      PERFORM DISPLAY_HEAEDR USING LV_TYPE ZRET_FG.

      PERFORM CONVERT_DATA USING LV_TYPE ZRET_FG.

  ENDCASE.





  PERFORM GET_LINE_LENGTH USING LV_TYPE ZRET_FG

                          CHANGING LV_LENGTH.

  PERFORM DRAW_LINE USING LV_LENGTH.



endform.

form CONVERT_DATA  using    LV_TYPE

                            ZRET_FG.



  CASE LV_TYPE.

    WHEN 'ORDER'.

      LOOP AT GT_OUT100 INTO GS_OUT100.




*        #### ###




        PERFORM CONVERT_ZMTART CHANGING GS_OUT100-ZMTART GS_OUT100-ZMTART_TXT.

        PERFORM CONVERT_ZSALE_FG CHANGING GS_OUT100-ZSALE_FG GS_OUT100-ZSALE_FG_TXT.

        PERFORM CONVERT_ZRET_FG CHANGING GS_OUT100-ZRET_FG GS_OUT100-ZRET_FG_TXT.

        PERFORM DISPLAY_ORDER_LINE USING GS_OUT100 ZRET_FG.







        CLEAR : GS_OUT100.

      ENDLOOP.

    WHEN 'DELIVERY'.

      LOOP AT GT_OUT101 INTO GS_OUT101.

        PERFORM CONVERT_ZMTART CHANGING GS_OUT101-ZMTART GS_OUT101-ZMTART_TXT.

        PERFORM CONVERT_ZDFLAG CHANGING GS_OUT101-ZDFLAG GS_OUT101-ZDFLAG_TXT.

        PERFORM CONVERT_ZDGUBUN CHANGING GS_OUT101-ZDGUBUN GS_OUT101-ZDGUBUN_TXT.



        PERFORM DISPLAY_DELIVERY_LINE USING GS_OUT101 ZRET_FG.





        CLEAR : GS_OUT101.

      ENDLOOP.

  ENDCASE.



endform.

form CONVERT_ZMTART  changing P_ZMTART

                              P_ZMTART_TXT.




*001  ##

*002  ##

*003  ##

*004  ##

*005  ##

*006  ###




    CASE P_ZMTART.

      WHEN '001'.

        P_ZMTART_TXT = '##'.

      WHEN '002'.

        P_ZMTART_TXT = '##'.

      WHEN '003'.

        P_ZMTART_TXT = '##'.

      WHEN '004'.

        P_ZMTART_TXT = '##'.

      WHEN '005'.

        P_ZMTART_TXT = '##'.

      WHEN '006'.

        P_ZMTART_TXT = '###'.

    ENDCASE.

endform.

form CONVERT_ZSALE_FG  changing P_ZSALE_FG

                                P_ZSALE_FG_TXT.

  IF P_ZSALE_FG = 1.

    P_ZSALE_FG_TXT = '##'.

  ELSEIF P_ZSALE_FG = 2.

    P_ZSALE_FG_TXT = '##'.

  ENDIF.

endform.

form CONVERT_ZRET_FG  changing P_ZRET_FG

                               P_ZRET_FG_TXT.






*1  ####

*2  ####

*3  ####






  IF P_ZRET_FG = 1.

    P_ZRET_FG_TXT = '####'.

  ELSEIF P_ZRET_FG = 2.

    P_ZRET_FG_TXT = '####'.

  ELSEIF P_ZRET_FG = 3.

    P_ZRET_FG_TXT = '####'.

  ENDIF.

endform.

form CONVERT_ZDFLAG  changing P_ZDFLAG

                              P_ZDFLAG_TXT.




*1  ####

*2  ###

*3  ####




  CASE P_ZDFLAG.

    WHEN '1'.

      P_ZDFLAG_TXT = '####'.

    WHEN '2'.

      P_ZDFLAG_TXT = '###'.

    WHEN '3'.

      P_ZDFLAG_TXT = '####'.

  ENDCASE.






*         ZDGUBUN   type ZEDT05_101-ZDGUBUN,    "####

*        ZDGUBUN_TXT   type STRING,    "####




endform.

form CONVERT_ZDGUBUN  changing P_ZDGUBUN

                               P_ZDGUBUN_TXT.



  CASE P_ZDGUBUN.

    WHEN '1'.

      P_ZDGUBUN_TXT = '###'.

    WHEN '2'.

      P_ZDGUBUN_TXT = '###'.

    WHEN '3'.

      P_ZDGUBUN_TXT = '###'.

    WHEN '4'.

      P_ZDGUBUN_TXT = '###'.

    WHEN '5'.

      P_ZDGUBUN_TXT = '###'.

    WHEN '6'.

      P_ZDGUBUN_TXT = '###'.

    WHEN '7'.

      P_ZDGUBUN_TXT = '###'.

  ENDCASE.



endform.




*

*  " #### ### ###### ## ##

*" ZORDNO(####), ZIDCODE(ID), ZMATNR(####), ZMATNAME(###), ZMTART(####),

*" ZVOLUM(##), VRKME(##), ZNSAMT(####), ZSLAMT(####), ZDCAMT(####),

*" ZSALE_FG(##), ZJDATE(####), ( ZRET_FG(####), ZRDATE(####) )*



*       ## ## ### ##




form GET_LINE_LENGTH using P_TYPE TYPE C

                           P_ZRET_FG TYPE C

                  changing P_LENGTH TYPE I.



  CASE P_TYPE.

    WHEN 'ORDER'.

      IF P_ZRET_FG = 'X'.

        P_LENGTH = 175.  " ## ## ##

      ELSE.

        P_LENGTH = 150.  " ## ## ##

      ENDIF.



    WHEN 'DELIVERY'.

      IF P_ZRET_FG = 'X'.

        P_LENGTH = 142.  " ## ## ##

      ELSE.

        P_LENGTH = 130.  " ## ## ##

      ENDIF.

  ENDCASE.



endform.






*       #### # ###




form DRAW_LINE using P_LENGTH TYPE I.



  DATA: LV_LINE TYPE STRING,

        LV_DASH(1) TYPE C VALUE '-'.



  DO P_LENGTH TIMES.

    CONCATENATE LV_LINE LV_DASH INTO LV_LINE.

  ENDDO.



  WRITE: / LV_LINE.



endform.



form DISPLAY_HEAEDR using LV_TYPE

                        ZRET_FG.



  DATA: LV_LENGTH TYPE I.



  " #### # ## ##

  PERFORM GET_LINE_LENGTH USING LV_TYPE ZRET_FG

                          CHANGING LV_LENGTH.

  PERFORM DRAW_LINE USING LV_LENGTH.



  WRITE: / '|' NO-GAP,

             2  '####' NO-GAP,

             12 '|' NO-GAP,

             14 'ID' NO-GAP,

             24 '|' NO-GAP,

             26 '####' NO-GAP,

             36 '|' NO-GAP,

             38 '###' NO-GAP,

             48 '|' NO-GAP,

             50 '####' NO-GAP,

             60 '|' NO-GAP,

             62 '##' NO-GAP,

             68 '|' NO-GAP,

             70 '##' NO-GAP,

             76 '|' NO-GAP.



  CASE LV_TYPE.

    WHEN 'ORDER'.

      WRITE: 78 '####' NO-GAP,

             93 '|' NO-GAP,

             95 '####' NO-GAP,

             110 '|' NO-GAP,

             112 '####' NO-GAP,

             127 '|' NO-GAP,

             129 '##' NO-GAP,

             137 '|' NO-GAP,

             139 '####' NO-GAP,

             150 '|' NO-GAP.



      IF ZRET_FG = 'X'.

        WRITE: 152 '####' NO-GAP,

               162 '|' NO-GAP,

               164 '####' NO-GAP,

               175 '|' NO-GAP.

      ENDIF.



    WHEN 'DELIVERY'.

      WRITE: 78 '####' NO-GAP,

             93 '|' NO-GAP,

             95 '####' NO-GAP,

             105 '|' NO-GAP,

             107 '##' NO-GAP,

             117 '|' NO-GAP,

             119 '####' NO-GAP,

             130 '|' NO-GAP.



      IF ZRET_FG = 'X'.

        WRITE: 132 '####' NO-GAP,

               142 '|' NO-GAP.

      ENDIF.

  ENDCASE.



endform.



form DISPLAY_ORDER_LINE using P_OUT100 TYPE TY_SEL_OUTPUT

                              P_ZRET_FG.



  DATA: LV_ZNSAMT_STR(20) TYPE C,

        LV_ZSLAMT_STR(20) TYPE C,

        LV_ZDCAMT_STR(20) TYPE C,

        LV_LENGTH TYPE I.



  " ## ##

  WRITE P_OUT100-ZNSAMT TO LV_ZNSAMT_STR CURRENCY 'KRW' NO-SIGN DECIMALS 0.

  CONDENSE LV_ZNSAMT_STR NO-GAPS.



  WRITE P_OUT100-ZSLAMT TO LV_ZSLAMT_STR CURRENCY 'KRW' NO-SIGN DECIMALS 0.

  CONDENSE LV_ZSLAMT_STR NO-GAPS.



  WRITE P_OUT100-ZDCAMT TO LV_ZDCAMT_STR CURRENCY 'KRW' NO-SIGN DECIMALS 0.

  CONDENSE LV_ZDCAMT_STR NO-GAPS.



  " #### # ###

  PERFORM GET_LINE_LENGTH USING 'ORDER' P_ZRET_FG

                          CHANGING LV_LENGTH.

  PERFORM DRAW_LINE USING LV_LENGTH.



  " ## ## ##

  WRITE: / '|' NO-GAP,

           2  P_OUT100-ZORDNO NO-GAP,

           12 '|' NO-GAP,

           14 P_OUT100-ZIDCODE NO-GAP,

           24 '|' NO-GAP,

           26 P_OUT100-ZMATNR NO-GAP,

           36 '|' NO-GAP,

           38 P_OUT100-ZMATNAME NO-GAP,

           48 '|' NO-GAP,

           50 P_OUT100-ZMTART_TXT NO-GAP,

           60 '|' NO-GAP,

           62 P_OUT100-ZVOLUM NO-GAP,

           68 '|' NO-GAP,

           70 P_OUT100-VRKME NO-GAP,

           76 '|' NO-GAP.



  " #### ## ##

  WRITE: 78 LV_ZNSAMT_STR NO-GAP,

         93 '|' NO-GAP,

         95 LV_ZSLAMT_STR NO-GAP,

         110 '|' NO-GAP,

         112 LV_ZDCAMT_STR NO-GAP,

         127 '|' NO-GAP,

         129 P_OUT100-ZSALE_FG_TXT NO-GAP,

         137 '|' NO-GAP,

         139 P_OUT100-ZJDATE NO-GAP,

         150 '|' NO-GAP.



  " #### ##

  IF P_ZRET_FG = 'X'.

    IF P_OUT100-ZRET_FG IS NOT INITIAL.

      WRITE: 152 P_OUT100-ZRET_FG_TXT NO-GAP,

             162 '|' NO-GAP,

             164 P_OUT100-ZRDATE NO-GAP,

             175 '|' NO-GAP.

    ELSE.

      WRITE: 152 '' NO-GAP,

             162 '|' NO-GAP,

             164 '' NO-GAP,

             175 '|' NO-GAP.

    ENDIF.

  ENDIF.

endform.






*&---------------------------------------------------------------------*

*&      Form  DISPLAY_DELIVERY_LINE (##)

*&---------------------------------------------------------------------*




form DISPLAY_DELIVERY_LINE using P_OUT101 TYPE TY_DEL_OUTPUT

                                 P_ZRET_FG.



  DATA: LV_ZSLAMT_STR(20) TYPE C,

        LV_LENGTH TYPE I.



  " ## ##

  WRITE P_OUT101-ZSLAMT TO LV_ZSLAMT_STR CURRENCY 'KRW' NO-SIGN DECIMALS 0.

  CONDENSE LV_ZSLAMT_STR NO-GAPS.



  " #### # ###

  PERFORM GET_LINE_LENGTH USING 'DELIVERY' P_ZRET_FG

                          CHANGING LV_LENGTH.

  PERFORM DRAW_LINE USING LV_LENGTH.



  " ## ## ##

  WRITE: / '|' NO-GAP,

           2  P_OUT101-ZORDNO NO-GAP,

           12 '|' NO-GAP,

           14 P_OUT101-ZIDCODE NO-GAP,

           24 '|' NO-GAP,

           26 P_OUT101-ZMATNR NO-GAP,

           36 '|' NO-GAP,

           38 P_OUT101-ZMATNAME NO-GAP,

           48 '|' NO-GAP,

           50 P_OUT101-ZMTART_TXT NO-GAP,

           60 '|' NO-GAP,

           62 P_OUT101-ZVOLUM NO-GAP,

           68 '|' NO-GAP,

           70 P_OUT101-VRKME NO-GAP,

           76 '|' NO-GAP.



  " #### ## ##

  WRITE: 78 LV_ZSLAMT_STR NO-GAP,

         93 '|' NO-GAP,

         95 P_OUT101-ZDFLAG_TXT NO-GAP,

         105 '|' NO-GAP,

         107 P_OUT101-ZDGUBUN_TXT NO-GAP,

         117 '|' NO-GAP,

         119 P_OUT101-ZDDATE NO-GAP,

         130 '|' NO-GAP.



  " #### ##

  IF P_ZRET_FG = 'X'.

    IF P_OUT101-ZFLAG IS NOT INITIAL.

      WRITE: 132 P_OUT101-ZRDATE,

             142 '|' NO-GAP.

    ELSE.

      WRITE: 132 '' NO-GAP,

             142 '|' NO-GAP.

    ENDIF.

  ENDIF.

endform.