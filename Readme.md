## बोल-Bach-an

A Sonic-pi implementation of Bach canons

Reference: https://plus.maths.org/content/topology-music-m-bius-strip

### Usage

Import the library

````ruby
eval_file "~/work/mavenik/bolbachan/canon_functions.rb"
````

Define a melody

````ruby
melody = [:bb4, :c4, :r, :eb3, :f3, :ab4, :g3, :eb3,
          :db3, :r, :r, :db3, :r, :r, :g4, :ab4]
````

Play melody


````ruby
play_melody melody, synth: :kalimba, amp: 4
````

Play a simple canon

````ruby
play_canon melody, synth: :kalimba, intro: 8, start: 0, length: 16, amp: 4
````

Play a crab canon

````ruby
play_crab_canon melody, synth: :kalimba, intro: 8, start: 10, length: 6, amp: 4
````

### Next Steps

Implement a Mobius canon using geometric glide reflection.

Probable approach:

1. Represent a melody as a balanced binary search tree
[](https://upload.wikimedia.org/wikipedia/commons/a/a9/Unbalanced_binary_tree.svg)

2. Perform tree manipulations to achieve a glide reflection in a 2d Cartesian space
