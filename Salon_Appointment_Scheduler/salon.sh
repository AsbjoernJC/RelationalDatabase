#! /bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"
SERVICES=$($PSQL "SELECT service_id, name FROM services")
LIST_SERVICES() {
  echo "$SERVICES" | while read SERVICE_ID BAR SERVICE_NAME
  do
    echo "$SERVICE_ID) $SERVICE_NAME"
  done
  FIND_SERVICE
}

FIND_SERVICE() {
  read SERVICE_ID_SELECTED
  SERVICE_ID_RESULT=$($PSQL "SELECT service_id FROM services WHERE service_id=$SERVICE_ID_SELECTED")
  SERVICE_NAME_RESULT=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")
  if [[ -z $SERVICE_ID_RESULT ]]
  then
    echo -e "\nI could not find that service. What would you like today?"
    LIST_SERVICES
  else
    CREATE_APPOINTMENT "$SERVICE_ID_RESULT" "$SERVICE_NAME_RESULT" 
  fi

}

USER_INPUT_IS_NUMBER() {
  if [[ ! $1 =~ ^[0-9]+$ ]]
  then
    echo "Enter a number that is listed in the services!"
    FIND_SERVICE
  fi
}

CREATE_APPOINTMENT(){
  SERVICE_ID=$1
  SERVICE_NAME=$2
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE
  CUSTOMER_ID=$(GET_CUSTOMER_ID "$CUSTOMER_PHONE") 
  if [[ -z $CUSTOMER_ID ]]
  then
    echo -e "\nI don't have a record for that phone number, what's your name?"
    read CUSTOMER_NAME

    echo -e "\nWhat time would you like your$SERVICE_NAME, $CUSTOMER_NAME?"
    read SERVICE_TIME
    CUSTOMER_ID=$(INSERT_CUSTOMER "$CUSTOMER_PHONE" "$CUSTOMER_NAME")
  else
    CUSTOMER_NAME=$(GET_CUSTOMER_NAME "$CUSTOMER_ID") 
    echo -e "\nWhat time would you like your $SERVICE_NAME, $CUSTOMER_NAME?"
    read SERVICE_TIME
  fi

  INSERT_APPOINTMENT "$CUSTOMER_ID" "$SERVICE_ID" "$SERVICE_TIME"

  SUCCESFULLY_CREATED_APPOINTMENT "$SERVICE_NAME" "$SERVICE_TIME" "$CUSTOMER_NAME"
}

SUCCESFULLY_CREATED_APPOINTMENT(){ 
  echo -e "\nI have put you down for a $1 at $2, $3."
}

GET_CUSTOMER_ID(){
  echo -e "$($PSQL "SELECT customer_ID FROM customers WHERE phone='$CUSTOMER_PHONE' ")"
}

GET_CUSTOMER_NAME(){
  CUSTOMER_ID=$1
  echo -e $($PSQL "SELECT name FROM customers WHERE customer_id = $CUSTOMER_ID")

}

INSERT_CUSTOMER(){
  CUSTOMER_PHONE=$1
  CUSTOMER_NAME=$2
  INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")  
  echo -e $(GET_CUSTOMER_ID "$1")
}

INSERT_APPOINTMENT(){
  CUSTOMER_ID=$1
  SERVICE_ID=$2
  SERVICE_TIME=$3
  INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID, '$SERVICE_TIME')")
}




echo -e "\n~~~~~ MY SALON ~~~~~\n"
echo -e "Welcome to My Salon, how can I help you?\n"
LIST_SERVICES
