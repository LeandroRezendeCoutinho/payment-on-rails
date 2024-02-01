require "rails_helper"

RSpec.describe PaymentsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/payments").to route_to("payments#index")
    end

    it "routes to #show" do
      expect(get: "/payments/1").to route_to("payments#show", id: "1")
    end

    it "routes to #create" do
      expect(post: "/payments").to route_to("payments#create")
    end
  end
end
