with entry {
    student_name:str ="Alice";
    grade:int = 95;
    gpa:float = 3.8;
    is_honor_student: bool = True;
}

# variables
#local variables
def add_numbers(a: int, b: int) ->{
    result: int = a + b;
    return result;
}
with entry {
    sum = add_numbers(5, 10);
    print(f"Sum:{sum}");
}

#glabale variables
glob school_name:str = "Jac High School";
glob passing_grade: int = 60;
glob honor_threshold: float = 3.5;

def get_school_info() -> str{
    :g: school_name;
    return f"Welcome to {school_name}";
    
}
with entry{
    print (get_school_info());
    print (f"Honour threshold is {honor_threshold}");
}