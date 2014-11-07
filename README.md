# Forking

A bash script for forking a repo

# Code Status

[![Build Status](https://travis-ci.org/frankywahl/forking.svg?branch=master)](https://travis-ci.org/frankywahl/forking)

## Usage

After installation, run the command with the repo you want to fork. EG

```bash 
$ git fork git@github.com:frankywahl/forking.git
```

## What will it do? 

It will do all the following for you: 
  1. It will clone the repository locally.
  2. It will fork the repository and set up remotes:
    * origin will point to your local copy, 
    * upstream will be pointing to the source.
  3. It will remove all branches on origin except the master branch.

## Installation

Copy `git-fork` into any directory that is included in you `$PATH`


### Notes
`git-fork` creates a name collision with `hub fork` if you aliased hub to git. 
To avoid that issue, you may want to either re-name this `git-fork` file you downloaded or remove the alias.

