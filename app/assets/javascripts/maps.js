$(document).ready(function(){

  var map = L.mapbox.map('four-map', 'mskyle.map-z3a8lt6o').setView([44.108173,-71.197549], 8);

  var marker = L.marker([44.108173,-71.197549]).addTo(map);

  // L.tileLayer('http://{s}.tile.cloudmade.com/22838cc65c0b414ba976b3ee537556d8/997/256/{z}/{x}/{y}.png', {
  //     maxZoom: 18
  //     }).addTo(map);
  });

// <!DOCTYPE html>
// <html>
// <head>
//   <meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no' />
  // <script src='http://api.tiles.mapbox.com/mapbox.js/v1.3.1/mapbox.js'></script>
  // <link href='http://api.tiles.mapbox.com/mapbox.js/v1.3.1/mapbox.css' rel='stylesheet' />
  // <!--[if lte IE 8]>
  //   <link href='http://api.tiles.mapbox.com/mapbox.js/v1.3.1/mapbox.ie.css' rel='stylesheet' >
  // <![endif]-->
//   <style>
//     body { margin:0; padding:0; }
//     #map { position:absolute; top:0; bottom:0; width:100%; }
//   </style>
// </head>
// <body>
// <div id='map'></div>
// <script type='text/javascript'>
// var map = L.mapbox.map('map', 'mskyle.map-z3a8lt6o');
// </script>
// </body>
// </html>
