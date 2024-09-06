#!/usr/bin/env just --justfile
# vim: set ft=make :

## Getting Started

# justfile requires - https://github.com/casey/just
#
# - https://github.com/casey/just/discussions
# - https://just.systems/man/en/
# - https://cheatography.com/linux-china/cheat-sheets/justfile Cheatsheet
# - https://docs.rs/regex/1.5.4/regex/#syntax Regexps

#export PATH := justfile_directory() + "/env/bin:" + env_var("PATH")

## Settings

# See: https://github.com/casey/just#settings

#set default-recipe := default
#set default-recipe := help
#set default-recipe := _list
# Load environment variables from `.env` file.
set dotenv-load := true
set export := false
#set positional-arguments := true
#set allow-unknown-flags := false
#set allow-unknown-variables := false
#set allow-unknown-recipes := false
#set allow-duplicate-variables := false
#set allow-duplicate-recipes := false
#set ignore-errors := false
set shell := ["bash", "-c"]
#set shell := ["bash", "-euo", "pipefail", "-c"]
#set windows-shell := ["cmd", "/c"]
#set windows-shell := ["powershell", "-Command"]
#set windows-powershell := ["pwsh", "-NoProfile", "-Command"]

## Variables

timestamp := `date +%s`
#project_name := env_var('PROJECT_NAME')
#project_version := env_var('PROJECT_VERSION')
#semver := env_var('PROJECT_VERSION')
#commit := `git show -s --format=%h`
#project_version := semver + "+" + commit
#work_dir := "build"

## Recipes

# Default recipe (equivalent to 'all' in Makefile)
#default:
#  @just --summary

#@default:
#	@just --list --justfile {{ justfile() }}


# Lists the tasks and variables in the justfile
@_list:
	just --justfile {{justfile()}} --list --unsorted
	echo ""
	echo "Available variables:"
	just --evaluate | sed 's/^/    /'
	echo ""
	echo "Override variables using 'just key=value ...' (also ALL_UPPERCASE ones)"

# Evaluate and return all just variables
evaluate:
	@just --evaluate

help:
	@just --list

# Return system information (e.g. os, architecture, etc)
alias sysinfo := system-info
system-info:
	@echo "architecture: {{arch()}}"
	@echo "os: {{os()}}"
	@echo "os family: {{os_family()}}"