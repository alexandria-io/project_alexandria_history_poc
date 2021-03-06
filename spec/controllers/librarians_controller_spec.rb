require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe LibrariansController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # Librarian. As you add validations to Librarian, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # LibrariansController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all librarians as @librarians" do
      librarian = Librarian.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:librarians)).to eq([librarian])
    end
  end

  describe "GET show" do
    it "assigns the requested librarian as @librarian" do
      librarian = Librarian.create! valid_attributes
      get :show, {:id => librarian.to_param}, valid_session
      expect(assigns(:librarian)).to eq(librarian)
    end
  end

  describe "GET new" do
    it "assigns a new librarian as @librarian" do
      get :new, {}, valid_session
      expect(assigns(:librarian)).to be_a_new(Librarian)
    end
  end

  describe "GET edit" do
    it "assigns the requested librarian as @librarian" do
      librarian = Librarian.create! valid_attributes
      get :edit, {:id => librarian.to_param}, valid_session
      expect(assigns(:librarian)).to eq(librarian)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Librarian" do
        expect {
          post :create, {:librarian => valid_attributes}, valid_session
        }.to change(Librarian, :count).by(1)
      end

      it "assigns a newly created librarian as @librarian" do
        post :create, {:librarian => valid_attributes}, valid_session
        expect(assigns(:librarian)).to be_a(Librarian)
        expect(assigns(:librarian)).to be_persisted
      end

      it "redirects to the created librarian" do
        post :create, {:librarian => valid_attributes}, valid_session
        expect(response).to redirect_to(Librarian.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved librarian as @librarian" do
        post :create, {:librarian => invalid_attributes}, valid_session
        expect(assigns(:librarian)).to be_a_new(Librarian)
      end

      it "re-renders the 'new' template" do
        post :create, {:librarian => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested librarian" do
        librarian = Librarian.create! valid_attributes
        put :update, {:id => librarian.to_param, :librarian => new_attributes}, valid_session
        librarian.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested librarian as @librarian" do
        librarian = Librarian.create! valid_attributes
        put :update, {:id => librarian.to_param, :librarian => valid_attributes}, valid_session
        expect(assigns(:librarian)).to eq(librarian)
      end

      it "redirects to the librarian" do
        librarian = Librarian.create! valid_attributes
        put :update, {:id => librarian.to_param, :librarian => valid_attributes}, valid_session
        expect(response).to redirect_to(librarian)
      end
    end

    describe "with invalid params" do
      it "assigns the librarian as @librarian" do
        librarian = Librarian.create! valid_attributes
        put :update, {:id => librarian.to_param, :librarian => invalid_attributes}, valid_session
        expect(assigns(:librarian)).to eq(librarian)
      end

      it "re-renders the 'edit' template" do
        librarian = Librarian.create! valid_attributes
        put :update, {:id => librarian.to_param, :librarian => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested librarian" do
      librarian = Librarian.create! valid_attributes
      expect {
        delete :destroy, {:id => librarian.to_param}, valid_session
      }.to change(Librarian, :count).by(-1)
    end

    it "redirects to the librarians list" do
      librarian = Librarian.create! valid_attributes
      delete :destroy, {:id => librarian.to_param}, valid_session
      expect(response).to redirect_to(librarians_url)
    end
  end

end
