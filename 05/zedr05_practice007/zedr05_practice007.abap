
*&---------------------------------------------------------------------*

*& Report ZEDR05_PRACTICE007

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




report ZEDR05_PRACTICE007.




*&---------------------------------------------------------------------*

*& Report ZEDR05_PRACTICE006

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*



* TABLES ##




tables: ZEDT05_102,

        ZEDT05_103,

        ZEDT05_104,

        ZEDT05_105,

        ZEDT05_106.






* TYPES ##




" #### ### ###

types: begin of TY_EMP_INFO,

         ZPERNR    type ZEDT05_102-ZPERNR,    "####

         ZPNAME    type ZEDT05_103-ZPNAME,    "####

         ZDEPCODE  type ZEDT05_102-ZDEPCODE,  "####

         ZDEPNAME  type CHAR20,               "###

         ZDEPRANK  type ZEDT05_102-ZDEPRANK,  "####

         ZRANKNAME type CHAR20,               "###

         ZEDATE    type ZEDT05_102-ZEDATE,    "###

         ZQDATE    type ZEDT05_102-ZQDATE,    "###

         ZQFLAG    type ZEDT05_102-ZQFLAG,    "####(##/##)

         ZQFLAG_T  type CHAR20,    "####(##/##)

         ZGENDER   type ZEDT05_103-ZGENDER,   "##

         ZGENDER_T type CHAR20,   "##(##)

         ZADDRESS  type ZEDT05_103-ZADDRESS,   "##

         ZBANKCODE type ZEDT05_106-ZBANKCODE, "####

         ZBANKNAME type CHAR20,               "###

         ZACCOUNT  type ZEDT05_106-ZACCOUNT,   "####

       end of TY_EMP_INFO.



" #### ### ###

types: begin of TY_SALARY,

         ZPERNR   type ZEDT05_102-ZPERNR,    "####

         ZQDATE   type ZEDT05_102-ZQDATE,    "###

         ZQFLAG   type ZEDT05_102-ZQFLAG,    "####

         ZSALARY  type ZEDT05_106-ZSALARY,   "####

         ZPAY_AMT type ZEDT05_106-ZSALARY,    "###

         ZRANK    type ZEDT05_104-ZRANK,     "####

       end of TY_SALARY.



" #### ### ###

types: begin of TY_EVAL,

         ZPERNR    type ZEDT05_102-ZPERNR,    "####

         ZPNAME    type ZEDT05_103-ZPNAME,    "####

         ZDEPCODE  type ZEDT05_102-ZDEPCODE,  "####

         ZDEPNAME  type CHAR20,               "###

         ZDEPRANK  type ZEDT05_102-ZDEPRANK,  "####

         ZRANKNAME type CHAR20,               "###

         ZEDATE    type ZEDT05_102-ZEDATE,    "###

         ZQDATE    type ZEDT05_102-ZQDATE,    "###

         ZQFLAG    type ZEDT05_102-ZQFLAG,    "####(##/##)

         ZQFLAG_T  type CHAR20,    "####(##/##)

         ZSALARY   type ZEDT05_106-ZSALARY,   "####

         ZRANK     type ZEDT05_104-ZRANK,     "####

         ZMON      type CURR13_2,

         WAERS     type WAERS,

       end of TY_EVAL.






* CONSTANTS ##




constants: C_X        type C value 'X',

           C_MALE     type C value 'M',           "##

           C_FEMALE   type C value 'F',           "##

           C_MALE_T   type CHAR4 value '##',

           C_FEMALE_T type CHAR4 value '##',

           C_RANK_A   type C value 'A',           "#### A

           C_BONUS    type P decimals 2 value '50000.00',  "### 5##

           C_QUIT     type C value 'Y',           "##

           C_ACTIVE   type CHAR10 value '##',

           C_QUIT_T   type CHAR10 value '##',

           C_ZERO     type P decimals 2 value 0,

           C_TWELVE   type I value 12.            "12##






* ALV ### Internal Tables




data: GT_EMP_INFO type table of TY_EMP_INFO,  "#### ###

      GS_EMP_INFO type TY_EMP_INFO.



data: GT_SALARY type table of TY_SALARY,      "#### ###

      GS_SALARY type TY_SALARY.



data: GT_EVAL type table of TY_EVAL,          "#### ###

      GS_EVAL type TY_EVAL.






* ALV ## ##






data: GT_FCAT   type SLIS_T_FIELDCAT_ALV,     "Field Catalog

      GS_FCAT   type SLIS_FIELDCAT_ALV,

      GT_SORT   type SLIS_T_SORTINFO_ALV,     "Sort

      GS_SORT   type SLIS_SORTINFO_ALV,

      GS_LAYOUT type SLIS_LAYOUT_ALV. "Layout








* SELECTION SCREEN




selection-screen begin of block B1 with frame.



" ## #### - ####

select-options: S_PERNR for ZEDT05_102-ZPERNR modif id ALL.



" ##### ####

select-options: S_DATE for ZEDT05_102-DATAB modif id M1.

select-options: S_DEPT for ZEDT05_102-ZDEPCODE modif id M1.



" ####/##### ####

parameters: P_YEAR  type ZEDT05_104-ZYEAR modif id M2,

            P_MONTH type NUMC2 modif id M2.



selection-screen end of block B1.





selection-screen begin of block B2 with frame.

" ##### - 3## ##

parameters: P_RAD1 radiobutton group RB1 default 'X' user-command UC1,

            P_RAD2 radiobutton group RB1,

            P_RAD3 radiobutton group RB1.



selection-screen end of block B2.







selection-screen begin of block B3 with frame.



parameters: P_CHK1 as checkbox default 'X' modif id M1. "####



selection-screen end of block B3.




*----------------------------------------------------------------------*

* INITIALIZATION

*----------------------------------------------------------------------*




initialization.



  perform GET_LAST_OF_DAY.






*----------------------------------------------------------------------*

* AT SELECTION-SCREEN OUTPUT

*----------------------------------------------------------------------*




at selection-screen output.

  perform SET_SCREEN_CONTROL.






*----------------------------------------------------------------------*

* AT SELECTION-SCREEN

*----------------------------------------------------------------------*




at selection-screen.

  perform CHECK_INPUT_VALUE.






*----------------------------------------------------------------------*

* START-OF-SELECTION

*----------------------------------------------------------------------*




start-of-selection.

  perform MAIN_PROCESS.






*----------------------------------------------------------------------*

* END-OF-SELECTION

*----------------------------------------------------------------------*




  "END-OF-SELECTION.




*&---------------------------------------------------------------------*

*&      Form  GET_LAST_OF_DAY

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form GET_LAST_OF_DAY.



  " ####/#### ### ##

  P_YEAR  = SY-DATUM(4).      "####

  P_MONTH = SY-DATUM+4(2).    "###



  " #### ### ##

  S_DATE-SIGN   = 'I'.

  S_DATE-OPTION = 'BT'.

  S_DATE-LOW    = SY-DATUM(4) && '0101'.  "## 1# 1#



  call function 'RP_LAST_DAY_OF_MONTHS'

    exporting

      DAY_IN            = SY-DATUM

    importing

      LAST_DAY_OF_MONTH = S_DATE-HIGH

    exceptions

      DAY_IN_NO_DATE    = 1

      others            = 2.

  if SY-SUBRC <> 0.




*   message id SY-MSGID type SY-MSGTY number SY-MSGNO

*              with SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.




  endif.

  append S_DATE.

endform.




*&---------------------------------------------------------------------*

*&      Form  SET_SCREEN_CONTROL

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form SET_SCREEN_CONTROL .



  loop at screen.

    case SCREEN-GROUP1.

      when 'M1'.

        if P_RAD1 = C_X.

          SCREEN-ACTIVE = 1.

        else.

          SCREEN-ACTIVE = 0.

        endif.

      when 'M2'.

        if P_RAD2 = C_X or P_RAD3 = C_X.

          SCREEN-ACTIVE = 1.

        else.

          SCREEN-ACTIVE = 0.

        endif.

      when 'ALL'.

        SCREEN-ACTIVE = 1.

    endcase.

    modify screen.

  endloop.



endform.




*&---------------------------------------------------------------------*

*&      Form  CHECK_INPUT_VALUE

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form CHECK_INPUT_VALUE .



  if P_RAD1 = C_X.  " #### ##

    if S_DATE[] is initial.

      message '##### ######.' type 'E'.

      stop.

    endif.

  elseif P_RAD2 = C_X or P_RAD3 = C_X.  " ####

    if P_YEAR is initial.

      message '##### ######.' type 'E'.

      stop.

    endif.



    if P_MONTH is initial.

      message '#### ######.' type 'E'.

      stop.

    endif.



    " # ### ## (1~12)

    if P_MONTH < 1 or P_MONTH > 12.

      message '## 1~12 ### #### ###.' type 'E'.

      stop.

    endif.

  elseif P_RAD3 = C_X.  " ####

    if P_YEAR is initial.

      message '##### ######.' type 'E'.

      stop.

    endif.

  endif.

endform.






*&---------------------------------------------------------------------*

*&      Form  MAIN_PROCESS

*&---------------------------------------------------------------------*

*       ## ## ##

*----------------------------------------------------------------------*




form MAIN_PROCESS.

  " ### ### ## ## ##




*  4. SELECT### JOIN# ### ####, join# ## 4## #### ### ##




  if P_RAD1 = C_X.  " #### ##

    perform GET_EMPLOYEE_INFO. " ## ## select#

    perform DISPLAY_ALV_EMP_INFO. "## ## ALV ###

  elseif P_RAD2 = C_X.  " ####

    perform GET_SAL_INFO. " ## ## select#

  elseif P_RAD3 = C_X.  " ####

    perform GET_EVAL.

    perform DISPLAY_ALV_EVAL.

  endif.

endform.




*&---------------------------------------------------------------------*

*&      Form  GET_EMPLOYEE_INFO

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form GET_EMPLOYEE_INFO .

  ranges : R_Q_CON for ZEDT05_102-ZQFLAG.



  if P_CHK1 = C_X.

    R_Q_CON-SIGN = 'I'.

    R_Q_CON-OPTION = 'NE'.

    R_Q_CON-LOW = 'X'.

    append R_Q_CON.




*    DELETE

*      GT_EMP_INFO

*    WHERE

*      ZQDATE IS NOT INITIAL

*      AND ZQDATE <= S_DATE-HIGH.

*    IF GT_EMP_INFO[] IS INITIAL.

*      MESSAGE '## ### #### #### ####.' TYPE 'E'.

*      STOP.

*    ENDIF.




  endif.







  select

      A~ZPERNR,      B~ZPNAME,      A~ZDEPRANK,      A~ZDEPCODE,

      A~ZEDATE,      A~ZQDATE,      A~ZQFLAG,      B~ZGENDER,

      B~ZADDRESS,      C~ZBANKCODE,      C~ZACCOUNT

    from ZEDT05_102 as A

    left outer join ZEDT05_103 as B

      on A~ZPERNR = B~ZPERNR

    left outer join ZEDT05_106 as C

      on A~ZPERNR = C~ZPERNR

    where

      A~ZPERNR in @S_PERNR

    and

       A~ZEDATE <= @S_DATE-HIGH

    and

      A~ZQFLAG in @R_Q_CON

    into corresponding fields of table @GT_EMP_INFO.



  if GT_EMP_INFO[] is initial.

    message '## ### #### ##### ####.' type 'E'.

    stop.

  endif.









  " ### ## ##

  if GT_EMP_INFO[] is initial.

    message '## ### #### ##### ####.' type 'E'.

  endif.



  perform CONVERT_KOR changing GT_EMP_INFO.

endform.




*&---------------------------------------------------------------------*

*&      Form  CONVERT_KOR

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form CONVERT_KOR

  changing PT_DATA type any table.



  field-symbols: <FS_DATA> type ANY,

                 <FS_CODE> type ANY,

                 <FS_NAME> type ANY.



  loop at PT_DATA assigning <FS_DATA>.



    " ## ##

    assign component 'ZGENDER' of structure <FS_DATA> to <FS_CODE>.

    if SY-SUBRC = 0.

      assign component 'ZGENDER_T' of structure <FS_DATA> to <FS_NAME>.

      if SY-SUBRC = 0.

        case <FS_CODE>.

          when C_MALE.   <FS_NAME> = C_MALE_T.

          when C_FEMALE. <FS_NAME> = C_FEMALE_T.

        endcase.

      endif.

    endif.





    " ### ## ##

    assign component 'ZDEPCODE' of structure <FS_DATA> to <FS_CODE>.

    if SY-SUBRC = 0.

      assign component 'ZDEPNAME' of structure <FS_DATA> to <FS_NAME>.

      if SY-SUBRC = 0.

        case <FS_CODE>.

          when 'SS0001'. <FS_NAME> = '###'.

          when 'SS0002'. <FS_NAME> = '###'.

          when 'SS0003'. <FS_NAME> = '###'.

          when 'SS0004'. <FS_NAME> = '###'.

          when 'SS0005'. <FS_NAME> = '###'.

          when 'SS0006'. <FS_NAME> = '###'.

        endcase.

      endif.

    endif.



    " ### ## ##

    assign component 'ZDEPRANK' of structure <FS_DATA> to <FS_CODE>.

    if SY-SUBRC = 0.

      assign component 'ZRANKNAME' of structure <FS_DATA> to <FS_NAME>.

      if SY-SUBRC = 0.

        case <FS_CODE>.

          when 'A'. <FS_NAME> = '##'.

          when 'B'. <FS_NAME> = '##'.

          when 'C'. <FS_NAME> = '##'.

          when 'D'. <FS_NAME> = '##'.

          when 'E'. <FS_NAME> = '##'.

          when 'F'. <FS_NAME> = '##'.

          when 'G'. <FS_NAME> = '##'.

        endcase.

      endif.

    endif.





    " #### ## ##

    assign component 'ZQFLAG' of structure <FS_DATA> to <FS_CODE>.

    if SY-SUBRC = 0.

      assign component 'ZQFLAG_T' of structure <FS_DATA> to <FS_NAME>.

      if SY-SUBRC = 0.

        if <FS_CODE> ='X'.  " # CODE# ##!

          <FS_NAME> = C_QUIT_T.

        else.

          <FS_NAME> = C_ACTIVE.

        endif.

      endif.

    endif.



    " ### ## ##

    assign component 'ZBANKCODE' of structure <FS_DATA> to <FS_CODE>.

    if SY-SUBRC = 0.

      assign component 'ZBANKNAME' of structure <FS_DATA> to <FS_NAME>.

      if SY-SUBRC = 0.

        case <FS_CODE>.

          when '001'. <FS_NAME> = '####'.

          when '002'. <FS_NAME> = '####'.

          when '003'. <FS_NAME> = '####'.

          when '004'. <FS_NAME> = '####'.

          when '005'. <FS_NAME> = '###'.

        endcase.

      endif.

    endif.



  endloop.



endform.






*&---------------------------------------------------------------------*

*&      Form  SET_FIELDCAT_EMP_INFO

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*

*&      Form  GET_SAL_INFO




form GET_SAL_INFO.

  data: LV_LAST_DAY type DATUM,

        LV_MSG      type STRING,

        LV_DATE_IN  type DATUM.



  " ##

  select A~ZPERNR, A~ZQDATE, C~ZSALARY, B~ZRANK

    from ZEDT05_102 as A

    left join ZEDT05_104 as B

      on A~ZPERNR = B~ZPERNR

     and B~ZYEAR = @P_YEAR

    left join ZEDT05_106 as C

      on A~ZPERNR = C~ZPERNR

    where A~ZPERNR in @S_PERNR

    into corresponding fields of table @GT_SALARY.



  " ### ##

  check GT_SALARY[] is not initial.



  " ### # ##

  concatenate P_YEAR P_MONTH '01' into LV_DATE_IN.



  call function 'RP_LAST_DAY_OF_MONTHS'

    exporting

      DAY_IN            = LV_DATE_IN

    importing

      LAST_DAY_OF_MONTH = LV_LAST_DAY

    exceptions

      others            = 1.



  if SY-SUBRC <> 0.

    message '# ### #### ####.' type 'E'.

    return.

  endif.



  " ## ## ### (###, ## ## ##, ## 0 ##)

  delete GT_SALARY

    where ( ZQDATE is not initial and ZQDATE <= LV_LAST_DAY )

       or ZRANK is initial

       or ZSALARY = C_ZERO.



  " ### ## (#### #11)

  if GT_SALARY[] is initial.

    message '### ## #### ####.' type 'E'.

    return.

  endif.



  " ## ## ##

  perform PROCESS_SALARY changing LV_MSG.



  " ## ###

  if LV_MSG is initial.

    message '### #######.' type 'S'.

  else.

    message LV_MSG type 'E'.

  endif.



endform.






*&      Form  PROCESS_SALARY




form PROCESS_SALARY changing P_MSG type STRING.

  data: LT_105   type table of ZEDT05_105,

        LS_105   type ZEDT05_105,

        LS_MON   type CHAR10,

        LS_SAL   type TY_SALARY,

        LV_AMT   type P decimals 2,

        LV_BONUS type P decimals 2,

        LV_COUNT type I.



  field-symbols: <FS_105>     type ZEDT05_105,

                 <FS_105_MON> type ANY.



  " 1. 105 ### ## ##

  if GT_SALARY[] is not initial.

    select *

      from ZEDT05_105

      into table LT_105

      for all entries in GT_SALARY

      where ZPERNR = GT_SALARY-ZPERNR

        and ZYEAR = P_YEAR.

  endif.



  " 2. # ### ## ##

  loop at GT_SALARY into LS_SAL.



    " ## ## (##/12 + A## ###)

    LV_AMT = LS_SAL-ZSALARY * 100 / C_TWELVE.



    " A## ### ##

    if LS_SAL-ZRANK = C_RANK_A.

      LV_BONUS = C_BONUS.

    else.

      LV_BONUS = C_ZERO.

    endif.



    LV_AMT = ( LV_AMT + LV_BONUS ) / 100.



    " ## 0 ##

    if LV_AMT <= C_ZERO.

      continue.

    endif.



    " 3. ## ## ### ## ## ## ##

    read table LT_105 assigning <FS_105>

      with key ZPERNR = LS_SAL-ZPERNR

               ZYEAR = P_YEAR.



    if SY-SUBRC <> 0.

      " ## ### ##

      clear LS_105.

      LS_105-ZPERNR = LS_SAL-ZPERNR.

      LS_105-ZYEAR = P_YEAR.

      append LS_105 to LT_105.



      " ## ### #### ASSIGN

      read table LT_105 assigning <FS_105>

        with key ZPERNR = LS_SAL-ZPERNR

                 ZYEAR = P_YEAR.



      if SY-SUBRC <> 0.

        rollback work.

        P_MSG = '## ##: ### ## ##'.

        exit.

      endif.

    endif.



    if <FS_105> is not assigned.

      rollback work.

      P_MSG = '## ##: ### ## ##'.

      exit.

    endif.



    CONCATENATE 'ZMON' P_MONTH INTO LS_MON.

    " 4. CASE #### ## ### ## ##

    assign component LS_MON of structure <FS_105> to <FS_105_MON>.





    if SY-SUBRC <> 0.

      " ### # ##

      rollback work.

      concatenate '### # ##:' P_MONTH into P_MSG separated by SPACE.

      exit.

    endif.



    <FS_105_MON> = LV_AMT.

    " ## ## ####

    <FS_105>-AEDATE = SY-DATUM.

    <FS_105>-AENAME = SY-UNAME.

    <FS_105>-AEZEIT = SY-UZEIT.



    " ## ## ####

    <FS_105>-AEDATE = SY-DATUM.

    <FS_105>-AENAME = SY-UNAME.

    <FS_105>-AEZEIT = SY-UZEIT.



  endloop.



  " 5. ## ##### ##

  if P_MSG is initial.

    LV_COUNT = 0.



    loop at LT_105 into LS_105.

      if LS_105-ZPERNR is initial or LS_105-ZYEAR is initial.

        rollback work.

        P_MSG = '#### ##: ## ## ##'.

        exit.

      endif.



      " ## MODIFY

      modify ZEDT05_105 from LS_105.



      " #### ### ## ROLLBACK # ##

      if SY-SUBRC <> 0.

        rollback work.

        concatenate '#### ##: ####' LS_105-ZPERNR

                    into P_MSG separated by SPACE.

        exit.  " # 1#### #### ## ##

      endif.



      LV_COUNT = LV_COUNT + 1.

    endloop.



    " ## ### #### COMMIT

    if P_MSG is initial.

      commit work and wait.

    endif.

  endif.



endform.




*&---------------------------------------------------------------------*

*&      Form  GET_EVAL

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*







*13-3. ####

*1)ALV# ##

*3)### ##### ##

*4)###### ##

*5)#### ### ##### ##  ##### ### ## ##

*6)##### ##(#)# ##

*7)#### ####### ##### ## ## ## ## (1####, 2####..)

*8)## ##### SUM## ####






" #### ### ###




*TYPES: BEGIN OF TY_EVAL,

*         ZPERNR    TYPE ZEDT05_102-ZPERNR,    "####

*         ZPNAME    TYPE ZEDT05_103-ZPNAME,    "####

*         ZDEPCODE  TYPE ZEDT05_102-ZDEPCODE,  "####

*         ZDEPNAME  TYPE CHAR20,               "###

*         ZDEPRANK  TYPE ZEDT05_102-ZDEPRANK,  "####

*         ZEDATE    TYPE ZEDT05_102-ZEDATE,    "###

*         ZQDATE    TYPE ZEDT05_102-ZQDATE,    "###

*         ZQFLAG    TYPE ZEDT05_102-ZQFLAG,    "####(##/##)

*         ZSALARY   TYPE ZEDT05_106-ZSALARY,   "####

*         ZRANK     TYPE ZEDT05_104-ZRANK,     "####

*         ZMON      TYPE CURR13_2,

*       END OF TY_EVAL.




form GET_EVAL.



  data: LT_105       type table of ZEDT05_105,

        LS_105       type ZEDT05_105,

        LV_FIELDNAME type STRING,

        LV_LAST_DAY  type DATUM,

        LV_DATE_IN   type DATUM.



  field-symbols : <FS_EVAL>     type TY_EVAL,

                  <FS_EVAL_MON> type ANY.



  " #### ### # ##

  concatenate P_YEAR P_MONTH '01' into LV_DATE_IN.



  call function 'RP_LAST_DAY_OF_MONTHS'

    exporting

      DAY_IN            = LV_DATE_IN

    importing

      LAST_DAY_OF_MONTH = LV_LAST_DAY

    exceptions

      others            = 1.



  if SY-SUBRC <> 0.

    message '# ### #### ####.' type 'E'.

    return.

  endif.



  " #### ## (### ### ##!)

  select

     A~ZPERNR,B~ZPNAME,A~ZDEPCODE,A~ZDEPRANK,

     A~ZQDATE,A~ZEDATE,A~ZQFLAG,C~ZSALARY,D~ZRANK

  from

     ZEDT05_102 as A

  left outer join ZEDT05_103 as B on A~ZPERNR = B~ZPERNR

  left outer join ZEDT05_106 as C on A~ZPERNR = C~ZPERNR

  left outer join ZEDT05_104 as D on A~ZPERNR = D~ZPERNR

  where A~ZPERNR in @S_PERNR and D~ZYEAR = @P_YEAR and A~ZEDATE <= @LV_LAST_DAY      " # ### ### ##!

  into corresponding fields of table @GT_EVAL.



  " ### ##

  if GT_EVAL[] is initial.

    message '## ### #### ## #### ####.' type 'E'.

    return.

  endif.



  " ## ## ### ##

  select *

  from ZEDT05_105

  into table LT_105

  for all entries in GT_EVAL

  where ZPERNR = GT_EVAL-ZPERNR

  and ZYEAR = P_YEAR.



  concatenate 'ZMON' P_MONTH into LV_FIELDNAME.

  loop at GT_EVAL ASSIGNING <FS_EVAL>.



    read table LT_105 into LS_105

      with key ZPERNR = <FS_EVAL>-ZPERNR

               ZYEAR = P_YEAR.



    if SY-SUBRC = 0.





      assign component LV_FIELDNAME of structure LS_105 to <FS_EVAL_MON>.



      if SY-SUBRC = 0.

        <FS_EVAL>-ZMON = <FS_EVAL_MON>.

        <FS_EVAL>-WAERS = 'KRW'.  " ## ## ##



      endif.

    endif.

  endloop.



  " ### 0# ## ## (#### 13-3-2)

  delete GT_EVAL where ZMON = C_ZERO or ZMON is initial.



  " ## ### ##

  if GT_EVAL[] is initial.

    message '## ### #### ## #### ####.' type 'E'.

    return.

  endif.



  " ## ##

  perform CONVERT_KOR changing GT_EVAL.



endform.



form DISPLAY_ALV_EMP_INFO.



  data: LT_FCAT   type SLIS_T_FIELDCAT_ALV,

        LS_LAYOUT type SLIS_LAYOUT_ALV,

        LT_SORT   type SLIS_T_SORTINFO_ALV.



  " Field Catalog ##

  perform SET_FIELDCAT_EMP_INFO changing LT_FCAT.



  " Layout ##

  perform SET_COMMON_LAYOUT changing LS_LAYOUT.



  " Sort ##

  perform SET_SORT_EMP_INFO changing LT_SORT.



  " ALV ##

  perform DISPLAY_ALV

    using    LT_FCAT

             LS_LAYOUT

             LT_SORT

    changing GT_EMP_INFO.



endform.

form SET_FIELDCAT_EMP_INFO

  changing PT_FCAT type SLIS_T_FIELDCAT_ALV.



  clear PT_FCAT.



  " ####

  perform ADD_FIELDCAT using 'ZPERNR' '####' '10' '' '' changing PT_FCAT.

  " ####

  perform ADD_FIELDCAT using 'ZPNAME' '####' '15' '' '' changing PT_FCAT.

  " ####

  perform ADD_FIELDCAT using 'ZDEPCODE' '####' '10' '' '' changing PT_FCAT.

  " ###

  perform ADD_FIELDCAT using 'ZDEPNAME' '###' '20' '' '' changing PT_FCAT.

  " ###

  perform ADD_FIELDCAT using 'ZRANKNAME' '###' '15' '' '' changing PT_FCAT.

  " ###

  perform ADD_FIELDCAT using 'ZEDATE' '###' '10' '' '' changing PT_FCAT.

  " ####

  perform ADD_FIELDCAT using 'ZQFLAG_T' '####' '10' '' '' changing PT_FCAT.

  " ##

  perform ADD_FIELDCAT using 'ZGENDER_T' '##' '10' '' '' changing PT_FCAT.

  " ##

  perform ADD_FIELDCAT using 'ZADDRESS' '##' '30' '' '' changing PT_FCAT.

  " ####

  perform ADD_FIELDCAT using 'ZBANKCODE' '####' '10' '' '' changing PT_FCAT.

  " ###

  perform ADD_FIELDCAT using 'ZBANKNAME' '###' '20' '' '' changing PT_FCAT.

  " ####

  perform ADD_FIELDCAT using 'ZACCOUNT' '####' '20' '' '' changing PT_FCAT.



endform.



form SET_SORT_EMP_INFO

  changing PT_SORT type SLIS_T_SORTINFO_ALV.



  data: LS_SORT type SLIS_SORTINFO_ALV.



  clear PT_SORT.



  LS_SORT-FIELDNAME = 'ZPERNR'.

  LS_SORT-UP = 'X'.

  append LS_SORT to PT_SORT.



endform.



form DISPLAY_ALV_EVAL.



  data: LT_FCAT   type SLIS_T_FIELDCAT_ALV,

        LS_LAYOUT type SLIS_LAYOUT_ALV,

        LT_SORT   type SLIS_T_SORTINFO_ALV.



  " Field Catalog ##

  perform SET_FIELDCAT_EVAL changing LT_FCAT.



  " Layout ##

  perform SET_COMMON_LAYOUT changing LS_LAYOUT.



  " Sort ##

  perform SET_SORT_EVAL changing LT_SORT.



  " ALV ##

  perform DISPLAY_ALV

    using    LT_FCAT

             LS_LAYOUT

             LT_SORT

    changing GT_EVAL.



endform.






*&---------------------------------------------------------------------*

*&      Form  SET_FIELDCAT_EVAL

*&---------------------------------------------------------------------*




form SET_FIELDCAT_EVAL



  changing PT_FCAT type SLIS_T_FIELDCAT_ALV.



  clear PT_FCAT.



  data : LV_MONTH type CHAR50.

  concatenate P_MONTH '###' into LV_MONTH.



  perform ADD_FIELDCAT using 'ZPERNR' '####' '10' '' '' changing PT_FCAT.

  perform ADD_FIELDCAT using 'ZPNAME' '####' '20' '' '' changing PT_FCAT.

  perform ADD_FIELDCAT using 'ZDEPCODE' '####' '10' '' '' changing PT_FCAT.

  perform ADD_FIELDCAT using 'ZDEPNAME' '###' '20' '' '' changing PT_FCAT.

  perform ADD_FIELDCAT using 'ZRANKNAME' '###' '10' '' '' changing PT_FCAT.

  perform ADD_FIELDCAT using 'ZEDATE' '###' '10' '' '' changing PT_FCAT.

  perform ADD_FIELDCAT using 'ZSALARY' '####' '20' 'X' 'X' changing PT_FCAT.  " ##O, ##O

  perform ADD_FIELDCAT using 'ZRANK' '####' '20' '' '' changing PT_FCAT.

  perform ADD_FIELDCAT using 'ZMON' LV_MONTH '15' 'X' 'X' changing PT_FCAT.  " ##O, ##O



endform.






*&---------------------------------------------------------------------*

*&      Form  SET_SORT_EVAL

*&---------------------------------------------------------------------*




form SET_SORT_EVAL

  changing PT_SORT type SLIS_T_SORTINFO_ALV.



  data: LS_SORT type SLIS_SORTINFO_ALV.



  clear PT_SORT.



  LS_SORT-FIELDNAME = 'ZPERNR'.

  LS_SORT-UP = 'X'.

  append LS_SORT to PT_SORT.



endform.



form ADD_FIELDCAT using P_FIELDNAME type CHAR30

                        P_TEXT type CHAR50

                        P_OUTPUTLEN type CHAR10

                        P_DO_SUM type C

                        P_CURRENCY type C

                changing PT_FCAT   type SLIS_T_FIELDCAT_ALV.



  data LS_FCAT type SLIS_FIELDCAT_ALV.



  clear LS_FCAT.

  LS_FCAT-FIELDNAME = P_FIELDNAME.

  LS_FCAT-SELTEXT_M = P_TEXT.

  LS_FCAT-OUTPUTLEN = P_OUTPUTLEN.



  " ## ##

  if P_DO_SUM = 'X'.

    LS_FCAT-DO_SUM = 'X'.

  endif.



  " ## ##

  if P_CURRENCY = 'X'.

    LS_FCAT-CFIELDNAME = 'WAERS'.

    LS_FCAT-CTABNAME = ''.

  endif.



  append LS_FCAT to PT_FCAT.

endform.





form SET_COMMON_LAYOUT

  changing PS_LAYOUT type SLIS_LAYOUT_ALV.



  PS_LAYOUT-ZEBRA = 'X'.                " ###

  PS_LAYOUT-COLWIDTH_OPTIMIZE = 'X'.   " ## ###



endform.








*&---------------------------------------------------------------------*

*&      Form  DISPLAY_ALV_EMP_INFO

*&---------------------------------------------------------------------*

*       text

*----------------------------------------------------------------------*

*  -->  p1        text

*  <--  p2        text

*----------------------------------------------------------------------*




form DISPLAY_ALV

  using PT_FCAT type SLIS_T_FIELDCAT_ALV

        PS_LAYOUT type SLIS_LAYOUT_ALV

        PT_SORT   type SLIS_T_SORTINFO_ALV

  changing PT_DATA type standard table .



  GS_LAYOUT-ZEBRA = 'X'.

  GS_LAYOUT-COLWIDTH_OPTIMIZE = 'X'.



  call function 'REUSE_ALV_GRID_DISPLAY'

    exporting

      I_CALLBACK_PROGRAM = SY-REPID

      IS_LAYOUT          = PS_LAYOUT

      IT_FIELDCAT        = PT_FCAT

      IT_SORT            = PT_SORT

    tables

      T_OUTTAB           = PT_DATA

    exceptions

      PROGRAM_ERROR      = 1

      others             = 2.



  if SY-SUBRC <> 0.

    message 'ALV ## # ### ######.' type 'E'.

  endif.

endform.








*Messages

*----------------------------------------------------------

*

* Message class: Hard coded

*   ##### ######.