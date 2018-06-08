class Api::DepartmentsController < ApplicationController
  before_action :set_api_department, only: [:show, :update, :destroy]

  # GET /api/departments
  # GET /api/departments.json
  def index
    @api_departments = Department.all
    render json: @api_departments
  end

  # GET /api/departments/1
  # GET /api/departments/1.json
  def show
  end

  # POST /api/departments
  # POST /api/departments.json
  def create
    @api_department = Department.new(api_department_params)

    if @api_department.save
      render :show, status: :created, location: @api_department
    else
      render json: @api_department.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/departments/1
  # PATCH/PUT /api/departments/1.json
  def update
    if @api_department.update(api_department_params)
      render :show, status: :ok, location: @api_department
    else
      render json: @api_department.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/departments/1
  # DELETE /api/departments/1.json
  def destroy
    @api_department.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_department
      @api_department = Api::Department.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def api_department_params
      params.fetch(:api_department, {})
    end
end
