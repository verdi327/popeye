module StorePrograms
  class FrankieNyFactory
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
      #pull a
      @deadlift = Exercise.create(name: "Deadlift", increase_weight_by: 5, decrease_weight_by: 20, increase_strategy: 1, decrease_strategy: 2, user_id: user.id )
      @bb_row = Exercise.create(name: "Barbell Row", increase_weight_by: 5, decrease_weight_by: 10, increase_strategy: 1, decrease_strategy: 2, user_id: user.id )
      @bb_curl = Exercise.create(name: "Barbell Curl", increase_weight_by: 5, decrease_weight_by: 10, increase_strategy: 1, decrease_strategy: 2, user_id: user.id )
      #pull b
      @power_clean = Exercise.create(name: "Power Clean", increase_weight_by: 5, decrease_weight_by: 10, increase_strategy: 1, decrease_strategy: 2, user_id: user.id )
      @chin_up = Exercise.create(name: "Wide Grip Chin Ups", increase_weight_by: 5, decrease_weight_by: 5, increase_strategy: 1, decrease_strategy: 2, user_id: user.id )
      @hammer_curl = Exercise.create(name: "Hammer Curls", increase_weight_by: 5, decrease_weight_by: 10, increase_strategy: 1, decrease_strategy: 2, user_id: user.id )
      #push a
      @bench_press = Exercise.create(name: "Bench Press", increase_weight_by: 5, decrease_weight_by: 10, increase_strategy: 1, decrease_strategy: 2, user_id: user.id )
      @press = Exercise.create(name: "Press", increase_weight_by: 5, decrease_weight_by: 10, increase_strategy: 1, decrease_strategy: 3, user_id: user.id )
      @dips = Exercise.create(name: "Dips", increase_weight_by: 5, decrease_weight_by: 10, increase_strategy: 2, decrease_strategy: 2, user_id: user.id )
      #push b
      @db_bench_press = Exercise.create(name: "Dumbbell Bench Press", increase_weight_by: 5, decrease_weight_by: 10, increase_strategy: 1, decrease_strategy: 2, user_id: user.id )
      @tri_ext = Exercise.create(name: "Tricep Extension", increase_weight_by: 5, decrease_weight_by: 10, increase_strategy: 1, decrease_strategy: 2, user_id: user.id )
      #leg a
      @b_squat = Exercise.create(name: "Back Squat", increase_weight_by: 5, decrease_weight_by: 15, increase_strategy: 1, decrease_strategy: 3, user_id: user.id )
      @stiff_deadlift = Exercise.create(name: "Stiff Leg Deadlift", increase_weight_by: 5, decrease_weight_by: 10, increase_strategy: 1, decrease_strategy: 2, user_id: user.id )
      @crunch = Exercise.create(name: "Weighted Crunches", increase_weight_by: 5, decrease_weight_by: 5, increase_strategy: 2, decrease_strategy: 2, user_id: user.id )
      #leg b
      @f_squat = Exercise.create(name: "Front Squat", increase_weight_by: 5, decrease_weight_by: 15, increase_strategy: 1, decrease_strategy: 3, user_id: user.id )
      @leg_raise = Exercise.create(name: "Weighted Leg Raises", increase_weight_by: 5, decrease_weight_by: 5, increase_strategy: 2, decrease_strategy: 2, user_id: user.id )
    end

    def create_lift_details
      [@deadlift, @bb_row, @bb_curl, @power_clean, @chin_up, @hammer_curl, @bench_press,
       @press, @dips, @db_bench_press, @tri_ext, @b_squat, @stiff_deadlift, @f_squat].each do |exercise|
        (1..4).to_a.each do |set|
          LiftDetail.create(set: set, reps: 6, weight: 45, exercise_id: exercise.id)
        end
      end

      #ab work
      [@crunch, @leg_raise].each do |exercise|
        (1..3).to_a.each do |set|
          LiftDetail.create(set: set, reps: 12, weight: 0, exercise_id: exercise.id)
        end
      end
    end

    def create_workouts
      @pull_a = Workout.create(name: "Pull A", user_id: user.id)
      @push_a = Workout.create(name: "Push A", user_id: user.id)
      @leg_a  = Workout.create(name: "Legs A", user_id: user.id)
      @pull_b = Workout.create(name: "Pull B", user_id: user.id)
      @push_b = Workout.create(name: "Push B", user_id: user.id)
      @leg_b  = Workout.create(name: "Legs B", user_id: user.id)
    end

    def link_workouts_with_exercises
      #pull a
      ExerciseWorkout.create(workout_id: @pull_a.id, exercise_id: @deadlift.id)
      ExerciseWorkout.create(workout_id: @pull_a.id, exercise_id: @bb_row.id)
      ExerciseWorkout.create(workout_id: @pull_a.id, exercise_id: @bb_curl.id)

      #push a
      ExerciseWorkout.create(workout_id: @push_a.id, exercise_id: @bench_press.id)
      ExerciseWorkout.create(workout_id: @push_a.id, exercise_id: @press.id)
      ExerciseWorkout.create(workout_id: @push_a.id, exercise_id: @dips.id)

      #legs a
      ExerciseWorkout.create(workout_id: @leg_a.id, exercise_id: @b_squat.id)
      ExerciseWorkout.create(workout_id: @leg_a.id, exercise_id: @stiff_deadlift.id)
      ExerciseWorkout.create(workout_id: @leg_a.id, exercise_id: @crunch.id)

      #pull b
      ExerciseWorkout.create(workout_id: @pull_b.id, exercise_id: @power_clean.id)
      ExerciseWorkout.create(workout_id: @pull_b.id, exercise_id: @chin_up.id)
      ExerciseWorkout.create(workout_id: @pull_b.id, exercise_id: @hammer_curl.id)

      #push b
      ExerciseWorkout.create(workout_id: @push_b.id, exercise_id: @db_bench_press.id)
      ExerciseWorkout.create(workout_id: @push_b.id, exercise_id: @press.id)
      ExerciseWorkout.create(workout_id: @push_b.id, exercise_id: @tri_ext.id)

      #legs b
      ExerciseWorkout.create(workout_id: @leg_b.id, exercise_id: @f_squat.id)
      ExerciseWorkout.create(workout_id: @leg_b.id, exercise_id: @stiff_deadlift.id)
      ExerciseWorkout.create(workout_id: @leg_b.id, exercise_id: @leg_raise.id)
    end

    def program_description
      <<-eos
        <p>Program's focus is on gaining mass.</p>
        <p>The program is broken down into three lift categories per week; pull, push and legs.</p>
        <p>The point on this program is to add weight, which is incremented on a per week basis.</p>
        <p>It's important to follow the three workouts per week guideline as your body will not be able to recovery fast enough if you add additional sessions or exercises.</p>
        <p>Program Specifics</p>
        <ul>
        <li>6 different workouts</li>
        <li>16 total exercises</li>
        <li>3 workouts per week</li>
        <li>Each workout takes between 45-60 minutes</li>
        <li>Program's duration is 8-12 weeks</li>
        </ul>
      eos
    end

    def create_program
      @frankie = Program.create(
        name: "Frankie NY's Mass Builder",
        workout_order: [@pull_a.id, @push_a.id, @leg_a.id, @pull_b.id, @push_b.id, @leg_b.id],
        current_workout: @pull_a.id,
        active: true,
        user_id: user.id,
        creator_id: user.id,
        available_in_store: true,
        skill_level: "intermediate",
        retest_frequency: 24,
        description: program_description
      )
    end

    def link_workouts_with_program
      ProgramWorkout.create(program_id: @frankie.id, workout_id: @pull_a.id)
      ProgramWorkout.create(program_id: @frankie.id, workout_id: @push_a.id)
      ProgramWorkout.create(program_id: @frankie.id, workout_id: @leg_a.id)
      ProgramWorkout.create(program_id: @frankie.id, workout_id: @pull_b.id)
      ProgramWorkout.create(program_id: @frankie.id, workout_id: @push_b.id)
      ProgramWorkout.create(program_id: @frankie.id, workout_id: @leg_b.id)
    end
  end
end