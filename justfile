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

# Install the aliases (symlinks ~/.aws/cli/alias to this checkout)
install:
	mkdir -p ~/.aws/cli
	ln -sfn "{{justfile_directory()}}/alias" ~/.aws/cli/alias

# Run all linters
lint: lint-install lint-aliases lint-docs

# Lint the installer
lint-install:
	shellcheck install.sh

# Lint every `!f() { ... }; f` shell alias as POSIX sh (aliases run via /bin/sh, which may be dash)
lint-aliases:
	#!/usr/bin/env bash
	set -euo pipefail
	tmp=$(mktemp -d)
	trap 'rm -rf "$tmp"' EXIT
	# An alias starts at `name =` in column 0; its body continues on indented or blank lines
	awk -v dir="$tmp" '
		/^[A-Za-z0-9_-]+ *=/ { name = $1; body = $0; sub(/^[^=]*= */, "", body); out = dir "/" name ".sh"; print body > out; next }
		/^[ \t]/ && out { print > out; next }
		/^[^ \t]/ { out = "" }
	' alias
	failed=0
	for f in "$tmp"/*.sh; do
		grep -q '^ *!' "$f" || continue
		sed -i 's/^\( *\)!/\1/; 1s/^/#!\/bin\/sh\n/' "$f"
		shellcheck -s sh -S warning -e SC2016,SC2119,SC2120 "$f" || failed=1
	done
	exit "$failed"

# Lint the README
lint-docs:
	rumdl check README.md
