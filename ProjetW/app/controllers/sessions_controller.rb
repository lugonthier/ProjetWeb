class SessionsController < ApplicationController

  skip_before_action :only_signed_in, only: [:new, :create]

  def new

  end

  def create

    coach_params = params.require(:coach)

    @coach = Coach.where(username: coach_params[:username]).or(Coach.where(email: coach_params[:username])).first

    if @coach and @coach.authenticate(coach_params[:password]) and Coach.where(confirmed: true)
      
      session[:auth] = @coach.to_session

      redirect_to profil_path, success: 'vous êtes connecté'

    else

        redirect_to new_session_path, danger: 'Identifiants incorrects'
    end

  end

  def destroy

  end
end
