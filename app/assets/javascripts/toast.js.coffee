@toast = (type = 'info', title = 'Gratulacje!', message = 'Udało się zrealizować akcję.', target = 'body') ->
  html =
    """
      <div class="alert alert-#{type} alert-dismissible toast" role="alert">
        <button class="close" type="button" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <strong>#{title} </strong>#{message}
      </div>
    """
  if $('.toast').length
    $('.toast').each( ->
      $(this).remove()
    )

  $(html).hide().appendTo(target).fadeIn(1000)

  setTimeout ->
    $('.toast').fadeOut(1000, ->
      $(this).alert('close')
      $(this).remove()
    );
  , 5000
