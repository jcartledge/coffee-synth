class Module
    @synth
    @name
    @wrapped
    @controls = {}

    constructor: (@synth) ->
        @synth.add_module(this)
        # super

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

    trigger: ->
    release: ->

module.exports = Module
