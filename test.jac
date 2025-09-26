import random;

walker TodoManager{
    has threshold: int;
    
    can start with `root entry;
    can process_task with turn entry;
}
node turn{
    has priority: int = random.randint(1, 10);

}
with entry: __main__{
    root spawn TodoManager(3);
    root spawn TodoManager(4);
    root spawn TodoManager(5);
    root spawn TodoManager(6);
}
impl TodoManager.start {
    if not [root -->(`?turn)]{
        #create a turn node and connect it to root
        next = root ++> turn(random.randint(1,10));
    }else{
        next = [root --> (`?turn)];
    }
    visit next;
}
impl TodoManager.process_task {
    if [-->]{
        visit [-->];
    }else{
        if self.threshold < here.priority{
            print("High priority task - handle now!");
            disengage;
        }elif self.threshold > here.priority{
            print("Low priority task - defer!");
            here ++> turn(random.randint(1,10));
        }else {
            print("Medium priority task - schedule exactly.");
            disengage;
        }
    }
}