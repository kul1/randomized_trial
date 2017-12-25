# encoding: utf-8
class Result
  include Mongoid::Document
  # jinda begin
  include Mongoid::Timestamps
  belongs_to:user
  belongs_to:trial
  field :treatment_group, :type => String
  field :variable_specific, :type => String
  # jinda end
end
