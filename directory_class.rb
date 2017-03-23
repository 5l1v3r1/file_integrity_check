require 'digest'

UNIX = "U"
WINDOWS = "W"

class Directory

	attr_reader :path
	attr_reader :system_type
	attr_reader :ls
	attr_reader :ls_hash

	def initialize(path_,system_type_)

		raise unless path_.is_a?(String)
		raise unless system_type_.is_a?(String)

		if(system_type_ != "W" && system_type_ != "U") then 
			puts "Sytem type not recognized [W for windows, U for Unix like]";
			exit 
		end

		@path = path_
		@system_type = system_type_
		@ls = ""
		@ls_hash = ""
	end

	def ls()
		if @system_type == WINDOWS then 
			@ls = %x(dir #{@path})
		end 
		if @system_type == UNIX then 
			@ls = %x(ls #{@path})
		end
		#set_ls_hash
		return @ls
	end

	def set_ls_hash()
		@ls_hash = md5.digest @ls
	end
end