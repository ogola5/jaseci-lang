obj Student {
    has name: str;
    has age: int;
    has gpa: float;

    def  get_info() -> str{
        return f"Name: {self.name}, Age: {self.age}, GPA: {self.gpa}";
    }
}
with entry {
    student: Student = Student("Alice", 20, 3.8);
    print(student.get_info());
}