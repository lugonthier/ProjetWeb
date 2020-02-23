class CoachesController < ApplicationController


    def new
        @coach = Coach.new
    end


    def create

        coach_params = params.require(:coach).permit(:username, :email, :password, :password_confirmation)
        @coach = Coach.new(coach_params)

        if @coach.valid?
            
            @coach.save

            CoachMailer.confirm(@coach).deliver_now
            redirect_to new_coach_path, success: 'Votre compte a été créé, vous devrez recevoir un email pour confirmer votre compte'
        
            
        else
            render 'new'
            
        end
    end

    def confirm

        @coach = Coach.find(params[:id])

        if @coach.confirmation_token == params[:token]
        
            @coach.update_attributes(confirmed: true, confirmation_token: nil)

            @coach.save(validate: false)

            session[:auth] = {id: @user.id}
            
            redirect_to new_coach_path, success: 'Votre compte a bien été confirmé'

        else
            redirect_to new_coach_path, danger: 'Ce token ne semble pas être valide'
        end
    end
    
end
    