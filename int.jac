#int
with entry {
    student_id: int = 12345;
    print(student_id);
}
#float
with entry {
    gpa: float = 3.5;
    print(gpa);
}
#strings
with entry {
    student_name: str ="Alice Johnson";
    print(f"Student Name: {student_name}");
}

#boolean
with entry{
    is_enrolled: bool =True;
    print(f"Is enrolled: {is_enrolled}");
}

# any type for flebility
with entry {
    grade_date: any = 95;
    print(f"Grade as  number:{grade_date}");

    grade_data = "A";
    print(f"Grade as letter: {grade_data}");
}