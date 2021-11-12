/*
Fizz Buzz is described as follows:

Write a short program that displays each number from 1 to 100.
For each multiple of 3, display "Fizz" instead of the number.
For each multiple of 5, display "Buzz" instead of the number.
For numbers which are multiples of both 3 and 5, display "FizzBuzz" instead of the number.
*/

//Start and End Values
let startValue=1;
let endValue=100;

//Print out all numbers

function DefineFizzBuzz(number){
	let result="";
	
	switch(number){
		case number%3===0 && number%5===0:
			result="FizzBuzz";
			break;
		case number%3===0:
			result="Fizz";
			break;
		case number%3===0 && number%5===0:
			result="Buzz";
			break;
		default:
			result="Nothing";
	}
	
	return result;
}
