class ListsController < ApplicationController
  def index
    @lists = current_user.lists
  end

  def create
    @list = current_user.lists.build(list_params)

    if @list.save
      redirect_to request.referrer, notice: "List created successfully"
    else
      redirect_to request.referrer, alert: "Error creating list"
    end
  end

  def show
    @lists = current_user.lists
    @list = List.find(params[:id])
  end

  def update_list1
    update_list("Смотрю")
  end

  def update_list2
    update_list("Просмотрено")
  end

  def update_list3
    update_list("Брошено")
  end

  def destroy
    @list = List.find(params[:id])

    if @list.destroy
      redirect_back(fallback_location: root_path)
    else
      redirect_to request.referrer, alert: "Error deleting list"
    end
  end

  private

  def update_list(list_name)
    list = current_user.lists.find_by(name: list_name)
    shikimori_id = params[:list][:shikimori_id]

    if list.animes.include?(shikimori_id.to_s)
      redirect_to request.referrer
    else
      anime = Anime.find_by(shikimori_id: shikimori_id)
      if anime

      current_user.lists.each do |list_name|
        if list_name.animes.include?(anime.shikimori_id.to_s)
          list_name.animes.delete(anime.shikimori_id.to_s)
          list_name.save
        end
      end

        list.animes << shikimori_id.to_s

        if list.save
          redirect_to request.referrer
        else
          redirect_to request.referrer, alert: "Error saving list"
        end
      else
        redirect_to request.referrer, alert: "Anime not found"
      end
    end
  end

  def list_params
    params.require(:list).permit(:name, animes: [])
  end
end
