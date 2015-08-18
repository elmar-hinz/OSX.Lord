#! /usr/bin/env ruby

filename = File.dirname(__FILE__) + '/bootstrap.rc'
puts '* source bootstrapping environment settings from: ' + filename
ENV.replace(eval(`bash -c 'source #{filename} && ruby -e "p ENV"'`))

puts '* Ensuring Lord is cloned into ' + ENV['LORD_HOME'] 
unless(Dir.exists?(ENV['LORD_HOME'])) 
    cmd = 'git clone https://github.com/elmar-hinz/OSX.Lord.git ' + ENV['LORD_HOME'] 
    puts '* ' + cmd
    system(cmd)
end

puts '* Ensuring Homebrew is available ' 
unless(`brew --version`) 
    cmd = 'git clone https://github.com/Homebrew/homebrew.git ' + ENV['HOMEBREW_PREFIX'] 
    puts '* ' + cmd
    system(cmd)
    Dir.mkdir(ENV['HOMEBREW_TEMP'])
end

puts '* Ensuring Ansible is installed'
unless(`ansible --version`) 
    cmd = 'brew install ansible'
    puts '* ' + cmd
    system(cmd)
end

Dir.chdir(File.dirname(__FILE__) + '/Installation') do
    puts '* Changing into installation directory ' + Dir.pwd
    puts '* Running installation playbook'
    system('ansible-playbook install.yml') 
end

