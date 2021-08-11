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

let greyblank= L.tileLayer('https://server.arcgisonline.com/ArcGIS/rest/services/Canvas/World_Light_Gray_Base/MapServer/tile/{z}/{y}/{x}', {
	attribution: 'Tiles &copy; Esri &mdash; Esri, DeLorme, NAVTEQ',
	maxZoom: 16
});

let blockMap= L.tileLayer('https://server.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer/tile/{z}/{y}/{x}', {
	attribution: 'Tiles &copy; Esri &mdash; Source: Esri, DeLorme, NAVTEQ, USGS, Intermap, iPC, NRCAN, Esri Japan, METI, Esri China (Hong Kong), Esri (Thailand), TomTom, 2012'
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
		//layer.bindPopup(feature.properties.name);
		layer.on('click',function(){
			let polygonID=feature.properties.name;
			LoadTerritoryInformation(polygonID);
		});
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
	"Block Map": blockMap,
	"Gray": greyblank
};

//Shapes to Layer
let overlayMaps={
	"Markers": mapMarkerGroup,
	"Polygons": geoPolygons
};

L.control.layers(baseMaps,overlayMaps).addTo(map);


osm.addTo(map);




///////////////////////////////////////////
//Functions
///////////////////////////////////////////
function LoadTerritoryInformation(territoryID){
	
	const result=testPolygonsList.features.filter(x=>x.properties.name===territoryID)[0];
	
	//Parcel Title
	document.getElementById("TerritoryTitle").innerHTML = `Polygon: ${result.properties.name}`;
	//Load Territory Information
	document.getElementById("TerritoryNumber").value=result.properties.TerritoryNumber;
	document.getElementById("name").value=result.properties.name;
	document.getElementById("TerritoryTypeColor").value=result.properties.TerritoryTypeColor;
	document.getElementById("description").value=result.properties.description;
};

function LoadTerritoryJSONText(fg){
	let drawnGeoJSONtext=JSON.stringify(fg.toGeoJSON(),null,2);
	
	document.getElementById("TerritoryJSON").value=drawnGeoJSONtext;
};

 
 
///////////////////////////////////////////
//Add Leaflet Drawing Controls 
///////////////////////////////////////////

map.on('pm:create', e => {
  generateGeoJson();
  ClearAllDrawingLayers();
});


map.pm.addControls({  
  position: 'topleft',
  editMode: true,
  removalMode: true,
  drawMarker:true,
  drawPolygon:true,
  drawRectangle:false,
  drawCircle:false,
  drawCircleMarker:false
});




/*
Function to get geoJSON after shape has been created

map.on('pm:create',(e) {
  e.layer.on('pm:edit', ({ layer }) => {
    // layer has been edited
    console.log(layer.toGeoJSON());
  })
});
*/

/*
Function to clear all shapes


map.eachLayer(function(layer){
     if (layer._path != null) {
    layer.remove()
  }
});

*/


function ClearAllDrawingLayers(){
	map.eachLayer(function(layer){
     if (layer._path != null) {
    layer.remove()
	  }
	});
};


function generateGeoJson(){
	var fg = L.featureGroup();    
	var layers = findLayers(map);
  layers.forEach(function(layer){
  	fg.addLayer(layer);
  });
	LoadTerritoryJSONText(fg);
	console.log(fg.toGeoJSON());
}

function findLayers(map) {
    var layers = [];
    map.eachLayer(layer => {
      if (
        layer instanceof L.Polyline ||
        layer instanceof L.Marker ||
        layer instanceof L.Circle ||
        layer instanceof L.CircleMarker
      ) {
        layers.push(layer);
      }
    });

    // filter out layers that don't have the leaflet-geoman instance
    layers = layers.filter(layer => !!layer.pm);

    // filter out everything that's leaflet-geoman specific temporary stuff
    layers = layers.filter(layer => !layer._pmTempLayer);

    return layers;
};


