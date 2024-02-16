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
FactoryBot.define do
  factory :integration do
    name { "MyString" }
    config { "" }
  end
end
