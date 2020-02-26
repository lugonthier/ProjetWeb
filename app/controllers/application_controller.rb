class ApplicationController < ActionController::Base

    before_action :only_signed_in
    

    add_flash_types :success, :danger

    helper_method :current_coach

    helper_method :is_coach_signed_in


    private

    # Only for users logged in
    def only_signed_in

        if !current_coach
            redirect_to new_coach_path, danger: "Vous n'avez pas accès à cette page."
        end
    end


    #Is coach signed in?

    def is_coach_signed_in

        !current_coach.nil?

    end




    # Only for users logged out.

    def only_signed_out

        redirect_to profil_path if is_coach_signed_in
    
    end



    #Return the currently coach logged in user.

    def current_coach

        return nil if !session[:auth] || !session[:auth]['id']

        return @_coach if @_coach

        @_coach = Coach.find_by_id(session[:auth]['id'])

    end


end
