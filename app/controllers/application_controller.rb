class ApplicationController < ActionController::Base
    before_action :set_locale

    before_action :authenticate_user!#para que se autentique el usuario


    def set_locale
        I18n.locale = 'es'
    end
end
