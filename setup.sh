#!/bin/bash

echo "Input Project Name(default: start-cdk) "
read project_name
if [ -z $project_name ]; then
  project_name="start-cdk"
fi

mkdir -p $project_name
cd $project_name
npm init
npm install --save-dev jest aws-cdk eslint typescript typedoc ts-jest ts-node  eslint @eslint/js @types/eslint__js typescript typescript-eslint prettier @types/jest @types/node globals

git init
git branch -m main

cat <<EOF > .git/hooks/pre-commit
#!/bin/bash

npx prettier . --write
git add -u
EOF
chmod +x .git/hooks/pre-commit

BASE_URL="https://github.com/yutaro-sakamoto/start-cdk/tree/main/"
curl -L -o .prettierignore   ${BASE_URL}/.prettierignore
curl -L -o .prettierrc       ${BASE_URL}/.prettierrc
curl -L -o .gitignore        ${BASE_URL}/.gitignore
curl -L -o eslint.config.mjs ${BASE_URL}/eslint.config.mjs
curl -L -o jest.config.js    ${BASE_URL}/jest.config.js

mkdir -p .github/workflows

cd .github/
curl -L -o dependabot.yml ${BASE_URL}/.github/dependabot.yml

cd workflows/
curl -L -o check-workflows.yml ${BASE_URL}/.github/workflows/check-workflows.yml
curl -L -o deploy.yml          ${BASE_URL}/.github/workflows/deploy.yml
curl -L -o post-cdk-diff.yml   ${BASE_URL}/.github/workflows/post-cdk-diff.yml
curl -L -o pull_request.yml    ${BASE_URL}/.github/workflows/pull_request.yml
curl -L -o push-main.yml       ${BASE_URL}/.github/workflows/push-main.yml
curl -L -o push.yml            ${BASE_URL}/.github/workflows/push.yml
curl -L -o test.yml            ${BASE_URL}/.github/workflows/test.yml
