open_project: setup_project
	open *.xcworkspace

setup_project: xcodegen cocoapods

xcodegen:
	xcodegen

cocoapods:
	bundle install && bundle exec pod install

carthage:
	carthage bootstrap --no-use-binaries --platform iOS --cache-builds

clean:
	rm -rf Pods
	rm -rf *.xcodeproj
	rm -rf *.xcworkspace

export_app: carthage setup_project
	xcodebuild -workspace TestProject.xcworkspace -scheme App -archivePath App.xcarchive archive
	xcodebuild -exportArchive -archivePath App.xcarchive -exportPath App.ipa -exportOptionsPlist exportOptions.plist
