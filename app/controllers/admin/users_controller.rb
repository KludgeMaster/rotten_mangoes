class Admin::UsersController < ApplicationController

  before_action :must_be_admin

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # session[:user_id] = @user.id
      redirect_to admin_users_path, notice: "You created and logged in as #{@user.firstname}!"
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to admin_user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    # @user.destroy
    # binding.pry
    # respond_to do |format|
    #   if 
    @user.destroy
    binding.pry
    if @user.destroyed? 
        # binding.pry
        # Tell the UserMailer to send a welcome email after save
    UserMailer.byebye_email(@user)
    else

    #some other stuff.  
 
        # format.html { redirect_to admin_users_path }
        # format.json { render json: @user, status: :created, location: @user }
      # else
      #   format.html { render action: 'new' }
      #   format.json { render json: @user.errors, status: :unprocessable_entity }
    #   end
    # end
    # @user = User.find(session[:user_id])
    
    end
    redirect_to admin_users_path
  end

  protected

  def must_be_admin
    if !current_user || !current_user.admin
      flash[:error] = "must be a admin"
      redirect_to new_session_path
    end
  end

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin)
  end

end
##########################################################################################


