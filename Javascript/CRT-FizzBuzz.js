//Javascript FizzBuzz

//Event Listener
let runProgramButton=document.getElementById("");
runProgramButton.addEventListener("click", RunFizzBuzz);

//Main Function
function RunFizzBuzz(){
	
	//Start and End Values
	let startValue=1;
	let endValue=100;
	
	//Print out Fizz Buzz Table
	PrintOutNumbersToScreen(startValue, endValue);
}


//Print out all numbers to screen
function PrintOutNumbersToScreen(startValue,endValue){
	
	let completeTableText="";
	
	//Each Table Row loop
	for(let y=1; y<=5;y++){
		
		let insertedRowText=`<tr>`;
		//Add each individual value
		for(let i=startValue; i<endValue;i++){
			let fizzBuzzValue=DefineFizzBuzz(i);
			insertedRowText+=`<td class=${fizzBuzzValue}>${fizzBuzzValue}</td>`;
		}
		insertedRowText+=`</tr>`;
		completeTableText+=insertedRowText;
	}

}

//Function to determine Fizz or Buzz
function DefineFizzBuzz(number){
	let result="";
	switch(number){
		case number%3===0 && number%5===0:
			result="FizzBuzz";
			break;
		case number%3===0:
			result="-Fizz";
			break;
		case number%3===0 && number%5===0:
			result="-Buzz";
			break;
		default:
			result=number;
	}
	
	return result;
}
