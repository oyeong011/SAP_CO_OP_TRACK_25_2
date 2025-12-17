
*&---------------------------------------------------------------------*

*& Report ZEDR16_PRACTICE008

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR16_PRACTICE008 MESSAGE-ID ZMED16.






*#### ## ##

*0. ##### ZEDTXX_100, ##### ZEDTXX_101##### #### (##..####)

*1. R1##### R2##### ## CALL SCREEN 100, 200## ## ##### ALV# ####.

*2. ALV# DOCKING CONTAINER# #### ####

*3. PERFORM## ### ####

*4. RANGE### ## 1# ## ####

*5. INITIALIZATION# START-OF-SELECTION# ### ####

*6. ALV### ### #### ### ####

*7. ## ### #### ### ## ### #### #### (### ### ### ## ## ##)

*8. ##### / ##### / ###### ### ###### # 3## ### PERFORM# #### ##

*9. CONSTANTS# ## 1# ## ####

*10. INCLUDE TOP, SCR, F01, PBO, PAI### ##

*11. CREATE OBJECT, SORT, VARIANT, LAYOUT, CALL ALV# 100####,

*200#### #### ### ### #### CALL SCREEN 100, CALL SCREEN 200# ### # ### ##

*(#, ###### ## ### #### ###100,200# ###! & CALL ALV## ## ## ####

*# ### #### ###100,200###! ####### SCREEN100, SCREEN200# ## ##)

*

*#### ## ##

*0. ### #### R1 ######, R2 ######### ####

*1. ### ##

* R1 : ##### ##### ## , ##### ##

* R2 : ##### X##### ##, # # ##

*2. ##### ## ## ### ### ##### ## ## #### #### ## ### ## ### ####

*3. #### #### ## ###, ####, ## ### , ###### ### ##

*4. ## ### ### ## ##(CFIELD,QFIELD## ##)## ## SUM## ####

*5. ALV_SORT## ##ID## ###### ####, ID### ## SUM## ####

*6. ##### ### ### #### VARIANT# #### ALV# ####

*7. ZEDT00_101-ZFLAG# X### ###### ## ## # ### ####

*8. ###### #### # # ### # # ##, ### ######

*9. ###### #### ### ### ####(R1), ####(R1, R2), ####(R2) ## ####

*(### # ## ### ## ### ### ##)






include
ZEDR16_PRACTICE008_TOP
.

include
ZEDR16_PRACTICE008_SCR
.

include
ZEDR16_PRACTICE008_F01
.

include
ZEDR16_PRACTICE008_PBO
.

include
ZEDR16_PRACTICE008_PAI
.



INITIALIZATION.

  PERFORM SET_DEFAULT_DATE.



AT SELECTION-SCREEN OUTPUT.

  PERFORM SET_SELECTION_SCREEN.



START-OF-SELECTION.

  PERFORM CHECK_INITIAL_INPUT.

  PERFORM SET_RANGE_TABLE.



  IF P_R1 = 'X'.

    PERFORM GET_ORDER.

    PERFORM MODIFY_ORDER.

    IF GT_ORDER[] IS NOT INITIAL.

      CALL SCREEN 100.

    ELSE.

      MESSAGE I001.

      EXIT.

    ENDIF.

  ELSEIF P_R2 = 'X'.

    PERFORM GET_DELIVER.

    PERFORM MODIFY_DELIVER.

    IF GT_DELIVER[] IS NOT INITIAL.

      CALL SCREEN 200.

    ELSE.

      MESSAGE I001.

      EXIT.

    ENDIF.

  ENDIF.






*GUI Texts

*----------------------------------------------------------

* T100 --> ######

* T200 --> ######

* T100 --> ######

* T200 --> ######