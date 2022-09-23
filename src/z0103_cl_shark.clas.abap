CLASS z0103_cl_shark DEFINITION INHERITING FROM z0103_cl_fish
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS Bite
      IMPORTING
        person TYPE REF TO z0103_cl_person.

    METHODS constructor
      IMPORTING
        vegetarian TYPE char01
        depth      TYPE i
        name       TYPE char20
        gender     TYPE char01
        color      TYPE char20
        teeth      TYPE i.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA Teeth TYPE i.
ENDCLASS.



CLASS z0103_cl_shark IMPLEMENTATION.
  METHOD bite.
    Person->is_pissed = abap_true.
    z0103_if_animal~is_hungry = abap_false.
  ENDMETHOD.

  METHOD constructor.
    super->constructor(
      name          = name
      gender        = gender
      color         = color
      is_vegetarian = is_vegetarian
      depth         = depth
    ).

    me->teeth = teeth.
  ENDMETHOD.

ENDCLASS.
