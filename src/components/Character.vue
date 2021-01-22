<template>
  <div>
    <div id="canvas"></div>
  </div>
</template>

<script>
import * as THREE from "three";
// import { GLTFLoader } from "three/examples/jsm/loaders/GLTFLoader.js";

export default {
  name: "Character",
  mounted() {
    this.create();
  },
  methods: {
    async create() {
      // Init the scene
      const backgroundColor = 0x000000;
      const scene = new THREE.Scene();
      scene.background = new THREE.Color(backgroundColor);
      scene.fog = new THREE.Fog(backgroundColor, 60, 100);

      // Init the renderer
      const container = document.getElementById("canvas");
      const renderer = new THREE.WebGLRenderer({ antialias: true });
      renderer.setSize(200, 200);
      container.appendChild(renderer.domElement);

      // The Cube
      const geometry = new THREE.BoxGeometry();
      const material = new THREE.MeshBasicMaterial({ color: 0x00ff00 });
      const cube = new THREE.Mesh(geometry, material);
      scene.add(cube);

      // Add a camera
      const camera = new THREE.PerspectiveCamera(
        50,
        window.innerWidth / window.innerHeight,
        0.1,
        1000
      );
      camera.position.z = 5;

      function animate() {
        requestAnimationFrame(animate);
        cube.rotation.x += 0.01;
        cube.rotation.y += 0.01;
        renderer.render(scene, camera);
      }
      animate();

      // // Add lights
      // let hemiLight = new THREE.HemisphereLight(0xffffff, 0xffffff, 0.61);
      // hemiLight.position.set(0, 50, 0);
      // // Add hemisphere light to scene
      // scene.add(hemiLight);

      // let d = 8.25;
      // let dirLight = new THREE.DirectionalLight(0xffffff, 0.54);
      // dirLight.position.set(-8, 12, 8);
      // dirLight.castShadow = true;
      // dirLight.shadow.mapSize = new THREE.Vector2(1024, 1024);
      // dirLight.shadow.camera.near = 0.1;
      // dirLight.shadow.camera.far = 1500;
      // dirLight.shadow.camera.left = d * -1;
      // dirLight.shadow.camera.right = d;
      // dirLight.shadow.camera.top = d;
      // dirLight.shadow.camera.bottom = d * -1;
      // // Add directional Light to scene
      // scene.add(dirLight);

      // // Floor
      // let floorGeometry = new THREE.PlaneGeometry(5000, 5000, 1, 1);
      // let floorMaterial = new THREE.MeshPhongMaterial({
      //   color: 0xeeeeee,
      //   shininess: 0
      // });

      // let floor = new THREE.Mesh(floorGeometry, floorMaterial);
      // floor.rotation.x = -0.5 * Math.PI; // This is 90 degrees by the way
      // floor.receiveShadow = true;
      // floor.position.y = -11;
      // scene.add(floor);

      // // Model
      // const clock = new THREE.Clock();
      // let stacy_txt = new THREE.TextureLoader().load(
      //   "https://s3-us-west-2.amazonaws.com/s.cdpn.io/1376484/stacy.jpg"
      // );
      // stacy_txt.flipY = false;

      // const stacy_mtl = new THREE.MeshPhongMaterial({
      //   map: stacy_txt,
      //   color: 0xffffff,
      //   skinning: true
      // });

      // const loader = new GLTFLoader();

      // let model;

      // loader.load(
      //   "https://s3-us-west-2.amazonaws.com/s.cdpn.io/1376484/stacy_lightweight.glb",
      //   function(gltf) {
      //     model = gltf.scene;

      //     model.traverse((o) => {
      //       if (o.isMesh) {
      //         o.castShadow = true;
      //         o.receiveShadow = true;
      //         o.material = stacy_mtl;
      //       }
      //     });

      //     // Set the models initial scale
      //     model.scale.set(7, 7, 7);
      //     model.position.y = -11;

      //     scene.add(model);

      //     let fileAnimations = gltf.animations;
      //     let clips = fileAnimations.filter((val) => val.name !== "idle");
      //     clips.map((val) => {
      //       let clip = THREE.AnimationClip.findByName(clips, val.name);

      //       clip.tracks.splice(3, 3);
      //       clip.tracks.splice(9, 3);

      //       clip = mixer.clipAction(clip);
      //       return clip;
      //     });

      //     let idleAnim = THREE.AnimationClip.findByName(fileAnimations, "idle");

      //     idleAnim.tracks.splice(3, 3);
      //     idleAnim.tracks.splice(9, 3);

      //     let idle = mixer.clipAction(idleAnim);
      //     idle.play();
      //   },
      //   undefined,
      //   function(error) {
      //     console.error(error);
      //   }
      // );

      // let mixer = new THREE.AnimationMixer(model);

      // function update() {
      //   if (resizeRendererToDisplaySize(renderer)) {
      //     const canvas = renderer.domElement;
      //     camera.aspect = canvas.clientWidth / canvas.clientHeight;
      //     camera.updateProjectionMatrix();
      //   }
      //   renderer.render(scene, camera);
      //   if (mixer) {
      //     mixer.update(clock.getDelta());
      //   }
      //   requestAnimationFrame(update);
      // }

      // update();

      // function resizeRendererToDisplaySize(renderer) {
      //   const canvas = renderer.domElement;
      //   let width = window.innerWidth;
      //   let height = window.innerHeight;
      //   let canvasPixelWidth = canvas.width / window.devicePixelRatio;
      //   let canvasPixelHeight = canvas.height / window.devicePixelRatio;

      //   const needResize =
      //     canvasPixelWidth !== width || canvasPixelHeight !== height;
      //   if (needResize) {
      //     renderer.setSize(width, height, false);
      //   }
      //   return needResize;
      // }
    }
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
#canvas {
  background-color: #000;
  width: 200px;
  height: 200px;
  border: 1px solid black;
  margin: 100px;
  padding: 0px;
  position: static; /* fixed or static */
  top: 100px;
  left: 100px;
}
</style>
