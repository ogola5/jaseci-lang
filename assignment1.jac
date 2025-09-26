import random;

walker TaskManager{
    has task_name: str;
    
    can start_task with `root entry;
    can update_status with task_status entry; 
}

node task_status{
    has status: str = "Pending";
    has task_id: int = random.randint(100, 999); 
}

with entry: __main__{
    # Spawning multiple walkers mirrors the 'GuessGame' example structure
    root spawn TaskManager(task_name="Write Report");
    root spawn TaskManager(task_name="Code Review");
    root spawn TaskManager(task_name="Plan Meeting");
}

impl TaskManager.start_task {
    # Check if any task_status node is connected to the root
    if not [root -->(`?task_status)]{
        # If none exist, create the first one
        next = root ++> task_status();
        print(f"New task_status node created for: {self.task_name}");
    }else{
        # If nodes exist, retrieve the list of existing nodes
        next = [root --> (`?task_status)];
        # FIX: Use the standard len() function to get the list size (resolved syntax error)
        print(f"Found {len(next)} existing task nodes."); 
    }
    # Visit the task_status node(s) to transition to the update_status block
    visit next;
}

impl TaskManager.update_status {
    # Mirror: Use 'if [-->]' to check for the parent walker context (root or another task)
    if [-->]{
        visit [-->];
    }else{
        # 'here' is the current task_status node being visited
        if here.status == "Pending"{
            print(f"Task ID {here.task_id} updated to 'In Progress'.");
            here.status = "In Progress";
            # Mirror: Create a new node connected to 'here'
            here ++> task_status(status="In Progress Log"); 
        }elif here.status == "In Progress"{
            print(f"Task ID {here.task_id} updated to 'Completed'.");
            here.status = "Completed";
            # Mirror: Create a new node
            here ++> task_status(status="Completed Log");
        }else {
            print(f"Task ID {here.task_id} is already completed.");
            # Mirror: Disengage to stop the walker
            disengage;
        }
    }
}