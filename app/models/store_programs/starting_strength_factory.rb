module StorePrograms
  class StartingStrengthFactory
    attr_reader :user

    def initialize(user)
      @user = user
    end

    def create
      create_exercises
      create_lift_details
      create_workouts
      link_workouts_with_exercises
      create_program
      link_workouts_with_program
    end

    def create_exercises
      @squat = Exercise.create(name: "Squat", increase_weight_by: 5, decrease_weight_by: 15, increase_strategy: 1, decrease_strategy: 3, user_id: user.id )
      @press = Exercise.create(name: "Press", increase_weight_by: 5, decrease_weight_by: 10, increase_strategy: 1, decrease_strategy: 3, user_id: user.id )
      @deadlift = Exercise.create(name: "Deadlift", increase_weight_by: 10, decrease_weight_by: 20, increase_strategy: 1, decrease_strategy: 3, user_id: user.id )
      @bench_press = Exercise.create(name: "Bench Press", increase_weight_by: 5, decrease_weight_by: 10, increase_strategy: 1, decrease_strategy: 3, user_id: user.id )
      @power_clean = Exercise.create(name: "Power Clean", increase_weight_by: 5, decrease_weight_by: 10, increase_strategy: 1, decrease_strategy: 3, user_id: user.id )
      @pull_ups = Exercise.create(name: "Pull Ups", increase_weight_by: 5, decrease_weight_by: 5, increase_strategy: 1, decrease_strategy: 1, user_id: user.id )
      @back_ext = Exercise.create(name: "Back Extensions", increase_weight_by: 5, decrease_weight_by: 10, increase_strategy: 2, decrease_strategy: 3, user_id: user.id )
    end

    def create_lift_details
      [@squat, @press, @bench_press].each do |exercise|
        (1..3).to_a.each do |set|
          LiftDetail.create(set: set, reps: 5, weight: 45, exercise_id: exercise.id)
        end
      end

      #deadlift
      LiftDetail.create(set: 1, reps: 5, weight: 45, exercise_id: @deadlift.id)

      #power clean
      (1..5).to_a.each do |set|
        LiftDetail.create(set: set, reps: 3, weight: 45, exercise_id: @power_clean.id)
      end

      #pull ups
      (1..3).to_a.each do |set|
        LiftDetail.create(set: set, reps: 15, weight: 0, exercise_id: @pull_ups.id)
      end

      #back extensions
      (1..3).to_a.each do |set|
        LiftDetail.create(set: set, reps: 10, weight: 0, exercise_id: @back_ext.id)
      end
    end

    def create_workouts
      @a = Workout.create(name: "Workout A", user_id: user.id)
      @b = Workout.create(name: "Workout B", user_id: user.id)
      @c = Workout.create(name: "Workout C", user_id: user.id)
      @d = Workout.create(name: "Workout D", user_id: user.id)
    end

    def link_workouts_with_exercises
      #workout a
      ExerciseWorkout.create(workout_id: @a.id, exercise_id: @squat.id)
      ExerciseWorkout.create(workout_id: @a.id, exercise_id: @press.id)
      ExerciseWorkout.create(workout_id: @a.id, exercise_id: @deadlift.id)

      #workout b
      ExerciseWorkout.create(workout_id: @b.id, exercise_id: @squat.id)
      ExerciseWorkout.create(workout_id: @b.id, exercise_id: @bench_press.id)
      ExerciseWorkout.create(workout_id: @b.id, exercise_id: @back_ext.id)

      #workout c
      ExerciseWorkout.create(workout_id: @c.id, exercise_id: @squat.id)
      ExerciseWorkout.create(workout_id: @c.id, exercise_id: @press.id)
      ExerciseWorkout.create(workout_id: @c.id, exercise_id: @power_clean.id)

      #workout d
      ExerciseWorkout.create(workout_id: @d.id, exercise_id: @squat.id)
      ExerciseWorkout.create(workout_id: @d.id, exercise_id: @bench_press.id)
      ExerciseWorkout.create(workout_id: @d.id, exercise_id: @pull_ups.id)
    end

    def program_description
      <<-eos
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
    end

    def create_program
      @ss = Program.create(
        name: "Starting Strength",
        workout_order: [@a.id, @b.id, @c.id, @d.id],
        current_workout: @a.id,
        active: true,
        user_id: user.id,
        creator_id: user.id,
        available_in_store: true,
        skill_level: "beginner",
        retest_frequency: 24,
        description: program_description
      )
    end

    def link_workouts_with_program
      ProgramWorkout.create(program_id: @ss.id, workout_id: @a.id)
      ProgramWorkout.create(program_id: @ss.id, workout_id: @b.id)
      ProgramWorkout.create(program_id: @ss.id, workout_id: @c.id)
      ProgramWorkout.create(program_id: @ss.id, workout_id: @d.id)
    end
  end
end
