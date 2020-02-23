class ApplicationController < ActionController::Base

    before_action :only_signed_in

    add_flash_types :success, :danger

    private

    def only_signed_in

        if !session[:auth] || !session[:auth]['id']
            redirect_to new_coach_path, danger: "Vous n'avez pas accès à cette page."
        end
    end
end
