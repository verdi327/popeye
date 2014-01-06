module StorePrograms
  class SquatAttackFactory
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
      @power_clean = Exercise.create(name: "Power Clean", increase_weight_by: 5, decrease_weight_by: 10, increase_strategy: 1, decrease_strategy: 2, user_id: user.id )
      @squat = Exercise.create(name: "Squat", increase_weight_by: 5, decrease_weight_by: 10, increase_strategy: 1, decrease_strategy: 2, user_id: user.id )
      @press = Exercise.create(name: "Press", increase_weight_by: 5, decrease_weight_by: 10, increase_strategy: 1, decrease_strategy: 2, user_id: user.id )
      @chin_ups = Exercise.create(name: "Chin Ups", increase_weight_by: 5, decrease_weight_by: 5, increase_strategy: 3, decrease_strategy: 1, user_id: user.id )
      @dips = Exercise.create(name: "Dips", increase_weight_by: 5, decrease_weight_by: 5, increase_strategy: 1, decrease_strategy: 2, user_id: user.id )
      @deadlift = Exercise.create(name: "Deadlift", increase_weight_by: 5, decrease_weight_by: 20, increase_strategy: 1, decrease_strategy: 2, user_id: user.id )
    end

    def create_lift_details
      #power clean
      (1..5).to_a.each do |set|
        LiftDetail.create(set: set, reps: 3, weight: 45, exercise_id: @power_clean.id)
      end

      #squat
      LiftDetail.create(set: 1, reps: 20, weight: 45, exercise_id: @squat.id)

      #press
      (1..2).to_a.each do |set|
        LiftDetail.create(set: set, reps: 12, weight: 45, exercise_id: @press.id)
      end

      #chin ups
      (1..2).to_a.each do |set|
        LiftDetail.create(set: set, reps: 10, weight: 0, exercise_id: @chin_ups.id)
      end

      #dips
      (1..2).to_a.each do |set|
        LiftDetail.create(set: set, reps: 10, weight: 0, exercise_id: @dips.id)
      end

      #deadlift
      LiftDetail.create(set: 1, reps: 15, weight: 45, exercise_id: @deadlift.id)
    end

    def create_workouts
      @squat_attack = Workout.create(name: "Squat Attack", user_id: user.id)
    end

    def link_workouts_with_exercises
      #squat attack
      ExerciseWorkout.create(workout_id: @squat_attack.id, exercise_id: @power_clean.id)
      ExerciseWorkout.create(workout_id: @squat_attack.id, exercise_id: @squat.id)
      ExerciseWorkout.create(workout_id: @squat_attack.id, exercise_id: @press.id)
      ExerciseWorkout.create(workout_id: @squat_attack.id, exercise_id: @chin_ups.id)
      ExerciseWorkout.create(workout_id: @squat_attack.id, exercise_id: @dips.id)
      ExerciseWorkout.create(workout_id: @squat_attack.id, exercise_id: @deadlift.id)
    end

    def program_description
      <<-eos
        <p>'Ball Buster', 'Widow Maker' and 'Man Breaker' have all been used to descriped this crueling six week program.</p>
        <p>The main focus of this program is muscle exhaustion through high volume squat training.</p>
        <p>The other exercises are supplementary and should be completed at approximately 70%-80% of 5RM.</p>
        <p>Program Specifics</p>
        <ul>
        <li>6 total exercises</li>
        <li>3 workouts per week</li>
        <li>1 workout overall</li>
        <li>Each workout takes between 45-60 minutes</li>
        <li>Program's duration is 6 weeks</li>
        </ul>
      eos
    end

    def create_program
      @twenty_rep = Program.create(
        name: "20 Rep Power Squat",
        workout_order: [@squat_attack.id],
        current_workout: @squat_attack.id,
        active: false,
        user_id: user.id,
        creator_id: user.id,
        available_in_store: true,
        skill_level: "advanced",
        retest_frequency: 19,
        description: program_description
      )
    end

    def link_workouts_with_program
      ProgramWorkout.create(program_id: @twenty_rep.id, workout_id: @squat_attack.id)
    end
  end
end
