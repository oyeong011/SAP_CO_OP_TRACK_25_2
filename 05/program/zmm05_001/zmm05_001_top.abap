
*&---------------------------------------------------------------------*

*&  Include           ZMM05_001_TOP

*&---------------------------------------------------------------------*






TABLES : ZLFA1_05, ZLFB1_05, ZLFM1_05.



CONSTANTS: C_X           TYPE C VALUE 'X'.

DATA : OK_CODE TYPE SY-UCOMM.

" 1. Key Fields

DATA : GV_LIFNR LIKE ZLFA1_05-LIFNR,  " ### ## (## # ###)

       GV_BUKRS LIKE ZLFB1_05-BUKRS,  " ## ##

       GV_KTOKK LIKE ZLFA1_05-KTOKK,  " ## ## (## ### ##)

" 2. LFA1 (## ###)

       GV_NAME1 LIKE ZLFA1_05-NAME1,  " ####

       GV_LAND1 LIKE ZLFA1_05-LAND1,  " ##

       GV_STCD1 LIKE ZLFA1_05-STCD1,  " #### (3000 ###)

       GV_STCD2 LIKE ZLFA1_05-STCD2,  " #####

       GV_STRAS LIKE ZLFA1_05-STRAS,  " ##

" 3. LFB1 (#### ###)

       GV_LOEVM LIKE ZLFB1_05-LOEVM,  " #####

       GV_AKONT LIKE ZLFB1_05-AKONT,  " ####

       GV_ZTERM LIKE ZLFB1_05-ZTERM,  " ####

" 4. LFM1 (## ###)

       GV_EKORG LIKE ZLFM1_05-EKORG,  " ####

       GV_EKGRP LIKE ZLFM1_05-EKGRP,  " ####

       GV_WAERS LIKE ZLFM1_05-WAERS,  " ######

       GV_MWSKZ LIKE ZLFM1_05-MWSKZ.  " ####





DATA : BEGIN OF GS_ALV,

      LIFNR LIKE ZLFA1_05-LIFNR,  "#####

      BUKRS LIKE ZLFB1_05-BUKRS, "####

      NAME1 LIKE ZLFA1_05-NAME1,  "####

      LAND1 LIKE ZLFA1_05-LAND1,   "##

      KTOKK LIKE ZLFA1_05-KTOKK,"#####

      STCD1 LIKE ZLFA1_05-STCD1,    "#### / ###### 3000# ##

      STCD2 LIKE ZLFA1_05-STCD2,    "#####

      STRAS LIKE ZLFA1_05-STRAS,    "##



      AKONT LIKE ZLFB1_05-AKONT,  "##

      ZTERM LIKE ZLFB1_05-ZTERM,  "####

      EKORG LIKE ZLFM1_05-EKORG,  "####

      EKGRP LIKE ZLFM1_05-EKGRP,  "####

      WAERS LIKE ZLFM1_05-WAERS,  "######

      MWSKZ LIKE ZLFM1_05-MWSKZ,"####

  END OF GS_ALV.

  DATA : GT_ALV LIKE TABLE OF GS_ALV.