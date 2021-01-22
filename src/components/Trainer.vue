<template>
  <div id="trainer">
    <b-container>
      <b-row>
        <b-col cols="2">
          <div @click="previousExercise()">
            <font-awesome-icon icon="chevron-left" />
          </div>
        </b-col>
        <b-col cols="8">
          <Exercise
            :title="exercises[currentExercise].title"
            :description="exercises[currentExercise].description"
            :timeout="exercises[currentExercise].timer"
            :key="exercises[currentExercise].title"
            @end="nextExercice()"
          ></Exercise>
        </b-col>
        <b-col cols="2">
          <div>After that:</div>
          <div>{{ estimatedTime.minutes }} m {{ estimatedTime.seconds }}</div>

          <div @click="nextExercice()">
            <font-awesome-icon icon="chevron-right" />
          </div>
        </b-col>
      </b-row>
    </b-container>

    <b-container>
      <b-row>
        <b-col>
          <div @click="removePagination()">
            <font-awesome-icon icon="chevron-left" />
          </div>
        </b-col>
        <b-col v-for="(exercise, index) in paginatedExercises" :key="index">
          <div
            class="paginated-el"
            @click="changeExercise(paginationStart + index)"
          >
            {{ exercise.title }}
          </div>
        </b-col>
        <b-col>
          <div @click="addPagination()">
            <font-awesome-icon icon="chevron-right" />
          </div>
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>

<script>
import Exercise from "@/components/Exercise.vue";
import { exercisesData } from "@/components/exercises_data.js";

export default {
  name: "Trainer",
  components: {
    Exercise
  },
  data() {
    return {
      exercises: exercisesData,
      currentExercise: 0,
      paginationStart: 0
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
        globalTime += this.exercises[i].timer;
      }

      return {
        minutes: Math.floor(globalTime / 60),
        seconds: globalTime % 60
      };
    }
  },
  methods: {
    addPagination() {
      if (this.exercises.length - this.paginationStart > 8) {
        console.log(this.paginationStart);
        this.paginationStart = this.paginationStart + 1;
      }
    },
    removePagination() {
      if (this.paginationStart > 8) {
        this.paginationStart = this.paginationStart - 1;
      }
    },
    changeExercise(exercise) {
      this.currentExercise = exercise;
    },
    previousExercice() {
      this.currentExercise -= 1;
    },
    nextExercice() {
      this.currentExercise += 1;
    }
  }
};
</script>

<style>
div.paginated-el {
  background-color: blue;
  color: white;
  width: 6em;
  height: 6em;
  border-radius: 6em;
}
</style>
