Module = require('../module.coffee')

class LFOModule extends Module
    constructor: (@synth, @name = 'LFO') ->
        super(@synth)
        @wrapped = @synth.create('oscillator');
        @wrapped.frequency.value = 1.0
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
        @add_range_control(
            'name': 'rate'
            'min': 0.1
            'max': 20
            'set': (n) => @wrapped.frequency.value = n
            'get': => @wrapped.frequency.value
        )
        @wrapped.start(0)

module.exports = LFOModule
