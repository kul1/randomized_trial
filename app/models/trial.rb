# encoding: utf-8
class Trial
  include Mongoid::Document
  # jinda begin
  include Mongoid::Timestamps
  field :title, :type => String
  field :status, :type => String
  belongs_to :user
  field :estart, :type => Date
  field :eend, :type => Date
  # jinda end
end
