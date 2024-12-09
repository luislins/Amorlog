class GoalsController < ApplicationController
    include ActionView::RecordIdentifier

    before_action :set_couple
    before_action :set_goals, only: %i[index update]
    before_action :set_goal, only: %i[show edit update destroy mark_as_achieved]

    def index
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
        redirect_to couple_goals_path(@couple.slug), alert: @goal.errors.full_messages.to_sentence
      end
    end

    def destroy
      @goal.destroy
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.remove(dom_id(@goal))
        end
        format.html { redirect_to couple_goals_path(@couple.slug), notice: 'Meta removida com sucesso!' }
      end
    end

    def mark_as_achieved
      if @goal.update(achieved: true)
        redirect_to couple_goals_path(@couple.slug), notice: 'Meta concluída com sucesso!'
      else
        redirect_to couple_goals_path(@couple.slug), alert: 'Não foi possível concluir a meta.'
      end
    end

    def remove_image
      @goal = Goal.find(params[:id])
      image = @goal.images.find(params[:image_id])
      image.purge
      redirect_to edit_couple_goal_path(@couple.slug, @goal), notice: 'Imagem removida com sucesso.'
    end

    private

    def set_couple
      @couple = Couple.find_by(slug: params[:couple_slug])
      return unless @couple.nil? || @couple.user != current_user

      redirect_to root_path, alert: 'Acesso não autorizado.'
    end

    def set_goal
      @goal = @couple.goals.find(params[:id])
    end

    def set_goals
      @goals = @couple.goals
    end

    def goal_params
      params.require(:goal).permit(
        :title,
        :description,
        :due_date,
        :kind,
        :numeric_value,
        :achieved,
        images: []
      )
    end
end
