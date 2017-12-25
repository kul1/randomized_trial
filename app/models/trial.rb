# encoding: utf-8
class Trial
  include Mongoid::Document
  # jinda begin
  include Mongoid::Timestamps
  field :title, :type => String
  field :enrollment_start, :type => Date
  field :enrollment_end, :type => Date
  field :proposed, :type => Date
  field :status, :type => String
  # jinda end
end
