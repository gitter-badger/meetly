$(document).ready(function () {

//ANALYSE DOM in html

	// Zmienne



  var calakonferencja = $('.cala-konferencja');
  var pierwszydzien = $('.pierwszy-dzien');
  var drugidzien = $('.drugi-dzien');
  var trzecidzien = $('.trzeci-dzien');
  var wszystkiedni = $(".dzien");
  var wszystkiepola  = $(".cala-konferencja, .pierwszy-dzien, .drugi-dzien, .trzeci-dzien");


  var nocleg = $('div.noclegi .nocleg');
  var nocleg1 = $('div.noclegi .nocleg1');
  var nocleg2 = $('div.noclegi .nocleg2');
  var obiad = $('div.obiady .obiad');
  var obiad1 = $('div.obiady .obiad1');
  var obiad2 = $('div.obiady .obiad2');


  wszystkiepola.prop('checked', true);


//Funkcja liczy koszty po zaznaczonych polach.
  function kosztUdzial() { 

      var calakonferencjaKoszt = calakonferencja.val();
      var pierwszydzienKoszt = pierwszydzien.val();
      var drugidzienKoszt = drugidzien.val();
      var trzecidzienKoszt = trzecidzien.val();

      var koszt = 0;

      //Warunki dla różnych opcji zaznaczeń


      //TODO:
      //Use Math.max()
      //change "value"






      if (pierwszydzien.prop('checked') && drugidzien.prop('checked') && trzecidzien.prop('checked')) {
        koszt = parseInt(calakonferencjaKoszt);
	} else {

		if (pierwszydzien.prop('checked') && drugidzien.prop('checked')) {
			koszt = parseInt(pierwszydzienKoszt) + parseInt(drugidzienKoszt);
		} else if (pierwszydzien.prop('checked') && trzecidzien.prop('checked')) {
			koszt = parseInt(pierwszydzienKoszt) + parseInt(trzecidzienKoszt);
		} else if (drugidzien.prop('checked') && trzecidzien.prop('checked')) {
			koszt = parseInt(drugidzienKoszt) + parseInt(trzecidzienKoszt);
		} else if (pierwszydzien.prop('checked') || drugidzien.prop('checked') || trzecidzien.prop('checked')) {
			koszt = parseInt($('.dzien:checked').val());
		} else {
			koszt = 0;
		}


	}
	//koszt_udzialu necessary?
     var koszt_udzialu = koszt;
	console.log('koszt udzialu: ' + koszt_udzialu);
return koszt_udzialu;

}
//Funkcja liczy koszt noclegów
function kosztNoclegi() { 

	var koszt = 0;

//TODO:
//Use COUNT or SUM

		if (nocleg1.prop('checked') && nocleg2.prop('checked')) {
			koszt = parseInt(nocleg1.val()) + parseInt(nocleg2.val());
		} else if (nocleg1.prop('checked') || nocleg2.prop('checked')) {
			koszt = parseInt($('.nocleg:checked').val());
		} else {
			koszt = 0;
		}

		koszt_noclegi = koszt;
		console.log('koszt noclegów: ' + koszt_noclegi);
        return koszt_noclegi;
}

//Funkcja liczy koszt obiadów
function kosztObiady() { 

	var koszt = 0;

//TODO: jw

		if (obiad1.prop('checked') && obiad2.prop('checked')) {
			koszt = parseInt(obiad1.val()) + parseInt(obiad2.val());
		} else if (obiad1.prop('checked') || obiad2.prop('checked')) {
			koszt = parseInt($('.obiad:checked').val());
		} else {
			koszt = 0;
		}

		koszt_obiady = koszt;
		console.log('koszt obiadów: ' + koszt_obiady);
        return koszt_obiady;
}


//Funkcja liczy całkowity koszt konferencji
  function kosztKonferencji() { 

//TODO: operate on return values

	var koszt_konferencji = kosztUdzial() + kosztNoclegi() + kosztObiady();
	console.log('Koszt konferencji: ' + koszt_konferencji);
	$( ".koszt" ).html( koszt_konferencji );
};




kosztKonferencji();


//Funkcje odpowiadające za zaznaczanie/odznaczanie checkboxów jeśli checkbox calakonferencja jest zaznaczany/odznaczany + Aktualizacja cen
	
	//TODO: checkboxes.click()...
	
	pierwszydzien.click(function() {
 		if(pierwszydzien.prop('checked') && drugidzien.prop('checked') && trzecidzien.prop('checked')){
		calakonferencja.prop('checked', true);
		} else {
		calakonferencja.prop('checked', false);
		}

		kosztKonferencji();
 		});

	drugidzien.click(function() {
 		if(pierwszydzien.prop('checked') && drugidzien.prop('checked') && trzecidzien.prop('checked')){
		calakonferencja.prop('checked', true);
		} else {
		calakonferencja.prop('checked', false);
		}

		kosztKonferencji();
 		});

	trzecidzien.click(function() {
 		if(pierwszydzien.prop('checked') && drugidzien.prop('checked') && trzecidzien.prop('checked')){
		calakonferencja.prop('checked', true);
		} else {
		calakonferencja.prop('checked', false);
		}

		kosztKonferencji();
 		});


//Funkcja odpowiadająca za zaznaczanie checkboxów udziału w zależności od zaznaczenia checboxu "calakonferencja" + aktualizacja cen
 	calakonferencja.click(function() {
 		if(calakonferencja.prop('checked')) {
 			wszystkiedni.prop('checked', true);
 		} else {
 			wszystkiedni.prop('checked', false);
 			nocleg.prop('checked', false);
 			obiad.prop('checked', false);	
 			nocleg.attr('disabled', true);
			obiad.attr('disabled', true);		
 			}

 		kosztKonferencji();
	
 	});

//TODO: replace long condition

//Funkcja odpowiadająca za wyłączanie/włączanie checkboxów noclegów i obiadów, w zależności od tego, czy wybrana jest jakakolwiek opcja udziału
	$('div.udzial input[type="checkbox"]').click(function(){
		if(calakonferencja.prop('checked') || pierwszydzien.prop('checked') || drugidzien.prop('checked') || trzecidzien.prop('checked')) {
			nocleg.attr('disabled', false);
			obiad.attr('disabled', false);
		} else {
			nocleg.attr('disabled', true);
			obiad.attr('disabled', true);
		}
	});

//EVENT on click ...

//Funkcje odświeżające koszt, przy kliknięciu w konkretny typ opcji + aktualizacja cen
 	nocleg.click(function() {
 		kosztKonferencji();
 	});

 	obiad.click(function() {
 		kosztKonferencji();
 	});

//Update and check with subdomain
$('form').on('submit', function (event){
    console.log('im inside!');
    console.log($('.pierwszy-dzien:checked').val()=='on');
    event.preventDefault();
	var form = $(this);
	var data = 
	{
		"name" : $("#name").val(),
		"surname" : $("#surname").val(),
		"age" : $('#age').val(),
        "nights" : $('.nocleg:checked').length,
        "dinners" : $('.obiad:checked').length,
        "day1" : $('.pierwszy-dzien:checked').val()=='on',
        "day2" : $('.drugi-dzien:checked').val()=='on',
        "day3" : $('.trzeci-dzien:checked').val()=='on',
        "gender" : true,
        "phone" : $('.tel').val(),
        "email" : $('.email').val(),
        "city" : $('.city').val()
	};
	console.log('DATA: ' + data.name + ' ' + data.surname);
	console.log(data);
	$.ajax('https://shrouded-caverns-4963.herokuapp.com/receive_form', {
	type: 'POST',
	contentType: 'application/json',
	dataType: 'jsonp',
	data: data,
	success: function(result){
		var msg = $('<p></p>');
		msg.append('SUCCESS: ');
		msg.append('result: ');
		msg.append(result.name);
		form.after(msg);
		console.log(msg)
	},
	error: function(response, errorType, errorMessage)
	{
		console.log(errorType + ': ' + errorMessage);
	}

});
});

});
