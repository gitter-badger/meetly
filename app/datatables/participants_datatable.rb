class ParticipantsDatatable
  delegate :params, :link_to, :amount_or_zero_pln, :render_true, :render_false, :event_participant_delete_path, :event_participant_delete_and_notify_path, :event_participant_set_paid_and_notify_path, :edit_event_participant_path, :event_participant_set_arrived_path, :render_participant_status, :render_participant_actions, to: :@view

  def initialize(view, event)
  	@view = view
    @event = event
    @days = event.days.sort
    @services = event.services.sort
	end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Participant.active.count,
      iTotalDisplayRecords: participants.total_entries,
      aaData: data
    }
  end

private

  def data
    participants.map do |participant|
      arr = [
        participant.full_name.html_safe,
        participant.role.name.html_safe,
        participant.age,
        participant.gender_i18n.html_safe,
        participant.city.html_safe,
        participant.community,
        participant.duty,
        participant.email.html_safe,
        participant.phone.html_safe,
        participant.short_info
      ]

      @days.each do |day|
        if participant.days.include?(day)
          arr.push(render_true)
        else
          arr.push(render_false)
        end
      end

      @services.each do |service|
        if participant.services.include?(service)
          arr.push(render_true)
        else
          arr.push(render_false)
        end
      end
      arr.push(participant.created_at.strftime('%Y-%m-%d').html_safe)
      arr.push(participant.payment_deadline.strftime('%Y-%m-%d').html_safe)
      arr.push(amount_or_zero_pln(participant.cost).html_safe)
      arr.push(amount_or_zero_pln(participant.paid).html_safe)
      arr.push(render_participant_status(participant).html_safe)
      arr.push(render_participant_actions(participant).html_safe)
      arr
    end
  end

  def participants
    @participants ||= fetch_participants
  end

  def fetch_participants
    participants = @event.participants.includes(:days, :services, :role).active.references(:days, :services, :role).order("#{sort_column} #{sort_direction}")
    participants = participants.page(page).per_page(per_page)
    if params[:sSearch].present?
      participants = participants.where("first_name ilike :search or last_name ilike :search or city ilike :search", search: "%#{params[:sSearch]}%")
    end
    participants
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w(last_name role_id age gender city community duty email phone other_info)
    @days.each do |day|
        columns.push("days")
      end

      @services.each do |service|
        columns.push("services")
      end

      columns.push("created_at")
      columns.push("payment_deadline")
      columns.push("cost")
      columns.push("paid")
      columns.push("status")
      columns.push("actions")

      columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end

  def render_true
    '<i class="zmdi zmdi-check-circle zmdi-hc-lg boolean-icon text-success boolean-cell"></i>'.html_safe
  end

  def render_false
    '<i class="zmdi zmdi-minus-circle zmdi-hc-lg boolean-icon text-danger boolean-cell"></i>'.html_safe
  end

  def render_participant_status(participant)
    status = ""
    case participant.status
    when 'created' then status=build_created_status
    when 'pending' then status=build_pending_status
    when 'delayed' then status=build_delayed_status
    when 'paid' then status=build_paid_status
    when 'arrived' then status=build_arrived_status
    when 'deleted' then status=build_deleted_status
    end
    status
  end

  def build_created_status
    '<span class="label status-label label-info">Zarejestrowany</span>'.html_safe
  end

  def build_pending_status
    '<span class="label status-label label-warning">Czekamy</span>'.html_safe
  end

  def build_delayed_status
    '<span class="label status-label label-danger">Nieopłacony</span>'.html_safe
  end

  def build_paid_status
    '<span class="label status-label label-success">Opłacony</span>'.html_safe
  end

  def build_arrived_status
    '<span class="label status-label label-default">Przyjechał</span>'.html_safe
  end

  def build_deleted_status
    '<span class="label status-label label-default">Usunięty</span>'.html_safe
  end

  def render_participant_actions(participant)
    buttons = '<div class="btn-group" role="group">'
    buttons += build_arrived_button participant
    buttons += build_edit_button participant
    buttons += build_paid_button participant
    buttons += build_delete_and_notify_button participant
    buttons += build_delete_button participant
    buttons += '</div>'
    buttons.html_safe
  end

  def build_arrived_button(participant)
    if participant.status == 'arrived'
      ''
    else
      button = link_to event_participant_set_arrived_path(participant.event, participant.id), method: 'patch', remote: true, class: 'arrived-participant btn btn-primary btn-small participant-action iconic-button', title: 'Przyjechał', onclick: 'onArrived(this)' do
        '<i class="zmdi zmdi-car zmdi-hc-lg"></i><span class="text">Przyjechał</span>'.html_safe
      end
      button
    end
  end

  def build_edit_button(participant)
    button = link_to edit_event_participant_path(participant.event, participant.id), class: 'btn btn-small btn-default participant-action iconic-button', title: 'Edytuj zgłoszenie' do
      '<i class="zmdi zmdi-edit zmdi-hc-lg"></i><span class="text">Edytuj</span>'.html_safe
    end
    button
  end

  def build_paid_button(participant)
    button = link_to event_participant_set_paid_and_notify_path(participant.event, participant.id), method: 'patch', remote: true,
    data: {confirm: true, title: 'Potwierdź', message: 'Czy na pewno chcesz ustawić uczestnika jako opłaconego i wysłać mu powiadomienie e-mail o otrzymaniu wpłaty?', confirm_type: 'success', confirm_text: 'Potwierdź'},
    class: 'paid-participant btn btn-default btn-small participant-action icon-button', title: 'Opłać zgłoszenie', onclick: 'onPaid(this)' do
      '<i class="zmdi zmdi-money zmdi-hc-lg mailing"></i>'.html_safe
    end
    button
  end

  def build_delete_and_notify_button(participant)
    button = link_to event_participant_delete_and_notify_path(participant.event, participant.id), method: 'delete', remote: true,
    data: {confirm: true, title: 'Potwierdź', message: 'Czy napewno chcesz usunąć tego uczestnika i wysłać mu powiadomienie e-mail?', confirm_type: 'danger', confirm_text: 'Usuń', type: 'script'},
    class: 'delete-participant btn btn-small btn-default participant-action icon-button', title: 'Usuń zgłoszenie', onclick: 'onDelete(this)' do
      '<i class="zmdi zmdi-delete zmdi-hc-lg mailing"></i>'.html_safe
    end
    button
  end

  def build_delete_button(participant)
    button = link_to event_participant_delete_path(participant.event, participant.id), method: 'delete', remote: true,
    data: {confirm: true, title: 'Potwierdź', message: 'Czy napewno chcesz usunąć tego uczestnika?', confirm_type: 'danger', confirm_text: 'Usuń', type: 'script'},
    class: 'delete-participant btn btn-small btn-default participant-action icon-button', title: 'Usuń zgłoszenie', onclick: 'onDelete(this)' do
      '<i class="zmdi zmdi-delete zmdi-hc-lg"></i>'.html_safe
    end
    button
  end

end
