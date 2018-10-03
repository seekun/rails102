class GroupsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :join, :quit]
  before_action :find_group_and_check_permission, only: [:edit, :update, :destroy, :join, :quit]

  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.user = current_user
    if @group.save
      redirect_to groups_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    @group.update(group_params)

    redirect_to groups_path, notice: "Update Success"
  end

  def destroy
    @group.destroy
    redirect_to groups_path, alert: "Group deleted"
  end

  def show
    @group = Group.find(params[:id])
    @posts = @group.posts.recent.paginate(:page => params[:page], :per_page => 5)
  end

  def join
    @group = Group.find(params[:id])
    puts "test1"

    if !current_user.is_member_of?(@group)
      current_user.join!(@group)
      flash[:notice] = "Join Secceeded"
    else
      flash[:warning] = "Join Falied"
    end

    redirect_to group_path(@group)
  end

  def quit
    @group = Group.find(params[:id])

    if current_user.is_member_of?(@group)
      current_user.quit!(@group)
      flash[:alert] = "Quit Secceeded"
    else
      flash[:warning] = "Quit Failed"
    end

    redirect_to group_path(@group)
  end

  private

  def find_group_and_check_permission
    @group = Group.find(params[:id])

    if current_user != @group.user
      redirect_to root_path, alert: "You have no permission."
    end
  end

  def group_params
    params.require(:group).permit(:title, :description)
  end
end
