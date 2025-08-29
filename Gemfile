# frozen_string_literal: true

source "https://rubygems.org"

# Specify Ruby version for consistency across environments
ruby "3.3.4"

# =============================================================================
# iOS Development Dependencies
# =============================================================================

# CocoaPods - iOS dependency manager
gem "cocoapods", "~> 1.15.0"

# CocoaPods plugins for enhanced functionality
gem "cocoapods-deintegrate", "~> 1.0"  # Clean removal of CocoaPods from projects
gem "cocoapods-clean", "~> 0.0.1"      # Clean up unused CocoaPods files

# =============================================================================
# Development Tools
# =============================================================================

# Code quality and formatting
gem "rubocop", "~> 1.60"               # Ruby code linter and formatter
gem "rubocop-performance", "~> 1.20"   # Performance-focused RuboCop rules

# Development utilities
gem "bundler", "~> 2.5"                # Dependency manager
gem "rake", "~> 13.0"                  # Build tool
gem "xcpretty", "~> 0.3"               # Xcode build output formatter

# =============================================================================
# Optional Tools (uncomment as needed)
# =============================================================================

# iOS Deployment & CI/CD
# gem "fastlane", "~> 2.219"             # iOS deployment automation
# gem "match", "~> 2.219"                # Certificate and provisioning profile management
# gem "gym", "~> 2.219"                  # Building iOS apps
# gem "scan", "~> 2.219"                 # Running tests
# gem "pilot", "~> 2.219"                # TestFlight deployment
# gem "deliver", "~> 2.219"              # App Store deployment

# Documentation
# gem "jazzy", "~> 0.14"                 # Swift documentation generator

# Testing (if using Ruby for testing scripts)
# gem "rspec", "~> 3.12"                 # Testing framework
# gem "minitest", "~> 5.20"              # Lightweight testing framework

# Utilities
# gem "colorize", "~> 0.8"               # Colorized terminal output
# gem "tty-prompt", "~> 0.23"            # Interactive command line prompts

# =============================================================================
# Development group (only installed in development)
# =============================================================================

group :development do
  gem "pry", "~> 0.14"                   # Enhanced Ruby REPL for debugging
end
