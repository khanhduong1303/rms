class HomesController < ApplicationController
before_filter :authenticate_user! , :only => [:index, :new, :edit]
  def index

  end
  def edit
    
  end
end
