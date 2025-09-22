#!/usr/bin/env bash

echo "Starting healthcheck for the service.."

MAX_TIME=120
START_TIME=$(date +%s)
AGENT="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 Chrome/116.0.0.0 Safari/537.36" 

while true; do
  STATUS=$(curl -A "$AGENT" -o /dev/null -s -w "%{http_code}" -L "$PORTFOLIO_API_HEALTHCHECK" || echo "000")
  
# Check for HTTP response in a loop 
# status 200 or 401 if basic auth enabled or 403 because cloudflare is sometimes blocking runners traffic
if [[ "$STATUS" -eq 200 || "$STATUS" -eq 401 || "$STATUS" -eq 403 ]]; then
    echo "Healthcheck successful! $STATUS"
    exit 0
  else
    echo "Waiting for service... got status $STATUS"
  fi

  NOW=$(date +%s)
  ELAPSED=$((NOW - START_TIME))
  if [ $ELAPSED -ge $MAX_TIME ]; then
    echo "Timeout reached after $MAX_TIME seconds. Healthcheck failed."
    exit 1
  fi

  sleep 5
done