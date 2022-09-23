CLASS z0103_cl_dove DEFINITION
  PUBLIC
  INHERITING FROM z0103_cl_bird
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS shit
      IMPORTING
        person TYPE REF TO z0103_cl_person.

    METHODS: curr
      RETURNING
        VALUE(curr) TYPE string.

    METHODS constructor
      IMPORTING
        volume TYPE i
        height TYPE i
        span   TYPE i
        name   TYPE char20
        gender TYPE char01
        color  TYPE char20.


    DATA volume TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z0103_cl_dove IMPLEMENTATION.
  METHOD curr.
    IF is_hungry = abap_false.
      RETURN.
    ENDIF.

    curr = REDUCE #(
        INIT s = ``
        FOR  i = 1 UNTIL i > volume
        NEXT s = |{ s } CURR|
    ).

    WRITE: / |Dove { me->name } says: { curr }|.
  ENDMETHOD.

  METHOD shit.
    WRITE: / |Dove { me->name } has shit. Person { person->name } is pissed now!|.

    person->is_pissed = abap_true.
  ENDMETHOD.

  METHOD constructor.
    super->constructor(
      name   = name
      gender = gender
      color  = color
      height = height
      span   = span ).

    me->volume = volume.

    WRITE: / |I, { me->name }, am born!|.
  ENDMETHOD.

ENDCLASS.
