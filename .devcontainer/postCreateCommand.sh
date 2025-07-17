#!/usr/bin/env bash

set -e

PREFIX="🍰  "
echo "$PREFIX Running $(basename $0)"

echo "$PREFIX Setting up safe git repository to prevent dubious ownership errors"
git config --global --add safe.directory /workspace

echo "$PREFIX Setting up git configuration to support .gitconfig in .devcontainer"
git config --local --get include.path | grep -e ../.devcontainer/.gitconfig >/dev/null 2>&1 || git config --local --add include.path ../.devcontainer/.gitconfig


# Check if the GH CLI is required
if [ -e $(dirname $0)/_temp.token ]; then
    echo "$PREFIX setting up GitHub CLI"
    $(dirname $0)/gh-login.sh postcreate
    echo "$PREFIX Installing the techcollective/gh-tt gh cli extension"
    gh extension install thetechcollective/gh-tt
    echo "$PREFIX Installing the gh aliases"    
    gh alias import .devcontainer/.gh_alias.yml --clobber

fi

if [ -e Gemfile ]; then
  echo "$PREFIX Installing the Ruby gems"
  bundle config set frozen true
  bundle install
fi

echo "$PREFIX SUCCESS"
exit 0