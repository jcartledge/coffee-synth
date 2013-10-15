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

    render: ->
        @view.render(@controls)

    start: (f) ->
    release: ->

class ModuleView

    constructor: (@module) ->
        @el = $("<div>")

    render: (controls) ->
        console.log(@module)
        @el.html("<h2>#{@module.name}</h2>")
        @el.append(control.render()) for control in controls

module.exports = Module
