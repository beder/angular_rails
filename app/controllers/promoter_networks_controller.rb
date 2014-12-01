class PromoterNetworksController < ApplicationController
  def index
    @promoter_networks = PromoterNetwork.page(params[:page]).per(params[:per_page])
  end
end
