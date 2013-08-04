module.exports = (grunt) ->

  # Project configuration.
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    uglify:
      web:
        files:
          'build/web.min.js': ['build/web.js']

    browserify:
      options:
        ignore: "coffee-script"
      'build/web.js': ['build/browser.js']

    shell:
      options:
        stdout: true
        stderr: true
        failOnError: true
      test:
        command: "mocha --compilers coffee:coffee-script --reporter spec"
      setup:
        command: [
          "if [ ! -d gh-pages ]; then git clone -b gh-pages `git config --get remote.origin.url` gh-pages; fi"
          "mkdir -p build"
          "npm install -g coffee-script simple-http-server mocha"
        ].join(' && ')

      "gh-pages":
        command: [
          "rm -r gh-pages/*"
          "mkdir -p gh-pages/javascripts"
          "cp -r lib gh-pages/javascripts/"
          "cp build/*.js gh-pages/javascripts"
          "node build/cli.js demo.haml > gh-pages/index.html"
        ].join(' && ')

      "gh-pages-push":
        command: [
          "cd gh-pages"
          "git add ."
          "git ci -am 'updating pages'"
          "git push"
        ].join(' && ')

  grunt.loadNpmTasks('grunt-browserify')
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-uglify')
  grunt.loadNpmTasks('grunt-shell')

  grunt.registerTask 'test', ['shell:test']
  grunt.registerTask 'build', [
    'browserify'
    'uglify'
    'shell:demo'
  ]

  grunt.registerTask 'setup', [
    'shell:setup'
  ]

  grunt.registerTask 'gh-pages', [
    'build'
    'shell:gh-pages'
    'shell:gh-pages-push'
  ]

  grunt.registerTask 'default', ['build', 'shell:gh-pages']
