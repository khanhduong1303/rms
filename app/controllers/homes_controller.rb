class HomesController < ApplicationController

  def index
    session[:menustatus]='home';
  end
  def edit
    render layout: 'application'
  end
end
