#!/usr/bin/ruby
$VERBOSE = nil

#sudo gem install diffy
require 'diffy'

def ls_ (directory_)
	ls = %x(ls #{directory_})
	return ls.to_s
end

def integrity_check(directory)
	ls = ls_(directory)
	loop do
		new_ls = ls_(directory)
		if(ls != new_ls)
			puts "Ha cambiado el directorio " + directory
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
if ! ARGV[0] || ARGV[0] == "-h"
	puts "-----------------------------------------------"
	puts "|  File Integrity Check 0.1b - Gonzalo García |"
	puts "|  Uso:                                       |"
	puts "|      ./integrity.rb <directorio>            |"
	puts "|                                             |"
	puts "|  Plataformas: Unix/Linux                    |"
	puts "-----------------------------------------------"
	exit
end

directory = ARGV[0]
integrity_check(directory)


