<template>
  <div class="progress">
    <span class="progress-left left-0">
      <span class="progress-bar" :style="{ transform: degreesLeft }"></span>
    </span>
    <span class="progress-right right-0">
      <span class="progress-bar" :style="{ transform: degreesRight }"></span>
    </span>
    <div class="absolute top-12 w-full text-center text-xl text-gray-600">
      {{ value }}
    </div>
  </div>
</template>

<script>
export default {
  name: "ProgressCircle",
  props: {
    value: Number,
    max: Number
  },
  computed: {
    degreesLeft() {
      let deg = ((this.max - this.value) / this.max - 0.5) * 360;

      if (deg < 0) {
        deg = 0;
      }

      return "rotate(" + deg + "deg)";
    },
    degreesRight() {
      let deg = ((this.max - this.value) / this.max) * 360;

      if (deg > 180) {
        deg = 180;
      }

      return "rotate(" + deg + "deg)";
    }
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.progress {
  float: left;
  line-height: 150px;
  background: none;
  box-shadow: none;
  position: relative;
  @apply w-32 h-32;
}

.progress:after {
  content: "";
  width: 100%;
  height: 100%;
  border-radius: 50%;
  border: 16px solid #fff;
  position: absolute;
  top: 0;
  left: 0;
}

.progress > span {
  width: 50%;
  height: 100%;
  overflow: hidden;
  position: absolute;
  top: 0;
  z-index: 1;
}

.progress .progress-bar {
  width: 100%;
  height: 100%;
  background: none;
  border-width: 16px;
  border-style: solid;
  /* border-color: #fff; */
  position: absolute;
  top: 0;
  transition: transform 0.5s;
  @apply border-blue-600;
}

.progress .progress-left .progress-bar {
  left: 100%;
  border-top-right-radius: 80px;
  border-bottom-right-radius: 80px;
  border-left: 0;
  -webkit-transform-origin: center left;
  transform-origin: center left;
}

.progress .progress-right .progress-bar {
  left: -100%;
  border-top-left-radius: 80px;
  border-bottom-left-radius: 80px;
  border-right: 0;
  -webkit-transform-origin: center right;
  transform-origin: center right;
}
</style>
