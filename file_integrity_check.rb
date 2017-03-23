#!/usr/bin/ruby
$VERBOSE = nil

#sudo gem install diffy
require 'diffy'
require './directories_reader.rb'

def integrity_check(directory)
	ls = directory.ls
	loop do
		new_ls = directory.ls
		if(ls != new_ls)
			puts "Ha cambiado el directorio " + directory.path
			diff = Diffy::Diff.new(ls, new_ls).to_s
			#Busca si se han eliminado ficheros
			deleted_files = diff.to_s.scan(/^-.*$/)
			#Busca si se han añadido ficheros
			added_files = diff.to_s.scan(/^\+.*$/)

			if(deleted_files.length > 0)
				puts "Ficheros eliminados: "
				for i in 0..deleted_files.length-1
					puts "\t" + deleted_files[i]
				end
			end
			if(added_files.length > 0)
				puts "Ficheros añadidos: "
				for i in 0..added_files.length-1
					puts "\t" + added_files[i]
				end
			end

			ls = new_ls
		end
	sleep(5)
	end
end

## Main

dirs_under_check = DirectoriesReader.new(ARGV[0])

for i in 0..dirs_under_check.count-1 do
	integrity_check dirs_under_check[i]
end


if ! ARGV[0] || ARGV[0] == "-h" || ARGV[1] == ""
	puts "-----------------------------------------------"
	puts "|  File Integrity Check 0.1b - Gonzalo García |"
	puts "|  Uso:                                       |"
	puts "|      ./integrity.rb test.txt                |"
	puts "|                                             |"
	puts "|  Plataformas: Unix/Linux                    |"
	puts "-----------------------------------------------"
	exit
end


