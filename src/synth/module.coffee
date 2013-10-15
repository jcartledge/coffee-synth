Backbone = require("backbone")

class Module extends Backbone.Model
    @synth
    @name
    @wrapped
    @controls = {}

    constructor: (@synth) ->
        super
        @synth.add(this)

    input: (param = 0) ->
        if param
            @wrapped[param]
        else
            @wrapped

    connect: (input, gain = 1) ->
        amp = @synth.create('gain')
        amp.gain.value = gain
        amp.connect(input)
        @wrapped.connect(amp)

    start: (f) ->
    release: ->

module.exports = Module
