<template>
  <div>
    <b-button>{{ title }}</b-button>
    <b-container>
      <b-row>
        <b-col cols="2"></b-col>
        <b-col cols="8">
          <Character />
        </b-col>
        <b-col cols="2">
          <h1>{{ timer }}</h1>
          <div>
            <div v-if="playing" @click="pauseTimer()">
              <font-awesome-icon icon="pause-circle" />
            </div>
            <div v-if="!playing" @click="playTimer()">
              <font-awesome-icon icon="play-circle" />
            </div>
            <div @click="reloadTimer()">
              <font-awesome-icon icon="redo-alt" />
            </div>
          </div>
        </b-col>
      </b-row>
    </b-container>

    <p>
      {{ description }}
    </p>
  </div>
</template>

<script>
import Character from "./Character.vue";

export default {
  components: { Character },
  name: "Exercise",
  props: {
    title: String,
    description: String,
    timeout: Number
  },
  data() {
    return {
      timer: this.timeout,
      playing: true
    };
  },
  mounted() {
    this.chrono();
  },
  methods: {
    async chrono() {
      // Update the count down every 1 second
      const interval = setInterval(
        function() {
          if (this.timer > 0 && this.playing) {
            this.timer = this.timer - 1;
          }

          if (this.timer == 0) {
            console.log("lama");
            clearInterval(interval);
            this.$emit("end");
          }
        }.bind(this),
        1000
      );
    },
    pauseTimer() {
      this.playing = false;
    },
    playTimer() {
      this.playing = true;
    },
    reloadTimer() {
      this.timer = this.timeout;
    }
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped></style>
