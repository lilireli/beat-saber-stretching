<template>
  <div>
    <div id="canvas" class="bg-gray-200 border-gray-200 h-96 w-full"></div>
  </div>
</template>

<script>
import * as THREE from "three";
import { GLTFLoader } from "three/examples/jsm/loaders/GLTFLoader.js";

export default {
  name: "Character",
  props: {
    animation: String
  },
  data() {
    return {
      container: null,
      clock: null,
      mixer: null,
      actions: {},
      activeAction: null,
      previousAction: null,
      camera: null,
      scene: null,
      renderer: null,
      model: null,
      face: null
    };
  },
  mounted() {
    this.init();
    this.animate();
  },
  watch: {
    animation: function(val) {
      this.fadeToAction(val, 0.1);
    }
  },
  methods: {
    init() {
      // choose container
      this.container = document.getElementById("canvas");

      // camera
      this.camera = new THREE.PerspectiveCamera(
        45,
        window.innerWidth / window.innerHeight,
        0.25,
        100
      );
      this.camera.position.set(-5, 3, 10);
      this.camera.lookAt(new THREE.Vector3(0, 2, 0));

      // scene
      this.scene = new THREE.Scene();
      this.scene.background = new THREE.Color(0xe5e7eb);
      this.scene.fog = new THREE.Fog(0xe5e7eb, 20, 100);

      this.clock = new THREE.Clock();

      // lights
      const hemiLight = new THREE.HemisphereLight(0xffffff, 0x444444);
      hemiLight.position.set(0, 20, 0);
      this.scene.add(hemiLight);

      const dirLight = new THREE.DirectionalLight(0xffffff);
      dirLight.position.set(0, 20, 10);
      this.scene.add(dirLight);

      // ground
      const mesh = new THREE.Mesh(
        new THREE.PlaneBufferGeometry(2000, 2000),
        new THREE.MeshPhongMaterial({ color: 0x6a6a6e, depthWrite: false })
      );
      mesh.rotation.x = -Math.PI / 2;
      this.scene.add(mesh);

      // const grid = new THREE.GridHelper(200, 40, 0x000000, 0x000000);
      // grid.material.opacity = 0.2;
      // grid.material.transparent = true;
      // this.scene.add(grid);

      // model
      const loader = new GLTFLoader();
      loader.load(
        "RobotExpressive.glb",
        gltf => {
          this.model = gltf.scene;
          this.scene.add(this.model);

          this.fillActions(gltf.animations);
        },
        undefined,
        function(e) {
          console.error(e);
        }
      );

      // renderer
      this.renderer = new THREE.WebGLRenderer({ antialias: true });
      this.renderer.setPixelRatio(window.devicePixelRatio);
      const positionInfo = this.container.getBoundingClientRect();
      this.renderer.setSize(positionInfo.width, positionInfo.height);
      this.renderer.outputEncoding = THREE.sRGBEncoding;
      this.container.appendChild(this.renderer.domElement);

      window.addEventListener("resize", this.onWindowResize, false);
    },
    fillActions(animations) {
      const states = [
        "Idle",
        "Walking",
        "Running",
        "Dance",
        "Death",
        "Sitting",
        "Standing"
      ];
      const emotes = ["Jump", "Yes", "No", "Wave", "Punch", "ThumbsUp"];

      this.mixer = new THREE.AnimationMixer(this.model);

      for (let i = 0; i < animations.length; i++) {
        const clip = animations[i];
        const action = this.mixer.clipAction(clip);
        this.actions[clip.name] = action;

        if (emotes.indexOf(clip.name) >= 0 || states.indexOf(clip.name) >= 4) {
          action.clampWhenFinished = true;
          action.loop = THREE.LoopOnce;
        }
      }

      this.activeAction = this.actions["Idle"];
      this.activeAction.play();
    },
    fadeToAction(name, duration) {
      this.previousAction = this.activeAction;
      this.activeAction = this.actions[name];

      if (this.previousAction !== this.activeAction) {
        this.previousAction.fadeOut(duration);
      }

      this.activeAction
        .reset()
        .setEffectiveTimeScale(1)
        .setEffectiveWeight(1)
        .fadeIn(duration)
        .play();
    },
    onWindowResize() {
      this.camera.aspect = window.innerWidth / window.innerHeight;
      this.camera.updateProjectionMatrix();

      this.renderer.setSize(window.innerWidth, window.innerHeight);
    },
    animate() {
      const dt = this.clock.getDelta();

      if (this.mixer) this.mixer.update(dt);

      requestAnimationFrame(this.animate);

      this.renderer.render(this.scene, this.camera);
    }
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
#canvas {
  height: 30rem;
  width: 50rem;
  margin: 0px;
  padding: 0px;
  position: static; /* fixed or static */
  top: 100px;
  left: 100px;
}
</style>
