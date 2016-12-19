class ProfilesController < ApplicationController

  # GET request to /users/:user_id/new
  def new
    @profile = Profile.new
    # Render blank profiles details form
  end
end