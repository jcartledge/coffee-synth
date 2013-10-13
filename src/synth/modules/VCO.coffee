Module = require('../module.coffee')

class VCOModule extends Module
    # VCO needs to handle creating and destroying oscillators on trigger
    constructor: (@synth, @name = 'VCO', type = 'sine') ->
        @controls = [
            {
                'name': 'type'
                'type': 'list'
                'values': ['sine', 'sawtooth', 'square', 'triangle']
            }
        ]
        @wrapped = @synth.create('oscillator');
        @wrapped.type = type
        super

    trigger: (f) ->
        @wrapped.frequency.value = f
        @wrapped.start(0)

    release: ->
        @wrapped.stop(0)

module.exports = VCOModule
