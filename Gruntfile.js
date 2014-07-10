/*
 * Gruntfile Game of Life
 */

module.exports = function(grunt) {

  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    coffee: {
      compile: {
        files: {
          'dist/<%= pkg.name %>.min.js': ['src/*.coffee']
        },
      },
    },
    coffeelint: {
      app: ['src/*.coffee']
    },
  });

  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-coffeelint');
  grunt.loadNpmTasks('grunt-contrib-watch');

  grunt.registerTask('default', ['coffeelint', 'coffee']);
};
