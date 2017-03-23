require './directory_class.rb'

SYSTEM_TYPE = "U"

class DirectoriesReader
	attr_reader :directories
	def initialize(file_path_)
		@directories = Array.new
		File.foreach(file_path_) { |line_|  @directories.push(Directory.new(line_,SYSTEM_TYPE))}
	end
	def count
		return @directories.length
	end

	def [] (pos)
		return @directories[pos]
	end
end