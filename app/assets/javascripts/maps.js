$(document).ready(function(){
  var mountains = $("#index-map").data('url');
  var center = $("#index-map").data('center');
  var map = L.mapbox.map('index-map', 'mskyle.map-z3a8lt6o').setView([center.latitude,center.longitude], 8);  
  $.each(mountains, function( index, mountain ) { 
    var marker = L.marker([mountain.latitude,mountain.longitude]).addTo(map);
    marker.bindPopup('<a href="mountains/'+mountain.id+'">'+mountain.name+'</a>').openPopup();
  });
});

