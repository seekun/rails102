class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end
  def new
    @group = Group.new
  end

  def create

  end

  def edit

  end

  def update

  end

  def delete

  end

  def show

  end
end
