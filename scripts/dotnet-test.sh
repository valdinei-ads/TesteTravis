#!/bin/bash

# Download codacy test reporter
curl -L https://github.com/codacy/codacy-coverage-reporter/releases/download/4.0.5/codacy-coverage-reporter-4.0.5-assembly.jar > ./codacy-test-reporter.jar
chmod +x ./codacy-test-reporter.jar

echo 'Install dotnet tools to generate test report'
# Install dotnet tools to generate test report
dotnet tool install --global coverlet.console 
# dotnet add package coverlet.msbuild

echo 'Build Solution'
# Build solution
dotnet restore
dotnet build TesteTravis.sln

echo 'Running unit tests - cobertura output format'
# Running unit tests - 'cobertura' output format
dotnet test /p:CollectCoverage=true /p:CoverletOutputFormat=cobertura /p:CoverletOutput=coverage /p:Exclude=[xunit.*]* ./TesteTravis.sln

echo 'Send test report result to codacy'
# Send test report result to codacy
# java -jar ./codacy-test-reporter.jar report -l CSharp -t ${CODACY_PROJECT_TOKEN} -r ./CalculadoraTests/coverage.cobertura.xml
bash <(curl -Ls https://coverage.codacy.com/get.sh) report -l CSharp -t ${CODACY_PROJECT_TOKEN} -r ./CalculadoraTests/coverage.cobertura.xml
