var ready;
ready = function() {
  var table = $('#participants').DataTable( {
    stateSave: false,
    autoWidth: true,
    searching: true,
    ordering:  true,
    sPaginationType: "full_numbers",
    columnDefs: [
      { visible: false, targets: [3, 5, 6, 7] }
    ],
    fixedColumns: {
        leftColumns: 2
    },
    language: {
      emptyTable:     "Brak danych",
      info:           "Wyświetlanie _START_ do _END_ z _TOTAL_ wyników",
      infoEmpty:      "Brak dostępnych wyników",
      infoFiltered:   "(Przefiltrowano z _MAX_ wyników)",
      infoPostFix:    "",
      thousands:      ",",
      lengthMenu:     "Pokaż _MENU_ wyników na stronę",
      loadingRecords: "Ładowanie...",
      processing:     "Przetwarzanie...",
      search:         "Szukaj: ",
      zeroRecords:    "Przepraszamy, nie znaleziono wyników",
      paginate: {
        first:      "Pierwsza",
        last:       "Ostatnia",
        next:       "Następna",
        previous:   "Poprzednia"
      },
      aria: {
        sortAscending:  ": aktywuj, aby sortować rosnąco",
        sortDescending: ": aktywuj, aby sortować malejąco"
      }
    }
  });

  var colvis = new $.fn.dataTable.ColVis( table,
  {
    buttonText: 'Widok kolumn',
    exclude: [8, 9, 10, 11, 12, 13, 14],
    groups: [
      {
        title: 'Dni',
        columns: [8, 9, 10]
      },
      {
        title: 'Obiady',
        columns: [11, 12]
      },
      {
        title: 'Noclegi',
        columns: [13, 14]
      }
    ]
  } );
  $( colvis.button() ).insertBefore('#participants_length');
  $(".ColVis_MasterButton").removeClass("ColVis_Button");
  $(".ColVis_MasterButton").addClass("btn btn-default");

  $( "#participants" ).wrap( "<div class='table-container'></div>" );

  $(document).on('menuToggled', function(table) {
    console.log('menu toggled');
  });

};

$(document).ready(ready);
$(document).on('page:load', ready);
