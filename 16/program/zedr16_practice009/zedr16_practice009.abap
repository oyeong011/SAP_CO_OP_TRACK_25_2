
*&---------------------------------------------------------------------*

*& Report ZEDR16_PRACTICE009

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR16_PRACTICE009 MESSAGE-ID ZMED16.






*1. ##### ## ### ####.

*##### #### # #### ####(DATBI)# ###(DATAB)# ### ##### ##.

*#### ## # ### ### ##### ### ## ### ##.

*#### ## # ### #### # #### ## ### ##### ##.

*1) ##### ## ####, ###### ### #### - 1####

*2) ##### ## #### #### - 2####

*3) ##### ## #### #### - 3####

*

*2. ALV# DOCKING CONTAINER# SPLITTER# #### ####

*3. FOR ALL ENTRIES### ### ######## ## #### ### ###### ##### ####

*4. RANGE### ## 1# ## ####

*5. INITIALIZATION# START-OF-SELECTION# ### ####

*6. ALV### ### #### ### ####

*7. ## ### #### ### ## ### #### #### (### ### ### ## ## ##)

*8. PERFORM # USING# CHANGING# ## 1# ## ####, PERFORM# ### #####

*9. CONSTANTS# ## 1# ## ####

*10. INCLUDE TOP, SCR, F01, PBO, PAI### ##

*11. SLPITTER### ### ### ## 3## ### #### ## # # ### ##

*2#### 	3####

*1####

*#, ### SORT ## : ##### ####

*12. ### ### 1# ##### #### #### ##, ### ##,  #### #### ##

*13. ##### ### ## ## ### ### ### ## ### ##

*14. #### #### ###, ###, ##, ###### ### ## ### ##.

*15. ##### 001~010 ### ##### KRW# #### ## ###### ##### ## ## ####, ###### # CFIELD#### ##

*16. ##### ## SUM# ##

*17. ##### ### ### ##

*18. ##### SUM## # ## ## ### ##






include
ZEDR16_PRACTICE009_TOP
.

include
ZEDR16_PRACTICE009_SCR
.

include
ZEDR16_PRACTICE009_F01
.

include
ZEDR16_PRACTICE009_PBO
.

include
ZEDR16_PRACTICE009_PAI
.



INITIALIZATION.

  PERFORM SET_DEFAULT_DATE.



START-OF-SELECTION. " EMP, EVAL, CONTRACT

  PERFORM CHECK_INITIAL_INPUT.

  PERFORM SET_RANGE_TABLE.



  " 1) ##### ## ####, ###### ### #### - 1####

  PERFORM GET_EMP.

  PERFORM MODIFY_EMP.



  " 2) ##### ## #### #### - 2####

  PERFORM GET_EVAL.

  PERFORM MODIFY_EVAL.



  " 3) ##### ## #### #### - 3####

  PERFORM GET_CONTRACT.

  PERFORM MODIFY_CONTRACT.



  IF GT_EMP[] IS NOT INITIAL AND GT_EVAL[] IS NOT INITIAL AND GT_CONTRACT[] IS NOT INITIAL.

    CALL SCREEN 100.

  ELSE.

    MESSAGE I001.

    EXIT.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> ## ## ###

* T100 --> ## ## ###