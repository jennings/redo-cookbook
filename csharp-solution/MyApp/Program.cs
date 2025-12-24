using MyLibrary;

var greeter = new Greeter();
Console.WriteLine(greeter.GetGreeting("World"));

var calculator = new Calculator();
Console.WriteLine($"2 + 3 = {calculator.Add(2, 3)}");
Console.WriteLine($"4 * 5 = {calculator.Multiply(4, 5)}");
