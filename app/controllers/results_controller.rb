class ResultsController < ApplicationController

  before_action :load_result, only: [:show, :destroy]

  def index
    @results = Result.desc(:created_at).page(params[:page]).per(10)
  end

  def show
    prepare_meta_tags(title: @result.title,
                      status: @result.status)
  end

  def edit
    @result = Result.find(params[:id])
    @page_title       = 'Member Login'
    redirect_to :action=>'index'

  end

  def create
    @result = Result.new(
        title: $xvars["form_result"]["title"],
        status: $xvars["form_result"]["status"],
        estart: $xvars["form_result"]["estart"],
        eend: $xvars["form_result"]["eend"],
        user_id: $xvars["user_id"])
    @result.save!
  end

  def my
    @results = Result.where(user_id: current_ma_user).desc(:created_at).page(params[:page]).per(10)
    @page_title       = 'Member Login'
  end

  def update
    # $xvars["select_result"] and $xvars["edit_result"]
    # These are variables.
    # They contain everything that we get their forms select_result and edit_result
    result_id = $xvars["select_result"] ? $xvars["select_result"]["title"] : $xvars["p"]["result_id"]
    @result = Result.find(result_id)
    @result.update(title: $xvars["edit_result"]["result"]["title"],
                  status: $xvars["edit_result"]["result"]["status"])

  end

  def destroy
    if current_ma_user.role.upcase.split(',').include?("A") || current_ma_user == @result.user
      @result.destroy
    end
    redirect_to :action=>'index'
  end

  private

  def load_result
    @result = Result.find(params[:id])
  end


end
