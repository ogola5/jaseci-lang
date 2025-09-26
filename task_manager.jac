import random;

# Walker that plays a rock-paper-scissors round
walker RPSGame {
    has player_choice: str;     # "rock", "paper", or "scissors"
    
    can start with `root entry;
    can evaluate with round entry;
}

# Node representing a single round
node round {
    has computer_choice: str = random.choice(["rock", "paper", "scissors"]);
}

# Entry point
with entry: __main__ {
    root spawn RPSGame("rock");
    root spawn RPSGame("paper");
    root spawn RPSGame("scissors");
}

impl RPSGame.start {
    if not [root -->(`?round)] {
        # create a round node and connect it to root
        next = root ++> round(random.choice(["rock", "paper", "scissors"]));
    } else {
        next = [root --> (`?round)];
    }
    visit next;
}

impl RPSGame.evaluate {
    if [-->] {
        visit [-->];
    } else {
        let cpu = here.computer_choice;
        let player = self.player_choice;
        print("Player: " + player + " | Computer: " + cpu);

        if player == cpu {
            print("It's a tie!");
        } elif (player == "rock" and cpu == "scissors") or
              (player == "paper" and cpu == "rock") or
              (player == "scissors" and cpu == "paper") {
            print("You win!");
        } else {
            print("Computer wins!");
        }
        disengage;
    }
}
