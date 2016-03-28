class User < ActiveRecord::Base
  include EpiCas::DeviseHelper

  before_save :assign_role
  has_many :category
  has_many :question
  has_many :quiz
  has_many :language

  def assign_role
  	roleString = self.dn.split(',')[2].downcase

    self.role = roleString

  	if roleString.include? "student"
  		self.role = "student"
  	end

  	if roleString.include? "staff"
  		self.role = "staff"
  	end

    #hack so that my account will be staff
    if self.username == "aca12nw"
      self.role = "staff"
    end
  end

  def staff?
    self.role == "staff"
  end

end