
*&---------------------------------------------------------------------*

*& Report ZEDR04_003

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR04_003.



DATA :  text1 TYPE STRING,

        text2(8) TYPE C,

        text3(8) TYPE C.



" 1. Find : #### ## ## ### SY-SUBRC = 0 ##

text1 = 'ABAP'.

text2 = 'B'.



FIND text2 IN text1.



IF SY-SUBRC = 0.

  WRITE text2.      "B

ENDIF.

WRITE / '---------------------------------------------------'.



" 2. REPLACE : ## ##

text1 = 'ABAP'.

text2 = 'BBAP'.



REPLACE text1 IN text1 WITH text2.



WRITE / text1.      "BBAP

WRITE / '---------------------------------------------------'.



" 3. TRANSLATE : #### ##

text1 = 'ABAP'.

text2 = 'abap'.



TRANSLATE text1 to LOWER CASE.

TRANSLATE text2 to UPPER CASE.



WRITE : / text1,    "abap

        / text2.    "ABAP

WRITE / '---------------------------------------------------'.



" 4. SHIFT : ### #### # ## ##

text1 = ' ABAP'.

text2 = ' ABAP'.



SHIFT text1.



WRITE : / text1,    "ABAP

        / text2.    " ABAP

WRITE / '---------------------------------------------------'.



" 5. CONDENSE : ## ##, ## ##. NO-GAPS# ## ##

text1 = 'AB    AP'.

text2 = 'AB    AP'.

text3 = 'AB    AP'.



CONDENSE text1.

CONDENSE text2 NO-GAPS.



WRITE : / text1,    "AB AP

        / text2,    "ABAP

        / text3.    "AB    AP

WRITE / '---------------------------------------------------'.



" 6. OVERLAY : CHAR # ## ###

text1 = ' B P'.

text2 = 'AAAA'.



OVERLAY text1 with text2.



WRITE / text1.      "ABAP

WRITE / text2.      "AAAA

WRITE / '---------------------------------------------------'.



" 7. CONCATENATE : #### ## ##

text1 = 'AB'.

text2 = 'AP'.



CONCATENATE text1 text2 INTO text3.



WRITE / text1.      "AB

WRITE / text2.      "AP

WRITE / text3.      "ABAP

WRITE / '---------------------------------------------------'.



" 8. SPLIT : ## ### #### ### ##

text1 = 'AB+AP'.

SPLIT text1 AT '+' INTO text2 text3.



write / text1.      "AB+AP

WRITE / text2.      "AB

WRITE / text3.      "AP