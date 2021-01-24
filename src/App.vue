<template>
  <div id="app" class="flex flex-col bg-gray-200 text-gray-800">
    <h1 class="title bg-gray-700 pt-1 pl-2 h-16">
      <span class="text-red-600">Beat</span>
      <span class="text-blue-600">Saber </span>
      <span class="text-gray-200">Stretching</span>
    </h1>

    <Trainer class="flex-grow" />
  </div>
</template>

<script>
import Trainer from "./components/Trainer.vue";

export default {
  name: "App",
  components: {
    Trainer
  }
};
</script>

<style lang="scss">
@font-face {
  font-family: "neon-tubes-2-regular";
  src: url("~@/assets/fonts/NeonTubes2.otf") format("woff"),
    url("~@/assets/fonts/NeonTubes2.otf") format("opentype"),
    url("~@/assets/fonts/NeonTubes2.otf") format("truetype");
}

html,
body,
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  @apply h-full w-full;
}

div.paginated-el {
  background-color: blue;
  color: white;
  width: 6em;
  height: 6em;
  border-radius: 6em;
}

h1.title {
  font-family: "neon-tubes-2-regular";
  font-size: 50px;
  text-transform: none;
  text-align: left;
}
</style>
