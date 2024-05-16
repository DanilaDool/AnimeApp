class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']

    # Проверяем, существует ли пользователь с полученным UID от провайдера
    user = User.find_by(uid: auth['uid'])

    if user
      # Если пользователь найден, входим в систему
      session[:user_id] = user.id
      @user = user
      redirect_to root_path, notice: 'Вы успешно вошли в систему!'
    else
      # Если пользователь не найден, создаем нового пользователя на основе полученных данных

      new_user = User.create(
        uid: auth['uid'],
        name: auth['info']['name'],
        email: auth['info']['email'],
        image: auth['info']['image']
      # Дополнительные данные о пользователе могут быть добавлены сюда в соответствии с вашими потребностями
      )

      if new_user.persisted?
        session[:user_id] = new_user.id
        @user = new_user
        create_default_lists_for_user(new_user)
        redirect_to root_path, notice: 'Регистрация прошла успешно. Вы вошли в систему!'
      else
        redirect_to root_path, alert: 'Ошибка при создании пользователя'
      end
    end
  end

  def destroy
    session[:user_id] = nil
    @user = nil
    redirect_to root_path, notice: 'Вы успешно вышли из системы!'
  end

  private

  def create_default_lists_for_user(user)
    list_names = ["Смотрю", "Просмотрено", "Брошено"]
    list_names.each do |name|
      user.lists.create(name: name)
    end
  end
end
