
*&---------------------------------------------------------------------*

*& Report ZEDR04_002

*&---------------------------------------------------------------------*

*&

*&---------------------------------------------------------------------*




REPORT ZEDR04_002.



" C (Text Field) : ##. ## ## ## ##

DATA gv_text1 VALUE 'A'.

DATA gv_text2 LENGTH 3 TYPE C VALUE 'ABC'.

DATA gv_text3(5) TYPE C VALUE 'ABCDE'.



" String : ## ## ###. ## ## ## x

DATA gv_text4 TYPE STRING VALUE 'ABCDE'.



" Date : ##.

" Time : ##. # # ## ## ## x

DATA gv_date TYPE D.

DATA gv_time TYPE T.



gv_date = SY-DATUM. " ### ##

gv_time = SY-UZEIT. " ### ##





DATA gv_len TYPE i.

gv_len = STRLEN( gv_text3 ). " ### ## ##. ## #### ##.



WRITE : gv_text1.   "A

WRITE : / gv_text2. "ABC

WRITE : / gv_text3. "ABCDE

WRITE : / gv_text4. "ABCDE

WRITE : / gv_date.  "20251102

WRITE : / gv_time.  "174758

WRITE : / gv_len.   "         5