require 'capybara/rspec'

describe 'Joining subscription', type: :feature do
  before :each do
    OutputHelper.capture_stdout { load "#{Rails.root}/scripts/01_jestwiecej_seed.rb" }
    OutputHelper.capture_stdout { load "#{Rails.root}/scripts/02_add_guest_role.rb" }
    OutputHelper.capture_stdout { load "#{Rails.root}/scripts/03_add_blaine_event.rb" }
    OutputHelper.capture_stdout { load "#{Rails.root}/scripts/04_add_gary_event.rb" }
    OutputHelper.capture_stdout { load "#{Rails.root}/scripts/05_add_agreement.rb" }
    OutputHelper.capture_stdout { load "#{Rails.root}/scripts/06_move_created_to_registration.rb" }
  end

  it 'navigates to not found page when no participant found'

  it 'navigates to thank you page when participant found'
end
