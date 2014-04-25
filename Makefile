RJS=node node_modules/.bin/r.js
BROWSER=google-chrome
SERVER_PORT=8080
SERVER=http-server -p $(SERVER_PORT)
JSDOC=node node_modules/.bin/jsdoc
JSHINT=node node_modules/.bin/jshint
LESSC=node node_modules/.bin/lessc
SOURCE=src/js/**/*.js

MOCHA=node node_modules/.bin/mocha-phantomjs
TEST_URL="test/test.html"

.PHONY: all
all: check test build

.PHONY: check
check:
	@echo running jshint...
	@$(JSHINT) $(SOURCE)
	@echo jshint reported no errors!

.PHONY: less
less:
	@echo running less compiler
	@$(LESSC) src/less/index.less src/css/index.css
	@echo less compilation finished

.PHONY: clean
clean:
	@echo removing dist/ folder
	@rm -rf dist/

.PHONY: build
build: clean just_build

.PHONY: just_build
just_build:
	@mkdir dist/
	@mkdir dist/js
	@mkdir dist/css

	@echo running r.js optimizer for js
	@$(RJS) -o \
		name="../bower/almond/almond" \
		baseUrl="src/js" \
		include="index" \
		mainConfigFile="./src/js/require/config.js" \
		out="dist/js/index.js" \
		preserveLicenseComments=false

	@echo running r.js optimizer for css
	@$(RJS) -o optimizeCss=standard \
		preserveLicenseComments=false \
		cssIn="src/css/index.css" \
		out="dist/css/index.css"

	@echo copying fonts
	@cp -r src/fonts dist/

	@echo copying index.html
	@cp src/index.html dist/index.src.html
	#@cp src/favicon* dist/

	@echo replacing index.html \<script\> tags
	@sed -e '/SCRIPT START/,/SCRIPT END/c\	<script type="text/javascript" src="js/index.js"></script>' \
		dist/index.src.html > dist/index.html

	@rm dist/index.src.html

	@echo adding snippets...
	@snippets/add.js

	@echo "build successfully finished!"


.PHONY: server
server:
	@echo server started
	@echo visit http://localhost:$(SERVER_PORT)/src/index.html to start the app
	@echo visit http://localhost:$(SERVER_PORT)/test/test.html to run the tests
	@$(SERVER)

.PHONY: docs
docs:
	rm -rf docs/
	$(JSDOC) -d docs/ src/js/**/*.js

.PHONY: test
test:
	$(MOCHA) $(TEST_URL)

.PHONY: test-grep
test-grep:
	$(MOCHA) $(TEST_URL)"?grep="$(GREP)
