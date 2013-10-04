$( document ).ready(function() {
  $("a.sort").click(function(e) {
    e.preventDefault();

    if ($( this ).hasClass( "sort_column" )) {
      $( this ).toggleClass( "desc" );
    }
    else {
      $( "a.sort" ).removeClass( "sort_column" );
      $( this ).addClass( "sort_column" );
    }

    var sortColumn = $( this )[0].id;
    var sortDirection = "";

    if ($( "#"+sortColumn ).hasClass("desc")) {
      sortDirection = "desc";
    }
    else {
      sortDirection = "asc";
    }
    sortBy(sortColumn, sortDirection);
  });
});

function sortBy(sortColumn, sortDirection, filterQuery) {
  $( "ul.mountains" ).html(getList(sortColumn, sortDirection, filterQuery));
}

function getList(sortColumn, sortDirection, filterQuery) {
  var query = "/mountains/?sort="+sortColumn+"&direction="+sortDirection;
  var jsonMountains = $.getJSON( query );
}
