

class MainsController < ApplicationController
  skip_before_action :require_login

  def index
    # puts RBTracer::VERSION
  end

  def information

  end 
end
