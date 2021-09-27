#!/usr/bin/env sh

set -e

npm run build

cd dist

git init
git add -A
git commit -m "New Deployment"
git push -f git@github.com:vijayandika/deployVue.git main:deployVue

cd -

# chmod +x deploy.sh