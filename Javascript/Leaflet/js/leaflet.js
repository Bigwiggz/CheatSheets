/*
Leaflet Javascript File
*/



///////////////////////////////////////////
//Create Map with coordinates
///////////////////////////////////////////
let map = L.map('map').setView([33.996166, -81.031456], 13);

///////////////////////////////////////////
//Create Global Variables
///////////////////////////////////////////

//Used to display variables
let mapMarkerList=[];
let mapPolygonList=[];

//used to filter list on input
let filteredMarkerList=[];
let filteredPolygonList=[];



///////////////////////////////////////////
//Add Map Layers
///////////////////////////////////////////

let osm=L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
})

let googleStreets = L.tileLayer('http://{s}.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',{
    maxZoom: 20,
    subdomains:['mt0','mt1','mt2','mt3']
});

let googleHybrid = L.tileLayer('http://{s}.google.com/vt/lyrs=s,h&x={x}&y={y}&z={z}',{
    maxZoom: 20,
    subdomains:['mt0','mt1','mt2','mt3']
});

let googleSat = L.tileLayer('http://{s}.google.com/vt/lyrs=s&x={x}&y={y}&z={z}',{
    maxZoom: 20,
    subdomains:['mt0','mt1','mt2','mt3']
});

let googleTerrain = L.tileLayer('http://{s}.google.com/vt/lyrs=p&x={x}&y={y}&z={z}',{
    maxZoom: 20,
    subdomains:['mt0','mt1','mt2','mt3']
});

let smoothDark =  L.tileLayer('https://tiles.stadiamaps.com/tiles/alidade_smooth_dark/{z}/{x}/{y}{r}.png', {
	maxZoom: 20,
	attribution: '&copy; <a href="https://stadiamaps.com/">Stadia Maps</a>, &copy; <a href="https://openmaptiles.org/">OpenMapTiles</a> &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors'
});

let ThunderforestLandscape = L.tileLayer('https://{s}.tile.thunderforest.com/landscape/{z}/{x}/{y}.png?apikey={apikey}', {
	attribution: '&copy; <a href="http://www.thunderforest.com/">Thunderforest</a>, &copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
	apikey: '<your apikey>',
	maxZoom: 22
});



//import list of locations
filteredMarkerList=testMarkerLocations;
//import list of polygons
filteredPolygonList=testPolygonsList;


///////////////////////////////////////////
//Add Marker List
///////////////////////////////////////////
let myIcon=L.icon({
	iconUrl:'./img/wrench.png',
	iconSize:[20, 20]
});

for(let i=0;i< filteredMarkerList.length; i++){
	let singleMarker=L.marker([filteredMarkerList[i].Latitude,filteredMarkerList[i].Longitude],{
		title:filteredMarkerList[i].BusinessName,
		icon: myIcon
	});
	
	let popup=singleMarker.bindPopup(`${filteredMarkerList[i].FullAddress}`).openPopup();

	mapMarkerList.push(singleMarker);
};

///////////////////////////////////////////
//Add Polygon List
///////////////////////////////////////////
let geoPolygons=L.geoJSON(filteredPolygonList,{
	style:function(feature){
		return{
			color: `#${feature.properties.TerritoryTypeColor}`,
			fillColor: `#${feature.properties.TerritoryTypeColor}`,
			fill:true,
			fillOpacity: 0.2
		}
	},
	onEachFeature:function(feature, layer){
		layer.bindPopup(feature.properties.name);
		//Add On Click Event
	}
});


///////////////////////////////////////////
//Create Layer Groups
///////////////////////////////////////////
let mapMarkerGroup=L.layerGroup(mapMarkerList);



///////////////////////////////////////////
//Add Map Layer Controller
///////////////////////////////////////////

//Base Maps to Layer
let baseMaps={
	"OSM": osm,
	"Google Streets": googleStreets,
	"Google Satelite":googleSat,
	"Google Hybrid":googleHybrid,
	"Dark Map": smoothDark,
	"BlueLandscape": ThunderforestLandscape
};

//Shapes to Layer
let overlayMaps={
	"Markers": mapMarkerGroup,
	"Polygons": geoPolygons
};

L.control.layers(baseMaps,overlayMaps).addTo(map);


osm.addTo(map);

