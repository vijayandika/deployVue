<template>
  <div id="app">
    <helloworld></helloworld>
    <helloworld2></helloworld2>
  </div>
</template>

<script>
import helloworld from "./components/HelloWorld.vue";
import helloworld2 from "./components/HelloWorld2.vue";
export default {
  name: "App",
  components: { helloworld, helloworld2 }
};
</script>

<style>
#app {
  font-family: "Avenir", Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
