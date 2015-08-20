#! /usr/bin/env ruby

mydir = File.dirname(File.realpath(__FILE__))

if(ARGV[0] == 'ansible')
    Dir.chdir(mydir + '/../Vendors/Lord/Me') do
        exec('ansible-playbook me.yml')
    end
else
    puts 'Usage: lord ansible' 
end

