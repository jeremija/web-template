(function() {
    mocha.setup('bdd')
        .globals([/* define global objects here */])
        .checkLeaks();


    require(['logger'], function(Logger) {
        function run() {
            if (window.mochaPhantomJS) {
                // disable log output in tests
                Logger.prototype.disabled = true;
                mochaPhantomJS.run();
            }
            else {
                mocha.run();
            }
        }
        require(tests, function() {
            run();
        });
    });

}());