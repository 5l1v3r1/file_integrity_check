require './directory_class.rb'

class DirectoriesReader
	attr_reader :directories
	def initialize(file_path_)
		@directories = Array.new
		File.foreach(file_path_) { |line_|  @directories.push(Directory.new(line_,"U"))}
	end
	def count
		return @directories.length
	end

	def [] (pos)
		return @directories[pos]
	end
end