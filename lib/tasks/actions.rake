require 'action_controller/integration'

namespace :actions do
  desc "test action"
  task "echo" do
    app = ActionController::Integration::Session.new;
    app.get('/fields/2/edit')
    puts app.html_document.root.to_s
  end
end
