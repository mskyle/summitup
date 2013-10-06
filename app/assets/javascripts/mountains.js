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

function sortBy(sortColumn, sortDirection, filterQuery) {
  $( "ul.mountains" ).html(getList(sortColumn, sortDirection, filterQuery));
}

function getList(sortColumn, sortDirection, filterQuery) {
  var query = "/mountains/?sort="+sortColumn+"&direction="+sortDirection+"&filter="+filterQuery;
  var jsonMountains = $.getJSON( query );
}

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
    return $( ".filter button.active" );
}
