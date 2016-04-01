require 'spec_helper'
# require 'rails_helper'

RSpec.describe WelcomeController, :type => :controller do
  describe "GET welcom#history" do
    it "responds successfully" do
      get :history
      expect(response).to be_success
    end

    it "renders the history template" do
      get :history
      expect(response).to render_template("welcome/history")
    end

    # it "history should be maximum size of ten" do
    #   array = []
    #   (1..10).each do |i|
    #     array.push(Event.create!)
    #   end
    #   get :history
    #   expect(assigns(:history)).to match_array(array)
    # end
  end
end