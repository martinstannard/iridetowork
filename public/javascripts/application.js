// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
//

function initMap(fromId, toId, f_lat, f_lon, t_lat, t_lon, mid_lat, mid_lon) {
    var from = new GLatLng(f_lat, f_lon);
    var to = new GLatLng(t_lat, t_lon);
    var mid = new GLatLng(mid_lat, mid_lon);
    var canvas = $("map_canvas");
    var map = new GMap2(canvas);
    map.setCenter(mid, 13);
    map.addOverlay(createMarker(map, from, fromId));
    map.addOverlay(createMarker(map, to, toId));
    var topRight = new GControlPosition(G_ANCHOR_TOP_RIGHT, new GSize(10,10));
    map.addControl(new GLargeMapControl(), topRight);
    map.addControl(new GOverviewMapControl());
    map.openInfoWindow(from, $(fromId).cloneNode(true));
    addRoute(map, from, to);
    return map;
}


function createMarker(map, point, nodeId) {
    marker  = new GMarker(point);
    GEvent.addListener(marker,"click", function() {
        map.openInfoWindowHtml(point, $(nodeId).innerHTML);
    });
    return marker;
}

function addRoute(map, from, to) {
    var polyline = new GPolyline([from, to], "#0870C0", 2, 1);
    map.addOverlay(polyline);
}

function paint(routes) {
    var map = new GMap2($("map_canvas"));
    var to = new GLatLng(routes[0].to.lat, routes[0].to.lng);
    map.setCenter(to, 13, G_SATELLITE_MAP);
    var topRight = new GControlPosition(G_ANCHOR_TOP_RIGHT, new GSize(10,10));
    var topLeft = new GControlPosition(G_ANCHOR_TOP_LEFT, new GSize(10,10));
    map.addControl(new GLargeMapControl(), topRight);
    map.addControl(new GOverviewMapControl());
    map.addControl(new GMenuMapTypeControl(), topLeft);

    for (var i = 0; i < routes.length; i++) {
      var route = routes[i];
      var from = new GLatLng(route.from.lat, route.from.lng);
      var to = new GLatLng(route.to.lat, route.to.lng);
      addRoute(map, from, to);      
    }
    return map;
}
