# encoding: utf-8
class Trial
  include Mongoid::Document

  # jinda begin
  include Mongoid::Timestamps
  field :title, :type => String
  field :status, :type => String
  field :estart, :type => Date
  field :eend, :type => Date
  belongs_to :user
end
