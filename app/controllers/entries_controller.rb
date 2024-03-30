class EntriesController < ApplicationController
  def create
    @entry = Entry.new(entry_params)
    if @entry.save
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    @entry = Entry.find(params[:id])
    if @entry.update(entry_params)
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @entry = Entry.find(params[:id])

    if @entry.destroy
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def entry_params
    params.require(:entry).permit(:user_id, :content, :img_content)
  end

end
