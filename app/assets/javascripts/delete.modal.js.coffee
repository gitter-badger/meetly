$.rails.allowAction = (link) ->
  return true unless link.attr('data-confirm')
  $.rails.showConfirmDialog(link) # look bellow for implementations
  false # always stops the action since code runs asynchronously

$.rails.confirmed = (link) ->
  link.removeAttr('data-confirm')
  link.trigger('click.rails')

$.rails.showConfirmDialog = (link) ->
  title = link.attr 'data-title'
  message = link.attr 'data-message'
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
                  <a data-dismiss="modal" class="btn btn-danger confirm">Usuń</a>
                </div>
              </div>
            </div>
          </div>
         """
  $(html).modal()
  $('#confirmationDialog .confirm').on 'click', -> $.rails.confirmed(link)
