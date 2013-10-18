Module = require('../module.coffee')

class DCOModule extends Module

    constructor: (@synth, @name = 'DCO') ->
        super(@synth)
        @voices = {}
        @wrapped =
            'type': 'sine'
            'incoming': []
            'outgoing': []
        @add_select_control(
            'name': 'wave'
            'values': [
                'sine'
                'sawtooth'
                'square'
                'triangle'
            ]
            'set': (n) => @wrapped.type = n
            'get': => @wrapped.type
        )

    # internal - called by synth.connect
    incoming: (src, param) ->
        @wrapped.incoming.push([src, param])

    # internal - called by synth.connect
    outgoing: (target) ->
        @wrapped.outgoing.push(target)

    trigger: (f) ->
        return if @voices[f]
        voice = @synth.create('oscillator')
        src.connect(@input(param, voice)) for [src, param] in @wrapped.incoming
        voice.connect(target) for target in @wrapped.outgoing
        voice.type = @wrapped.type
        voice.frequency.value = f
        voice.start(0)
        console.log(voice)
        @voices[f] = voice

    release: (f) ->
        @voices[f].stop(0)
        delete @voices[f]

module.exports = DCOModule
