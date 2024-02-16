# == Schema Information
#
# Table name: integrations
#
#  id         :bigint           not null, primary key
#  name       :string
#  config     :json
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Integration, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
  end
end
