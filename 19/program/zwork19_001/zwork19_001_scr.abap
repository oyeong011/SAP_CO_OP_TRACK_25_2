
*&---------------------------------------------------------------------*

*&  Include  ZWORK19_001_SCR

*&---------------------------------------------------------------------*






" #### ## (## ### ## ##)

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-001.

PARAMETERS: p_date  TYPE sy-datum OBLIGATORY DEFAULT sy-datum. "####(####)

PARAMETERS: p_file  TYPE string LOWER CASE.

PARAMETERS : p_kurst TYPE kurst DEFAULT 'M' MODIF ID m1 VISIBLE LENGTH 1.

SELECTION-SCREEN END OF BLOCK b1.



"=== Application Toolbar# Function Key ## ===

SELECTION-SCREEN FUNCTION KEY 1.



"F4 - ## ##

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_file.

  PERFORM f4_file_open CHANGING p_file.



INITIALIZATION.

  sscrfields-functxt_01 = '### ####'.  "## Application Toolbar ## ###