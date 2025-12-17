
*&---------------------------------------------------------------------*

*& Report ZEDR09_018

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR09_018.






* =====================================================================

* DB TABLE ## - SELECT#

* =====================================================================





* =====================================================================

* 1. SELECT# ## ##, ##/###



*  SELECT <##1> <##2> ... (## *)

*    FROM <###### ###>

*    INTO <##/###/### ###>

*    WHERE <##>.

* => ##, FROM ### ### # ##





* # # ##, ## WHERE #### #### #### ### #### ###, ### ## ##

*  SELECT SINGLE <##>

*    FROM <###>

*    INTO <### ## ##>

*    WHERE <##>.



* ## # ##

*  SELECT <##>

*    FROM <###>

*    INTO TABLE <### ###>

*    WHERE <##>.



* =====================================================================



* =====================================================================

* 2. FROM # : ### ## (Alias) ## ##



*  SELECT A~CARRNAME

*    FROM SCARR AS A

*    WHERE A~CARRID = 'AA'.

* -> AS A# SCARR#### 'A'## ## ##, A~CARRNAME## A## ### ## CARRNAME### ##



* =====================================================================



* =====================================================================

* 3. INTO # : ## ##, ### OR ######



* INTO <wa>

* => ### ### ## #### ### ## # ##

* => (### ####) CORRESPONDING FIELDS OF ### ####, ## ##"##" #### # ##



* INTO TABLE <######>

* => ## ### ## ## # ##

* =====================================================================





* >> SELECT ~ ENDSELECT ## ## DB# #### ### ###### # #####.

*  ##) SELECT ~ ENDSELECT# ####

*  SELECT: ### ### ###### ##(cursor)# ## # ## #### #####.

*  ENDSELECT: ### ### #### ## ####### #### ## #### # ## #####. # ### # ## ### #### ## ### #####






DATA : BEGIN OF GS_SCARR,

  CARRID LIKE SCARR-CARRID,

  CARRNAME LIKE SCARR-CARRNAME,

END OF GS_SCARR.

DATA : GT_SCARR LIKE TABLE OF GS_SCARR.



SELECT CARRID CARRNAME

  FROM SCARR

  INTO GS_SCARR "#### select

  WHERE CARRID = 'AA'.



  WRITE : / GS_SCARR-CARRID, GS_SCARR-CARRNAME.

ENDSELECT.






* # SELECT ~ ENDSELECT# ### #####.. ## ### ##.




CLEAR : GS_SCARR.






* WHERE ### ## SELECT single line




SELECT SINGLE CARRID CARRNAME INTO ( GS_SCARR-CARRID, GS_SCARR-CARRNAME )

  FROM SCARR

  WHERE CARRID = 'AA'.



WRITE : / GS_SCARR-CARRID, GS_SCARR-CARRNAME.






* #### ###, intenalTable ##






SELECT CARRID

       CARRNAME

  FROM SCARR

  INTO TABLE GT_SCARR "#### ### ####### ##. SELECT ~ ENDSELECT#### ## ###!

  WHERE CARRID = 'AA'.



CLEAR : GS_SCARR.

LOOP AT GT_SCARR INTO GS_SCARR.

  WRITE : / GS_SCARR-CARRID, GS_SCARR-CARRNAME.

  CLEAR : GS_SCARR.

ENDLOOP.










* INTO TABLE vs INTO CORRESPONING FIELDS OF TABLE ##!




DATA : BEGIN OF GS_SCARR_02,

  ZCHECK TYPE C,

  CARRID LIKE SCARR-CARRID,

  CARRNAME LIKE SCARR-CARRNAME,

  END OF GS_SCARR_02.

DATA : GT_SCARR_02 LIKE TABLE OF GS_SCARR_02.



SELECT CARRID

       CARRNAME

  FROM SCARR

  INTO TABLE GT_SCARR_02 "MOVE A to B##, ####### select# into table# 1#1 #### ###,

  WHERE CARRID = 'AA'.   "#, carrid -> zcheck (type c, 1###) ##, 'AA'# 'A'# ## #### ..



CLEAR : GS_SCARR_02.

LOOP AT GT_SCARR_02 INTO GS_SCARR_02.

  WRITE : / GS_SCARR_02-CARRID, GS_SCARR_02-CARRNAME.

  CLEAR : GS_SCARR.

ENDLOOP.



CLEAR : GT_SCARR_02.



SELECT CARRID

       CARRNAME

  FROM SCARR

  INTO CORRESPONDING FIELDS OF TABLE GT_SCARR_02 "corresponding fields of ### ### ### ###,

  WHERE CARRID = 'AA'.                           "select## ### table# ###, ##### ####.



CLEAR : GS_SCARR_02.

LOOP AT GT_SCARR_02 INTO GS_SCARR_02.

  WRITE : / GS_SCARR_02-CARRID, GS_SCARR_02-CARRNAME.

  CLEAR : GS_SCARR.

ENDLOOP.






* =====================================================================

* ##) ####### #### select## #### ## ###?!

*    => INTO ## APPENDING# ##!

*    => INTO# ## ######, APPENDING# ### ## ####### ## ###!!

* =====================================================================



* INTO TABLE# ###.. SELECT## ## ######.




CLEAR : GS_SCARR_02, GT_SCARR_02.



SELECT CARRID

       CARRNAME

  FROM SCARR

  INTO CORRESPONDING FIELDS OF TABLE GT_SCARR_02

  WHERE CARRID = 'AA'.






*  BREAK-POINT.






SELECT CARRID

       CARRNAME

  FROM SCARR

  INTO CORRESPONDING FIELDS OF TABLE GT_SCARR_02

  WHERE CARRID = 'AB'. "#, INDEX2# #### #### ## ##, #### ### !!!





" #### ####### ##### ##, APPENDING# ##!

CLEAR : GS_SCARR_02, GT_SCARR_02.



SELECT CARRID

       CARRNAME

  FROM SCARR

  INTO CORRESPONDING FIELDS OF TABLE GT_SCARR_02

  WHERE CARRID = 'AA'.



SELECT CARRID

       CARRNAME

  FROM SCARR

  APPENDING CORRESPONDING FIELDS OF TABLE GT_SCARR_02 "INTO## APPENDING

  WHERE CARRID = 'AB'. "#, INTO# ## ## #### ####.








* =====================================================================

* 4. WHERE# : #### ## ### ##### ##, ### #####!



* 1. ### : EQ(=), NE(<>)   // LT(<), LE(<=), GT(>), GE(>=)

* 2. BETWEEN A AND B

* 3. LIKE 'A%'

* 4. IN ## -> ## # ## -> ###, 5. RANGE TABLE# ## ##..

* =====================================================================




CLEAR : GS_SCARR_02, GT_SCARR_02.



" BETWEEN A AND B

SELECT CARRID

       CARRNAME

  FROM SCARR

  INTO CORRESPONDING FIELDS OF TABLE GT_SCARR_02

  WHERE CARRID BETWEEN 'AA' AND 'AB'.



" LIKE 'A%' -> CARRID# A# #### ## ##

CLEAR : GS_SCARR_02, GT_SCARR_02.



SELECT CARRID

       CARRNAME

  FROM SCARR

  INTO CORRESPONDING FIELDS OF TABLE GT_SCARR_02

  WHERE CARRID LIKE 'A%'.



" IN #### ## ### ####.

CLEAR : GS_SCARR_02, GT_SCARR_02.



SELECT CARRID

       CARRNAME

  FROM SCARR

  INTO CORRESPONDING FIELDS OF TABLE GT_SCARR_02

  WHERE CARRID IN ( 'AA', 'AC' ).



CLEAR : GS_SCARR_02, GT_SCARR_02.






* =====================================================================

* 5. IN### #### -> "RANGE TABLE"



* IN### ### # ### 20## ####?? ## #### # ##### ## ##### ####..



* -> RANGE TABLE : SIGN, OPTION, LOW, HIGH 4## ### #### #### ## ### ## ###!



* - RANGES <RANGE TABLE ##> FOR <##>.

*   RANGES GR_SCARR FOR SCARR-CARRID.

*   1) # ### ### ####, #### GR_SCARR# #### #### ####### ######,

*      ### ##(GR_SCARR)## #### ####### ###### ### ##!!!



*   2) # ##### ##, ### ## ### ## ## ###(GR_SCARR),# ######.

*      SIGN (##/##) : ### ####(I), ####(E) #####.

*      OPTION (###) : ### ##(EQ), ##(BT), ##(CP) ### #####.

*      LOW (###) : OPTION ### #### ####.

*      HIGH (##) : OPTION# BT(Between)# ## ####, ## ### ##.



* => ### ####, RANGE TABLE# ### ### #### #, WHERE ... IN ... #### ### ####### ### #####.



* =====================================================================



* >> SIGN & OPTION




RANGES : GR_SCARR FOR SCARR-CARRID.



CLEAR : GR_SCARR.



" ### ### 'A'# ### ## ## ##

GR_SCARR-SIGN = 'I'.

GR_SCARR-OPTION = 'CP'.

GR_SCARR-LOW = '*A'. "OPTION### #### ##.

APPEND GR_SCARR.



" GR_SCARR# ### ### ######,, WHERE IN## ### ####!

DATA : BEGIN OF GS_SCARR_03.

  INCLUDE TYPE SCARR.

DATA : END OF GS_SCARR_03.

DATA : GT_SCARR_03 LIKE TABLE OF GS_SCARR_03.



SELECT * FROM SCARR

  INTO CORRESPONDING FIELDS OF TABLE GT_SCARR_03

  WHERE CARRID IN GR_SCARR.








* >> LOW, HIGH




CLEAR : GR_SCARR.



DATA : BEGIN OF GS_SCARR_04,

  ZCHECK TYPE C,

  CARRID LIKE SCARR-CARRID,

  CARRNAME LIKE SCARR-CARRNAME,

  END OF GS_SCARR_04.

DATA : GT_SCARR_04 LIKE TABLE OF GS_SCARR_04.



" GR_SCARR# ## ## => CARRID# 'AA'## 'AC'### #### #####! => ## ### ##... ## #### #



GR_SCARR-SIGN = 'I'.

GR_SCARR-OPTION = 'BT'.

GR_SCARR-LOW = 'AA'.

GR_SCARR-HIGH = 'AC'.

APPEND GR_SCARR. "## ##





" ## #### SELECT## ####.

SELECT CARRID

  FROM SCARR

  INTO CORRESPONDING FIELDS OF TABLE GT_SCARR_04

  WHERE CARRID IN GR_SCARR.












* =====================================================================

* 6. GROUPING



* ##### #####, SELECT### GROUP BY# #### #



* ## ##,, AVG, MAX, MIN, SUM

* ## ##### COUNT, STUDEV (####), VARIANCE (##)

* =====================================================================






DATA : BEGIN OF GS_SFLIGHT,

  CARRID TYPE SFLIGHT-CARRID,

  CONNID TYPE SFLIGHT-CONNID,

  GV_SUM TYPE i,

  END OF GS_SFLIGHT.

DATA : GT_SFLIGHT LIKE TABLE OF GS_SFLIGHT.



" ##### # #, AS# ### ## #####, GROUP BY# ## ####!

SELECT CARRID "airline code

       CONNID "flight connection number

       AVG( PRICE ) AS GV_SUM

  FROM SFLIGHT

  INTO CORRESPONDING FIELDS OF TABLE GT_SFLIGHT

  GROUP BY CARRID CONNID.








* =====================================================================

* 7. HAVING



* 6. GROUPYBY## ## ### ### ##### ###,, HAVING #!

* =====================================================================




CLEAR : GT_SFLIGHT.





"6# GROUPBY## ###, AVG( PRICE )##, 1000 ### # ## ####

SELECT CARRID "airline code

       CONNID "flight connection number

       AVG( PRICE ) AS GV_SUM

  FROM SFLIGHT

  INTO CORRESPONDING FIELDS OF TABLE GT_SFLIGHT

  GROUP BY CARRID CONNID

  HAVING AVG( PRICE ) > 1000.

  "SELECT ## ### GROUP BY# HAVING ## ### ## #####, HAVING### ## ## ##. ### #### ## ##.






* =====================================================================

* 8. ORDER BY



* ## ###.. ## ### ###### ## ###?

* =====================================================================




CLEAR : GT_SFLIGHT.



SELECT CARRID "airline code

       CONNID "flight connection number

       AVG( PRICE ) AS GV_SUM

  FROM SFLIGHT

  INTO CORRESPONDING FIELDS OF TABLE GT_SFLIGHT

  GROUP BY CARRID CONNID

  HAVING AVG( PRICE ) > 1000

" ORDER BY CARRID.

" ORDER BY CONNID DESCENDING.

  ORDER BY GV_SUM DESCENDING.

  " ORDER BY#### GV_SUM, # ## ## ##! #####, SELECT## ### GROUPBY# HAVING# ### ## #####..








* =====================================================================

* 9. Subquery



* SELECT### WHERE###, ### SELECT ## ##

* =====================================================================




CLEAR : GT_SFLIGHT.






* DATA : BEGIN OF GS_SFLIGHT,

*   CARRID TYPE SFLIGHT-CARRID,

*    CONNID TYPE SFLIGHT-CONNID,

*    GV_SUM TYPE i,

*    END OF GS_SFLIGHT.

*  DATA : GT_SFLIGHT LIKE TABLE OF GS_SFLIGHT.





* ##!!  WHERE## ## #### ###, ## ### ### ### #### ###, alias# #### ##.






SELECT CARRID

       CONNID

       PRICE

   FROM SFLIGHT AS a "## ##

   INTO CORRESPONDING FIELDS OF TABLE GT_SFLIGHT

   " #####, CARRID# Subquery### ## #### ####

   WHERE CARRID IN ( SELECT CARRID

                     FROM SPFLI "#### #####.

                     WHERE CARRID = a~CARRID

                       AND CONNID = a~CONNID )

   AND CARRID = 'AA'

   AND CONNID LIKE '00%'. "%# #######. 00## #### ## #, ex) 001, 0025, 0088



CLEAR : GT_SFLIGHT.



"a~CARRID ##, sflight~carrid# ##.



SELECT CARRID

       CONNID

       PRICE

   FROM SFLIGHT

   INTO CORRESPONDING FIELDS OF TABLE GT_SFLIGHT

   " #####, CARRID# Subquery### ## #### ####

   WHERE CARRID IN ( SELECT CARRID

                     FROM SPFLI "#### #####.

                     WHERE CARRID = SFLIGHT~CARRID

                       AND CONNID = SFLIGHT~CONNID )

   AND CARRID = 'AA'

   AND CONNID LIKE '00%'.






* =====================================================================

* 10. JOIN



* ## #### ## ### ### # ##,

* # #### ##### ON #### ##



* 1) INNER JOIN (###)

*  INNER JOIN# # #### ## #### #### #####. # ### ## ### ###(###)# ### #####.

*  ##:

*  ## ## #### #### #### INNER JOIN##, ### ## #### ##(SSU-01, SSU-02)# ### #####.

*  ###(SSU-03)# #### #### ### #### #### #####.



* 2) OUTER JOIN (###)



*  OUTER JOIN# ## #### #### ## ####, ## ##### #### #### ## #### ### ### #####. # #### ## ###(###)# #####.

*  # ##: ## #### ## ### ##### ## # #### ## ### #### ## # #####.



*  ##:

*  ## ## #### #### #### OUTER JOIN##, ## #### ## ##(SSU-01, SSU-02, SSU-03)# #####.

*  #### #### ### ## ###(SSU-03)# ##, #### ### # ### #####.



* =====================================================================



* 1) INNER JOIN




DATA : BEGIN OF GS_SFLIGHT_02,

  CARRID TYPE SFLIGHT-CARRID,

  CONNID TYPE SFLIGHT-CONNID,

  CARRNAME TYPE SCARR-CARRNAME, "## #### ###.

END OF GS_SFLIGHT_02.

DATA : GT_SFLIGHT_02 LIKE TABLE OF GS_SFLIGHT_02.



" from## inner join## as# ## #####, on# where##, #### ## ### #####.

SELECT A~CARRID

       A~CONNID

       B~CARRNAME

  INTO CORRESPONDING FIELDS OF TABLE GT_SFLIGHT_02

  FROM SFLIGHT AS A

  INNER JOIN SCARR AS B

  ON A~CARRID = B~CARRID

  WHERE A~CARRID = 'AA'.

  " ###, where### on### ## #### ###,

  " where# ## ######, # #### #### ## ON#### # #### JOIN###.






* 2) OUTER JOIN

* SCARR# ## ### ## ### ## ## ## ###, #### ### ## ## ### ## left outer join ##




CLEAR : GT_SFLIGHT_02.



SELECT A~CARRID

       A~CONNID

       B~CARRNAME

  INTO CORRESPONDING FIELDS OF TABLE GT_SFLIGHT_02

  FROM SFLIGHT AS A

  LEFT OUTER JOIN SCARR AS B "left outer join## ###

  ON A~CARRID = B~CARRID     "join## ### ## #### ####, select ### ##

  WHERE A~CARRID = 'AA'.










* =====================================================================

* 11. FOR ALL ENTRIES ##



* # join### ### x #######, for all entries ### ### x ###### ## join## ## ##

* ## ## ###.."## ### #### #### ## ##### # #" ##.

*    - ## # ## SELECT ### ## #### ## ## ###, # ## SELECT ## WHERE # #### ### #



* =====================================================================






TYPES: BEGIN OF ty_carrid,

         carrid TYPE scarr-carrid,

       END OF ty_carrid.



DATA: lt_carriers TYPE TABLE OF ty_carrid.






* 1## : ## ##(USD)# #### ### ## ###

* SCARR #### CURRCODE ### ### ## ### ## ### ID## #### lt_carriers ## #### ###.

* # 1#### #### lt_carriers# for all entries ### ### # #!






SELECT carrid

  FROM scarr

  INTO CORRESPONDING FIELDS OF TABLE lt_carriers

  WHERE currcode = 'USD'.






* 2## : 1### ### ###, ### ##(###) ####

* lt_carriers# ## ### ID## ####, sflight #####, ## #### ## ### ### ####!






DATA: lt_flights TYPE TABLE OF sflight.



" lt_carriers# ## ## ### ## SFLIGHT #### ####

SELECT *

  FROM sflight

  INTO CORRESPONDING FIELDS OF TABLE lt_flights

  FOR ALL ENTRIES IN lt_carriers "## #### ######(#####)

  WHERE carrid = lt_carriers-carrid. "##### x ###### ###






* =====================================================================

* 11. FOR ALL ENTRIES ## (##)



*  FOR ALL ENTRIES# ### #### ### ### ### ## #

*  ## SFLIGHT #### ## ### # ##### ##,

*   #### '## ### ### ## #### ###'## ####### ### ##

*  # ### ### ######## ### ### ## ## ### ##



* =====================================================================



* #### ### for all entries ##






DATA : GS_SPFLI TYPE SPFLI.

DATA : GT_SPFLI LIKE TABLE OF GS_SPFLI.



DATA : BEGIN OF GS_RESULT,

  CARRID LIKE SPFLI-CARRID,

  CONNID LIKE SPFLI-CONNID,

  FLIDATE LIKE SFLIGHT-FLDATE,

  PRICE LIKE SFLIGHT-PRICE,

END OF GS_RESULT.

DATA : GT_RESULT LIKE TABLE OF GS_RESULT.






* 1##: for all entries ### ### ###### ##




SELECT CARRID "airline code

       CONNID "flight connection number

  FROM SPFLI

  INTO CORRESPONDING FIELDS OF TABLE GT_SPFLI

  WHERE CARRID LIKE 'A%'.










* 2## : 1#### #### GT_SPFLI ###### # SFLIGHT ##### join### -> for all entries



* !!##!! ## #### ### ###### (GT_SPFLI)# # ### ####.

* ###, GT_SPFLI# null###, full scan## memory dump# ######..






IF GT_SPFLI IS NOT INITIAL.

  SELECT *

    FROM sflight

    INTO CORRESPONDING FIELDS OF TABLE GT_RESULT

    FOR ALL ENTRIES IN GT_SPFLI

    WHERE CARRID = GT_SPFLI-CARRID

    AND   CONNID = GT_SPFLI-CONNID.

ELSE.

  WRITE : / 'GT_SPFLI ###### ## #### ###'.

ENDIF.