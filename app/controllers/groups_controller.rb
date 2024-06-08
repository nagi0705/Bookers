# app/controllers/groups_controller.rb
class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: [:show, :edit, :update, :destroy, :join, :leave]

  def index
    @groups = Group.all
  end

  def show
    @members = @group.users
  end

  def new
    @group = Group.new
  end

  def create
    @group = current_user.owned_groups.build(group_params)
    if @group.save
      redirect_to @group, notice: 'Group was successfully created.'
    else
      render :new
    end
  end

  def edit
    unless @group.owner == current_user
      redirect_to @group, alert: "You are not the owner of this group."
    end
  end

  def update
    if @group.update(group_params)
      redirect_to @group, notice: 'Group was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @group.destroy
    redirect_to groups_url, notice: 'Group was successfully destroyed.'
  end

  def join
    if !@group.users.include?(current_user)
      @group.users << current_user
      redirect_to @group, notice: "You have joined the group."
    else
      redirect_to @group, alert: "You are already a member of this group."
    end
  end

  def leave
    if @group.users.include?(current_user)
      @group.users.delete(current_user)
      redirect_to @group, notice: "You have left the group."
    else
      redirect_to @group, alert: "You are not a member of this group."
    end
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :description)
  end
end
