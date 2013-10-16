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

    trigger: (f) ->
        module.trigger(f) for module in @modules

    release: (f) ->
        module.release(f) for module in @modules

    speaker: ->
        @context.destination

class SynthView

    constructor: (@el) ->

    render: (modules) ->
        @el.html('<div class="synth">')
        @el.append(module.render()) for module in modules

module.exports = Synth
