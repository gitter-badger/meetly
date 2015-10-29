$.rails.allowAction = (element) ->
  return true unless element.attr('data-confirm')
  $.rails.showConfirmDialog(element) # look bellow for implementations
  false # always stops the action since code runs asynchronously

$.rails.confirmed = (element) ->
  element.removeAttr('data-confirm')
  if element.attr('data-form')
    element.trigger('submit.rails')
    element.attr('data-confirm', 'true')
  else
    element.trigger('click.rails')

$.rails.showConfirmDialog = (element) ->
  title = element.attr 'data-title'
  message = element.attr 'data-message'
  confirm_text = element.attr 'data-confirm-text'
  confirm_type = element.attr 'data-confirm-type'
  html = """
          <div class="modal" id="confirmationDialog" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
              <div class="modal-content">
                <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                  <h4>#{title}</h4>
                </div>
                <div class="modal-body">
                  <p>#{message}</p>
                </div>
                <div class="modal-footer">
                  <a data-dismiss="modal" class="btn btn-default">Anuluj</a>
                  <a data-dismiss="modal" class="btn btn-#{confirm_type} confirm">#{confirm_text}</a>
                </div>
              </div>
            </div>
          </div>
         """
  $(html).modal()
  $('#confirmationDialog .confirm').on 'click', -> $.rails.confirmed(element)
