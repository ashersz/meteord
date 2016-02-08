set -e

curl -sL https://install.meteor.com | sed s/--progress-bar/-sL/g | /bin/sh
meteor update — release 1.3-modules-beta.8
