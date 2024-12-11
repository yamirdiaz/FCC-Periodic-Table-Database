#!/bin/bash
#Creating PSQL query variable
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

#Creating function 
ELEMENT_SEARCH() {
  if [[ -z $1 ]]
  then 
    echo Please provide an element as an argument.
  else
    #if the argument is a INT
    if [[ $1 =~ ^[0-9]+$ ]]
    then
      SEARCH_ARGUMENT_INT_RESULT=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements LEFT JOIN properties USING(atomic_number) LEFT JOIN types USING(type_id) WHERE atomic_number=$1")
      #if element does not exist
      if [[ -z $SEARCH_ARGUMENT_INT_RESULT ]]
      then
        echo I could not find that element in the database.
      else 
        echo $SEARCH_ARGUMENT_INT_RESULT | while IFS='|' read ATOMIC_NUMBER NAME SYMBOL TYPE ATOMIC_MASS MELTING_POINT BOILING_POINT
        do
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
        done
      fi
    #if the argument is not a INT
    else
      SEARCH_ARGUMENT_INT_RESULT=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements LEFT JOIN properties USING(atomic_number) LEFT JOIN types USING(type_id) WHERE name='$1' or symbol='$1'")
      #if element does not exist
      if [[ -z $SEARCH_ARGUMENT_INT_RESULT ]]
      then
        echo I could not find that element in the database.
      else 
        echo $SEARCH_ARGUMENT_INT_RESULT | while IFS='|' read ATOMIC_NUMBER NAME SYMBOL TYPE ATOMIC_MASS MELTING_POINT BOILING_POINT
        do
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
        done
      fi
    fi
  fi
}


ELEMENT_SEARCH $1
