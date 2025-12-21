#!/bin/bash
# Fix gradlew line endings if needed
if [ -f ./gradlew ]; then
    tr -d '\r' < ./gradlew > ./gradlew.tmp && mv ./gradlew.tmp ./gradlew
    chmod +x ./gradlew
fi

# Run the original command
exec "$@"

