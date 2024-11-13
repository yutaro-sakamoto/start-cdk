#!/bin/bash

echo "Input Project Name(default: start-cdk) "
read project_name
if [ -z $project_name ]; then
  project_name="start-cdk"
fi

mkdir -p $project_name
cd $project_name
npm init