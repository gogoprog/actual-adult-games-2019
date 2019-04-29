all:
	haxe build.hxml

retail:
	rm -rf build
	rm -rf retail
	mkdir -p retail/build
	haxe build.hxml
	rsync -avzm . ./retail -progress --exclude='**/phaser.js' --include='deps/**/*.css' --include='deps/**/*.js' --include='data/**' --include='src/*.css' --exclude='haxe-babylon' --exclude='examples' --include='src/*.html' --include='*/' --include='index.html' --exclude='*'
	uglifyjs --compress --mangle -- build/game.js > retail/build/game.js

zip: retail
	rm -f retail.zip
	zip -r retail.zip retail

.PHONY: all retail
