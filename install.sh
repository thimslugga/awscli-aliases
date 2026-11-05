#!/usr/bin/env bash

set -euo pipefail

repo_url="https://github.com/thimslugga/awscli-aliases.git"
repo_dir="${HOME}/.aws/awscli-aliases"
alias_file="${HOME}/.aws/cli/alias"

mkdir -p "${HOME}/.aws/cli"

if [[ -d "${repo_dir}/.git" ]]; then
  git -C "${repo_dir}" pull --ff-only
else
  git clone "${repo_url}" "${repo_dir}"
fi

# Back up an existing alias file unless it's already our symlink
if [[ -e "${alias_file}" && ! -L "${alias_file}" ]]; then
  backup="${alias_file}.bak.$(date +%s)"
  mv "${alias_file}" "${backup}"
  echo "Backed up existing alias file to ${backup}"
fi

ln -sfn "${repo_dir}/alias" "${alias_file}"
echo "Installed: ${alias_file} -> ${repo_dir}/alias"
