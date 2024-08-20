# KChallenge Moski iOS App

## Contents
- [Getting Started](#getting-started)
- [Running](#running)
- [Testing](#testing)
- [Releasing](#releasing)

## Getting Started
### Style Guide

To accomplish the code challenge project, my primary goals are:

- Clarity of code
- Consistency throughout the codebase
- Brevity of logic/statements

All in that order.

### Prerequisites

- Make sure to have `read` and `write` access to the `KChallenge` repo. `Myself`  can help with that!
- Have [KChallenge](https://github.com/guerravc/KChallenge) repo cloned to your local machine.

#### Dependencies

* [Homebrew](https://brew.sh/) - running `make homebrew-install` will only install/update Homebrew as well as all the dependencies defined in `Brewfile`, you can also run `make init` which will run through all targets needed to install/update dependencies

##### Installed through Homebrew 
* [Git Large File Storage](https://git-lfs.github.com/) - running `make git-lfs-install` will only install `git lfs`
* [rbenv](https://github.com/rbenv/rbenv) - running `brew install rbenv` will install `rbenv`  
* [Ruby](https://www.ruby-lang.org/en/) - running `make ruby-install` will only install `ruby` using the version defined in `.ruby-version` and the ruby packages defined in `Gemfile`, you can also run `make init` which will run through all targets needed to install/update dependencies

##### Installed using Ruby and RubyGems
* [Cocoapods](https://cocoapods.org/)


#### Setup Project - for the first time

- Run `make init` will do the following:
  - Installs:
    - `homebrew` if needed, and install `brew` dependencies listed in this project's `Brewfile`
    - `bundler` v2.X, if needed.
    - gems
    - pods

## Running

### Locally -- How do I
#### Clean the project

- Run `make clean`.
- This helps remove pre-compiled assets that may be stale for the current build environment.
- You can also press `command + shift + K` in Xcode to clean your project.

#### Reset the project

- Run `make reset`.
- Sometimes, the project configuration gets to a weird state and we would just like to start fresh. This command removes: the Gems, Pods and build caches for Cocoapods and bundler. After running this command, you might want to run `make init` to get things setup correctly again.

#### Run project on

##### Simulator
- Use KChallengDev targe.
- In Xcode, select the simulated device you would want to run on in the top left corner of the IDE.
- Press `command + R` to run the project.


## Testing
### Unit Tests

- In Xcode, press `command + U` to run unit tests.


## Releasing
### Pull Requests

All code merged into `dev` must be merged via a pull request.

