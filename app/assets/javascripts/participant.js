var ready;
ready = function() {
  $('#participants').DataTable( {
    responsive: true,
    searching: true,
    ordering:  true,
    sPaginationType: "full_numbers",
    buttons: [{
      extend: 'print',
      text: 'Drukuj',
      className: 'print-button btn btn-default',
      title: 'Lista uczestników'
    }],
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
};
$(document).ready(ready);
$(document).on('page:load', ready);
