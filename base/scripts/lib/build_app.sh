set -e
echo "starting build_app"
COPIED_APP_PATH=/copied-app
BUNDLE_DIR=/tmp/bundle-dir

# sometimes, directly copied folder cause some wierd issues
# this fixes that
cp -R /app $COPIED_APP_PATH
cd $COPIED_APP_PATH
echo "app copied to $COPIED_APP_PATH"
meteor build --directory $BUNDLE_DIR --server=http://localhost:3000
echo "after meteor build"
cd $BUNDLE_DIR/bundle/programs/server/
npm i
echo " after npm install"
mv $BUNDLE_DIR/bundle /builtapp

# cleanup
rm -rf $COPIED_APP_PATH
rm -rf $BUNDLE_DIR
rm -rf ~/.meteor
rm /usr/local/bin/meteor
