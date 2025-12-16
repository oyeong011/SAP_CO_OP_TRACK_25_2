
*&---------------------------------------------------------------------*

*& Report ZDOCKING_CONTAINER21

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZDOCKING_CONTAINER21 MESSAGE-ID ZMED07.

"CLASS ALV & FUNCTION ALV ### ### class alv

"#### ### # #### ### method ### ### #### ## ### #### ##

"### ### ## --> #### ## ### method# ## ## CL_GUI_ALV_GRID##  ### ## #### #### CALL_

"METHOD ##



"1. ## ##

"DATA : ## # TYPE REF TO CLASS -> ## ## ## ##

"CREATE OBJECT ## # --> ## ##

"2. CONTAINER ## --> ### ### ###

"1.CUSTOM CONTAINER ->###, #### #### #### #####

"2.DOCKING CONTAINER ->#### ## ### ## ####### ## ##

"3.SPLITTER CONTAINER -> #### ### ####### ### ### ## container + grid



"SET_TABLE_FOR_FIRST_DISPLAY Method ##









""# ##### CUSTOM CONTAINER # ## ####

"#### ##### #### ### #### ###

"CUSTOM CONTROL AREA -> CONTAINER -> GRID -> ALV ##



 "CALL SCREEN --> OKCODE --> CUSTOM CONTROL --> LAYOUT --> #### GC_CUSTOM_TYPE --> CREATE OBJECT

 "-->GC_GRID_TYPEREF2_CLV_GRID --> GC_CUSTOM## ## --> Create Object ### --> callm method# ### #

 "-->



 "APPEND ## ## --> APPLICATION TOOLBAR## -> 'APND' ## # ICON_ADD_ROW # ICON ###### ## ###

 "## ### ###







include
ZDOCKING_CONTAINER21_TOP
.

include
ZDOCKING_CONTAINER21_SCR
.

include
ZDOCKING_CONTAINER21_F01
.

include
ZDOCKING_CONTAINER21_001
.

include
ZCUSTOM_CONTAINER21_I01
.



INITIALIZATION.

  PERFORM SET_INIT.



AT SELECTION-SCREEN OUTPUT.

  PERFORM SET_SCREEN.



  START-OF-SELECTION.

    PERFORM GET_DATA.

    PERFORM MODIFY_DATA.



 IF GT_STUDENT IS NOT INITIAL.

   CALL SCREEN 100.

   ELSE.

      MESSAGE I000.

      EXIT.

      ENDIF.



include
zdocking_container21_modifyf01
.






*GUI Texts

*----------------------------------------------------------

* T100 --> 100