#!/usr/bin/ruby
$VERBOSE = nil

#sudo gem install diffy
require 'diffy'
#sudo gem install parallel
require 'parallel'
require 'socket'
require './directories_reader.rb'

def log(message)
	time = Time.new
	File.open("integrity.log", "a+") { |file| file.puts "[#{time}] - " + message }
end

def send_changes_to_logstash(head,files)
	begin
		socket = TCPSocket.new ARGV[1],1337
		message = "#{head}".gsub("\n","")
		for i in 0..files.length-1 do message = message + "; " + files[i] end
		socket.puts message.gsub("-","").gsub("+","")
	rescue StandardError
		log("No pudo conectarse al servidor Logstash: #{ARGV[1]}")
		puts "No pudo conectarse al servidor Logstash: #{ARGV[1]}"
	end
end

def integrity_check(directory)
	#Compara el hash actual, con un nuevo hash sobre
	#el directorio
	if(directory.ls_hash != directory.do_ls_hash)
		diff = Diffy::Diff.new(directory.ls, directory.do_ls).to_s
		#Busca si se han eliminado ficheros
		deleted_files = diff.to_s.scan(/^-.*$/)
		#Busca si se han añadido ficheros
		added_files = diff.to_s.scan(/^\+.*$/)

		if(deleted_files.length > 0)
			send_changes_to_logstash("[#{directory.path}] Se han eliminado ficheros",deleted_files)
		end
		if(added_files.length > 0)
			send_changes_to_logstash("[#{directory.path}] Se han añadido ficheros",added_files)
		end
		directory.update
	end
end

## Main

dirs_under_check = DirectoriesReader.new(ARGV[0])

#Bucle infinito miltihilo que procesa varios directorio simultáneamente
sem = Mutex.new
loop do
	results = Parallel.map(dirs_under_check.directories,in_threads: dirs_under_check.count.to_i) do |dir|
			sem.synchronize { integrity_check(dir) }
	end
	sleep(1)
end


if ! ARGV[0] || ARGV[0] == "-h" || ARGV[1] == ""
	puts "------------------------------------------------------------------"
	puts "|  Directory Integrity Check for Logstash 0.8b - Gonzalo García  |"
	puts "|  Uso:                                            			   |"
	puts "|      ./check.rb test.txt <ip_logstash>                         |"
	puts "|                                                                |"
	puts "|  Plataformas: Unix/Linux                                       |"
	puts "------------------------------------------------------------------"
	exit
end


