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
    getList(findSortColumn(), findSortDirection(), findFilters());
  });

  $( ".filter button" ).click(function(e) {
      $( this ).toggleClass("active");
      getList(findSortColumn(), findSortDirection(), findFilters());
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
  $.getJSON( query, function(data) {
    $( "ul.mountains" ).html("");
    $.each( data, function( key, mountain ) {
      $( "ul.mountains" ).append(
        '<li class="list-group-item"><a href="/mountains/'+mountain.id+'">'+mountain.name+'</a> '+mountain.height+'</li>')
    });
  });
}
