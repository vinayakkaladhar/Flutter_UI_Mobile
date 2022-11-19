cd flutter-ui-test-main
# Go to the android folder which contains the "gradlew" script used
# for building Android apps from the terminal
pushd android
# Build an Android test APK (that's why we've created the MainActivityTest.java)
./gradlew app:assembleAndroidTest
# Build a debug APK, passing in the integration test file
./gradlew app:assembleDebug -Ptarget="/Users/vinayakkaladhar/work/Fluttertest/flutter-ui-test-main/integration_test/forgetpassword_test.dart"
# Go back to the root of the project
popd

# # Write the environment variable in base64 into a JSON file
# echo $GCLOUD_KEY_FILE | base64 --decode > ./gcloud_key_file.json

# # Using the gcloud CLI (preinstalled on Codemagic) authenticate using the service account key
# gcloud auth activate-service-account --key-file=gcloud_key_file.json

# # Select YOUR Firebase project through which want to run the tests
# gcloud --quiet config set project your-project-id

# # Run the Flutter integration tests as if they were regular Android instrumentation tests
# gcloud firebase test android run \
#   --type instrumentation \
#   --app build/app/outputs/apk/debug/app-debug.apk \
#   --test build/app/outputs/apk/androidTest/debug/app-debug-androidTest.apk \
#   --timeout 2m