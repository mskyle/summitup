$(document).ready(function(){
  var mountains = $("#index-map").data('url');
  var center = $("#index-map").data('center');
  var mountain_show = $("#mountain-map").data('url');
  if (mountains !== null) {
    var index_map = L.mapbox.map('index-map', 'mskyle.map-z3a8lt6o').setView([center.latitude,center.longitude], 8);
    $.each(mountains, function( index, mountain ) {
      var marker = L.marker([mountain.latitude,mountain.longitude]).addTo(index_map);
      marker.bindPopup('<a href="mountains/'+mountain.id+'">'+mountain.name+'</a>').openPopup();
    });
  }
  if (mountain_show !== null) {
    var mountain_map = L.mapbox.map('mountain-map', 'mskyle.map-z3a8lt6o').setView([mountain_show.latitude,mountain_show.longitude], 6);
    var mountain_marker = L.marker([mountain_show.latitude,mountain_show.longitude]).addTo(mountain_map);
  }
});

