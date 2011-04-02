
randomNum := Random value(0,100) round
tries := 10
guess := -1
oldGuess := -1

write("Guess a number (hint: ", randomNum, ")\n\n")

while(tries > 0 and guess != randomNum,
    write("you have still ", tries, " attempts\n")

    line := File standardInput readLine("your guess: ")
    guess := line asNumber

    (guess != randomNum) ifTrue(
        if((randomNum - oldGuess) abs > (randomNum - guess) abs,
            write("hotter\n"),
            write("colder\n"))
    )
    oldGuess = guess

    tries = tries - 1
    "" println
)

if(guess == randomNum,
    write("You got it"),
    write("The number was ", randomNum))
