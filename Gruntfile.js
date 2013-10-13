module.exports = function(grunt) {
    grunt.initConfig({
        pkg: grunt.file.readJSON('package.json'),
        browserify: {
            'build/index.js': ['src/index.coffee']
        }
    });
    grunt.loadNpmTasks('grunt-browserify');
}

