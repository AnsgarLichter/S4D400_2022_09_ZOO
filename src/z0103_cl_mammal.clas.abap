CLASS z0103_cl_mammal DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES z0103_if_animal.

    ALIASES eat
        FOR z0103_if_animal~eat.
    ALIASES move
        FOR z0103_if_animal~move.
    ALIASES sleep
        FOR z0103_if_animal~sleep.
    ALIASES name
        FOR z0103_if_animal~name.
    ALIASES is_hungry
        FOR z0103_if_animal~is_hungry.
    ALIASES gender
        FOR z0103_if_animal~gender.
    ALIASES color
        FOR z0103_if_animal~color.
    ALIASES food
        FOR z0103_if_animal~food.

    METHODS feed_offspring
      IMPORTING
        food TYPE string
      RAISING
        cx_s4d400_power_error.

    METHODS constructor
      IMPORTING
        name              TYPE string
        gender            TYPE gender
        color             TYPE char20
        blood_temperature TYPE i.

    CLASS-METHODS give_birth
      IMPORTING
        mammal1 TYPE REF TO z0103_cl_mammal
        mammal2 TYPE REF TO z0103_cl_mammal
      RAISING
        cx_s4d400_power_error.

    CLASS-METHODS try_make_child
      IMPORTING
        mammal1 TYPE REF TO z0103_cl_mammal
        mammal2 TYPE REF TO z0103_cl_mammal
      RAISING
        cx_s4d400_power_error.

    DATA:
      blood_temperature TYPE i,
      is_pregnant       TYPE abap_bool,
      mother            TYPE REF TO z0103_cl_mammal,
      father            TYPE REF TO z0103_cl_mammal,
      children          TYPE STANDARD TABLE OF REF TO z0103_cl_mammal.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS z0103_cl_mammal IMPLEMENTATION.
  METHOD z0103_if_animal~eat.
    IF is_hungry = abap_false.
      WRITE: / |I, { me->name }, am not hungry.|.

      RAISE EXCEPTION TYPE cx_s4d400_power_error.
    ENDIF.

    me->food = VALUE #(
        BASE me->food
        ( food )
    ).
    is_hungry = abap_false.

    WRITE: / |I, { me->name }, eat { food }. I am not hungry anymore.|.
  ENDMETHOD.

  METHOD z0103_if_animal~move.
    IF is_hungry = abap_true.
      WRITE: / |I, { me->name }, am hungry. I can not move now.|.

      RAISE EXCEPTION TYPE cx_s4d400_power_error.
    ENDIF.

    is_hungry = abap_true.

    WRITE: / |I, { me->name }, moved. I am hungry now.|.
  ENDMETHOD.

  METHOD z0103_if_animal~sleep.
    IF is_hungry = abap_true.
      WRITE: / |I, { me->name }, am hungry. I can not sleep now.|.

      RAISE EXCEPTION TYPE cx_s4d400_power_error.
    ENDIF.

    is_hungry = abap_true.

    WRITE: / |I, { me->name }, have slept. I am hungry now.|.
  ENDMETHOD.


  METHOD feed_offspring.
    LOOP AT children ASSIGNING FIELD-SYMBOL(<child>).
      IF <child>->is_hungry = abap_false.
        RAISE EXCEPTION TYPE cx_s4d400_power_error.
      ENDIF.
    ENDLOOP.

    LOOP AT children ASSIGNING <child>.
      <child>->eat( food ).
    ENDLOOP.
  ENDMETHOD.

  METHOD give_birth.
    IF ( mammal1->gender = 'M' AND mammal2->gender = 'M' )
       OR ( mammal1->gender = 'W' AND mammal2->gender = 'W' ).
      RAISE EXCEPTION TYPE cx_s4d400_power_error.
    ENDIF.

    DATA female TYPE REF TO z0103_cl_mammal.
    DATA male TYPE REF TO z0103_cl_mammal.
    IF mammal1->gender = 'W'.
      female = mammal1.
      male = mammal2.
    ELSE.
      female = mammal2.
      male = mammal1.
    ENDIF.

    IF female->is_pregnant = abap_false OR female->is_hungry = abap_true.
      RAISE EXCEPTION TYPE cx_s4d400_power_error.
    ENDIF.

    DATA(randomizer) = cl_abap_random=>create( ).
    DATA(count_children) = randomizer->intinrange( low = 1 high = 1000 ).
    WHILE count_children > 0.
      DATA(gender) = randomizer->intinrange( low = 1 high = 2 ).
      DATA(child) = NEW z0103_cl_mammal(
        name              = SWITCH #( gender WHEN 1 THEN 'NICOLA' ELSE `ANDREAS` )
        gender            = SWITCH #( gender WHEN 1 THEN 'W' ELSE 'M' )
        color             = |BLACK|
        blood_temperature = 98090
      ).

      child->father = male.
      child->mother = female.

      child->father->children = VALUE #(
         BASE child->father->children
         ( child )
      ).
      child->mother->children = VALUE #(
         BASE child->mother->children
         ( child )
      ).

      count_children -= 1.
    ENDWHILE.
  ENDMETHOD.

  METHOD try_make_child.
    IF ( mammal1->gender = 'M' AND mammal2->gender = 'M' )
       OR ( mammal1->gender = 'W' AND mammal2->gender = 'W' ).
      RAISE EXCEPTION TYPE cx_s4d400_power_error.
    ENDIF.

    DATA(randomizer) = cl_abap_random=>create( ).
    DATA(result) = randomizer->intinrange( low = 1 high = 2 ).
    IF result = 2.
      RAISE EXCEPTION TYPE cx_s4d400_power_error.
    ENDIF.

    DATA female TYPE REF TO z0103_cl_mammal.
    IF mammal1->gender = 'W'.
      female = mammal1.
    ELSE.
      female = mammal2.
    ENDIF.

    female->is_pregnant = abap_true.
  ENDMETHOD.

  METHOD constructor.
    me->name = name.
    me->gender = gender.
    me->color = color.
    me->blood_temperature = blood_temperature.

    me->is_hungry = abap_false.
    me->is_pregnant = abap_false.
  ENDMETHOD.

ENDCLASS.
