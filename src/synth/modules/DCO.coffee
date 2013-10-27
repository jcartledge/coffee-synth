Module = require('../module.coffee')

class DCOModule extends Module

    voices: {}
    wrapped:
        'type': 'sine'
        'incoming': []
        'outgoing': []

    constructor: (@synth, @name = 'DCO') ->
        super(@synth)
        types = ['sine', 'sawtooth', 'square', 'triangle']
        @add_param_list_control('type', types)

    # internal - called by synth.connect
    incoming: (src, param) ->
        @wrapped.incoming.push([src, param])

    # internal - called by synth.connect
    outgoing: (target) ->
        @wrapped.outgoing.push(target)

    set: (param, val) ->
        @wrapped[param] = val
        voice[param] = val for _, voice of @voices

    trigger: (f) ->
        return if @voices[f]
        voice = @synth.create('oscillator')
        src.connect(@input(param, voice)) for [src, param] in @wrapped.incoming
        voice.connect(target) for target in @wrapped.outgoing
        voice.type = @wrapped.type
        voice.frequency.value = f
        voice.start(0)
        @voices[f] = voice

    release: (f) ->
        if @voices[f]
            @voices[f].stop(0)
            delete @voices[f]

module.exports = DCOModule
