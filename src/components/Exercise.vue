<template>
  <b-container class="flex-grow flex flex-col">
    <b-row class="h-1/6 justify-center items-center">
      <div class="text-3xl text-red-600 p-10">
        {{ params.title }}
      </div>
    </b-row>

    <b-row class="h-4/6">
      <b-col cols="8">
        <Character :animation="currentAnimation" />
      </b-col>
      <b-col cols="4">
        <div class="h-1/2 flex flex-col items-center justify-center">
          <div class="text-gray-700 p-2">
            {{ currentVariation + 1 }} /
            {{ params.variations.length }}
          </div>
          <div class="text-gray-700">
            {{ params.variations[currentVariation].name }}
          </div>
        </div>

        <div>
          <div
            v-if="transition > 0"
            class="h-100 overflow-hidden w-full relative"
          >
            <div class="w-full flex justify-center">
              <div class="loader"></div>
            </div>

            <div
              class="absolute top-12 w-full items-center text-center text-xl text-gray-600"
            >
              <span v-if="transition == 3">Ready</span>
              <span v-else-if="transition == 2">Set</span>
              <span v-else>Go</span>
            </div>
          </div>

          <div v-else>
            <div class="h-100 flex justify-center text-gray-600 text-xl">
              <ProgressCircle :value="timer" :max="params.timer" />
            </div>
            <div class="flex justify-center">
              <div
                v-if="playing"
                @click="pauseTimer()"
                class="p-2 text-gray-600 text-xl"
              >
                <font-awesome-icon icon="pause-circle" />
              </div>
              <div
                v-if="!playing"
                @click="playTimer()"
                class="p-2 text-gray-600 text-xl"
              >
                <font-awesome-icon icon="play-circle" />
              </div>
              <div @click="reloadTimer()" class="p-2 text-gray-600 text-xl">
                <font-awesome-icon icon="redo-alt" />
              </div>
            </div>
          </div>
        </div>
      </b-col>
    </b-row>

    <b-row class="h-1/6 justify-center items-center">
      <div class="text-gray-600">
        {{ params.description }}
      </div>
    </b-row>
  </b-container>
</template>

<script>
import Character from "./Character.vue";
import ProgressCircle from "./ProgressCircle.vue";

export default {
  name: "Exercise",
  components: { Character, ProgressCircle },
  props: {
    params: Object
  },
  data() {
    return {
      transition: 3,
      timer: this.params.timer,
      currentVariation: 0,
      playing: true,
      currentAnimation: "Idle"
    };
  },
  mounted() {
    this.waitTransition();
  },
  methods: {
    waitTransition() {
      this.transition = 3;

      const interval = setInterval(
        function() {
          if (this.transition > 0) {
            this.transition -= 1;
          } else {
            clearInterval(interval);
            this.chrono();
          }
        }.bind(this),
        1000
      );
    },
    async chrono() {
      // Update the count down every 1 second
      const interval = setInterval(
        function() {
          if (this.playing) {
            this.timer -= 1;
            this.currentAnimation = this.params.variations[
              this.currentVariation
            ].animation;
          } else {
            this.currentAnimation = "Idle";
          }

          if (this.timer < 0) {
            clearInterval(interval);
            this.currentVariation += 1;
            this.currentAnimation = "Idle";

            if (this.currentVariation < this.params.variations.length) {
              this.timer = this.params.timer;
              this.waitTransition();
            } else {
              this.$emit("end");
            }
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
      this.timer = this.params.timer;
    }
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.loader {
  font-size: 10px;
  border-radius: 50%;
  background: #ffffff;
  background: -moz-linear-gradient(
    left,
    #ffffff 10%,
    rgba(255, 255, 255, 0) 42%
  );
  background: -webkit-linear-gradient(
    left,
    #ffffff 10%,
    rgba(255, 255, 255, 0) 42%
  );
  background: -o-linear-gradient(left, #ffffff 10%, rgba(255, 255, 255, 0) 42%);
  background: -ms-linear-gradient(
    left,
    #ffffff 10%,
    rgba(255, 255, 255, 0) 42%
  );
  background: linear-gradient(
    to right,
    #ffffff 10%,
    rgba(255, 255, 255, 0) 42%
  );
  -webkit-animation: loadRotate 1s infinite linear;
  animation: loadRotate 1s infinite linear;
  -webkit-transform: translateZ(0);
  -ms-transform: translateZ(0);
  transform: translateZ(0);
  @apply relative w-32 h-32;
}

.loader:before {
  width: 50%;
  height: 50%;
  background: #ffffff;
  border-radius: 100% 0 0 0;
  position: absolute;
  top: 0;
  left: 0;
  content: "";
}

.loader:after {
  width: 75%;
  height: 75%;
  border-radius: 50%;
  content: "";
  margin: auto;
  top: 0;
  left: 0;
  bottom: 0;
  right: 0;
  @apply bg-gray-200 absolute;
}

@-webkit-keyframes loadRotate {
  0% {
    -webkit-transform: rotate(0deg);
    transform: rotate(0deg);
  }
  100% {
    -webkit-transform: rotate(360deg);
    transform: rotate(360deg);
  }
}

@keyframes loadRotate {
  0% {
    -webkit-transform: rotate(0deg);
    transform: rotate(0deg);
  }
  100% {
    -webkit-transform: rotate(360deg);
    transform: rotate(360deg);
  }
}
</style>
