module ApplicationHelper

    def current_user_admin?
        if user_signed_in?
            current_user.admin
        else
            false
        end
    end

end
