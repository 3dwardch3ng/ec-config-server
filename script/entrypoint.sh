#!/bin/sh

if test "${SPRING_PROFILES_ACTIVE}" != '';
then
  echo "spring active profile is "$SPRING_PROFILES_ACTIVE
  JAVA_OPTIONS="$JAVA_OPTIONS -Dspring.profiles.active=cloud,native,$SPRING_PROFILES_ACTIVE"
fi

if test "${LOCAL_DOCKER_ENV}" = 'true';
then
  JAVA_OPTIONS="$JAVA_OPTIONS -Dspring.profiles.active=native"
fi

java $JAVA_OPTIONS -jar /app/app.jar