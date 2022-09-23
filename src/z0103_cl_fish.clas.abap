CLASS z0103_cl_fish DEFINITION ABSTRACT
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES Z0103_IF_Animal.

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

    METHODS constructor
      IMPORTING
        name          TYPE char20
        gender        TYPE gender
        color         TYPE char20
        depth         TYPE i
        is_vegetarian TYPE abap_bool.

    METHODS: dive
      IMPORTING
        dive TYPE i
      RAISING
        cx_s4d400_power_error.

    METHODS: dive_up
      IMPORTING
        dive TYPE i
      RAISING
        cx_s4d400_power_error.

  PROTECTED SECTION.
    DATA: is_vegetarian TYPE abap_bool,
          Depth         TYPE i.

  PRIVATE SECTION.
ENDCLASS.



CLASS z0103_cl_fish IMPLEMENTATION.
  METHOD dive.
    IF Z0103_IF_Animal~Is_Hungry = abap_true.
      RETURN.
    ENDIF.

    depth += dive.

    IF depth > 200.
      WRITE : / |I, { me->name }, am lower than 200 meters. I'm dead now.|.
      RAISE EXCEPTION TYPE cx_s4d400_power_error.
    ENDIF.
  ENDMETHOD.

  METHOD dive_up.
    IF Z0103_IF_Animal~Is_Hungry = abap_true.
      RETURN.
    ENDIF.
    Depth -= dive.

    IF Depth < 0.
      WRITE : / |I, { me->name }, am higher than 0 meters. I'm dead now.|.

      RAISE EXCEPTION TYPE cx_s4d400_power_error.
    ENDIF.
  ENDMETHOD.

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

  METHOD constructor.
    me->name = name.
    me->gender = gender.
    me->color = color.
    me->is_vegetarian = is_vegetarian.
    me->depth = depth.

    me->is_hungry = abap_false.
  ENDMETHOD.

ENDCLASS.
