class GrantSnippetsController < ApplicationController
  before_action :set_grant_snippet, only: [:show, :edit, :update, :destroy]

  # GET /grant_snippets
  def index
    @grant_snippets = GrantSnippet.all
  end

  # GET /grant_snippets/1
  def show
  end

  # GET /grant_snippets/new
  def new
    @grant_snippet = GrantSnippet.new(grant_id: params[:grant_id])
  end

  # GET /grant_snippets/1/edit
  def edit
  end

  # POST /grant_snippets
  def create
    @grant_snippet = GrantSnippet.new(grant_snippet_params)

    if @grant_snippet.save
      # redirect_to @grant_snippet, notice: 'Grant snippet was successfully created.'
      redirect_to new_admin_account_path(grant_id: @grant_snippet.grant_id), notice: 'Your snippets were successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /grant_snippets/1
  def update
    if @grant_snippet.update(grant_snippet_params)
      redirect_to @grant_snippet, notice: 'Grant snippet was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /grant_snippets/1
  def destroy
    @grant_snippet.destroy
    redirect_to grant_snippets_url, notice: 'Grant snippet was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_grant_snippet
      @grant_snippet = GrantSnippet.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def grant_snippet_params
      params.require(:grant_snippet).permit(:general_desc, :highlights, :eligibility, :grant_id)
    end
end
