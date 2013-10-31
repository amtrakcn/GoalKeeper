class GoalsController < ApplicationController
  before_filter :authenticate, :except => [:index]

  def new
    @goal = Goal.new
    render :new
  end

  def edit
    @goal = Goal.find(params[:id])
    render :edit
  end

  def create
    p params[:goal][:private_goal]
    @goal = Goal.new(params[:goal])
    @goal.user_id = self.current_user.id

    p @goal

    if @goal.save
      redirect_to goals_url
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def update
    @goal = Goal.find(params[:id])
    if @goal.update_attributes(params[:goal])
       @goal.save
       redirect_to goal_url(@goal)
     else
       flash.now[:errors] = @goal.errors.full_messages
       render :edit
     end
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy
    redirect_to goals_url
  end

  def show
    @goal = Goal.find(params[:id])
    render :show
  end

  def index
    if logged_in?
      @goals = Goal.where('(user_id = :id) OR (private_goal = :bool)', :id => self.current_user.id, :bool => false)
    else
      @goals = Goal.where('(private_goal = :bool)', :bool => false)
    end

    render :index
  end
end
