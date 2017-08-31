class AdminAccountsController < ApplicationController
  before_action :set_admin_account, only: [:show, :edit, :update, :destroy]

  # GET /admin_accounts
  def index
    @admin_accounts = AdminAccount.all
  end

  # GET /admin_accounts/1
  def show
  end

  # GET /admin_accounts/new
  def new
    @admin_account = AdminAccount.new(grant_id: params[:grant_id])
  end

  # GET /admin_accounts/1/edit
  def edit
  end

  # POST /admin_accounts
  def create
    @admin_account = AdminAccount.new(admin_account_params)

    if @admin_account.save
    
      redirect_to grant_path(id: @admin_account.grant_id), notice: 'You\'ve completed the sign up process.'
    else
      render :new
    end
  end

  # PATCH/PUT /admin_accounts/1
  def update
    if @admin_account.update(admin_account_params)
      redirect_to @admin_account, notice: 'Admin account was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /admin_accounts/1
  def destroy
    @admin_account.destroy
    redirect_to admin_accounts_url, notice: 'Admin account was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_account
      @admin_account = AdminAccount.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def admin_account_params
      params.require(:admin_account).permit(:admin1_email, :admin1_pwd, :admin2_email, :admin2_pwd, :admin3_email, :admin3_pwd, :admin4_email, :admin4_pwd, :admin5_email, :admin5_pwd, :grant_id)
    end
end
