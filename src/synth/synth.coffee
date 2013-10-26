class Synth

    constructor: (el) ->
        @modules = []
        @context = new webkitAudioContext()
        @view = new SynthView(el)

    create: (type) ->
        return @context['create' + type[0].toUpperCase() + type[1..-1]]()

    add_module: (module) ->
        @modules.push(module)
        @render()

    render: ->
        @view.render(@modules)

    speaker: ->
        @context.destination

    connect: (src, target, input, options) ->
        amp = @create('gain')
        amp.gain.value = 1
        target.incoming(amp, input)
        src.outgoing(amp)
        # add a gain control to target if options supplied
        if options
            amp.gain.value = options.value
            target.add_range_control(
                'name': "#{src.name} &#x21dd; #{input}"
                'min': options.min
                'max': options.max
                'set': (n) => amp.gain.value = n
                'get': => amp.gain  .value
            )

class SynthView

    constructor: (@el) ->

    render: (modules) ->
        @el.html('<div class="synth">')
        @el.append(module.render()) for module in modules

module.exports = Synth
