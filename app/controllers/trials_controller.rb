class TrialsController < ApplicationController
  before_action :load_trial, only: [:show, :destroy]

	def index
    @trials = Trial.desc(:created_at).page(params[:page]).per(10)
	end

  def show 
    prepare_meta_tags(title: @trial.title,
                      status: @trial.status)
  end

  def edit
    @trial = Trial.find(params[:id])
    @page_title       = 'Member Login'
    redirect_to :action=>'index'

  end



  def create
    @trial = Trial.new(
        title: $xvars["form_trial"]["trial"]["title"],
        status: $xvars["form_trial"]["trial"]["status"],
        estart: $xvars["form_trial"]["trial"]["estart"],
        eend: $xvars["form_trial"]["trial"]["eend"],
        user_id: $xvars["user_id"])
    @trial.save!

  end

  def my
    @trials = Trial.where(user_id: current_ma_user).desc(:created_at).page(params[:page]).per(10)
    @page_title       = 'Member Login'
  end

  def update
    # $xvars["select_trial"] and $xvars["edit_trial"]
    # These are variables.
    # They contain everything that we get their forms select_trial and edit_trial
    trial_id = $xvars["select_trial"] ? $xvars["select_trial"]["title"] : $xvars["p"]["trial_id"]
    @trial = Trial.find(trial_id)
    @trial.update(
        title: $xvars["edit_trial"]["trial"]["title"],
        status: $xvars["edit_trial"]["trial"]["status"],
        estart: $xvars["edit_trial"]["trial"]["estart"],
        eend: $xvars["edit_trial"]["trial"]["eend"])
  end

  def destroy
    if current_ma_user.role.upcase.split(',').include?("A") || current_ma_user == @trial.user
      @trial.destroy
    end
      redirect_to :action=>'index'
  end

  private

  def load_trial
    @trial = Trial.find(params[:id])
  end


end
