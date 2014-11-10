class UsersController < ApplicationController
  def index
    @user = User.new(params[:user])
    
    respond_to do |format|
      if @user.save
        # Tell the UserMailer to send a welcome email after save
        UserMailer.welcome_email(@user).deliver
        
        format.html { redirect_to(@user, notice: 'User was successfully created.') }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.welcome_email(@user).deliver
      flash.now[:success] = I18n.t :success, :scope => [:user, :create]
      redirect_to contact_us_users_path
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:user, :create]
      render "new"
    end
  end


  def edit
  end

  def new
  end
  def user_params
    params.require(:user).permit( :name, :email, :details)
  end
end
