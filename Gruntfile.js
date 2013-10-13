module.exports = function(grunt) {

    'use strict';

    grunt.initConfig({
        pkg: grunt.file.readJSON('package.json'),
        coffeeify: {
            files: {
                src: ['src/index.coffee'],
                dest: 'build/js/index.js'
            }
        },
        watch: {
            files: ['src/**/*.coffee'],
            tasks: ['coffeeify']
        }
    });
    grunt.loadNpmTasks('grunt-coffeeify');
    grunt.loadNpmTasks('grunt-contrib-watch');

};
