require 'digest'

UNIX = "U"
WINDOWS = "W"

class Directory

	attr_reader :path
	attr_reader :system_type
	attr_accessor :ls
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
		@ls = dols
		@ls_hash = ""
	end

	def dols()
		if @system_type == WINDOWS then 
			return %x(dir #{@path})
		end 
		if @system_type == UNIX then 
			return %x(ls #{@path})
		end
	end

	def set_ls_hash()
		@ls_hash = md5.digest @ls
	end
end