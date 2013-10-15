Backbone = require("backbone")
views = require('./views.coffee')

class Module extends Backbone.Model

    constructor: (@synth) ->
        super
        @view = new views.ModuleView(@)
        @synth.add_module(this)

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

    render: ->
        @view.render()

    start: (f) ->
    release: ->

module.exports = Module
