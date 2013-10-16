Module = require('../module.coffee')

class DCAModule extends Module
    constructor: (@synth, @name = 'DCA') ->
        super
        @wrapped = @synth.create('gain');
        @add_range_control(
            'name': 'gain'
            'min': 0
            'max': 1
            'set': (n) => @wrapped.gain.value = n
            'get': => @wrapped.gain.value
        )

module.exports = DCAModule
