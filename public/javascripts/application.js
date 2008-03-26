// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
//

google.load("maps", "2");


function initMap(fromId, toId, f_lat, f_lon, t_lat, t_lon, mid_lat, mid_lon) {
    var map = new google.maps.Map2($("map_canvas"));
    var from = new google.maps.LatLng(f_lat, f_lon);
    var to = new google.maps.LatLng(t_lat, t_lon);
    var mid = new google.maps.LatLng(mid_lat, mid_lon);
    map.setCenter(mid, 13, G_HYBRID_MAP);
    map.addOverlay(createMarker(map, from, fromId));
    map.addOverlay(createMarker(map, to, toId));
    var topRight = new GControlPosition(G_ANCHOR_TOP_RIGHT, new GSize(10,10));
    map.addControl(new GLargeMapControl(), topRight);
    map.addControl(new GOverviewMapControl());
    map.openInfoWindow(from, $(fromId).cloneNode(true));
    addRoute(map, from, to);

    return map;
}

function updateLocation(lat, long) {

}

function createMarker(map, point, nodeId) {
    marker  = new google.maps.Marker(point);
    google.maps.Event.addListener(marker,"click", function() {
        map.openInfoWindowHtml(point, $(nodeId).innerHTML);
    });
    return marker;
}

function addRoute(map, from, to) {
    var polyline = new google.maps.Polyline([from, to], "#0870C0", 2, 1);
    map.addOverlay(polyline);
}
