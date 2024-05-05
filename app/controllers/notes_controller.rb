class NotesController < ApplicationController
  before_action :require_user
  before_action :ensure_authorized_user, only: :destroy

  def create
    note = Note.new(params.require(:note).permit(:content, :track_id))
    note.author = current_user
    note.save
    redirect_to track_url(note.track_id)
  end

  def destroy
    @note.destroy
    redirect_to track_url(@note.track_id)
  end

  private

  def ensure_authorized_user
    @note = Note.find_by(id: params[:id])
    unless @note.author == current_user
      render plain: 'Unauthorized user!', status: :forbidden
    end
  end
end