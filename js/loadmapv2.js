var map;
var place;
var autocomplete;
var infowindow = new google.maps.InfoWindow();

function initialization() {
    showAllReports();
    initAutocomplete();
}

function showAllReports() {
    $.ajax({
        url: 'HttpServlet',
        type: 'POST',
        data: { "tab_id": "1"},
        success: function(reports) {
            mapInitialization(reports);
        },
        error: function(xhr, status, error) {
            alert("An AJAX error occured: " + status + "\nError: " + error);
        }
    });
}

function mapInitialization(reports) {
    var mapOptions = {
        mapTypeId : google.maps.MapTypeId.ROADMAP, // Set the type of Map
    };

    // Render the map within the empty div
    map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);

    var bounds = new google.maps.LatLngBounds ();

    $.each(reports, function(i, e) {
        var long = Number(e['longitude']);
        var lat = Number(e['latitude']);
        var latlng = new google.maps.LatLng(lat, long);

        bounds.extend(latlng);

        // Create the infoWindow content
        var contentStr = '<h4>Holiday Event Details</h4><hr>';
        contentStr += '<p><b>' + 'Holiday' + ':</b>&nbsp' + e['holidaytype'] + '</p>';
        contentStr += '<p><b>' + 'Event Venue Type' + ':</b>&nbsp' + e['eventtype'] +
            '</p>';
        contentStr += '<p><b>' + 'Neighborhood' + ':</b>&nbsp' + e['neighborhood'] +'</p>';
        contentStr += '<p><b>' + 'Street Address' + ':</b>&nbsp' + e['st_address'] +'</p>';
        contentStr += '<p>'  + '</p>';
        if (e['eventtype'] == 'commercial' || e['eventtype'] == 'residential') {
            contentStr += '<p><b>' + 'Decoration Type' + ':</b>&nbsp' +
                e['decorationtype'] + '</p>';
        }
        else if (e['eventtype'] == 'charity') {
            contentStr += '<p>' + 'Requested Donation Type' + ':&nbsp' + e['donationtype']
                + '</p>';
        }
        if ('message' in e){
            contentStr += '<p>' + 'Message' + ':&nbsp' + e['message'] + '</p>';
        }

        // Create the custom marker **ANSWER TO QUESTION 2, link to images**
        function getIcon(){
            switch (e['eventtype']) {
                case "residential": return "img/house.png";

                case "commercial": return "img/commercial.png";

                case "charity": return "img/charity.png"

            }
        }

        // Scaling and sizing images
        const images = {
            url: getIcon(), // url
            scaledSize: new google.maps.Size(25, 25), // scaled size
            origin: new google.maps.Point(0,0), // origin
            anchor: new google.maps.Point(0, 0) // anchor
        };


        const marker = new google.maps.Marker({ // Set the marker
            position : latlng, // Position marker to coordinates
            map : map, // assign the market to our map variable
            icon : images,
            customInfo: contentStr,
        });

        // Add a Click Listener to the marker
        google.maps.event.addListener(marker, 'click', function() {
            // use 'customInfo' to customize infoWindow
            infowindow.setContent(marker['customInfo']);
            infowindow.open(map, marker); // Open InfoWindow
        });

    });

    map.fitBounds (bounds);

}

function initAutocomplete(listener) {
    // Create the autocomplete object
    autocomplete = new google.maps.places.Autocomplete(document
        .getElementById('autocomplete'));

    // When the user selects an address from the dropdown, show the place selected
    autocomplete.addListener('place_changed', onPlaceChanged);
}

function onPlaceChanged() {
    place = autocomplete.getPlace();
    //**ANSWER TO QUESTION 3**
    map.setCenter(place.geometry.location);
    map.setZoom(13);
}

//Execute our 'initialization' function once the page has loaded.
google.maps.event.addDomListener(window, 'load', initialization);