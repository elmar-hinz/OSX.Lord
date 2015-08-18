# Local OSX Maintainance with Ansible

Maintain packages and dotfiles by use of Ansible. Strive to maintain the packages
in the user directory or alternatively on USB stick as far as possible.

## Separation of Private and Public Configuration

* Keep public usable parts as general as posible.
* Set useful default values.
* Hook in files for private settings and customizing to overwrite defaults. 
* The private files are excluded from github by use of `.gitignore`.
* Bundle personal settings in OSX.Lord/Configuration.

## Structure

* OSX.Lord
    * OSX.Lord/ Conatiner directory
    * OSX.Lord/install.rb installation
    * OSX.Lord/lord.rb the user interface
    * OSX.Lord/Vendors/ repositories go here
    * OSX.Lord/Configuration/ personal configurations go here
* OSX.Lord.core
    * This git repository contains the main playbook. 
    * It draws other repsitories in a modular way from github. 
    * It delegates to them. 
    * There are at least two such repositories  **packages** and **dotfiles**.
* OSX.Lord.core.packages
    * This repository maintains the packages by use of package managers **homebrew**,     **caskroom**, **gem**, **pip** and others.
    * The general part maintains this managers themself.
    * The wanted packages are listet in the personal configuration.
* OSX.Lord.core.dotfiles
    * The dotfiles are keept in git repositories.
    * They are symlinkt into the user directory.
* OSX.Lord.core.bundles
    * Modularisation similar to vim bundles.
    * Bundles bundle configuration for *core.packages* and *core.dotfiles*.  
    * Bundles are keept in git repositories.

## Prerequests

* homebrew
* ansible (`brew ansible`)
* To install into the user directory follow setup in OSX.homebrew-at-home

