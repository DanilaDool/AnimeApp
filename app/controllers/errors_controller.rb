class ErrorsController < ApplicationController
  def not_found
    respond_to do |format|
      format.html { render status: 404 }
    end
  end

  def invalid
    respond_to do |format|
      format.html { render status: 422 }
    end
  end

  def internal_server
    respond_to do |format|
      format.html { render status: 500 }
    end
  end

  def bad_request
    respond_to do |format|
      format.html { render status: 400 }
    end
  end

  def unauthorized
    respond_to do |format|
      format.html { render status: 401 }
    end
  end

  def forbidden
    respond_to do |format|
      format.html { render status: 403 }
    end
  end

  def request_timeout
    respond_to do |format|
      format.html { render status: 408 }
    end
  end

  def too_many_requests
    respond_to do |format|
      format.html { render status: 429 }
    end
  end

  def service_unavailable
    respond_to do |format|
      format.html { render status: 503 }
    end
  end

  #ТЕСТЫ ОШИБОК
  def trigger_422
    render plain: "Искусственная ошибка 422", status: :unprocessable_entity
  end

  def trigger_500
    raise "Искусственная ошибка 500"
  end

  def trigger_404
    raise "Искусственная ошибка 404"
  end

  def trigger_400
    raise "Искусственная ошибка 400"
  end

  def trigger_401
    raise "Искусственная ошибка 401"
  end

  def trigger_403
    raise "Искусственная ошибка 403"
  end

  def trigger_408
    raise "Искусственная ошибка 408"
  end

  def trigger_429
    raise "Искусственная ошибка 429"
  end

  def trigger_503
    raise "Искусственная ошибка 503"
  end


end
