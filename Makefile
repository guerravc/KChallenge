.DEFAULT_GOAL := help
SHELL := /bin/bash
.ONESHELL:
set -euo pipefail

# Project Configuration
PROJECT_NAME := KChallenge
WORKSPACE := $(PROJECT_NAME).xcworkspace
PROJECT := $(PROJECT_NAME).xcodeproj
DEV_SCHEME := KChallengeDev
PROD_SCHEME := $(PROJECT_NAME)
DERIVED_DATA_PATH := ./build

# Build Configuration
SDK_IOS := iphoneos
SDK_SIMULATOR := iphonesimulator
DESTINATION_SIMULATOR := "platform=iOS Simulator,name=iPhone 15,OS=latest"

# Phony targets
.PHONY: help init clean reset build build-release test open archive
.PHONY: homebrew-install git-lfs-install ruby-install pods-install pods-update
.PHONY: lint format derived-data-clean simulator-reset

# Silent targets
.SILENT: init help

## Setup and Installation
init: homebrew-install git-lfs-install ruby-install pods-install ## Initialize the project (run this first)
	echo "✅ Project initialization is complete!"
	echo "⚠️  IMPORTANT: Make sure to set the PERSONAL ACCESS TOKEN into the project"

homebrew-install: ## Install Homebrew and dependencies from Brewfile
	@echo "📦 Installing Homebrew and dependencies..."
	command -v brew >/dev/null 2>&1 || /bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	brew bundle --verbose || (echo "❌ Brewfile installation failed" && exit 1)

git-lfs-install: ## Install and configure Git LFS
	@echo "📁 Setting up Git LFS..."
	git lfs install
	git lfs pull 2>/dev/null || echo "ℹ️  No LFS files to pull"

ruby-install: ## Install Ruby, Bundler, and gems from Gemfile
	@echo "💎 Installing Ruby dependencies..."
	rbenv local 2>/dev/null || echo "⚠️  rbenv not configured, using system Ruby"
	gem install bundler --no-doc -v '~> 2.0' || (echo "❌ Bundler installation failed" && exit 1)
	bundle config set path vendor/bundle
	bundle install || (echo "❌ Bundle install failed" && exit 1)

pods-install: ## Install iOS project dependencies using CocoaPods
	@echo "🍫 Installing CocoaPods dependencies..."
	bundle exec pod install || (echo "❌ Pod install failed" && exit 1)

pods-update: ## Update CocoaPods dependencies
	@echo "🔄 Updating CocoaPods dependencies..."
	bundle exec pod update

## Build and Test
build: ## Build the development scheme
	@echo "🔨 Building $(DEV_SCHEME)..."
	set -o pipefail && xcodebuild \
		-workspace "$(WORKSPACE)" \
		-scheme "$(DEV_SCHEME)" \
		-sdk $(SDK_SIMULATOR) \
		-destination $(DESTINATION_SIMULATOR) \
		-derivedDataPath "$(DERIVED_DATA_PATH)" \
		build | xcpretty || (echo "❌ Build failed" && exit 1)

build-release: ## Build the production scheme for release
	@echo "🚀 Building $(PROD_SCHEME) for release..."
	set -o pipefail && xcodebuild \
		-workspace "$(WORKSPACE)" \
		-scheme "$(PROD_SCHEME)" \
		-sdk $(SDK_IOS) \
		-configuration Release \
		-derivedDataPath "$(DERIVED_DATA_PATH)" \
		build | xcpretty || (echo "❌ Release build failed" && exit 1)

test: ## Run unit tests
	@echo "🧪 Running tests..."
	set -o pipefail && xcodebuild \
		-workspace "$(WORKSPACE)" \
		-scheme "$(DEV_SCHEME)" \
		-sdk $(SDK_SIMULATOR) \
		-destination $(DESTINATION_SIMULATOR) \
		-derivedDataPath "$(DERIVED_DATA_PATH)" \
		test | xcpretty || (echo "❌ Tests failed" && exit 1)

archive: ## Create an archive for distribution
	@echo "📦 Creating archive..."
	mkdir -p ./archives
	set -o pipefail && xcodebuild \
		-workspace "$(WORKSPACE)" \
		-scheme "$(PROD_SCHEME)" \
		-sdk $(SDK_IOS) \
		-configuration Release \
		-derivedDataPath "$(DERIVED_DATA_PATH)" \
		-archivePath "./archives/$(PROJECT_NAME).xcarchive" \
		archive | xcpretty || (echo "❌ Archive failed" && exit 1)

## Development Tools
open: ## Open the Xcode workspace
	@echo "📱 Opening Xcode workspace..."
	open "$(WORKSPACE)"

open-project: ## Open the Xcode project (without workspace)
	@echo "📱 Opening Xcode project..."
	open "$(PROJECT)"

lint: ## Run SwiftLint (if available)
	@echo "🔍 Running SwiftLint..."
	command -v swiftlint >/dev/null 2>&1 && swiftlint || echo "⚠️  SwiftLint not installed (run: brew install swiftlint)"

format: ## Format code with SwiftFormat (if available)
	@echo "✨ Formatting code with SwiftFormat..."
	command -v swiftformat >/dev/null 2>&1 && swiftformat . || echo "⚠️  SwiftFormat not installed (run: brew install swiftformat)"

## Cleanup
clean: ## Clean build artifacts
	@echo "🧹 Cleaning build artifacts..."
	set -o pipefail && xcodebuild \
		-workspace "$(WORKSPACE)" \
		-scheme "$(DEV_SCHEME)" \
		clean | xcpretty || echo "⚠️  Clean completed with warnings"

derived-data-clean: ## Clean Xcode derived data
	@echo "🗑️  Cleaning derived data..."
	rm -rf ~/Library/Developer/Xcode/DerivedData/*
	rm -rf "$(DERIVED_DATA_PATH)"
	simulator-reset: ## Reset iOS Simulator
	@echo "📱 Resetting iOS Simulator..."
	xcrun simctl erase all

reset: ## Reset project (removes CocoaPods dependencies and Ruby gems)
	@echo "🔄 Resetting project dependencies..."
	bundle exec pod deintegrate "$(PROJECT)" || echo "⚠️  Pod deintegration completed"
	rm -rf Pods Podfile.lock
	rm -rf ~/Library/Developer/Xcode/DerivedData/*
	rm -rf "$(DERIVED_DATA_PATH)"
	bundle exec pod cache clean --all || echo "⚠️  Pod cache clean completed"
	rm -rf ./vendor/bundle ~/Library/MobileDevice/Provisioning\ Profiles/ ./.bundle
	@echo "✅ Reset complete! Run 'make init' to reinstall dependencies."

## Information
status: ## Show project status and dependency versions
	@echo "📊 Project Status:"
	@echo "Project: $(PROJECT_NAME)"
	@echo "Workspace: $(WORKSPACE)"
	@echo "Schemes: $(DEV_SCHEME), $(PROD_SCHEME)"
	@echo ""
	@echo "🔧 Tool Versions:"
	@xcode-select -p 2>/dev/null && echo "Xcode: $$(xcode-select -p)" || echo "Xcode: Not found"
	@xcrun --show-sdk-version 2>/dev/null && echo "iOS SDK: $$(xcrun --show-sdk-version)" || echo "iOS SDK: Not found"
	@ruby -v 2>/dev/null || echo "Ruby: Not found"
	@bundle -v 2>/dev/null || echo "Bundler: Not found"
	@bundle exec pod --version 2>/dev/null && echo "CocoaPods: $$(bundle exec pod --version)" || echo "CocoaPods: Not found"
	@git --version 2>/dev/null || echo "Git: Not found"
	@git lfs version 2>/dev/null || echo "Git LFS: Not found"

help: ## Show this help message
	@echo "📚 Available commands:"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}' | \
		sort
