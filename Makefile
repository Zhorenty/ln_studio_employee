get:
	flutter pub get

	cd packages/rest_client && flutter pub get

analyze:
	flutter analyze

format:
	dart format lib --set-exit-if-changed

runner:
	flutter pub get

	dart run build_runner build --delete-conflicting-outputs

	cd packages/rest_client && flutter pub get

clean:
	flutter clean

	cd packages/rest_client && flutter clean

watch:
	dart run build_runner watch

intl:
	dart run intl_utils:generate