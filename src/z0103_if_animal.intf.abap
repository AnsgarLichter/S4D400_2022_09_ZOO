"! <p class="shorttext synchronized" lang="en">Animal</p>
INTERFACE z0103_if_animal
  PUBLIC.

  METHODS eat
    IMPORTING
      food TYPE string
    RAISING
      cx_s4d400_power_error.

  METHODS move
    RAISING
      cx_s4d400_power_error.


  METHODS sleep
    RAISING
      cx_s4d400_power_error.

  DATA:
    name      TYPE string,
    is_hungry TYPE abap_bool,
    gender    TYPE gender,
    color     TYPE char20,
    food      TYPE STANDARD TABLE OF string WITH EMPTY KEY.

ENDINTERFACE.
