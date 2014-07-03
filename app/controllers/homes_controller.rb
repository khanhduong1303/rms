class HomesController < ApplicationController
before_filter :authenticate_user! , :only => [:index, :new, :edit]
  def index
    session[:menustatus]='home';
  end
  def edit
    
  end
end
