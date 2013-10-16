Module = require('../module.coffee')

class SpeakerModule extends Module
    constructor: (@synth, @name = 'Speaker') ->
        super

    input: ->
        @synth.speaker()

module.exports = SpeakerModule
