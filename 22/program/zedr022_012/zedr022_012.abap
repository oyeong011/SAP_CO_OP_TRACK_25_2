
*&---------------------------------------------------------------------*

*& Report ZEDR022_012

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR022_012.






*DATA : BEGIN OF GS_STUDENT.

*  INCLUDE TYPE ZEDT022_001.

*  DATA : END OF GS_STUDENT.

*DATA : GT_STUDENT LIKE TABLE OF GS_STUDENT.



*select : ##

* single line : ######## ### ## #### # #

* select single carrname from scarr into l_carrname.

*where carrid = 'aa'.

** several lines : ######## ## ## ##

*select carrname from scarr into table gt_scarr

*where carrid = 'aa'.

*

**RANGE TABLE ##

*RANGES GR_SCARR FOR SCARR-CARRID.

** RANGES### #### ### ##### 4## ### ## ### #### #

*

**------- RANGES ## ### ## ## ### ## ##

**DATA : BEGIN OF GR_NAME OCCURS 0,

**  SIGN TYPE DDSIGN, "### ## #### #### #### ##### I : ##, E : ## ## ##

**  OPTION TYPE DDOPTION, "### ## ## ## ## CP : ## ##

**  LOW LIKE TYPE Reference,

**  HIGH LIKE TYPE Reference,

**END OF GR_NAME.

**-------

**

*CLEAR : GR_SCARR.

**

*DATA : BEGIN OF GS_SCARR,

*  ZCHECK TYPE C,

*  CARRID LIKE SCARR-CARRID,

*  CARRNAME LIKE SCARR-CARRNAME,

*  END OF GS_SCARR.

*DATA : GT_SCARR LIKE TABLE OF GS_SCARR.

*

*GR_SCARR-SIGN = 'I'.

*GR_SCARR-OPTION = 'EQ'.

*GR_SCARR-LOW = 'AA'.

*APPEND GR_SCARR.

*

*GR_SCARR-LOW = 'AC'.

*APPEND GR_SCARR.

*

**

*SELECT CARRID

*       CARRNAME

*  FROM SCARR

*  INTO CORRESPONDING FIELDS OF TABLE GT_SCARR

*  WHERE CARRID IN GR_SCARR.

*

*  WHERE CARRID IN ( 'AA', 'AC' ). "List value : in ### #### ## ### ## ### ## ###

** in () ## ### ##### ### ## ### # ## ## : range##(###)

**  WHERE CARRID LIKE 'A%'.

** A# #### ## ##

*

** ### #### ### ### # ## ### #### #### ###?

*

*SELECT CARRID

*       CARRNAME

*  FROM SCARR

*  INTO CORRESPONDING FIELDS OF TABLE GT_SCARR

** into : ### #### #### ### ## ###

*  WHERE CARRID = 'AB'.

** ## ## : 'AA' -> 'AB'# ## ###(#### #)

*

** GROUPING ,HAVING, ORDER BY

*SELECT CARRID

*       CARRNAME

*  FROM SCARR

*  APPENDING CORRESPONDING FIELDS OF TABLE GT_SCARR

** into : ### #### #### ### ## ###

*  WHERE CARRID = 'AB'.

** ## ## : 'AA', 'AB' ## ##

*

*SELECT CARRID

*       CONNID

*  AVG( PRICE ) AS GV_SUM "SQL## INTO CORRESPONG FIELDS OF TABLE ### #### #### ### AS### ### ## ##

*  INTO CORRESPONDING FIELDS OF TABLE GT_SFLIGHT

*  FROM SFLIGHT GROUP BY CARRID CONNID

*  HAVING AVG( PRICE ) > 1000 " GROUP BY# ### SELECT### ### ## ##

*  ORDER BY GV_NUM.



* #### ##




DATA : BEGIN OF GS_SFLIGHT,

  CARRID TYPE SFLIGHT-CARRID,

  CONNID TYPE SFLIGHT-CONNID,

  PRICE TYPE SFLIGHT-PRICE,

  END OF GS_SFLIGHT.

DATA : GT_SFLIGHT LIKE TABLE OF GS_SFLIGHT.



SELECT CARRID

       CONNID

       PRICE

  INTO CORRESPONDING FIELDS OF TABLE GT_SFLIGHT

  FROM SFLIGHT "## ### ## ### ## ### ## # ##

  WHERE CARRID IN ( SELECT CARRID "##### ### ## #### ####

                         FROM SPFLI "# sflight##### #### CARRID#### spfli#### CARRID## ##

                         WHERE CARRID = SFLIGHT~CARRID "#### ###(EX. SFLIGHT# CARRID# AB# ###

                         AND CONNID = SFLIGHT~CONNID ) "SPFLI# AB# ### ### # ##

  AND CARRID = 'AA'

  AND CONNID LIKE '00%'.






* ## ##

*DATA : BEGIN OF GS_SFLIGHT,

*  CARRID TYPE SFLIGHT-CARRID,

*  CONNID TYPE SFLIGHT-CONNID,

*  CARRNAME TYPE SCARR-CARRNAME,

*  END OF GS_SFLIGHT.

*DATA : GT_SFLIGHT LIKE TABLE OF GS_SFLIGHT.

*

*SELECT A~CARRID

*       A~CONNID

*       B~CARRNAME "### select# #### #### ## ##### ##

*  INTO CORRESPONDING FIELDS OF TABLE GT_SFLIGHT

*  FROM SFLIGHT AS A "## ##(## #### ### SFLIGHT~CARRID ## ##

*  INNER JOIN SCARR AS B "###

*  ON A~CARRID = B~CARRID "where### on### ####### where ### ## #### # #### ####

*  WHERE A~CARRID = 'AA'."## ON ### # ### ##

*

** scarr# ## ### ### ### ## ## ## ###

** #### ### ## ## ### ## left outer join ##

*SELECT A~CARRID

*       A~CONNID

*       B~CARRNAME "### select# #### #### ## ##### ##

*  INTO CORRESPONDING FIELDS OF TABLE GT_SFLIGHT

*  FROM SFLIGHT AS A "## ##(## #### ### SFLIGHT~CARRID ## ##

*  LEFT OUTER JOIN SCARR AS B "## ### ### ## #### #### select## ##

*  ON A~CARRID = B~CARRID

*  WHERE A~CARRID = 'AA'.








LOOP AT GT_SFLIGHT INTO GS_SFLIGHT.

   WRITE :/ GS_SFLIGHT-CARRID, GS_SFLIGHT-CONNID, GS_SFLIGHT-PRICE.

ENDLOOP.