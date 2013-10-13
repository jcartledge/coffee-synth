class Synth

    constructor: ->
        @context = new webkitAudioContext()
        @modules = []

    add_module: (module) ->
        @modules.push(module)

    create: (type) ->
        return @context['create' + type[0].toUpperCase() + type[1..-1]]()

    trigger: ->
        module.trigger() for module in @modules

    speaker: ->
        @context.destination

class Module
    @synth
    @name
    @wrapped
    @controls = {}

    constructor: (@synth) ->
        @synth.add_module(this)
        # super

    input: (param = 0) ->
        if param
            @wrapped[param]
        else
            @wrapped

    connect: (input, gain = 1) ->
        amp = @synth.create('gain')
        amp.gain.value = gain
        amp.connect(input)
        @wrapped.connect(amp)

    trigger: ->
    release: ->

class ModuleUI
    @module

    constructor: (@module) ->

class VCOModule extends Module
    # VCO needs to handle creating and destroying oscillators on trigger
    constructor: (@synth, @name = 'VCO', type = 'sine') ->
        @controls = [
            {
                'name': 'type'
                'type': 'list'
                'values': ['sine', 'sawtooth', 'square', 'triangle']
            }
        ]
        @wrapped = @synth.create('oscillator');
        @wrapped.type = type
        super

    trigger: ->
        @wrapped.start(0)

    release: ->
        @wrapped.stop(0)

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

class FilterModule extends Module
    constructor: (@synth, @name = 'Filter') ->
        @controls = [
            {
                'name': 'type'
                'type': 'list'
                'values': ['lowpass', 'highpass']
            }
        ]
        @wrapped = @synth.create('biquadFilter');
        super

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

# synth = new Synth()

# vco = new VCOModule(synth, 'VCO', 'square')
# lfo = new LFOModule(synth)
# vcf = new FilterModule(synth)
# vca = new VCAModule(synth)

# lfo.connect(vco.input('frequency'), 100)
# lfo.connect(vcf.input('frequency'), 100)
# lfo.connect(vca.input('gain'), .5)
# vco.connect(vcf.input())
# vcf.connect(vca.input())

# vca.connect(synth.speaker())

# synth.trigger()

# console.log(synth)

module.exports = Synth
