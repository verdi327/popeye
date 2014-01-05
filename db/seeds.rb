# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#clear all records first
puts "destroying all duplicate records"
Exercise.destroy_all
Workout.destroy_all
Program.destroy_all
LiftDetail.destroy_all

# user
# will already be created id: 1
user = User.find_by_email "god@popeye.com"

# exercises
puts "creating the exercise records"
squat = Exercise.create(name: "Squat", increase_weight_by: 5, decrease_weight_by: 15, increase_strategy: 1, decrease_strategy: 3, user_id: user.id )
press = Exercise.create(name: "Press", increase_weight_by: 5, decrease_weight_by: 10, increase_strategy: 1, decrease_strategy: 3, user_id: user.id )
deadlift = Exercise.create(name: "Deadlift", increase_weight_by: 10, decrease_weight_by: 20, increase_strategy: 1, decrease_strategy: 3, user_id: user.id )
bench_press = Exercise.create(name: "Bench Press", increase_weight_by: 5, decrease_weight_by: 10, increase_strategy: 1, decrease_strategy: 3, user_id: user.id )
power_clean = Exercise.create(name: "Power Clean", increase_weight_by: 5, decrease_weight_by: 10, increase_strategy: 1, decrease_strategy: 3, user_id: user.id )
pull_ups = Exercise.create(name: "Pull Ups", increase_weight_by: 5, decrease_weight_by: 5, increase_strategy: 1, decrease_strategy: 1, user_id: user.id )
back_ext = Exercise.create(name: "Back Extensions", increase_weight_by: 5, decrease_weight_by: 10, increase_strategy: 2, decrease_strategy: 3, user_id: user.id )

#lift details
puts "creating the associated lift details"
[squat, press, bench_press].each do |exercise|
  (1..3).to_a.each do |set|
    LiftDetail.create(set: set, reps: 5, weight: 45, exercise_id: exercise.id)
  end
end

#deadlift
LiftDetail.create(set: 1, reps: 5, weight: 45, exercise_id: deadlift.id)

#power clean
(1..5).to_a.each do |set|
  LiftDetail.create(set: set, reps: 3, weight: 45, exercise_id: power_clean.id)
end

#pull ups
(1..3).to_a.each do |set|
  LiftDetail.create(set: set, reps: 15, weight: 0, exercise_id: pull_ups.id)
end

#back extensions
(1..3).to_a.each do |set|
  LiftDetail.create(set: set, reps: 10, weight: 0, exercise_id: back_ext.id)
end

puts "creating the workouts"
# workouts
a = Workout.create(name: "Workout A", user_id: user.id)
b = Workout.create(name: "Workout B", user_id: user.id)
c = Workout.create(name: "Workout C", user_id: user.id)
d = Workout.create(name: "Workout D", user_id: user.id)

#ExerciseWorkouts - link workouts with exercises
puts "linking the exercise and workouts"
#workout a
ExerciseWorkout.create(workout_id: a.id, exercise_id: squat.id)
ExerciseWorkout.create(workout_id: a.id, exercise_id: press.id)
ExerciseWorkout.create(workout_id: a.id, exercise_id: deadlift.id)

#workout b
ExerciseWorkout.create(workout_id: b.id, exercise_id: squat.id)
ExerciseWorkout.create(workout_id: b.id, exercise_id: bench_press.id)
ExerciseWorkout.create(workout_id: b.id, exercise_id: back_ext.id)

#workout c
ExerciseWorkout.create(workout_id: c.id, exercise_id: squat.id)
ExerciseWorkout.create(workout_id: c.id, exercise_id: press.id)
ExerciseWorkout.create(workout_id: c.id, exercise_id: power_clean.id)

#workout d
ExerciseWorkout.create(workout_id: d.id, exercise_id: squat.id)
ExerciseWorkout.create(workout_id: d.id, exercise_id: bench_press.id)
ExerciseWorkout.create(workout_id: d.id, exercise_id: pull_ups.id)

#program
puts "creating the ss program"

description = <<eos
<p>Starting Strength was developed by Mark Rippetoe, a  former competitive powerlifter, and has become a highly regarded strength program for novice lifters.</p>
<p>The program is successful because of it's simplicity to follow and its understanding of the body's biomechanics.  The program focuses on compound barbell based movements and uses linear weight progression.</p>
<p>Program Specifics</p>
<ul>
<li>6 total exercises</li>
<li>3 workouts per week</li>
<li>Each workout takes between 45-60 minutes</li>
<li>Program's duration is 7-9 months</li>
</ul>
eos

ss = Program.create(
  name: "Starting Strength",
  workout_order: [a.id, b.id, c.id, d.id],
  current_workout: a.id,
  active: true,
  user_id: user.id,
  creator_id: user.id,
  available_in_store: true,
  skill_level: "beginner",
  retest_frequency: 24,
  description: description
)

puts "linking the program and workouts"
#ProgramWorkouts - link programs and workouts
ProgramWorkout.create(program_id: ss.id, workout_id: a.id)
ProgramWorkout.create(program_id: ss.id, workout_id: b.id)
ProgramWorkout.create(program_id: ss.id, workout_id: c.id)
ProgramWorkout.create(program_id: ss.id, workout_id: d.id)

puts "all done...it was a success!"









