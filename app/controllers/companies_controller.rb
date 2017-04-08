class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token

  # GET /companies
  # GET /companies.json
  def index
    @companies = Company.all
    @companies = @companies.paginate(page: params[:page], per_page: params[:limit])
    if (params[:sort] == nil)
      render :json => {:companies => @companies}
    else
      if /\-/.match(params[:sort])
        var = params[:sort]
        var = var.sub('-', '')
        render :json => {:companies => @companies.order(var+ " " +"DESC")}
      else
        render :json => {:companies => @companies.order("#{params[:sort]} ASC")}
      end

    end
  end


  # GET /companies/1
  # GET /companies/1.json
  def show
    @company = Company.find(params[:id])
    render :json => {:company => @company}
  end

  # GET /companies/new
  def new
    @company = Company.new
  end

  # GET /companies/1/edit
  def edit
  end

  # POST /companies
  # POST /companies.json
  def create
    @company = Company.new(company_params)
    @company.save
    render :json => {:company => @company}

  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
      @company = Company.find(params[:id])
      @company.update(company_params)
      render :json => {:companies => @company}
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to companies_url, notice: 'Company was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.permit(:name, :description, :address, :phone)
    end
end
