$( document ).ready(function() {

  $("a.sort").click(function(e) {
    e.preventDefault();

    if ($( this ).hasClass( "sort_column" )) {
      $( this ).toggleClass( "desc" );
    }
    else {
      $( "a.sort_column" ).removeClass( "sort_column" );
      $( this ).addClass( "sort_column" );
    }
  });

  $( ".filter button" ).click(function(e) {
      $( this ).toggleClass("active");
  });

});

function findSortColumn() {
  return $( "a.sort_column" )[0].id;
}

function findSortDirection() {
  var sortColumn = findSortColumn();
  if ($( "#"+sortColumn ).hasClass("desc")) {
    return "desc";
  }
  else {
    return "asc";
  }
}

function findFilters() {
  var filterArray = [];
  $( ".filter button.active" ).each(function(){
    filterArray[filterArray.length] = this.id;
  });
  return filterArray.join("+");
}

function getList(sortColumn, sortDirection, filterQuery) {
  var query = "/mountains/?sort="+sortColumn+"&direction="+sortDirection+"&filter="+filterQuery;
  var jsonMountains = $.getJSON( query );
  // $.each(jsonMountains.responseJSON, function(i, mountain) { console.log(mountain.name) } );
  console.log(jsonMountains);
  return jsonMountains;
}

function sortBy() {
  $( "ul.mountains" ).html("");
  // debugger
  debugger;
  var list = getList(findSortColumn(), findSortDirection(), findFilters());
  debugger;
  $.each(list.responseJSON, function(i, mountain) { console.log(mountain.name) } );
  // $.each(jsonMountains.responseJSON, function(i, mountain) {
  //   $( "ul.mountains" ).append("<li class='list-group-item'>" + mountain.name + " " + mountain.height + "</li>");
  // });
}





// function allMountains() {
//   $.getJSON("http://localhost:3000/mountains.json",
//         function(data){
//           debugger
//           $.each(data.mountains, function(i,mountain){
//             debugger
//             content = '<p>' + product.product_title + '</p>';
//             content += '<p>' + product.product_short_description + '</p>';
//             content += '<img src="' + product.product_thumbnail_src + '"/>';
//             content += '<br/>';
//             $(content).appendTo("#product_list");
//           });
//         });
// }

