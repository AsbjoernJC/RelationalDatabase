#! /bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"
LIST_SERVICES() {
  echo "$1" | while read SERVICE_ID BAR SERVICE_NAME
  do
    echo "$SERVICE_ID) $SERVICE_NAME"
  done
}

FIND_SERVICE() {
  read SERVICE_ID_SELECTED
  SERVICE_ID_RESULT=$($PSQL "SELECT * FROM services WHERE service_id=$SERVICE_ID_SELECTED")
  if [[ -z $SERVICE_ID_RESULT ]]
  then
    echo -e "\nI could not find that service. What would you like today?"
    LIST_SERVICES
  else
    CREATE_APPOINTMENT
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
  echo -e "\nWhat's your phone number?"
}




echo -e "\n~~~~~ MY SALON ~~~~~\n"
echo -e "Welcome to My Salon, how can I help you?\n"
SERVICES=$($PSQL "SELECT service_id, name FROM services")
LIST_SERVICES "$SERVICES"
