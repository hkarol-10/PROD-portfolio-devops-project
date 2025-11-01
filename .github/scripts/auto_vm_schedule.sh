#!/usr/bin/env bash

#secrets:
    #$PORTFOLIO_VM_NAME
    #$MONITORING_VM_NAME

ZONE="europe-central2-a"

export TZ="Europe/Warsaw"

SERVICE_AVAILABLE_FROM=8   #8:00
SERVICE_AVAILABLE_TO=19   #19:00
HOUR=$(date +'%H')

echo "Current time runner: $HOUR"
echo "Machines should be running from: $SERVICE_AVAILABLE_FROM to: $SERVICE_AVAILABLE_TO "

if [ "$HOUR" -ge $SERVICE_AVAILABLE_FROM ] && [ "$HOUR" -lt $SERVICE_AVAILABLE_TO ]; then
    echo "Turning VMs ON because it's $HOUR"
        gcloud compute instances start "$PORTFOLIO_VM_NAME" --zone="$ZONE" --quiet --format="none" >/dev/null 2>&1 && echo "$PORTFOLIO_VM_NAME started"
        gcloud compute instances start "$MONITORING_VM_NAME" --zone="$ZONE" --quiet --format="none" >/dev/null 2>&1 && echo "$MONITORING_VM_NAME started"
else
    echo "Turning VMs OFF beacuse it's $HOUR"
        gcloud compute instances stop "$PORTFOLIO_VM_NAME" --zone="$ZONE" --quiet >/dev/null 2>&1 && echo "$PORTFOLIO_VM_NAME stopped"
        gcloud compute instances stop "$MONITORING_VM_NAME" --zone="$ZONE" --quiet >/dev/null 2>&1 && echo "$MONITORING_VM_NAME stopped"
fi
