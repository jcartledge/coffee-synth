Module = require('../module.coffee')

class VCAModule extends Module
    constructor: (@synth, @name = 'VCA') ->
        @controls = [
            {
                'name': 'gain'
                'range': true
                'min': 0.0
                'max': 1.0
                'change': (n) => @wrapped.gain.value = n
            }
        ]
        @wrapped = @synth.create('gain');
        super

module.exports = VCAModule
