class ApplicationController < ActionController::Base
    #callbacks
    before_action :set_locale

    before_action :authenticate_user!#para que se autentique el usuario

    #maneja la excepcion para ridireccionar
    rescue_from CanCan::AccessDenied do |exception|
        redirect_to root_path
    end  

    def set_locale
        I18n.locale = 'es'
    end

end
