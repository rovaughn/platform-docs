#!/bin/bash

git checkout stg-release-0.15
git merge master
git push
git checkout release-0.15
git merge master
git push
git checkout master
