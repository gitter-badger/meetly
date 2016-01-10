var ready;
ready = function() {

  /**
   * Index Action
   */
  $('#participants').ready(function(){

    var dinners_indexes = [13, 12];

    var table = $('#participants').DataTable( {
      stateSave: true,
      autoWidth: true,
      searching: true,
      ordering:  true,
      sPaginationType: "full_numbers",
      columnDefs: [
        { visible: false, targets: [1, 3] }
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
      groups: [
        {
          title: 'Obiady',
          columns: dinners_indexes
        }
      ],
      restore: 'Przywróć'
    } );
    $( colvis.button() ).insertBefore('#participants_length');
    $(".ColVis_MasterButton").removeClass("ColVis_Button");
    $(".ColVis_MasterButton").addClass("btn btn-default");

    $( "#participants" ).wrap( "<div class='table-container'></div>" );

    table.$('.delete-participant').each(function(){
      $(this).bind('ajax:success', function() {
        console.log('Participant has been removed.');
        table.row( $(this).parents('tr') ).remove().draw();
        toast('success', 'Udało się!', 'Uczestnik został poprawnie usunięty.');
      }).bind('ajax:error', function() {
        console.log('Error on removing a participant.');
        toast('danger', 'Wystapił błąd!', 'Uczestnik nie został usunięty, spróbuj ponownie.');
      });
    });

    table.$('.paid-participant').each(function(){
      $(this).bind('ajax:success', function(response, data) {
        console.log('Participant has been set as paid and notified by e-mail.');
        $(this).closest('tr').find('td.status').html('<span class="label status-label label-success">Opłacony</span>');
        $(this).closest('tr').find('td.paid').html(parseFloat(data.paid).toFixed(2) + ' PLN');
        toast('success', 'Udało się!', 'Uczestnik został oznaczony jako opłacony.');
      }).bind('ajax:error', function() {
        console.log('Error on setting participant as paid.');
        toast('danger', 'Wystapił błąd!', 'Uczestnik nie został oznaczony jako opłacony, spróbuj ponownie.');
      });
    });

    table.$('.arrived-participant').each(function(){
      $(this).bind('ajax:success', function(response, data) {
        console.log('Participant has been set as arrived.');
        $(this).closest('tr').find('td.status').html('<span class="label status-label label-default">Przyjechał</span>');
        $(this).closest('tr').find('.arrived-participant').remove();
        toast('success', 'Udało się!', 'Przyjazd uczestnika zapisany.');
      }).bind('ajax:error', function() {
        console.log('Error on setting participant as paid.');
        toast('danger', 'Wystapił błąd!', 'Przyjazd uczestnika nie został zapisany, spróbuj ponownie.');
      });
    });

  });

  /**
   * Edit Action
   */

  $('#participant-form').ready(function(){

    $(this).on("ajax:success", function(response, data){
      console.log('Success! Participant has been succesfully saved.');
      $('#participant_cost').val(data.cost);
      toast('success', 'Udało się!', 'Uczestnik został pomyślnie zapisany.');
    }).on("ajax:error", function(){
      console.log('Error! Participant has not been saved.');
      toast('danger', 'Wystapił błąd!', 'Uczestnik nie został zapisany.');
    });
  });

  function getPrice(){
    $('#participant-form').ajaxSubmit({
      url: $('#participant-form').data('calculate-url'),
      type: 'get',
      dataType: 'json',
      success: function(cost){
        $('#participant_cost').val(cost);
      }
    });
  }

  $('#participant-form :checkbox').click(function() {
    getPrice();
  });

  $('#participant_role_id').change(function() {
    getPrice();
  });

  $('#payment_deadline_date').datetimepicker({
    format: 'DD-MM-YYYY'
  });

};

$(document).ready(ready);
$(document).on('page:load', ready);
