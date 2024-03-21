# == Schema Information
#
# Table name: integrations
#
#  id         :bigint           not null, primary key
#  config     :json
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  client_id  :bigint
#
# Indexes
#
#  index_integrations_on_client_id  (client_id)
#
require 'rails_helper'

RSpec.describe Integration, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
  end
end
