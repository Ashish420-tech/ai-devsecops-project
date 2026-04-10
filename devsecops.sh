#!/bin/bash

echo "🔨 Building Docker Image..."
docker build --no-cache -t ai-devsecops-app:v2 .

echo "🔍 Running Trivy Scan..."
trivy image --format json -o result.json ai-devsecops-app:v2

echo "📊 Extracting Critical Issues..."
cat result.json | jq '.Results[].Vulnerabilities[]? | select(.Severity=="CRITICAL") | {PkgName, VulnerabilityID, Title}'

echo "✅ Done"
CRITICAL_COUNT=$(cat result.json | jq '[.Results[].Vulnerabilities[]? | select(.Severity=="CRITICAL")] | length')

if [ "$CRITICAL_COUNT" -gt 0 ]; then
  echo "❌ Build Failed: Critical vulnerabilities found"
  exit 1
else
  echo "✅ Build Passed"
fi
