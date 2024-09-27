#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"
$($PSQL "TRUNCATE TABLE users, games, usergames")
# Generate a random number between 1 and 1000
RANDOM_NUMBER=$((RANDOM % 1001))

# Returns name and user_id
GET_USER() {
  echo -e "$($PSQL "SELECT name, user_id FROM users WHERE name=$'$1'")"
}

# Returns number of games a user has played
GET_GAMES_PLAYED() {
  echo -e "$($PSQL "SELECT count(*) AS num_games FROM usergames WHERE user_id=$1 GROUP BY user_id ")"
}

# Returns the least number of guess a user has used in a game
GET_BEST_GAME() {
  echo -e "$($PSQL "SELECT MIN(guesses) FROM usergames WHERE user_id=$1 ")"
}

# Returns the least number of guess a user has used in a game
GET_GAME_INFO() {
  echo "$1" | while read USERNAME BAR USER_ID
  do
    GAMES_PLAYED=$(GET_GAMES_PLAYED $USER_ID)
    BEST_GAME=$(GET_BEST_GAME $USER_ID)
    echo -e "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
  done
}

# Returns a userinput that is an int
GET_USERINPUT_INT() {
    while :
    do
        READ GUESS
        echo "That is not an integer, guess again:"
        if [[ ! $GUESS =~ ^[0-9]+$ ]]; 
        then
            break
        fi
    done
    echo $GUESS
}

#Returns user id
GET_USER_ID() {
  GET_USER_ID_RESULT=$($PSQL "SELECT user_id FROM users WHERE name='$1'")
  ceho -e "$GET_USER_ID_RESULT"
}

#Returns 
GET_GAME_ID() {
  SELECT_GAME_ID_RESULT=$($PSQL "SELECT game_id FROM games ORDER BY game_id DESC LIMIT 1")
  echo -e "$SELECT_GAME_ID_RESULT"
}

INSERT_NEW_USER() {
  INSERT_USER_RESULT=$($PSQL "INSERT INTO users(name) VALUES('$1')")
  if [[ -z $INSERT_USER_RESULT ]]
  then
    exit
  fi
}

INSERT_NEW_GAME() {
  INSERT_GAME_RESULT=$($PSQL "INSERT INTO games(secret_number) VALUES($1)")
  if [[ -z $INSERT_GAME_RESULT ]]
  then
    exit
  fi
}

INSERT_NEW_USERGAME() {
  INSERT_USERGAME_RESULT=$($PSQL "INSERT INTO games(game_id, user_id, guesses) VALUES($GAME_ID, $1, $2)")
}


# The main game loop
GUESSING_GAME_LOOP() {
    USER_ID=$1
    GAME_ID=$( GET_GAME_ID )
    echo Guess the secret number between 1 and 1000:
    GUESSED_NUMBER=-1
    NUMBER_GUESSES=0
    while [[ $GUESSED_NUMBER != $RANDOM_NUMBER ]]
    do
        if [[ $NUMBER_GUESSES != 0 && $GUESSED_NUMBER < $RANDOM_NUMBER ]]
        then
            echo "It's lower than that, guess again:"
        elif [[ $NUMBER_GUESSES != 0 && $GUESSED_NUMBER > $RANDOM_NUMBER ]]
        then
            echo "It's higher than that, guess again:"
        fi
        GUESSED_NUMBER=$(GET_USERINPUT_INT)
        NUMBER_GUESSES=$(($NUMBER_GUESSES + 1))
    done
    echo "You guessed it in $NUMBER_GUESSES tries. The secret number was $RANDOM_NUMBER. Nice job!"
    INSERT_NEW_USERGAME $USER_ID
}

MAIN() {
    echo "Enter your username:"
    read USERNAME
    INSERT_NEW_GAME $RANDOM_NUMBER
    GET_USER_RESULT=$(GET_USER "$USERNAME")
    echo $GET_USER_RESULT
    if [[ -z $GET_USER_RESULT ]] 
    then
        INSERT_NEW_USER "$USERNAME"
        GUESSING_GAME_LOOP "$USERNAME"
    else
        GET_GAME_INFO "$GET_USER_RESULT"
        GUESSING_GAME_LOOP $USER_ID
    fi

}

MAIN