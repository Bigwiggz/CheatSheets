// Rewind Javascript

//Call function
let runRewind=document.getElementById("btnSubmit");
runRewind.addEventListener("click", StartRewind);

//Main Function
function StartRewind(){
	
	//Get input values
	let inputText=document.getElementById("inputText").value;

	//Validate text entry to assure there is at least 1 character
	if(inputText.length===0){
		errorMessage="Please put in at least one character.";
		let errorMessageDisplay=document.getElementById("validation-summary");
		errorMessageDisplay.innerHTML=errorMessage;
	}
	
	//Call Reverse String function
	let reveresedString=GetReverseString(inputText);
	
	//Place on screen
	ResultToScreen(reveresedString);
}

// function to reverse string
function GetReverseString(inputText){
	let reversedString=[];
	for(let i=inputText.length-1;i>=0 ;i--){
		reversedString.push(inputText[i]);
	}
	
	return reversedString;
}

//Place result to screen
function ResultToScreen(outputText){
	let outputField=document.getElementById("outputTextField");
	outputField.innerHTML=outputText;
}
