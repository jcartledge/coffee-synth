Module = require('../module.coffee')

class DCAModule extends Module
    constructor: (@synth, @name = 'DCA') ->
        super
        @wrapped = @synth.create('gain')
        @add_param_range_control('gain', 0, 1)

module.exports = DCAModule
