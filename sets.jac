with entry{
    alice_courses: set[str] = {"Math", "Science", "History"};
    bob_courses: set[str] = {"Math", "Art", "Physical Education"};

    #find shared course
    shared_courses = alice_courses.intersection(bob_courses);
    print(f"Shared courses: {shared_courses}");

    #All unique courses
    all_courses = alice_courses.union(bob_courses);
    print(f"All courses: {all_courses}");
}

with entry{
    #raw test scores
    test_scores: list[int] = [78,85,92,69,69,95,72];

    #Get passing grades (70 and above)

    passing_scores: list[int] = [score for score in test_scores if score >=70];
    print (f"Passing scores: {passing_scores}");
    
    #create  a new list where each score is a 5 points higher
    curved_scores: list[int] = [score + 5 for score in test_scores];
    print (f"Curved scores:{curved_scores}");
}

