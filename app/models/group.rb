class Group < ActiveRecord::Base
	has_many :members

	require 'csv'

	def self.import(file)
		if file.respond_to?(:read)
		  csv_text = file.read
		elsif file.respond_to?(:path)
		  csv_text = File.read(file.path)
		else
		  logger.error "Bad file_data: #{file.class.name}: #{file.inspect}"
		end


		CSV.foreach(csv_text, headers: true) do |row|

		  user_hash = row.to_hash 
		  user = user.where(email: product_hash["Email"])

		  raise user_hash.inspect

		  if user.count == 1
		  	Member.create(
			    :student_id => user.first.id, 
			    :group_id => params[:id])
		  else
		    @newUser = User.create!(
		    	:email => row["Email"],
		    	:username => row["Student Username"],
		    	:uid => row["Student Username"],
		    	:mail => row["Email"],
		    	:sn => row["Surname"],
		    	:givenname => row["Forename"],
		    	:role => "student")
		    Member.create(
			    :student_id => @newUser.id, 
			    :group_id => params[:id])
		  end 
		end 
	end 
end
