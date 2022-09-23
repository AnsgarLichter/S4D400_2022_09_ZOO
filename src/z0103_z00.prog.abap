*&---------------------------------------------------------------------*
*& Report z0103_z00
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z0103_z00.

WRITE: / |WELCOME TO ZOO @DUMMSCHWAETZER9|,
/ |HERE YOU CAN FIND ONLY THE GREATES ATTRACTIONS|,
/ |HERE ARE SOME OF OUR NEWLY BORN|.

data(elephant) = NEW Z0103_CL_ELEPHANT(
            force = 10
            trunk_capacity = 150
            blood_temperature = 1000
            name = |Dagobert Duck|
            gender = |M|
            color = |Purple| ).

data(person) = NEW Z0103_CL_PERSON(
    name = 'Julian Assmann'
    ITEMS = VALUE #( ( |Uhr| ) ( |Sonnenbrille| ) )
 ).

data(shark) = NEW Z0103_CL_SHARK(
        vegetarian = abap_false
        depth = 100
        name = |THE GREAT WHITE SHARK|
        gender =   |W|
        color  = |red|
        teeth = -234
 ).

 data(dove) = NEW Z0103_CL_DOVE(
    name = |BENJAMIN BLÜMCHEN|
    color = |OFF WHITE|
    volume = 99
    height = 923402
    span = 33
    gender = 'W'
 ).

 data(magpie) = NEW Z0103_CL_MAGPIE(
    name   = |ALBER ALBATROS|
    gender = |W|
    color  = |blue|
 ).

 WRITE: / |{ person->name } goes to the elephant { elephant->name }|.
 elephant->splash_water( person ).
 WRITE person->curse(  ).
 WRITE: / |{ person->name } now goes forward to the shark|.
 shark->bite( person ).
 WRITE person->curse(  ).
 WRITE: / |{ person->name } now goes forward to the dove|.
 dove->shit( person ).
 WRITE person->curse(  ).
