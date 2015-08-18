#! /usr/bin/env ruby

mydir = File.dirname(File.realpath(__FILE__))

if(ARGV[0] == 'ansible')
    Dir.chdir(mydir + '/../Vendors/Lord/Ansible') do
        exec('ansible-playbook osx.yml')
    end
else
    puts 'Usage: lord ansible' 
end

