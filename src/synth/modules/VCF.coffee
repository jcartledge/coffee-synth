Module = require('../module.coffee')

class VCFModule extends Module
    constructor: (@synth, @name = 'VCF') ->
        @controls = [
            {
                'name': 'type'
                'list': true
                'values': [
                    {'key': 'lowpass'}
                    {'key': 'highpass'}
                ]
                'change': (n) => @wrapped.type = n
            }
        ]
        @wrapped = @synth.create('biquadFilter');
        super

module.exports = VCFModule
