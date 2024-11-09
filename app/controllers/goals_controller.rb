class GoalsController < ApplicationController
    before_action :set_couple
    before_action :set_goal, only: %i[show edit update destroy mark_as_achieved]

    def index
      @goals = @couple.goals
      @pending_goals = @goals.where(achieved: false).order(due_date: :asc)
      @completed_goals = @goals.where(achieved: true).order(due_date: :asc)
    end

    def new
      @goal = @couple.goals.new
    end

    def create
      @goal = @couple.goals.new(goal_params)
      if @goal.save
        redirect_to couple_goals_path(@couple.slug), notice: 'Meta criada com sucesso!'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit; end

    def update
      if @goal.update(goal_params)
        redirect_to couple_goals_path(@couple.slug), notice: 'Meta atualizada com sucesso!'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @goal.destroy
      redirect_to couple_goals_path(@couple.slug), notice: 'Meta removida com sucesso!'
    end

    def mark_as_achieved
      @goal.update(achieved: true)
      redirect_to couple_goals_path(@couple.slug), notice: 'Meta marcada como atingida!'
    end

    private

    def set_couple
      @couple = Couple.find_by(slug: params[:couple_slug])
    end

    def set_goal
      @goal = @couple.goals.find(params[:id])
    end

    def goal_params
      params.require(:goal).permit(:title, :description, :due_date, :achieved)
    end
end
