Module = require('../module.coffee')
VCOModule = require('./VCO.coffee')

class LFOModule extends VCOModule
    constructor: (@synth, @name = 'LFO') ->
        super(@synth, @name)
        @controls.push({
            'name': 'frequency'
            'type': 'range'
            'min': 0.1
            'max': 100.0
        })
        @wrapped.frequency.value = 1.0
        @wrapped.start(0)

    trigger: (f) -> # so we don't catch VCO trigger

module.exports = LFOModule
