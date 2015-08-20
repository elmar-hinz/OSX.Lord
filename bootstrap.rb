#! /usr/bin/env ruby
 
def main()

    mydir = File.dirname(File.realpath(__FILE__))

    filename = File.realpath(mydir + '/bootstrap.rc')
    msg :green,  'Bootstrapping Lord', 'with environment from: ' + filename
    ENV.replace(eval(`bash -c 'source #{filename} && ruby -e "p ENV"'`))

    msg :green, 'Checking if Lord is already cloned' 
    if(Dir.exists?(ENV['LORD_HOME'])) 
        msg :yellow, 'Skip cloning', ENV['LORD_HOME'] + ' already exists'
    else
        cmd = 'git clone https://github.com/elmar-hinz/OSX.Lord.git ' + ENV['LORD_HOME'] 
        msg :green, 'Cloning Lord', cmd
        system(cmd)
    end

    msg :green, 'Checking if any brew bin is available'
    unless(`which brew`.empty?) 
        msg :green, 'Hombrew is available', ' in ' + `which brew`
    else
        cmd = 'git clone https://github.com/Homebrew/homebrew.git ' + ENV['HOMEBREW_PREFIX'] 
        msg :green, 'Cloning Homebrew', cmd
        system(cmd)
        Dir.mkdir(ENV['HOMEBREW_TEMP'])
    end

    msg :green, 'Checking if any ansible bin is available'
    unless(`which ansible`.empty?) 
        msg :green, 'Ansible is available', ' in ' + `which ansible`
    else
        cmd = 'brew install ansible'
        msg :green, 'Brewing Ansible', cmd
        system(cmd)
    end

    Dir.chdir(ENV['LORD_HOME'] + '/Installation') do
        msg :green, 'Changing into target installation directory ',  Dir.pwd
        msg :green, 'Running installation playbook'
        system('ansible-playbook install.yml') 
    end

end

def msg(status, title , text = NIL)
    prefixes = {} 
    prefixes[:green] =  " \033[1;32m✔ "
    prefixes[:yellow] = " \033[1;33m➜ "
    prefixes[:red] =    " \033[1;31m✖ "
    puts prefixes[status] << title << "\033[0m" 
    puts "\t" << text if text
end

main()


