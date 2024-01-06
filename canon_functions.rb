interval_length = 0.25

def get_options melody, options
  options ||= {}
  
  options[:interval_length] ||= 0.25
  options[:intro] ||= 0
  options[:start] ||= 0
  options[:length] ||= melody.length
  options[:amp] ||= 1
  
  validate_options melody, options
  
  return options
end

def validate_options melody, options
  raise "Length cannot be more than melody length" if options[:length] > melody.length
  raise "amp value cannot be negative" if options[:amp] < 0
  raise "start value cannot be negative" if options[:start] < 0
  raise "start + length cannot be more than melody length" if options[:start] + options[:length] > melody.length
  raise "intro value cannot be negative" if options[:intro] < 0
  raise "interval_length cannot be negative or zero" if options[:interval_length] <= 0
end

def canon base_melody,
    options
  return base_melody.slice(options[:start], options[:length]) # Join the part of melody in your canon
  .concat([*1..(base_melody.length - options[:length])].fill(:r)) # Fill silence in the end
end

define :play_melody do | base_melody, options |
  options = get_options base_melody, options
  
  # Main melody
  live_loop :pakad do
    base_melody.length.times do
      use_synth :kalimba
      play base_melody.tick, amp: options[:amp]
      sleep options[:interval_length]
    end
  end
end

define :play_canon do | base_melody, options |
  options = get_options base_melody, options
  
  canon_melody = canon base_melody, options
  
  play_melody base_melody, options
  
  # Canon
  live_loop :canon, delay: options[:intro]*options[:interval_length] do
    base_melody.length.times do
      use_synth :kalimba
      play canon_melody.tick, amp: options[:amp]
      sleep options[:interval_length]
    end
  end
end

define :play_crab_canon do | base_melody, options |
  options = get_options base_melody, options
  
  reverse_melody = canon base_melody.reverse, options
  
  play_melody base_melody, options
  live_loop :crabcanon, delay: options[:intro]*options[:interval_length] do
    base_melody.length.times do
      use_synth :kalimba
      play reverse_melody.tick, amp: options[:amp]
      sleep options[:interval_length]
    end
  end
end