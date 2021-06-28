/*
GOOGLE MAPS
*/

// This example requires the Drawing library. Include the libraries=drawing
// parameter when you first load the API. For example:
// <script src="https://maps.googleapis.com/maps/api/js?key=YOURAPIKEYHERE&libraries=drawing">

function initMap() {
	
////////////////////////////////////
//Map Initialization
////////////////////////////////////
  const map = new google.maps.Map(document.getElementById("map"), {
    center: { lat: 33.97864662150197, lng: -81.19475515526771 },
    zoom: 11,
	mapTypeId: 'roadmap'
  });
  const drawingManager = new google.maps.drawing.DrawingManager({
    drawingMode: google.maps.drawing.OverlayType.MARKER,
    drawingControl: true,
    drawingControlOptions: {
      position: google.maps.ControlPosition.TOP_CENTER,
      drawingModes: [
        google.maps.drawing.OverlayType.MARKER,
        google.maps.drawing.OverlayType.CIRCLE,
        google.maps.drawing.OverlayType.POLYGON,
        google.maps.drawing.OverlayType.POLYLINE,
        google.maps.drawing.OverlayType.RECTANGLE,
      ],
    },
    markerOptions: {
      icon: "https://developers.google.com/maps/documentation/javascript/examples/full/images/beachflag.png",
    },
    circleOptions: {
      fillColor: "#ffff00",
      fillOpacity: 1,
      strokeWeight: 5,
      clickable: false,
      editable: true,
      zIndex: 1,
    },
	polygonOptions:{
		fillColor:"#0000aa",
		fillOpacity:.2,
		clickable: false,
		editable: true,
		zIndex: 1,
	},
  });
  
 
  drawingManager.setMap(map);
  let dataLayer=new google.maps.Data();
  
////////////////////////////////////
//Add event Listener to capture complete shapes that are drawn and points to save to database
////////////////////////////////////

  // from http://stackoverflow.com/questions/25072069/export-geojson-data-from-google-maps
  // from http://jsfiddle.net/doktormolle/5F88D/
  google.maps.event.addListener(drawingManager, 'overlaycomplete',function(event){
	  switch(event.type){
			case google.maps.drawing.OverlayType.MARKER:
				dataLayer.add(new google.maps.Data.Feature({
					geometry:new google.maps.Data.Point(event.overlay.getPosition())
				}));
				break;
			case google.maps.drawing.OverlayType.RECTANGLE:
				let b=event.overlay.getBounds(),
					p=[b.getSouthWest(),{lat:b.getSouthWest().lat(),lng:b.getNorthEast().lng},b.getNorthEast(),{lng:b.getSouthWest().lng(),lat:b.getNorthEast().lat()}];
				dataLayer.add(new google.maps.Data.Feature({
					geometry:new google.maps.Data.Polygon([p])
				}));
				break;
			case google.maps.drawing.OverlayType.POLYGON:
				dataLayer.add(new google.maps.Data.Feature({
					geometry:new google.maps.Data.Polygon([event.overlay.getPath().getArray()])
				}));
				break;
			case google.maps.drawing.OverlayType.POLYLINE:
				dataLayer.add(new google.maps.Feature({
					geometry: new google.maps.Data.LineString(event.overlay.getPath().getArray())
				}));
				break;
			case google.maps.drawing.OverlayType.CIRCLE:
				dataLayer.add(new google.maps.Data.Feature({
					properties:{
						radius: event.overlay.getRadius()
					},
					geometry: new google.maps.Data.Point(event.overlay.getCenter())
				}));
				break;
		
		}
	});
	
////////////////////////////////////
//Load Data
////////////////////////////////////


  // Create a <script> tag and set the USGS URL as the source.
  const script = document.createElement("script");
  // This example uses a local copy of the GeoJSON stored at same folder for example "TerritoryHelper.js"
  script.src = "TerritoryHelper.js";
  document.getElementsByTagName("head")[0].appendChild(script);
	
 	////////////////////////////////////
	//Load Territories (Polygons)
	////////////////////////////////////

	google.maps.event.addDomListener(document.getElementById('loadData'),'click',function(){
		
		//load information if server is available
		//map.data.loadGeoJson('TerritoryHelper.json');
		
		//Load for testing only
		let previouslySelectedPolygon;
		LoadGeoJsonFile(jsGeoJson);
		
		function LoadGeoJsonFile(results){
			for(let i=0; i<results.features.length; i++){
				const territoryShapeCoords=results.features[i].geometry.coordinates[0];
				let pathCoords=[];
				//For Label Position
				let bounds=new google.maps.LatLngBounds();
				for(let j=0; j< territoryShapeCoords.length; j++){
					pathCoords.push({lat:territoryShapeCoords[j][1],lng:territoryShapeCoords[j][0]});
					//For label Position
					bounds.extend({lat:territoryShapeCoords[j][1],lng:territoryShapeCoords[j][0]});
				}

				//Add Polygon
				let territoriesLoaded=new google.maps.Polygon({
					paths: pathCoords,
					strokeColor: "#"+results.features[i].properties.TerritoryTypeColor,
					strokeOpacity: 0.8,
					strokeWeight: 2,
					fillColor: "#"+results.features[i].properties.TerritoryTypeColor,
					fillOpacity: 0.2,
					indexID:results.features[i].properties.name
				});
				
				//Add Label to polygon
				let myLatLngLabelPosition=bounds.getCenter();
				let mapLabel=new google.maps.Marker({
					icon:'./img/onePixel.png',
					position:myLatLngLabelPosition,
					label:results.features[i].properties.name,
					map:map
				});
				
				////////////////////////////////////
				//Select call on territory on 'mouseclick'
				////////////////////////////////////
				google.maps.event.addListener(territoriesLoaded, 'click', function (event) {
					if(previouslySelectedPolygon){
						previouslySelectedPolygon.setOptions({fillOpacity:0.2});
					}
					this.setOptions({fillOpacity:0.5});
									
					////////////////////////////////////
					//Get IndexID
					////////////////////////////////////
					console.log(this.indexID);
					previouslySelectedPolygon=territoriesLoaded;
				});
				
				mapLabel.setMap(map);
				territoriesLoaded.setMap(map);
			}

		}
	})

	////////////////////////////////////
	//Load Addresses as markers
	////////////////////////////////////

	// Create a <script> tag and set the USGS URL as the source.
	const AddressScript = document.createElement("script");
	// This example uses a local copy of the GeoJSON stored at same folder for example "addresses.js"
	AddressScript.src = "addresses.js";
	document.getElementsByTagName("head")[0].appendChild(AddressScript);

	google.maps.event.addDomListener(document.getElementById('loadAddresses'),'click',function(){


		LoadAddresses(addressesJson);

		function LoadAddresses(results){
			for(let i=0; i<results.Locations.length; i++){
				//Add Map Marker
				let mapAddressMarker=new google.maps.Marker({
					icon:`./img/${results.Locations[i].LocationType}.png`,
					position:{lat:parseFloat(results.Locations[i].Latitude),lng:parseFloat(results.Locations[i].Longitude)},
					label: results.Locations[i].AddressNumber,
					title: results.Locations[i].FullAddress,
					indexID: results.Locations[i].No
				});

				////////////////////////////////////
				//Select call on address on 'mouseclick'
				////////////////////////////////////
				google.maps.event.addListener(mapAddressMarker,'click',function(event){
					////////////////////////////////////
					//Get IndexID
					////////////////////////////////////
					console.log(this.indexID);
				})


				mapAddressMarker.setMap(map);

			}
		}
	})
	

////////////////////////////////////
//Save geoJsonData
////////////////////////////////////
	google.maps.event.addDomListener(document.getElementById('save'),'click',function(){
		dataLayer.toGeoJson(function(geoJsonData){
		  document.getElementById('geojson-input').innerHTML=JSON.stringify(geoJsonData);
	  });
	})
	
////////////////////////////////////
//Clear all shapes/points
////////////////////////////////////
	google.maps.event.addDomListener(document.getElementById('deleteAllShapes'),'click',function(dataLayer){
		console.log("got here");
		dataLayer.pop();
	})


}







