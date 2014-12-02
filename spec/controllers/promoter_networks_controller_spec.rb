require 'spec_helper'

describe PromoterNetworksController, type: :controller do
  render_views
  describe "index" do
    before do
      PromoterNetwork.create!(name: 'Fineco')
      PromoterNetwork.create!(name: 'Widiba')
      PromoterNetwork.create!(name: 'Che Banca')
      PromoterNetwork.create!(name: 'Mediolanum')

      xhr :get, :index, format: :json, page: page, per_page: per_page
    end

    subject(:results) { JSON.parse(response.body) }

    def extract_name
      ->(object) { object["name"] }
    end

    context "when a given page is requested" do
      let(:page) { 2 }
      let(:per_page) { 2 }
      it 'should 200' do
        expect(response.status).to eq(200)
      end
      it 'should return two results' do
        expect(results.size).to eq(2)
      end
      it "should include 'Che Banca'" do
        expect(results.map(&extract_name)).to include('Che Banca')
      end
      it "should include 'Mediolanum'" do
        expect(results.map(&extract_name)).to include('Mediolanum')
      end
    end

    context "when a non existent page is requested" do
      let(:page) { 10 }
      let(:per_page) { 10 }
      it 'should return no results' do
        expect(results.size).to eq(0)
      end
    end

  end
end