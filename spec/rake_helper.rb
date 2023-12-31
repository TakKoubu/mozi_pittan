# frozen_string_literal: true

require 'rake'
require 'rails_helper'

RSpec.configure do |config|
  config.before(:suite) do
    Rails.application.load_tasks
  end

  config.before(:each) do
    Rake.application.tasks.each(&:reenable)
  end
end
