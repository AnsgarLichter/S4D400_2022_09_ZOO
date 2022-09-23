CLASS z0103_cl_person DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES: ty_item TYPE STANDARD TABLE OF string WITH EMPTY KEY.

    METHODS constructor
      IMPORTING
        name  TYPE char20
        items TYPE ty_item.

    METHODS feed
      IMPORTING
        animal TYPE REF TO z0103_if_animal
        food   TYPE string.

    METHODS curse
      RETURNING
        VALUE(curse) TYPE string.

    DATA:
      name      TYPE string,
      is_pissed TYPE abap_bool,
      items     TYPE ty_item.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z0103_cl_person IMPLEMENTATION.
  METHOD curse.
    curse = SWITCH #(
       is_pissed
       WHEN abap_true THEN |FUCK YOU|
       ELSE |IT'S A HAPPY DAY|
    ).

    WRITE: / |I, { me->name }, say: { curse }|.
  ENDMETHOD.

  METHOD feed.
    IF is_pissed = abap_true.
      WRITE: / |I, { me->name }, am pissed. I can not eat now.|.
      RETURN.
    ENDIF.

    TRY.
        animal->eat( food ).
        WRITE: / |I, { me->name }, eat { food }. I am not hungry anymore|.
      CATCH cx_s4d400_power_error.
        WRITE: / |I, { me->name }, can not eat|.
    ENDTRY.
  ENDMETHOD.

  METHOD constructor.
    me->name = name.
    me->is_pissed = abap_false.
    me->items = items.

    WRITE: / |I, { me->name }, am born!|.
  ENDMETHOD.

ENDCLASS.
