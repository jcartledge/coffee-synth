Module = require('../module.coffee')

class VCOModule extends Module
    # VCO needs to handle creating and destroying oscillators on trigger
    constructor: (@synth, @name = 'VCO', type = 'sine') ->
        super(@synth)
        @wrapped = @synth.create('oscillator');
        @wrapped.type = type
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

    start: (f) ->
        @wrapped.frequency.value = f
        @wrapped.start(0)

    release: ->
        @wrapped.stop(0)

module.exports = VCOModule
