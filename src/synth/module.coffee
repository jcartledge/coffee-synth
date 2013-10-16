$ = require('jquery-browserify')
controls = require('./controls.coffee')

class Module

    constructor: (@synth) ->
        @controls = []
        @view = new ModuleView(@)
        @synth.add_module(this)

    add_range_control: (props) ->
        control = new controls.RangeControl(props)
        @_add_control(control)

    add_select_control: (props) ->
        @_add_control(new controls.SelectControl(props))

    _add_control: (control) ->
        @controls.push(control)
        @render

    input: (param) ->
        if param
            @wrapped[param]
        else
            @wrapped

    connect: (target, input = null, options = null) ->
        input = target.input(input)
        amp = @synth.create('gain')
        amp.gain.value = 1
        amp.connect(input)
        if options
            amp.gain.value = options.value
            target.add_range_control(
                'name': "#{@name} amount"
                'min': options.min
                'max': options.max
                'set': (n) => amp.gain.value = n
                'get': => amp.gain  .value
            )
        @wrapped.connect(amp)

    render: ->
        @view.render(@controls)

    trigger: (f) ->
    release: ->

class ModuleView

    constructor: (@module) ->
        @el = $("<div class='synth-module synth-module-#{@module.name}'>")

    render: (controls) ->

        @el.html("<h2>#{@module.name}</h2>")
        @el.append(control.render()) for control in controls

module.exports = Module
