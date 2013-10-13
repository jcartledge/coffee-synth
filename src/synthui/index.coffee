$ = require('jquery-browserify')

class SynthUI
    constructor: (selector) ->
        @container = $(selector)
        if not @container.length
            throw new Error("Container not found: " + selector)
        @container.text("HI!")

    add: (module) ->
        console.log(module)

module.exports = SynthUI
