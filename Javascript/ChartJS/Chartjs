/*
ChartJS 3.3.2
*/



let chartTitle='Chart Example';
//getChartData();
showBarChart();
showLineChart();
showPieChart();
showBarAndLineChart()

//Main Function Calls
//ChartJS


let siteURLRequest="";
let myAmounts=[10,50,30,40,60];
let myCategories=["Utilities","Telephone","Services","Consultancy","Raw Materials"];
let myInvoices;

//////////////////////////////////////////
//BAR CHART
//////////////////////////////////////////

//Bar Chart
function showBarChart(){
	/*
	//Please remove
	myAmounts=myInvoices.AmountList;
	myCategories=myInvoices.CategoryList;
	*/
	
	//For Testing ONLY
	let myAmounts=[14,55,33,40,67,22];
	let myCategories=["Utilities","Telephone","Services","Consultancy","Raw Materials", "Other"];
	//
	console.log(myAmounts);
	console.log(myCategories);
	
	let popCanvasName=document.getElementById("barChart");
	let barChartName=new Chart(popCanvasName,{
		type: 'bar',
		data:{
			labels: myCategories,
			datasets:[{
				label: 'Invoice data',
				data: myAmounts,
				backgroundColor:[
				'rgba(255, 99, 132, 0.6)',
                'rgba(54, 162, 235, 0.6)',
				'rgba(255, 206, 86, 0.6)',
				'rgba(75, 192, 192, 0.6)',
				'rgba(153, 102, 255, 0.6)'
				]
			}]
		},
		options:{
			responsive: false,
			scales:{
				yAxes:[{
					ticks:{beginAtZero:true}
				}]
			},
			plugins:{
				title:{
				display: true,
				text: chartTitle,
				font:{
					size:20
				}
				}
			}
		}
	});
}



//////////////////////////////////////////
//LINE CHART
//////////////////////////////////////////


//Line Chart
function showLineChart(){
	let lineCanvasName=document.getElementById("lineChart");
	let lineChartName=new Chart(lineCanvasName,{
		type:'line',
		data:{
			labels:  ['January','February','March','April','May','June','July','August','September','October','November','December'],
			datasets:[
				{
				  label: 'Dataset 1',
				  data: [42,72,54,89,65,35,41,21,35,9,10,77],
				  borderColor: ['rgba(255, 99, 132, 0.6)'],
				  backgroundColor: ['rgba(255, 99, 132, 0.6)'],
				  fill: true
				},
				{
				  label: 'Dataset 2',
				  data: [89,55,23,44,77,66,99,22,41,56,21,23],
				  borderColor: ['rgba(54, 162, 235, 0.6)'],
				  backgroundColor: ['rgba(54, 162, 235, 0.6)'],
				  fill:true
				}
			]
		},
		options: {
			responsive: true,
			plugins: {
				  title: {
					display: true,
					text: (ctx) => 'Chart.js Line Chart - stacked=' + ctx.chart.options.scales.y.stacked
				  },
				  tooltip: {
					mode: 'index'
				  },
			},
			interaction: {
			  mode: 'nearest',
			  axis: 'x',
			  intersect: false
			},
			scales: {
			  x:{
					title: {
					  display: true,
					  text: 'Month'
					}
				},
			  y:{
					stacked: true,
					title: {
					  display: true,
					  text: 'Value'
					}
				}
			}
		}
	});
}

//////////////////////////////////////////
//PIE CHART
//////////////////////////////////////////

//Pie Chart
function showPieChart(){
	let pieCanvasName=document.getElementById('pieChart');
	let pieChartName=new Chart(pieCanvasName,{
		type:'pie',
		data:{
			labels:["Utilities","Telephone","Services","Consultancy","Raw Materials", "Other"],
			datasets:[
			{
				label:'Breakdown',
				data:[10,32,11,22,14,11],
				backgroundColor: [
				'rgba(255, 99, 132, 0.6)',
                'rgba(54, 162, 235, 0.6)',
				'rgba(255, 206, 86, 0.6)',
				'rgba(75, 192, 192, 0.6)',
				'rgba(153, 102, 255, 0.6)',
				'rgba(125, 125, 125, 0.6)'
				]
			}
			]
		},
		options: {
			responsive: true,
			plugins: {
			  legend: {
				position: 'top',
			  },
			  title: {
				display: true,
				text: 'Chart.js Pie Chart'
			  }
			}
		},
	});
}

//////////////////////////////////////////
//BAR AND LINE CHART
//////////////////////////////////////////

function showBarAndLineChart(){
	let barAndLineCanvasName=document.getElementById('barAndLineChart');
	let barAndLineChartName=new Chart(barAndLineCanvasName,{
		type:'line',
		data:{
			labels: ['January','February','March','April','May','June','July','August','September','October','November','December'],
			datasets:[
				{
				  label: 'Dataset 1',
				  data: [42,72,54,89,65,35,41,21,35,9,10,77],
				  borderColor: ['rgba(255, 99, 132, 0.6)'],
				  backgroundColor: ['rgba(255, 99, 132, 0.6)'],
				  stack:'combined',
				  type:'bar'
				},
				{
				  label: 'Dataset 2',
				  data: [89,55,23,44,77,66,99,22,41,56,21,23],
				  borderColor: ['rgba(54, 162, 235, 0.6)'],
				  backgroundColor: ['rgba(54, 162, 235, 0.6)'],
				  stack:'combined'
				}
			]
			
		},
		options:{
			plugins:{
				title:{
					display:true,
					text: 'Chart.js Stacked Line/Bar Chart'
				}
			},
			scales:{
				y:{
					stacked:true
				}
			}
		}
	});
}

//////////////////////////////////////////
//FETCH API
//////////////////////////////////////////

//Fetch API
function getChartData(){
	return fetch(siteURLRequest,
	{
		method:'get',
		headers:{'Content-Type':'application/json;charset=UTF-8'}
	})
	.then(function (response){
		if(response.OK){
			return response.text();
		}
		else{
			throw Error('Response Not OK');
		}
	})
	.then(function (text){
		try{
			return JSON.parse(text);
		}
		catch(err){
			throw Error('Method Not Found');
		}
	})
	.then(function(responseJSON){
		myInvoices=responseJSON;
		showBarChart();
	})
}


<!DOCTYPE html>
<html lang="en-US">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Today's Date</title>
</head>

<body>
<div class="barChart">
	<canvas id="barChart" width="1000" height="600">
		 <p>Sorry, The Chart could not load properly.</p>
	</canvas>
</div>
<br>
<div class="lineChart">
	<canvas id="lineChart" width="250" height="150">
		 <p>Sorry, The Chart could not load properly.</p>
	</canvas>
</div>
<br>
<div class="pieChart">
	<canvas id="pieChart" width="500" height="300">
		<p>Sorry, The Chart could not load properly.</p>
	</canvas>
</div>
<br>
<div class="barAndLineChart">
	<canvas id="barAndLineChart" width="500" height="300">
		<p>Sorry, The Chart could not load properly.</p>
	</canvas>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.3.2/chart.min.js" integrity="sha512-VCHVc5miKoln972iJPvkQrUYYq7XpxXzvqNfiul1H4aZDwGBGC0lq373KNleaB2LpnC2a/iNfE5zoRYmB4TRDQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="Chartjs.js"></script>
</body>

</html>


