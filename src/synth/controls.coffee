$ = require('jquery-browserify')

class SynthControl

    constructor: (props) ->
        @[key] = value for key, value of props

    render: ->
        @view.render()

class RangeControl extends SynthControl
    constructor: (props) ->
        super(props)
        @view = new RangeControlView(@)

class SelectControl extends SynthControl
    constructor: (props) ->
        super(props)
        @view = new SelectControlView(@)

class ControlView
    constructor: (@control) ->
        @el = $("<p>#{@control.name}</p>")

    render: ->
        @el

class RangeControlView extends ControlView
class SelectControlView extends ControlView

module.exports =
  SynthControl: SynthControl
  RangeControl: RangeControl
  SelectControl: SelectControl
