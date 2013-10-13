Module = require('../module.coffee')

class VCAModule extends Module
    constructor: (@synth, @name = 'VCA') ->
        @controls = [
            {
                'name': 'gain'
                'type': 'range'
                'min': 0.0
                'max': 1.0
            }
        ]
        @wrapped = @synth.create('gain');
        super

module.exports = VCAModule
