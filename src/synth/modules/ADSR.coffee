Module = require('../module.coffee')

class ADSR extends Module

    constructor: (@synth, @name = 'DCA') ->
        super
        @attack = 0
        @decay = 0
        @sustain = 1
        @release = 0
        @wrapped = @synth.create('gain');
        @wrapped.gain.value = 0
        @add_range_control(
            'name': 'attack'
            'min': 0
            'max': 10
            'set': (n) => @attack = n
            'get': => @attack
        )
        @add_range_control(
            'name': 'decay'
            'min': 0
            'max': 10
            'set': (n) => @decay= n
            'get': => @decay
        )
        @add_range_control(
            'name': 'sustain'
            'min': 0
            'max': 1
            'set': (n) => @sustain = n
            'get': => @sustain
        )
        @add_range_control(
            'name': 'release'
            'min': 0
            'max': 10
            'set': (n) => @release = n
            'get': => @release
        )


    _get_now: ->
        now = @synth.time
        @wrapped.gain.cancelScheduledValues(now);
        @wrapped.gain.setValueAtTime(_amp.gain.value, now);
        return now;
    }
    return {
        'node': _amp,
        'trigger': function() {
            var now = getNow();
            var attackTime = now + attack;
            var decayTime = attackTime + decay;
            _amp.gain.linearRampToValueAtTime(1.0, attackTime);
            _amp.gain.linearRampToValueAtTime(sustain, decayTime);
        },
        'release': function() {
            var now = getNow();
            _amp.gain.linearRampToValueAtTime(0.0, now + release);
        }
    };
}
