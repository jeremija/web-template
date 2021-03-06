web-template
============
My web template for JavaScript web applications

Forking and setting up
----------------------

Prerequisites: [npm](https://www.npmjs.org/) and [bower](http://bower.io/) installed globally or their location must be added to the `$PATH` environment variable.

After you fork the repo:

```bash
git clone https://github.com/your-username/web-template.git
# Clones your fork of the repository into the current directory in terminal

# Change the active directory in the prompt to the newly cloned "web-template" directory
cd web-template

# Assign the original repository to a remote called "upstream"
git remote add upstream https://github.com/jeremija/web-template.git

# Pull in changes not present in your local repository, without modifying your files
git fetch upstream

# install bower and npm dependencies
bower install
npm install

# start the server
make server
```

Now you should be able to navigate to [http://localhost:8080/src/index.html](http://localhost:8080/src/index.html) in your browser.

Testing
-------

Follow the setting up guide, open your browser and navigate to [http://localhost:8080/test/test.html](http://localhost:8080/test/test.html).

You can also run the tests by typing `make test`. This will use [mocha-phantomjs](https://www.npmjs.org/package/mocha-phantomjs) as the test runner.

Building
--------

```bash
# install dependencies if not already
npm install
bower install
# initiate build
make
```

and a `./dist` folder should be created.

If you wish to build the documentation, run:

```bash
make docs
```

This should create a new folder: `./docs`.

License
-------
MIT license.
