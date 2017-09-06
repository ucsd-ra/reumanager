class SnippetsController < ApplicationController
  def index
    @grant = current_grant
    @snippets = Snippet.all
  end

  def create
    if current_grant.update_attributes(grant_params)
      redirect_to new_admin_account_path, notice: 'You have successfully updated your snippets.'
    else
      render :index
    end
  end

  protected

  def grant_params
    params.require(:grant)
      .permit(:snippets_attributes => [:id, :value])
  end
end
