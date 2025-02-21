
class Temp{
  

void SomeMethod(){
// This code is intentionally bad to demonstrate poor coding practices.

int x= 10; // No space around operators

String message = "Hello" ; // Extra space

// Inconsistent indentation
if (x > 5) {
  print("x is greater than 5");
}
else{
print("x is not greater than 5");} // Inconsistent brace placement

// Bad variable name
int a1b2c3d = 20;

// No comments explaining what the code does
int calculateSum(int num1, int num2){
return num1+num2;
}

// Unnecessary use of var
var result = calculateSum(x, a1b2c3d);

// Missing type annotations
addNumbers(n1, n2) {
  return n1 + n2;
}

// Long lines of code
String veryLongString = "This is a very long string that stretches across multiple lines and should ideally be broken down for better readability.";

// Mixed case for function name
void my_Function(){
  print("This is a function");
}

// No final or const where appropriate
String name = "John";
name = "Jane"; // name should be final if it's not going to change

// Using print for debugging instead of a proper logging mechanism
print("The result is: $result");

// Ignoring potential null values
String? nullableString;
// print(nullableString.length); // This will crash if nullableString is null

// No error handling
int divide(int a, int b) {
  return a ~/ b; // What if b is 0?
}

// Unnecessary else statement
bool isEven(int number) {
  if (number % 2 == 0) {
    return true;
  } else {
    return false;
  }
}

// Nested if statements leading to callback hell
void complexFunction() {
  if (x > 0) {
    if (a1b2c3d < 30) {
      if (calculateSum(x, a1b2c3d) > 25) {
        print("Complex condition met!");
      }
    }
  }
}
}
}
