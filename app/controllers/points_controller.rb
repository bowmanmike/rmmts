class PointsController < ApplicationController

  before_action :load_mate

  def create
    @point = @mate.points.build(point_params)
    @point.points_attributes(item)
  end

  private
  def point_params
    params.require(:point).permit(:name, :amount, :completed_date, :due_date, :category, :category_id)
  end

  def load_mate
    @mate = Mate.find(params[:mate_id])
  end
end
