def add(a: float, b: float) -> float {
    return a + b;
}
def subtract(a: float, b: float) -> float {
    return a - b;
}
def multiply (a: float, b: float) -> float{
    return  a * b;
}
def divide(a: float, b: float) -> float  |str{
    #we check if b is zero before divinding
    if b==0.0{
        return "Error: Cannot divide by zero!";
    }
    # if b is non
    return  a / b;
}
with entry {
    print ("=== simple calculator ===");

    #test calculations
    num1: float = 10.0;
    num2: float = 3.0;

    print(f"{num1} + {num2} ={add(num1, num2)}");
    print(f"{num1} - {num2} ={subtract(num1, num2)}");
    print(f"{num1} * {num2} ={multiply(num1, num2)}");
    print(f"{num1} / {num2} ={divide(num1, num2)}");
}