set -e
echo "starting build_app"
COPIED_APP_PATH=/copied-app
BUNDLE_DIR=/tmp/bundle-dir

# sometimes, directly copied folder cause some wierd issues
# this fixes that
cp -R /app $COPIED_APP_PATH
cd $COPIED_APP_PATH
echo "app copied to $COPIED_APP_PATH"
# next line fixes client dependencies not honored
npm install && npm cache clear
echo "after npm install on client side"
meteor build --server-only --directory $BUNDLE_DIR --server=http://localhost:3000
echo "after meteor build"
cd $BUNDLE_DIR/bundle/programs/server/
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
touch /var/log/meteor.log

# cleanup
rm -rf $COPIED_APP_PATH
rm -rf $BUNDLE_DIR
rm -rf ~/.meteor
rm /usr/local/bin/meteor
