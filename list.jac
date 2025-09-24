with entry {
    #Create an empty list for storing integer grades

    alice_grades: list[int] =[];

    #append grades to the list
    alice_grades.append(88);
    alice_grades.append(92);
    alice_grades.append(85);

    #access grades
    first_grade: int = alice_grades[0];
    print(f"Alice's first grade: {first_grade}");

    # print the entire list of grades
    print(f"Alice's grades: {alice_grades}");
}