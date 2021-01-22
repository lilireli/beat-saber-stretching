<template>
  <div id="app">
    <h1 class="title">
      <span class="red">Beat</span> <span class="blue">Saber</span> Stretching
    </h1>

    To do everyday, to train wrist and shoulder.

    <Trainer />
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

$background: #ffffff; //#2c3e50;
$text: #424141;

#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: grey;
  background-color: $background;
  margin-top: 20px;
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
  margin-left: 20px;
}

span.red {
  color: red;
}

span.blue {
  color: blue;
}
</style>
