require 'digest'

UNIX = "U"
WINDOWS = "W"

class Directory

	attr_reader :path
	attr_reader :system_type
	attr_accessor :ls
	attr_accessor :ls_hash

	def initialize(path_,system_type_)

		raise unless path_.is_a?(String)
		raise unless system_type_.is_a?(String)

		if(system_type_ != "W" && system_type_ != "U") then 
			puts "Sytem type not recognized [W for windows, U for Unix like]";
			exit 
		end

		@path = path_
		@system_type = system_type_
		@ls = do_ls
		@ls_hash = do_ls_hash

		
	end

	#Retorna un ls sobre el directorio
	def do_ls()
		if @system_type == WINDOWS then 
			return %x(dir #{@path})
		end 
		if @system_type == UNIX then 
			return %x(ls #{@path})
		end
	end

	def do_ls_hash()
		md5 = Digest::MD5.new
		return md5.hexdigest do_ls
	end

	def update()
		@ls = do_ls
		md5 = Digest::MD5.new
		@ls_hash = md5.hexdigest @ls
	end
end