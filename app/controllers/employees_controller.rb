class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token


  # GET /employees
  # GET /employees.json
  def index
    @employees = Employee.all
    @employees = @employees.paginate(page: params[:page], per_page: params[:limit])
    if (params[:sort] == nil)
      render :json => {:employees => @employees}
    else
      if /\-/.match(params[:sort])
        var = params[:sort]
        var = var.sub('-', '')
        render :json => {:employees => @employees.order(var+ " " +"DESC")}
      else
        render :json => {:employees => @employees.order("#{params[:sort]} ASC")}
      end
    end

  end

  # GET /employees/1
  # GET /employees/1.json
  def show
    @employee = Employee.find(params[:id])
    render :json => {:employee => @employee}
  end

  # GET /employees/new
  def new
    @employee = Employee.find(params[:id])
    @employee = Employee.new
  end

  # GET /employees/1/edit
  def edit
  end

  # POST /employees
  # POST /employees.json
  def create
    @employee = Employee.new(employee_params)
    @employee.save
    render :json => {:employee => @employee}
  end

  # PATCH/PUT /employees/1
  # PATCH/PUT /employees/1.json
  def update
    @employee = Employee.find(params[:id])
    @employee.update(employee_params)
    render :json => {:employee => @employee}
  end

  # DELETE /employees/1
  # DELETE /employees/1.json
  def destroy
    @employee.destroy
    respond_to do |format|
      format.html { redirect_to employees_url, notice: 'Employee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def employe_company
    query_id1 = ActiveRecord::Base.connection.quote(params[:company_id])
    @results = ActiveRecord::Base.connection.exec_query("SELECT * FROM employee WHERE company_id = #{query_id1}")
    @results = @results.paginate(page: params[:page], per_page: params[:per_page])
    sort_params = { "name" => "firts_name", "last_name" => "last_name" , "phone" => "phone", "email"=> "email", "mobile"=>"mobile", "company_id" =>"company_id" }
    render :json => {:employees => @results.order(sort_params[params[:sort]])}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
      params.permit(:first_name, :last_name, :email, :phone, :mobile, :company_id)
    end
end
