require 'rails_helper'

RSpec.describe User, type: :model do
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::ControllerHelpers, type: :view
end
