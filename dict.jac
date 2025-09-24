with entry {
    math_grades:dict[str, int] ={
        "Alice":92,
        "Bob":85,
        "Charlie":78
    };
    #access the grades by student name
    print(f"Alice's Math grade: {math_grades['Alice']}");
    print(f"Bob's Math grade: {math_grades['Bob']}");
    print(f"Charlie's Math grade: {math_grades['Charlie']}");
}