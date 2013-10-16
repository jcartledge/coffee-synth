Module = require('../module.coffee')
VCOModule = require('./VCO.coffee')

class LFOModule extends VCOModule
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

    start: (f) -> # so we don't catch VCO trigger

module.exports = LFOModule
