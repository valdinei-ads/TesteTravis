#!/bin/bash

# Download codacy test reporter
curl -L https://github.com/codacy/codacy-coverage-reporter/releases/download/4.0.5/codacy-coverage-reporter-4.0.5-assembly.jar > ./codacy-test-reporter.jar
chmod +x ./codacy-test-reporter.jar

# Install dotnet tools to generate test report
dotnet tool install --global coverlet.console 
dotnet add package coverlet.msbuild

# Build solution
dotnet restore
dotnet build ./MySolution.sln

# Running unit tests - 'cobertura' output format
dotnet test /p:CollectCoverage=true /p:CoverletOutputFormat=cobertura /p:CoverletOutput=coverage /p:Exclude=[xunit.*]* ./TesteTravis.sln

# Send test report result to codacy
java -jar ./codacy-test-reporter.jar report -l CSharp -t ${CODACY_PROJECT_TOKEN} -r ./CalculadoraTests/coverage.cobertura.xml



