set -e
export METEOR_NO_RELEASE_CHECK=true # make sure this is set in your environment.
# curl -sL https://install.meteor.com | sed s/--progress-bar/-sL/g | /bin/sh
# read in the release version in the app
METEOR_VERSION=$(head /app/.meteor/release | cut -d "@" -f 2)
curl https://install.meteor.com/?release=$METEOR_VERSION | sed s/--progress-bar/-sL/g | /bin/sh # You can use the exact version you're deploying here
