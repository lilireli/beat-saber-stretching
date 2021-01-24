<template>
  <div id="trainer" class="flex flex-col items-center">
    <b-container class="flex-grow flex">
      <b-row v-if="!started" class="flex flex-col flex-grow">
        <div class="justify-center flex h-1/2 items-end pb-20 text-xl">
          To do everyday, to train wrist and shoulder.
        </div>
        <div>
          <b-button
            @click="started = true"
            class="text-center rounded-full text-xl p-4"
            variant="primary"
            >Start exercise</b-button
          >
        </div>
      </b-row>

      <b-row
        v-else-if="started && currentExercise < exercises.length"
        class="flex-grow"
      >
        <b-col cols="1" class="flex justify-left">
          <div
            v-if="currentExercise > 0"
            @click="previousExercise()"
            class="flex h-1/2 items-end text-left justify-start text-gray-400 text-xl"
          >
            <font-awesome-icon icon="chevron-left" />
          </div>
        </b-col>

        <b-col cols="10" class="flex flex-grow flex-col">
          <Exercise
            :params="exercises[currentExercise]"
            :key="exercises[currentExercise].title"
            @end="nextExercise()"
          ></Exercise>
        </b-col>

        <b-col cols="1" class="flex flex-col">
          <div
            v-if="currentExercise < exercises.length"
            @click="nextExercise()"
            class="flex h-1/2 items-end text-right justify-end text-gray-400 text-xl"
          >
            <font-awesome-icon icon="chevron-right" class="text-right" />
          </div>

          <div class="flex h-1/2 items-end text-right text-gray-400">
            after that: {{ estimatedTime.minutes }}'{{ estimatedTime.seconds }}'
          </div>
        </b-col>
      </b-row>

      <b-row v-else class="flex flex-col flex-grow">
        <div
          class="justify-center flex h-2/6 items-end pb-20 text-4xl text-blue-600"
        >
          <b>Congrats !!!</b>
        </div>
        <div class="justify-center flex h-1/6 items-end pb-20 text-lg">
          You have successfully finished you training, you wrists and shoulder
          thank you :)
        </div>

        <div class="justify-center flex h-2/6 items-end pb-20 text-xl">
          <b-button
            @click="resetTrainer()"
            class="text-center rounded-full text-xl p-4"
            >Go back</b-button
          >
        </div>
      </b-row>
    </b-container>

    <b-container class="p-6 m-6 bg-gray-400 rounded-full ring-4 ring-gray-300">
      <b-row>
        <b-col class="flex items-center justify-center">
          <div v-if="paginationStart > 0" @click="decrementPagination()">
            <font-awesome-icon
              class="text-2xl text-gray-300"
              icon="chevron-left"
            />
          </div>
        </b-col>
        <b-col v-for="(exercise, index) in paginatedExercises" :key="index">
          <div
            class="rounded-full h-24 w-24 border-4"
            :class="
              activePagination(index) ? 'border-red-600' : 'border-blue-600'
            "
            @click="changeExercise(paginationStart + index)"
          >
            <ExerciseIcon
              :name="exercise.category"
              :color="
                activePagination(index) ? 'text-red-600' : 'text-blue-600'
              "
              class="p-3"
            />
          </div>
        </b-col>
        <b-col class="flex items-center justify-center">
          <div
            v-if="paginationStart < exercises.length - 8"
            @click="incrementPagination()"
          >
            <font-awesome-icon
              class="text-2xl text-gray-300"
              icon="chevron-right"
            />
          </div>
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>

<script>
import Exercise from "@/components/Exercise.vue";
import ExerciseIcon from "@/components/ExerciseIcon.vue";
import { exercisesData } from "@/components/exercises_data.js";

export default {
  name: "Trainer",
  components: {
    Exercise,
    ExerciseIcon
  },
  data() {
    return {
      exercises: exercisesData,
      currentExercise: 0,
      paginationStart: 0,
      started: false,
      paginationSize: 8
    };
  },
  computed: {
    paginatedExercises() {
      return this.exercises.slice(
        this.paginationStart,
        this.paginationStart + 8
      );
    },
    estimatedTime() {
      let globalTime = 0;

      for (let i = this.currentExercise + 1; i < this.exercises.length; i++) {
        globalTime +=
          this.exercises[i].timer * this.exercises[i].variations.length;
      }

      return {
        minutes: Math.floor(globalTime / 60),
        seconds: globalTime % 60
      };
    }
  },
  methods: {
    decrementPagination() {
      if (this.paginationStart > 0) {
        this.paginationStart = this.paginationStart - 1;
      }
    },
    incrementPagination() {
      if (this.exercises.length - this.paginationStart > this.paginationSize) {
        this.paginationStart = this.paginationStart + 1;
      }
    },
    changeExercise(exercise) {
      this.currentExercise = exercise;
    },
    previousExercise() {
      this.currentExercise -= 1;

      while (this.currentExercise < this.paginationStart) {
        this.decrementPagination();
      }
    },
    nextExercise() {
      this.currentExercise += 1;
      while (
        this.currentExercise < this.exercises.length &&
        this.currentExercise >= this.paginationStart + this.paginationSize
      ) {
        this.incrementPagination();
      }
    },
    resetTrainer() {
      this.started = false;
      this.currentExercise = 0;
      this.paginationStart = 0;
    },
    activePagination(index) {
      return (
        this.currentExercise == this.paginationStart + index && this.started
      );
    }
  }
};
</script>

<style></style>
