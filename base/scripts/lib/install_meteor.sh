set -e
export METEOR_NO_RELEASE_CHECK=true # make sure this is set in your environment.
# curl -sL https://install.meteor.com | sed s/--progress-bar/-sL/g | /bin/sh
curl https://install.meteor.com/?release=1.4.0.1 | sh # You can use the exact version you're deploying here
