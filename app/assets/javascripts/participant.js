var ready;
ready = function() {
  var table = $('#participants').DataTable( {
    stateSave: true,
    scrollX: true,
    scrollCollapse: true,
    autoWidth: true,
    searching: true,
    ordering:  true,
    sPaginationType: "full_numbers",
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

  $(document).on('menuToggled', function(table) {
    table.columns.adjust();
  });

};

$(document).ready(ready);
$(document).on('page:load', ready);
