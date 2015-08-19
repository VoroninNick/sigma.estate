//var map;
//var mgr;
//var lat = $('#map_canvas').attr('data-lat');
//var lng = $('#map_canvas').attr('data-lng');
//
//function initialize() {
//  var myOptions = {
//    zoom: 8,
//    center: new google.maps.LatLng(lat, lng),
//    mapTypeId: google.maps.MapTypeId.ROADMAP
//  };
//  map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
//  mgr = new MarkerManager(map);
//  google.maps.event.addListener(mgr, "loaded", function() {
//    for (var i = 0; i < 1000; i++) {
//      var marker = new google.maps.Marker({
//        position: new google.maps.LatLng(Math.random() * 180 - 90, Math.random() * 360 - 180),
//        title: "Random marker #" + i
//      });
//      mgr.addMarker(marker, 0);
//    }
//    mgr.refresh();
//  });
//}
//google.maps.event.addDomListener(window, "load", initialize);