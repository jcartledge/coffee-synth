Module = require('../module.coffee')

class VCOModule extends Module
    # VCO needs to handle creating and destroying oscillators on trigger
    constructor: (@synth, @name = 'VCO', type = 'sine') ->
        super(@synth)
        @controls = [
            {
                'name': 'type'
                'list': true
                'values': [
                    {'key': 'sine'}
                    {'key': 'sawtooth'}
                    {'key': 'square'}
                    {'key': 'triangle'}
                ]
                'change': (n) => @wrapped.type = n
            }
        ]
        @wrapped = @synth.create('oscillator');
        @wrapped.type = type

    start: (f) ->
        @wrapped.frequency.value = f
        @wrapped.start(0)

    release: ->
        @wrapped.stop(0)

module.exports = VCOModule
