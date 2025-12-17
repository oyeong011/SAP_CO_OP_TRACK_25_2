
*&---------------------------------------------------------------------*

*&  Include           ZMMR25_001_TOP

*&---------------------------------------------------------------------*




TYPE-POOLS: ICON.



TABLES : ZEDT25_LFA1, ZEDT25_LFB1, ZEDT25_LFM1.



CONSTANTS: C_X TYPE C VALUE 'X'.



DATA : OK_CODE TYPE SY-UCOMM.



" Key Fields

DATA : GV_LIFNR LIKE ZEDT25_LFA1-LIFNR,  " #### (## #)

       GV_BUKRS LIKE ZEDT25_LFB1-BUKRS,  " ####

       GV_KTOKK LIKE ZEDT25_LFA1-KTOKK,  " #### (## ##)



" LFA1 (####)

       GV_NAME1 LIKE ZEDT25_LFA1-NAME1,  " ##

       GV_LAND1 LIKE ZEDT25_LFA1-LAND1,  " ##

       GV_STCD1 LIKE ZEDT25_LFA1-STCD1,  " ####1 (3000 ####)

       GV_STCD2 LIKE ZEDT25_LFA1-STCD2,  " ####2

       GV_STRAS LIKE ZEDT25_LFA1-STRAS,  " ##



" LFB1 (#### ###)

       GV_LOEVM LIKE ZEDT25_LFB1-LOEVM,  " #####

       GV_AKONT LIKE ZEDT25_LFB1-AKONT,  " ####

       GV_ZTERM LIKE ZEDT25_LFB1-ZTERM,  " ####



" LFM1 (#### ###)

       GV_EKORG LIKE ZEDT25_LFM1-EKORG,  " ####

       GV_EKGRP LIKE ZEDT25_LFM1-EKGRP,  " ####

       GV_WAERS LIKE ZEDT25_LFM1-WAERS,  " ##

       GV_MWSKZ LIKE ZEDT25_LFM1-MWSKZ.  " ####



" ALV# ### # ###

DATA : BEGIN OF GS_ALV,

         LIFNR LIKE ZEDT25_LFA1-LIFNR,  " ####

         BUKRS LIKE ZEDT25_LFB1-BUKRS,  " ####

         KTOKK LIKE ZEDT25_LFA1-KTOKK,  " ####

         NAME1 LIKE ZEDT25_LFA1-NAME1,  " ##

         LAND1 LIKE ZEDT25_LFA1-LAND1,  " ##

         STCD1 LIKE ZEDT25_LFA1-STCD1,  " ####1

         STCD2 LIKE ZEDT25_LFA1-STCD2,  " ####2

         STRAS LIKE ZEDT25_LFA1-STRAS,  " ##

         AKONT LIKE ZEDT25_LFB1-AKONT,  " ####

         ZTERM LIKE ZEDT25_LFB1-ZTERM,  " ####

         EKORG LIKE ZEDT25_LFM1-EKORG,  " ####

         EKGRP LIKE ZEDT25_LFM1-EKGRP,  " ####

         WAERS LIKE ZEDT25_LFM1-WAERS,  " ##

         MWSKZ LIKE ZEDT25_LFM1-MWSKZ,  " ####

       END OF GS_ALV.

DATA : GT_ALV LIKE TABLE OF GS_ALV.



" ALV ## ####

DATA : GO_CONTAINER TYPE REF TO CL_GUI_CUSTOM_CONTAINER,

       GO_ALV       TYPE REF TO CL_GUI_ALV_GRID,

       GO_HANDLER   TYPE REF TO LCL_EVENT_HANDLER.



" ALV ###### # ####

DATA : GT_FIELDCAT TYPE LVC_T_FCAT,

       GS_FIELDCAT TYPE LVC_S_FCAT,

       GS_LAYOUT   TYPE LVC_S_LAYO,

       GS_STBL     TYPE LVC_S_STBL.