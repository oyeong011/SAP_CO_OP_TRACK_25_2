
*&---------------------------------------------------------------------*

*& Report ZEDR12_DBTSELECT007

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR12_DBTSELECT007.

DATA: BEGIN OF GS_SFLIGHT,

  CARRID TYPE SFLIGHT-CARRID,

  CONNID TYPE SFLIGHT-CONNID,

  PRICE TYPE SFLIGHT-PRICE,

  END OF GS_SFLIGHT.

DATA: GT_SFLIGHT LIKE TABLE OF GS_SFLIGHT.






*# SFLIGHT##### ####

*CARRID####

*SPFLI#### CARRID## ##

*#######

*(ex. SFLIGHT# CARRID# AB# ###

*SPFLI# AB# ### ## # # ##)




SELECT CARRID "airline code

       CONNID "Airline Connection Number

       PRICE "AIRFARE

  INTO CORRESPONDING FIELDS OF TABLE GT_SFLIGHT

  FROM SFLIGHT

  WHERE CARRID IN ( SELECT CARRID

                    FROM SPFLI

                    WHERE CARRID = SFLIGHT~CARRID

                    AND CONNID = SFLIGHT~CONNID )

  AND CARRID = 'AA'

  AND CONNID LIKE '00%'.



  LOOP AT GT_SFLIGHT INTO GS_SFLIGHT.

    WRITE:/ GS_SFLIGHT-CARRID, GS_SFLIGHT-CONNID, GS_SFLIGHT-PRICE.

  ENDLOOP.