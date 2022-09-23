CLASS z0103_cl_magpie DEFINITION
  PUBLIC
  INHERITING FROM z0103_cl_bird
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS constructor
      IMPORTING
        name   TYPE char20
        gender TYPE gender
        color  TYPE char20.
    .

    METHODS steal
      IMPORTING
        person TYPE REF TO z0103_cl_person.

    METHODS put_item_in_nest.

    DATA:
      items        TYPE STANDARD TABLE OF string WITH EMPTY KEY,
      current_item TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA randomizer TYPE REF TO cl_abap_random.
ENDCLASS.



CLASS z0103_cl_magpie IMPLEMENTATION.
  METHOD constructor.
    super->constructor(
      name   = name
      gender = gender
      color  = color
      height = height
      span   = span ).

    WRITE: / |I, { me->name }, am born!|.
  ENDMETHOD.

  METHOD put_item_in_nest.
    IF current_item IS INITIAL.
      WRITE: / |I, { me->name }, do not have a current item and can not put something in my nest.|.
      RETURN.
    ENDIF.

    items = VALUE #(
        BASE items
        ( current_item )
    ).

    WRITE: / |I, { me->name }, put { current_item } in my nest.|.

    CLEAR current_item.
  ENDMETHOD.

  METHOD steal.
    IF is_hungry = abap_true.
      WRITE: / |I, { me->name }, am hungry and can not steal something|.
      RETURN.
    ENDIF.

    DATA(index_item_to_steal) = randomizer->intinrange(
        low = 1
        high = lines( person->items )
    ).


    current_item = person->items[ index_item_to_steal ].
    DELETE person->items INDEX index_item_to_steal.

    WRITE: / |I, { me->name }, stole { current_item }|.
  ENDMETHOD.

ENDCLASS.
