Module = require('../module.coffee')

class VCFModule extends Module
    constructor: (@synth, @name = 'VCF') ->
        @controls = [
            {
                'name': 'type'
                'type': 'list'
                'values': ['lowpass', 'highpass']
            }
        ]
        @wrapped = @synth.create('biquadFilter');
        super

module.exports = VCFModule
