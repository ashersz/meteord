set -e
echo "starting build_app"
echo "node version"
node --version
COPIED_APP_PATH=/copied-app
BUNDLE_DIR=/tmp/bundle-dir
# Fix permissions warning in Meteor >=1.4.2.1 without breaking
# earlier versions of Meteor with --unsafe-perm or --allow-superuser
# https://github.com/meteor/meteor/issues/7959
export METEOR_ALLOW_SUPERUSER=true
echo "METEOR_ALLOW_SUPERUSER=$METEOR_ALLOW_SUPERUSER"
# sometimes, directly copied folder cause some wierd issues
# this fixes that
cp -R /app $COPIED_APP_PATH
cd $COPIED_APP_PATH
echo "app copied to $COPIED_APP_PATH"

# next line fixes client dependencies not honored
if [ -f "$COPIED_APP_PATH/package.json" ];then
  echo "install on client side"
  npm install && npm cache clear
  echo "finished install on client side"
fi
echo "before meteor build "
meteor build --server-only --directory $BUNDLE_DIR --server=http://localhost:3000
echo "after meteor build "
cd $BUNDLE_DIR/bundle/programs/server/
echo "before npm install server side"
npm install && npm cache clear
echo " after npm install server side"
if [ -d "$COPIED_APP_PATH/node_modules" ];then
  echo "copy client node_modules to web.browser"
  cp -R $COPIED_APP_PATH/node_modules $BUNDLE_DIR/bundle/programs/web.browser
  if [ -d "$BUNDLE_DIR/bundle/programs/web.cordova" ];then
      echo "copy client node_modules to web.cordova"
      cp -R $COPIED_APP_PATH/node_modules $BUNDLE_DIR/bundle/programs/web.cordova
  fi
fi
mv $BUNDLE_DIR/bundle /built_app
echo "create folder for logs"
mkdir -p /var/log/meteor

# cleanup
echo "cleanup"
rm -rf $COPIED_APP_PATH
rm -rf $BUNDLE_DIR
rm -rf ~/.meteor
rm /usr/local/bin/meteor
rm -rf /app
