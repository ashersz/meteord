set -e
curl -sL https://install.meteor.com | sed s/--progress-bar/-sL/g | /bin/sh
console.log("before update to 1.4.2.beta-4");
meteor update --release 1.4.2-beta.4
