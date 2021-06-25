/*
GOOGLE GEOCODE
*/

//Initialize Geocoder
geocoder = new google.maps.Geocoder();

////////////////////////////////////
//Google Autocomplete and retrieve Lat and Long
////////////////////////////////////
function initializeAutoComplete() {
          let input = document.getElementById('searchTextField');
          let autocomplete = new google.maps.places.Autocomplete(input);
            google.maps.event.addListener(autocomplete, 'place_changed', function () {
                let place = autocomplete.getPlace();
                document.getElementById('city2').value = place.name;
                document.getElementById('cityLat').value = place.geometry.location.lat();
                document.getElementById('cityLng').value = place.geometry.location.lng();
				
            });
}
google.maps.event.addDomListener(window, 'load', initialize);
