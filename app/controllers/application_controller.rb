class ApplicationController < ActionController::Base
    before_action :authenticate_user!

    protected

    def after_sign_in_path_for(resource)
        if resource.admin?
            admin_users_path
        else
            super
        end
    end
end