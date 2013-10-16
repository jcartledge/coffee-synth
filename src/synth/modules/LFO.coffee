Module = require('../module.coffee')
DCOModule = require('./DCO.coffee')

class LFOModule extends DCOModule
    constructor: (@synth, @name = 'LFO') ->
        super(@synth, @name)
        @wrapped.frequency.value = 1.0
        @add_range_control(
            'name': 'rate'
            'min': 0.1
            'max': 20
            'set': (n) => @wrapped.frequency.value = n
            'get': => @wrapped.frequency.value
        )
        @wrapped.start(0)

    trigger: (f) -> # so we don't catch DCO trigger
    release: (f) -> # and release

module.exports = LFOModule
