var ready;
ready = function() {
  var table = $('#participants').DataTable( {
    stateSave: false,
    autoWidth: true,
    searching: true,
    ordering:  true,
    sPaginationType: "full_numbers",
    columnDefs: [
      { visible: false, targets: [2, 4, 5, 6] }
    ],
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
    exclude: [7, 8, 9, 10, 11, 12, 13],
    groups: [
      {
        title: 'Dni',
        columns: [7, 8, 9]
      },
      {
        title: 'Obiady',
        columns: [10, 11]
      },
      {
        title: 'Noclegi',
        columns: [12, 13]
      }
    ]
  } );
  $( colvis.button() ).insertBefore('#participants_length');
  $(".ColVis_MasterButton").removeClass("ColVis_Button");
  $(".ColVis_MasterButton").addClass("btn btn-default");

  $( "#participants" ).wrap( "<div class='table-container'></div>" );

  table.$('.delete-participant').each(function(){
    $(this).bind('ajax:success', function() {
      console.log('Participant has been removed.');
      $(this).parents('tr').remove();
      toast('success', 'Udało się!', 'Użytkownik został poprawnie usunięty.');
    }).bind('ajax:error', function() {
      console.log('Error on removing a participant.');
      toast('danger', 'Wystapił błąd!', 'Użytkownik nie został usunięty, spróbuj ponownie.');
    });
  });

};

$(document).ready(ready);
$(document).on('page:load', ready);
