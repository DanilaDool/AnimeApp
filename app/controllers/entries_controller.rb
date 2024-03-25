class EntriesController < ApplicationController

  def create
    @entry = Entry.new(entry_params)
    @entry.save

  end

  def update

  end

  def destroy

  end

  private

  def entry_params
    params.require(:entry).permit(:user_id, :content)
  end

end
