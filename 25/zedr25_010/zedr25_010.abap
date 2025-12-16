
*&---------------------------------------------------------------------*

*& Report ZEDR25_010

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR25_010.






*DATA : BEGIN OF GS_SCARR,

*  CARRID LIKE SCARR-CARRID,

*  CARRNAME LIKE SCARR-CARRNAME,

*  END OF GS_SCARR.

*DATA : GT_SCARR LIKE TABLE OF GS_SCARR.






RANGES GR_SCARR FOR SCARR-CARRID.






*DATA : BEGIN OF GR_SCARR OCCURS 0,

*  SIGN TYPE DDSIGN,

*  OPTION TYPE DDOPTION,

*  LOW LIKE SCARR-CARRID,

*  HIGH LIKE SCARR-CARRID,

*END OF GR_SCARR.







*DATA : BEGIN OF GS_SCARR,

*  ZCHECK TYPE C,

*  CARRID LIKE SCARR-CARRID,

*  CARRNAME LIKE SCARR-CARRNAME,

*  END OF GS_SCARR.

*DATA : GT_SCARR LIKE TABLE OF GS_SCARR.








"SELECT CARRID CARRNAME INTO GS_SCARR




*SELECT SINGLE CARRID CARRNAME INTO ( GS_SCARR-CARRID, GS_SCARR-CARRNAME )

*  FROM SCARR " SAP ## ## ### # ## (#### ## ### ###

*  WHERE CARRID = 'AA'.

*

*  WRITE :/ GS_SCARR-CARRID, GS_SCARR-CARRNAME.




"ENDSELECT.






*SELECT CARRID

*       CARRNAME

*  FROM SCARR

*  "INTO TABLE GT_SCARR

*  INTO CORRESPONDING FIELDS OF TABLE GT_SCARR "## ## ## ## ## ## ###

*  WHERE CARRID = 'AA'.

*

*SELECT CARRID

*       CARRNAME

*  FROM SCARR

*  "INTO TABLE GT_SCARR

*  INTO CORRESPONDING FIELDS OF TABLE GT_SCARR "## ## ## ## ## ## ###

*  WHERE CARRID = 'AA'.



*SELECT CARRID

*       CARRNAME

*  FROM SCARR

*  INTO CORRESPONDING FIELDS OF TABLE GT_SCARR

*  "WHERE CARRID BETWEEN 'AA' AND 'AB'.

*  WHERE CARRID IN ('AA', 'AC').






" RANGES# #### ## #### ####(## ## ##)




*CLEAR : GR_SCARR.

*

*GR_SCARR-SIGN = 'I'.

*GR_SCARR-OPTION = 'CP'.

*GR_SCARR-LOW = 'A'.

*APPEND GR_SCARR.

*

*DATA : BEGIN OF GS_SCARR.

*  INCLUDE TYPE SCARR.

*DATA : END OF GS_SCARR.

*DATA : GT_SCARR LIKE TABLE OF GS_SCARR.

*

*SELECT * FROM SCARR

*  INTO CORRESPONDING FIELDS OF TABLE GT_SCARR

*  WHERE CARRID IN GR_SCARR.





*DATA : BEGIN OF GS_SCARR,

*  ZCHECK TYPE C,

*  CARRID TYPE SCARR-CARRID,

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

*SELECT CARRID

*       CARRNAME

*  FROM SCARR

*  INTO CORRESPONDING FIELDS OF TABLE GT_SCARR

*  WHERE CARRID IN GR_SCARR.



*DATA : BEGIN OF GS_SFLIGHT,

*         CARRID TYPE SFLIGHT-CARRID,

*         CONNID TYPE SFLIGHT-CONNID,

*         GV_SUM TYPE I,

*       END OF GS_SFLIGHT.

*

*DATA : GT_SFLIGHT LIKE TABLE OF GS_SFLIGHT.





*SELECT CARRID

*       CONNID

*       AVG( PRICE ) AS GV_SUM

*  INTO CORRESPONDING FIELDS OF TABLE GT_SFLIGHT

**  FROM SFLIGHT GROUP BY CARRID CONNID

**  HAVING AVG( PRICE ) > 1000 " GROUP BY# ### SELECT ### #### ##

**  ORDER BY CARRID.

*  FROM SFLIGHT

*  WHERE CARRID IN ( SELECT CARRID

*                      FROM SPFLI

*                      WHERE CARRID = A~CARRID

*                        AND CONNID = A~CONNID )

*AND CARRID = 'AA'.

*AND CONNID LIKE '00%'.



*DATA : BEGIN OF GS_SFLIGHT,

*         CARRID TYPE SFLIGHT-CARRID,

*         CONNID TYPE SFLIGHT-CONNID,

*         CARRNAME TYPE SCARR-CARRNAME,

*       END OF GS_SFLIGHT.

*DATA : GT_SFLIGHT LIKE TABLE OF GS_SFLIGHT.

*

*SELECT A~CARRID

*       A~CONNID

*       B~CARRNAME

*  INTO CORRESPONDING FIELDS OF TABLE GT_SFLIGHT

*  FROM SFLIGHT AS A

*  INNER JOIN SCARR AS B "OUTER

*  ON A~CARRID = B~CARRID

*  WHERE A~CARRID = 'AA'.





*LOOP AT GT_SFLIGHT INTO GS_SFLIGHT.

*  WRITE : / GS_SFLIGHT-CARRID, GS_SFLIGHT-CONNID, GS_SFLIGHT-CARRNAME.

*ENDLOOP.






DATA: BEGIN OF gs_spfli,

        carrid TYPE spfli-carrid,

        connid TYPE spfli-connid,

      END OF gs_spfli.



DATA: gt_spfli LIKE TABLE OF gs_spfli.



DATA: BEGIN OF gs_sflight,

        carrid TYPE sflight-carrid,

        connid TYPE sflight-connid,

        fldate TYPE sflight-fldate,

        price  TYPE sflight-price,

      END OF gs_sflight.



DATA: gt_sflight LIKE TABLE OF gs_sflight.



SELECT carrid

       connid

  FROM spfli

  INTO CORRESPONDING FIELDS OF TABLE gt_spfli

  WHERE carrid LIKE 'AA%'.



IF sy-subrc <> 0.

  WRITE: / '### ## SPFLI ### ##'.

  EXIT.

ENDIF.



DELETE ADJACENT DUPLICATES FROM gt_spfli COMPARING carrid connid.



IF gt_spfli IS NOT INITIAL.

  SELECT carrid

         connid

         fldate

         price

    FROM sflight

    INTO CORRESPONDING FIELDS OF TABLE gt_sflight

    FOR ALL ENTRIES IN gt_spfli

    WHERE carrid = gt_spfli-carrid

      AND connid = gt_spfli-connid.

ENDIF.



LOOP AT gt_sflight INTO gs_sflight.

  WRITE: / gs_sflight-carrid,

           gs_sflight-connid,

           gs_sflight-fldate,

           gs_sflight-price.

ENDLOOP.