#!/bin/bash

set -e

repo="$1"
if [ -z "$repo" ]; then
  echo "Please pass a repository as first argument."
  exit 1
fi

if ! type filename > /dev/null; then
  sudo apt -y -q install wcstools
fi


if ! type git > /dev/null; then
  sudo apt -y -q install git
fi

folder="`filename \"$repo\"`"

if ! [ -d "$folder" ]; then
  git clone "$repo"
  if ! [ -d "$folder" ]; then
    echo "Could not clone $repo into $folder. Exiting."
    exit 2
  fi
fi

(
  cd "$folder"
  start='10-09-2017'
  end='01-02-2018'
  echo "Collecting commits for the rang of https://codeheat.org/ "
  echo "From $start to $end"
  commits="`git log --after=\"$start\" --before=\"$end\" --pretty='format:%H'`"
  number_of_commits="`echo \"$commits\" | wc -l`"
  echo "Number of commits: $number_of_commits"
  first_commit="`echo \"$commits\" | tail -n 1`"
  last_commit="`echo \"$commits\" | head -n 1`"
  if [ -z "$first_commit" ] || [ -z "$last_commit" ]; then
    echo -e "no commits \t $folder"
    exit 3
  fi
  echo "From commit $first_commit to $last_commit"

  # last line must be the summary
  echo -e "`git diff --stat \"$first_commit\" \"$last_commit\" | tail -n 1 | sed 's/,/\t/g'`\t $number_of_commits commits \t $folder"
)
