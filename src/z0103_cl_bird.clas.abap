CLASS z0103_cl_bird DEFINITION ABSTRACT
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

    METHODS constructor
      IMPORTING
        name   TYPE char20
        gender TYPE gender
        color  TYPE char20
        height TYPE i
        span   TYPE i.

    METHODS fly_up
      IMPORTING
        height TYPE i
      RAISING
        cx_s4d400_power_error.

    METHODS fly_down
      IMPORTING
        height TYPE i
      RAISING
        cx_s4d400_power_error.

    DATA:
      height TYPE i,
      span   TYPE i.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z0103_cl_bird IMPLEMENTATION.
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

  METHOD fly_down.
    IF is_hungry = abap_true.
      WRITE : / |I, { me->name }, am hungry. I can not fly up.|.

      RAISE EXCEPTION TYPE cx_s4d400_power_error.
    ENDIF.

    me->height -= height.

    WRITE : / |I, { me->name }, flew down to { me->height } meters.|.

    IF me->height < 0.
      WRITE : / |I, { me->name }, am lower than 0 meters. I am dead now.|.

      RAISE EXCEPTION TYPE cx_s4d400_power_error.
    ENDIF.
  ENDMETHOD.

  METHOD fly_up.
    IF is_hungry = abap_true.
      WRITE : / |I, { me->name }, am hungry. I can not fly up.|.

      RAISE EXCEPTION TYPE cx_s4d400_power_error.
    ENDIF.

    me->height += height.

    WRITE : / |I, { me->name }, flew up to{ me->height } meters.|.

    IF me->height > 20000.
      WRITE : / |I, { me->name }, am higher than 20000 meters. I am dead now.|.

      RAISE EXCEPTION TYPE cx_s4d400_power_error.
    ENDIF.
  ENDMETHOD.

  METHOD constructor.
    me->name = name.
    me->gender = gender.
    me->color = color.
    me->height = height.
    me->span = span.
    me->is_hungry = abap_false.
  ENDMETHOD.

ENDCLASS.
