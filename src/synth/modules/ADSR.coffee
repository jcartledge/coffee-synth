Module = require('../module.coffee')

class ADSRModule extends Module

    _attack: 0.5
    _decay: 0.25
    _sustain: 0.5
    _release: 0.5

    _adsr_control: (param_name, min, max) ->
        @add_range_control(
            'name': param_name
            'min': min
            'max': max
            'set': (n) => @[param_name] = n
            'get': => @[param_name]
        )

    constructor: (@synth, @name = 'ADSR') ->
        super
        @dc = @synth.dc(1.0)
        @wrapped = @synth.create('gain')
        @dc.connect(@wrapped)
        @_adsr_control('_attack', 0, 5.0)
        @_adsr_control('_decay', 0, 5.0)
        @_adsr_control('_sustain', 0, 1)
        @_adsr_control('_release', 0, 5.0)

    _get_now: ->
        now = @synth.time()
        @wrapped.gain.cancelScheduledValues(now)
        @wrapped.gain.setValueAtTime(@wrapped.gain.value, now)
        now

    trigger: (f) ->
        @wrapped.gain.value = 0.0
        attack_time = @_get_now() + parseFloat(@_attack, 10)
        decay_time = attack_time + parseFloat(@_decay, 10)
        console.log(attack_time, decay_time)
        @wrapped.gain.linearRampToValueAtTime(1.0, attack_time)
        @wrapped.gain.linearRampToValueAtTime(@_sustain, decay_time)
        super(f)

    release: (f) ->
        now = @_get_now()
        @wrapped.gain.linearRampToValueAtTime(0.0, now + @_release)
        setTimeout((=> super(f)), @_release * 1000)

module.exports = ADSRModule
