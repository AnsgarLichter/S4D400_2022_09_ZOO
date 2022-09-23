CLASS z0103_cl_elephant DEFINITION INHERITING FROM z0103_cl_mammal
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS Stamp.

    METHODS Swap_Tail
      IMPORTING
        person TYPE REF TO z0103_cl_person.

    METHODS Absorb_Water
      IMPORTING
        amount TYPE i.

    METHODS Splash_Water
      IMPORTING
        person TYPE REF TO z0103_cl_person.

    METHODS constructor
      IMPORTING
        force             TYPE i
        trunk_capacity    TYPE i
        blood_temperature TYPE i
        name              TYPE string
        gender            TYPE gender
        color          TYPE char20.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: Force          TYPE i,
          Trunk_Capacity TYPE i.
ENDCLASS.



CLASS z0103_cl_elephant IMPLEMENTATION.
  METHOD absorb_water.
    Trunk_Capacity += amount.

    IF Trunk_Capacity > 200.
      WRITE / 'Der Elephant hat mehr als 200 Liter und verwirft das restliche Wasser'.
      Trunk_Capacity = 200.
    ENDIF.
  ENDMETHOD.

  METHOD splash_water.
    WRITE / 'Der Elephant spritzt die Person mit Wasser an'.

    IF Trunk_Capacity > 75.
      WRITE / 'Die Wassermenge ist so groß, dass die Person angepisst ist'.

      person->is_pissed = abap_true.
      RETURN.
    ENDIF.

    WRITE / 'Die Wassermenge ist zu gering um die Person anzupissen'.
  ENDMETHOD.

  METHOD stamp.
    IF force > 50 AND is_hungry = abap_true.
      WRITE 'Stampf'.
    ENDIF.

  ENDMETHOD.

  METHOD swap_tail.
    WRITE 'Elephant wedelt mit seinem Schwanz um die Person'.
    IF force > 30.
      person->is_pissed = abap_true.
    ENDIF.
  ENDMETHOD.

  METHOD constructor.
    super->constructor(
      name              = name
      gender            = gender
      color             = color
      blood_temperature = blood_temperature
    ).

    me->Force = force.
    me->trunk_capacity = trunk_capacity.

    WRITE: / |Elephant { me->name } is born!|.
  ENDMETHOD.

ENDCLASS.
