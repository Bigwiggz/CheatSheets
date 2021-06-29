



/*
FETCH API
See this website for more information
https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API/Using_Fetch
*/

/////////////////////////////////
//Fetch Options
/////////////////////////////////
fetch( url,{
	method: 'POST', // *GET, POST, PUT, DELETE, etc.
	mode: 'cors', // no-cors, *cors, same-origin
    cache: 'no-cache', // *default, no-cache, reload, force-cache, only-if-cached
    credentials: 'same-origin', // include, *same-origin, omit
    headers: {
      'Content-Type': 'application/json'
      // 'Content-Type': 'application/x-www-form-urlencoded',
	  'Authorization': Bearer {token},
    },
    redirect: 'follow', // manual, *follow, error
    referrerPolicy: 'no-referrer', // no-referrer, *no-referrer-when-downgrade, origin, origin-when-cross-origin, same-origin, strict-origin, strict-origin-when-cross-origin, unsafe-url
    body: JSON.stringify(data) // body data type must match "Content-Type" header
	credentials: 'same-origin' //If you only want to send credentials if the request URL is on the same origin as the calling script
});


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
let userId;

fetch(...)
	.then(response=>response.text())
	.then(id=>{
		userId=id;
		console.log(userId)
	});
	
//3) Getting JSON data
let dataObj;

fetch(...)
	.then(response=>response.json())
	.then(data=>{
		dataObj=data;
		console.log(dataObj)
	});



