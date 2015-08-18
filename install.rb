#! /usr/bin/env ruby

# Set env LORD_HOME if not existant 
ENV['LORD_HOME'] = ENV['HOME'] + '/Library/Lord' unless(ENV.key?('LORD_HOME')) 

# Clone Lord
if(false) 
    cmd = 'git clone https://github.com/elmar-hinz/OSX.Lord.git ' + ENV['LORD_HOME'] 
    puts cmd
    system(cmd)
end

puts '* Ensuring Ansible is installed'
unless(`ansible --version`) 
    cmd = 'brew install ansible'
    puts cmd
    system(cmd)
end

Dir.chdir(File.dirname(__FILE__) + '/Installation') do
    puts '* Changing into installation directory ' + Dir.pwd
    puts '* Running installation playbook'
    system('ansible-playbook install.yml') 
end

