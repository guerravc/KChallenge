.DEFAULT_GOAL := help
SHELL:=/bin/bash
.SILENT: init

clean: ## Runs xcodebuild clean
	bundle exec xcodebuild clean -workspace "KChallenge.xcworkspace" -scheme "KChallengeDev"

git-lfs-install: ## Install git-lfs
	git lfs install

init: homebrew-install git-lfs-install ruby-install pods-install
	echo "Project initialization is complete!"
	echo "IMPORTANT: Make sure to set the PERSONAL ACCESS TOKEN into the project"

homebrew-install: ## Installs homebrew and dependencies from Brewfile
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	brew bundle

ruby-install: ## Installs Ruby and RubyGems from Gemfile
	$(info Installing ruby, bundler and ruby gems...)
	rbenv local
	gem install bundler --no-doc -v '~> 2.0'
	bundle config set path vendor/bundle
	bundle install

pods-install: ## Installs iOS project dependencies using Cocoapods
	bundle exec pod install

reset: ## Uninstalls Cocopads dependencies and RubyGems
	bundle exec pod deintegrate KChallenge.xcodeproj
	bundle exec rm -rf Pods
	bundle exec rm Podfile.lock
	bundle exec rm -rf ~/Library/Developer/Xcode/DerivedData/*
	bundle exec pod cache clean --all
	bundle exec rm -rf ./vendor/bundle ~/Library/MobileDevice/Provisioning\ Profiles/ ./build ./.bundle

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' ./Makefile | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-25s\033[0m %s\n", $$1, $$2}'
