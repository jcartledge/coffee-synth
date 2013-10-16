Module = require('../module.coffee')

class VCFModule extends Module
    constructor: (@synth, @name = 'VCF') ->
        super
        @wrapped = @synth.create('biquadFilter');
        @add_select_control(
            'name': 'type'
            'values': [
                'lowpass'
                'highpass'
            ]
            'set': (n) => @wrapped.type = n
            'get': => @wrapped.type
        )
        @add_range_control(
            'name': 'cutoff'
            'min': 10
            'max': 10000
            'set': (n) => @wrapped.frequency.value = n
            'get': => @wrapped.frequency.value
        )
        @add_range_control(
            'name': 'Q'
            'min': 0
            'max': 10
            'set': (n) => @wrapped.Q.value = n
            'get': => @wrapped.Q.value
        )

module.exports = VCFModule
