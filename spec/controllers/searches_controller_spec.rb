require 'rails_helper'

RSpec.describe SearchesController, type: :controller do
  
  describe "GET #show" do 
    context "successfully" do 
      before do 
        @search = FactoryGirl.create :search 
        get :show, id: @search.id	
      end

      it "returns search" do 
        expect(assigns[:search]).to eq @search
      end

      it "render show template" do 
      	expect(response).to render_template :show
      end
    end

    context "unsuccessfully" do 
      before do 
        get :show, id: "some id"	
      end

      it "returns error flash alert" do 
        message = "Oops! search result failed for some reason"
        expect(flash[:alert]).to eq message 	
      end

      it "renders search form" do 
      	expect(response).to render_template :new
      end
    end
  end


  describe "GET #new" do 
  	context "successfully" do 
  	  before do 
  	    get :new	
  	  end	

  	  it "returns search form" do 
  	    expect(response).to render_template :new	
  	  end

  	  it "returns valid object" do 
  	  	expect(assigns[:search]).to be_valid
  	  end
  	end
  end

  describe "POST #create" do 
    context "successfully" do 
      before do 
        @search_attributes = FactoryGirl.attributes_for :search	
      end

      it "return search results" do 
        expect{ post :create, { search: @search_attributes }
        }.to change(Search, :count).by(1)
      end

      it "redirect to created search" do 
      	post :create, { search: @search_attributes }
      	expect(response).to redirect_to search_path(Search.last)
      end
    end	
  end
end
