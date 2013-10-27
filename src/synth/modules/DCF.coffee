Module = require('../module.coffee')

class DCFModule extends Module
    constructor: (@synth, @name = 'DCF') ->
        super
        @wrapped = @synth.create('biquadFilter')
        @add_param_list_control('type', ['lowpass', 'highpass'])
        @add_param_range_control('frequency', 20, 40000)
        @add_param_range_control('Q', 0, 100)

module.exports = DCFModule
