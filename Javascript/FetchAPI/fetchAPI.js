



/*
FETCH API
*/

/////////////////////////////////
//Fetch Options
/////////////////////////////////



/////////////////////////////////
//Async/Await
/////////////////////////////////

//1) Checking Status Code

async function getData(){
	let response=await fetch(...);
	if(response.status==200){
		//all OK
	}
	else{
		console.log(response.statusText);
	}
}

//2) Getting a single value

async function getData(){
	let response=await fetch(...);
	let userId=await response.text();
	return userId;
	console.log(userId);
}

//3) Getting JSON data
async function getData(){
	let response=await fetch(...);
	let dataObj=await response.json();
	return dataObj;
	console.log(dataObj);
}

/////////////////////////////////
//Promises
/////////////////////////////////

//1) Checking Status Code
fetch(...)
	.then(response=>{
		if(response.status==200){
			//all OK
		}
		else{
			console.log(response.statusText);
		}
	});
	
//2) Getting a single value
fetch(...)
	.then(response=>{
		if(response.status==200){
			//all OK
		}
		else{
			console.log(response.statusText);
		}
	});
	
//3) Getting JSON data
fetch(...)
	.then(response=>{
		if(response.status==200){
			//all OK
		}
		else{
			console.log(response.statusText);
		}
	});


