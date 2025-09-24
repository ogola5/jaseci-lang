import random;

walker GuessGame{
    has guess: int;
    
    can start with `root entry;
    can process_guess with turn entry;
}
node turn{
    has correct_number: int = random.randint(1, 10);

}
with entry: __main__{
    root spawn GuessGame(3);
    root spawn GuessGame(4);
    root spawn GuessGame(5);
    root spawn GuessGame(6);
}
impl GuessGame.start {
    if not [root -->(`?turn)]{
        #create a turn node and connect it to root
        next = root ++> turn(random.randint(1,10));
    }else{
        next = [root --> (`?turn)];
    }
    visit next;
}
impl GuessGame.process_guess {
    if [-->]{
        visit [-->];
    }else{
        if self.guess < here.correct_number{
            print("too low!");
            here ++> turn(random.randint(1,10));
        }elif self.guess > here.correct_number{
            print("Too high!");
            here ++> turn(random.randint(1,10));
        }else {
            print("Congratulations! You guessed correctly.");
            disengage;
        }
    }
}