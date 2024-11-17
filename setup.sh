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
