require "rails_helper"

RSpec.describe ChargesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/charges").to route_to("charges#index")
    end

    it "routes to #show" do
      expect(get: "/charges/1").to route_to("charges#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/charges").to route_to("charges#create")
    end
  end
end
