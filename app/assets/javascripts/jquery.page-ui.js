$(document).ready(function() {

	//Kliknięcie w plusik
	$(document).on('click', ".td-check .icon_check_alt", function(){
		var action = $(this).attr('data-action');
		var user_id = $(this).parent().parent().attr('data-id');
		var new_value = 0;
		var element = $(this);
		var ajax_call = 'id='+user_id+'&action='+action+'&value='+new_value;
		
		$.ajax({url:"update.php?"+ajax_call,success:function(result){
			switch (result) {
				case '1':
					$('.log-txt').html('Zmiana została zapisana.');
					element.removeClass('icon_check_alt');
					element.addClass('icon_close_alt');
					$('.log-box').animate({
						top: '0px'
					}, 1000, function() {
						$('.log-box').delay(2000).animate({
							top: '-200px'
						});
					});
					break;
				case '2':
					$('.log-txt').html('Zmiana nie została zapisana.');
					$('.log-box').animate({
						top: '0px'
					}, 1000, function() {
						$('.log-box').delay(2000).animate({
							top: '-200px'
						});
					});
					break;		
				default:
					$('.log-txt').html('Zmiana nie została zapisana.');
					$('.log-box').animate({
						top: '0px'
					}, 1000, function() {
						$('.log-box').delay(2000).animate({
							top: '-200px'
						});
					});
			}
		}});
	});
	
	
	//Zmiana roli
	$('.change-select').change(function() {
		
		var action = $(this).parent().attr('data-action');
		var user_id = $(this).parent().parent().attr('data-id');
		var new_value = $(this).parent().val();
		var element = $(this);
		var ajax_call = 'id='+user_id+'&action='+action+'&value='+new_value;
		
		$.ajax({url:"update.php?"+ajax_call,success:function(result){
			switch (result) {
				case '1':
					$('.log-txt').html('Zmiana została zapisana.');
					element.removeClass('active');
					$('.log-box').animate({
						top: '0px'
					}, 1000, function() {
						$('.log-box').delay(2000).animate({
							top: '-200px'
						});
					});					
					break;
				case '2':
					$('.log-txt').html('Zmiana nie została zapisana.');
					element.removeClass('active');
					element.html(old_value);
					$('.log-box').animate({
						top: '0px'
					}, 1000, function() {
						$('.log-box').delay(2000).animate({
							top: '-200px'
						});
					});
					break;		
				default:
					$('.log-txt').html('Zmiana nie została zapisana.');
					element.removeClass('active');
					element.html(old_value);
					$('.log-box').animate({
						top: '0px'
					}, 1000, function() {
						$('.log-box').delay(2000).animate({
							top: '-200px'
						});
					});
			}
		}});
		
	});
	
	//Kliknięcie w minusik
	$(document).on('click', "td-check .icon_close_alt", function(){
		var action = $(this).attr('data-action');
		var user_id = $(this).parent().parent().attr('data-id');
		var new_value = 1;
		var element = $(this);
		var ajax_call = 'id='+user_id+'&action='+action+'&value='+new_value;
		
		$.ajax({url:"update.php?"+ajax_call,success:function(result){
			switch (result) {
				case '1':
					$('.log-txt').html('Zmiana została zapisana.');
					element.removeClass('icon_close_alt');
					element.addClass('icon_check_alt');
					$('.log-box').animate({
						top: '0px'
					}, 1000, function() {
						$('.log-box').delay(2000).animate({
							top: '-200px'
						});
					});
					break;
				case '2':
					$('.log-txt').html('Zmiana nie została zapisana.');
					$('.log-box').animate({
						top: '0px'
					}, 1000, function() {
						$('.log-box').delay(2000).animate({
							top: '-200px'
						});
					});
					break;		
				default:
					$('.log-txt').html('Zmiana nie została zapisana.');
					$('.log-box').animate({
						top: '0px'
					}, 1000, function() {
						$('.log-box').delay(2000).animate({
							top: '-200px'
						});
					});
			}
		}});
	});
	
	
	$('.editable').click(function() {	
		if (!$(this).hasClass('active')) {
			$(this).addClass('active');
			value = $(this).html();			
			$(this).html('<input class="inline-edit" type="text" data-val="'+value+'" value="'+value+'" /><div class="icon icon_check_alt"></div><div class="icon icon_close_alt"></div>');
		}
	});

	$(document).on('click', ".editable .icon_close_alt", function(){
		txt = $(this).parent().children('input').attr('data-val');
		$(this).parent().removeClass('active');
		$(this).parent().html(txt);
	});
	
	$(document).on('click', ".editable .icon_check_alt", function(){
		
		var action = $(this).parent().attr('data-action');
		var user_id = $(this).parent().parent().attr('data-id');
		var new_value = $(this).parent().children('input').val();
		var old_value = $(this).parent().children('input').attr('data-val');
		var element = $(this).parent();
		var ajax_call = 'id='+user_id+'&action='+action+'&value='+new_value;
		
		$.ajax({url:"update.php?"+ajax_call,success:function(result){
			switch (result) {
				case '1':
					$('.log-txt').html('Zmiana została zapisana.');
					element.removeClass('active');
					element.html(new_value);
					$('.log-box').animate({
						top: '0px'
					}, 1000, function() {
						$('.log-box').delay(2000).animate({
							top: '-200px'
						});
					});
					
					if (element.hasClass('td-total')) {
						element.parent().children('.to-pay').html(parseInt(new_value)-parseInt(element.parent().children('.td-paid').html()));
					}
					
					if (element.hasClass('td-paid')) {
						element.parent().children('.to-pay').html(parseInt(element.parent().children('.td-total').html())-parseInt(new_value));
					}
					
					break;
				case '2':
					$('.log-txt').html('Zmiana nie została zapisana.');
					element.removeClass('active');
					element.html(old_value);
					$('.log-box').animate({
						top: '0px'
					}, 1000, function() {
						$('.log-box').delay(2000).animate({
							top: '-200px'
						});
					});
					break;		
				default:
					$('.log-txt').html('Zmiana nie została zapisana.');
					element.removeClass('active');
					element.html(old_value);
					$('.log-box').animate({
						top: '0px'
					}, 1000, function() {
						$('.log-box').delay(2000).animate({
							top: '-200px'
						});
					});
			}
		}});
	});
	
	//Kliknięcie w like (zmiana z przyjechal na nie przyjechal)
	$(document).on('click', ".icon_like", function(){
		var action = $(this).attr('data-action');
		var user_id = $(this).parent().parent().attr('data-id');
		var new_value = 0;
		var element = $(this);
		var ajax_call = 'id='+user_id+'&action='+action+'&value='+new_value;
		
		$.ajax({url:"update.php?"+ajax_call,success:function(result){
			switch (result) {
				case '1':
					$('.log-txt').html('Zmiana została zapisana.');
					element.parent().children('.icon_like').hide();
					element.parent().children('.icon_dislike').show();
					$('.log-box').animate({
						top: '0px'
					}, 1000, function() {
						$('.log-box').delay(2000).animate({
							top: '-200px'
						});
					});
					break;
				case '2':
					$('.log-txt').html('Zmiana nie została zapisana.');
					$('.log-box').animate({
						top: '0px'
					}, 1000, function() {
						$('.log-box').delay(2000).animate({
							top: '-200px'
						});
					});
					break;		
				default:
					$('.log-txt').html('Zmiana nie została zapisana.');
					$('.log-box').animate({
						top: '0px'
					}, 1000, function() {
						$('.log-box').delay(2000).animate({
							top: '-200px'
						});
					});
			}
		}});
	});
	
	//Kliknięcie w like (zmiana z nie przyjechal na przyjechal)
	$(document).on('click', ".icon_dislike", function(){
		var action = $(this).attr('data-action');
		var user_id = $(this).parent().parent().attr('data-id');
		var new_value = 1;
		var element = $(this);
		var ajax_call = 'id='+user_id+'&action='+action+'&value='+new_value;
		
		$.ajax({url:"update.php?"+ajax_call,success:function(result){
			switch (result) {
				case '1':
					$('.log-txt').html('Zmiana została zapisana.');
					element.parent().children('.icon_like').show();
					element.parent().children('.icon_dislike').hide();
					$('.log-box').animate({
						top: '0px'
					}, 1000, function() {
						$('.log-box').delay(2000).animate({
							top: '-200px'
						});
					});
					break;
				case '2':
					$('.log-txt').html('Zmiana nie została zapisana.');
					$('.log-box').animate({
						top: '0px'
					}, 1000, function() {
						$('.log-box').delay(2000).animate({
							top: '-200px'
						});
					});
					break;		
				default:
					$('.log-txt').html('Zmiana nie została zapisana.');
					$('.log-box').animate({
						top: '0px'
					}, 1000, function() {
						$('.log-box').delay(2000).animate({
							top: '-200px'
						});
					});
			}
		}});
	});
	
	//Usucienie uczestnika potwierdzenie
	$(document).on('click', ".icon_trash_alt", function(){
		action = $(this).attr('data-action');
		id = $(this).parent().parent().attr('data-id');
		$('.log-txt').html('Czy na pewno chcesz usunąć uczestnika?<br /><div id="trash-user" data-id="'+id+'" data-action="'+action+'" class="ColVis"><button class="ColVis_Button ColVis_MasterButton"><span>Tak</span></button></div><div id="cancel" class="ColVis"><button class="ColVis_Button ColVis_MasterButton"><span>Nie</span></button></div>');
		$('.log-box').animate({
			top: '0px'
		}, 1000);
	});
	
	//Usuniecie uzytkownika step 2
	$(document).on('click', "#trash-user", function(){
		var action = $(this).attr('data-action');
		var user_id = $(this).attr('data-id');
		var element = $(this);
		var ajax_call = 'id='+user_id+'&action='+action;
		
		$.ajax({url:"delete.php?"+ajax_call,success:function(result){
			switch (result) {
				case '1':
					$('.log-box').animate({
						top: '-200px'
					}, 500, function() {
						$('.log-txt').html('Uczestnik został usunięty.');
						$('tr[data-id="'+user_id+'"]').remove();
						$('.log-box').delay(100).animate({
							top: '0px'
						}, 1000, function() {
							$('.log-box').delay(2000).animate({
								top: '-200px'
							});
						});
					});
					break;
				case '2':
					$('.log-box').animate({
						top: '-200px'
					}, 500, function() {
						$('.log-txt').html('Nie udalo się usunąć uczestnika.');
						$('.log-box').delay(100).animate({
							top: '0px'
						}, 1000, function() {
							$('.log-box').delay(2000).animate({
								top: '-200px'
							});
						});
					});
					break;		
				default:
					$('.log-box').animate({
						top: '-200px'
					}, 500, function() {
						$('.log-txt').html('Nie udalo się usunąć uczestnika.');
						$('.log-box').delay(100).animate({
							top: '0px'
						}, 1000, function() {
							$('.log-box').delay(2000).animate({
								top: '-200px'
							});
						});
					});
			}
		}});
	});
	
	$(document).on('click', "#cancel", function(){		
		$('.log-box').animate({
			top: '-200px'
		});
	});
	
	//Modal dodawania uzytkownika
	$(document).on('click', "#add-new", function(){
		$('.add-new-cont').fadeIn('fast');
	});
	$('#new-form-close').click(function() {
		$('.add-new-cont').fadeOut('fast');
	});

});