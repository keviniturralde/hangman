# Hangman


README:
INTRO:

    - The Hangman App is an interactive app, which allows a user to play around with a lot of different features. They will save profiles and games associated with each user so they can track their progress. You’re also able to track the progress of other players who have and rise through the ranks of the leaderboard! Users will be able to play the game Hangman and learn new words in the process. Players can choose from 3 difficulty levels, easy, medium, and hard to accumulate wins! 

TO START: 
    - Please fork and clone the game repo
    - Bundle install 
    - Ensure you have a Webster API key. Please create an ENV file and save the API key within the ENV file. 
    - User interface is stored within cli.rb 
    - RUN ruby bin/play_hangman.rb


HOW IT WORKS: 
- Intro Screen - Hangman Game! - (ARTII gem implementation & maybe patorjk for a fun hangman screen)
    - Prompt user with a menu
        - Prompt user to Play A Game, check out the leader board, or Exit  (tty prompt/colorize  gem implementation,)
            -To play a game, a User will need to sign up or log in 
                - A new User will be created once user has signed up
                - If a user is logging in, the program will recognize if the username and password exists, if not the user will be rerouted to sign up or log in.
                    - *Once user is successfully logged in or signed up, program will recognize which user is currently playing the game*
                        - User will then be prompted to choose a difficult level 
                        - Once difficulty level is choose a new Game & UserGame instance will be created 
        - If a User chooses to Check the Leader Board 
            - A table will be outputted with the current top 3 Users' Username and Score based on data in Active Record
            - A User can then choose to Check Individual User Stats or Return to the Main Menu 
                - If a User chooses to Check User Stats, they will be prompted to a list of all the Users
                    - Once a User is choosen, a table will be outputted referencing all the User's Games data from ActiveRecord. Displaying each Game ID, difficulty of the game, the word, and if the game was won. 
                    - The User can then choose to return to the User Stat's menu, The Leader Board or Main Menu. 
    * GAME SPECIFICS *
    - The Game will choose a word at random based on difficulty level (from https://github.com/dwyl/english-words)
        - Easy: 3 - 5 letter word 
        - Medium: 6 - 9 letter word 
        - Hard: 10 - 13 letter word
    - The Game will generate a hint by making a call to the Merriam Webster Dictionary API and pulling the definition of the word selected or the closest possible definition (https://dictionaryapi.com/)
    - A User will have 6 guesses per game 
    - If a wrong guess is inputted, the remaining guesses will decrease
    - If a correct answer is inputted, the letter will be included to the display
    - The Game will continue until there are 0 guesses remaining or if the word is completed before the guesses hit zero
    - The User will have the option to play another game, return to the main menu or exit the game


RESOURCES:

https://github.com/piotrmurach/tty
https://dictionaryapi.com/ ( You are going to need a webster API Key, create a file in the home folder calle '.env' and be sure to use the Collegiate level Dictionary API) 


```WEBSTER-KEY=<key goes here>```

ASCII Art Generator 
https://github.com/dwyl/english-words/blob/master/words_dictionary.json (word file)

CONTRIBUTORS :

Jacqueline Lo, Bryan Moon, and Kevin Iturralde 
