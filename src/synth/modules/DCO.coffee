Module = require('../module.coffee')

class DCOModule extends Module
    # DCO needs to handle creating and destroying oscillators on trigger
    constructor: (@synth, @name = 'DCO') ->
        super(@synth)
        @wrapped = @synth.create('oscillator');
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

    trigger: (f) ->
        @wrapped.frequency.value = f
        @wrapped.start(0)

    release: (f) ->
        @wrapped.stop(0)

module.exports = DCOModule
