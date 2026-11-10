
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>WELCOME ONE AND ALL!</title>

<style>
* { box-sizing: border-box; }

body {
  margin: 0;
  background: #080014;
  color: white;
  font-family: "Comic Sans MS", Arial, sans-serif;
  text-align: center;
  overflow-x: hidden;
}

#welcome {
  min-height: 100vh;
  padding: 25px 10px;
  background: repeating-linear-gradient(
    45deg, #ff00cc, #ff00cc 25px,
    #7700ff 25px, #7700ff 50px
  );
}

h1 {
  font-size: clamp(30px, 8vw, 70px);
  color: #ffeb00;
  text-shadow: 4px 4px #f00, 7px 7px #00f;
}

button {
  padding: 16px 28px;
  background: #ffeb00;
  color: #b00000;
  border: 4px dashed #f00;
  border-radius: 12px;
  font-size: 20px;
  font-weight: bold;
  cursor: pointer;
}

button:hover {
  transform: scale(1.06);
}

#game {
  display: none;
  min-height: 100vh;
  padding: 12px;
  background: repeating-linear-gradient(
    45deg, #ff00cc, #ff00cc 25px,
    #7700ff 25px, #7700ff 50px
  );
}

#flashTitle {
  font-size: clamp(35px, 8vw, 75px);
  font-weight: 1000;
  animation: flash .6s infinite alternate;
  text-shadow: 0 0 15px red, 0 0 30px yellow;
}

@keyframes flash {
  from { color: red; transform: scale(1); }
  to { color: yellow; transform: scale(1.06); }
}

#character {
  font-size: 30px;
  font-weight: bold;
  margin: 12px;
}

#dialogue {
  font-size: clamp(19px, 4vw, 30px);
  min-height: 75px;
  color: white;
  text-shadow: 3px 3px black;
}

#timer {
  font-size: 25px;
  color: lime;
  font-weight: bold;
}

.marquee {
  overflow: hidden;
  white-space: nowrap;
  background: black;
  color: yellow;
  font-size: 22px;
  font-weight: bold;
  padding: 10px;
}

.marquee span {
  display: inline-block;
  animation: scroll 9s linear infinite;
}

@keyframes scroll {
  from { transform: translateX(100vw); }
  to { transform: translateX(-100%); }
}

#stage {
  height: 310px;
  max-width: 1000px;
  margin: 15px auto;
  position: relative;
  overflow: hidden;
  border: 5px dotted yellow;
  background: rgba(0,0,0,.4);
}

.character-picture {
  position: absolute;
  width: clamp(65px, 10vw, 105px);
  height: clamp(75px, 13vw, 125px);
  object-fit: contain;
  filter: drop-shadow(3px 3px 4px black);
  will-change: left, top;
}

#spamArea {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: 9px;
  margin: 18px auto;
  max-width: 1000px;
}

.spam {
  background: black;
  color: lime;
  border: 3px solid cyan;
  padding: 10px;
  font-size: 16px;
  font-weight: bold;
  animation: wobble .8s infinite alternate;
}

@keyframes wobble {
  from { transform: rotate(-2deg); }
  to { transform: rotate(2deg); }
}

#ending {
  display: none;
  min-height: 100vh;
  background: #080014;
  padding: 35px 10px;
}

.small {
  font-size: 14px;
  color: #ddd;
}

@media(prefers-reduced-motion:reduce) {
  *, *:before, *:after {
    animation: none !important;
  }
}
</style>
</head>

<body>

<div id="welcome">
  <h1>WELCOME ONE AND ALL!</h1>
  <h2>THE AMAZING CHAOS SHOW!</h2>
  <p>Featuring Bill Cipher, Spamton and Caine!</p>
  <p>Prepare for a ridiculous amount of nonsense...</p>
  <button onclick="startGame()">ENTER THE CHAOS</button>
  <p class="small">
    A harmless browser prank. Close this tab whenever you want.
  </p>
</div>

<div id="game">

  <div class="marquee">
    <span>
      YOU FELL FOR IT! • BIG SHOT! • WELCOME TO THE CIRCUS!
      • REALITY IS AN ILLUSION! • YOU FELL FOR IT! •
    </span>
  </div>

  <h1 id="flashTitle">YOU FELL FOR IT!</h1>

  <div id="character">BILL CIPHER</div>

  <div id="dialogue">
    REALITY IS AN ILLUSION!
  </div>

  <div id="timer">10:00</div>

  <div id="stage"></div>

  <h2 style="color:yellow">THE SPAM MACHINE</h2>

  <div id="spamArea"></div>

  <div class="marquee">
    <span>
      BUY NOW! • BIG SHOT! • HAHAHA!
      • THE SHOW MUST GO ON! • YOU FELL FOR IT! •
    </span>
  </div>

</div>

<div id="ending">
  <h1 id="endTitle">YOU FELL FOR IT!</h1>
  <h2 style="color:cyan">THE SHOW IS OVER!</h2>
  <p>Bill, Spamton and Caine say goodbye!</p>
  <button onclick="location.reload()">PLAY AGAIN</button>
</div>

<script>

const characters = [
 {
  name: "BILL CIPHER",
  color: "#ffff00",
  lines: [
   "REALITY IS AN ILLUSION!",
   "THE UNIVERSE IS A HOLOGRAM!",
   "BUY GOLD! BYEEEE!",
   "WELCOME TO WEIRDMAGEDDON!",
   "YOU'VE MADE A TERRIBLE MISTAKE!"
  ]
 },
 {
  name: "SPAMTON G. SPAMTON",
  color: "#00ffff",
  lines: [
   "NOW'S YOUR CHANCE TO BE A [[BIG SHOT]]!",
   "KRIS! GET THE [KROMER]!",
   "CALL NOW! LIMITED TIME OFFER!",
   "THANK YOU FOR YOUR [PURCHASE]!",
   "I NEED A [[BIG SHOT]]!"
  ]
 },
 {
  name: "CAINE",
  color: "#ff5555",
  lines: [
   "WELCOME TO THE AMAZING DIGITAL CIRCUS!",
   "WHAT A WONDERFUL DAY!",
   "LET'S HAVE AN ADVENTURE!",
   "EVERYONE REMAIN CALM!",
   "TIME FOR SOME DIGITAL FUN!"
  ]
 }
];

// YOUR FIVE UPLOADED PICTURES
const pictureFiles = [
 "pic1.jpeg",
 "pic2.jpeg",
 "pic3.jpeg",
 "pic4.jpeg",
 "pic5.jpeg"
];

let index = 0;
let timeLeft = 600;
let active = false;

let dialogueTimer;
let clockTimer;
let spamTimer;
let animationFrame;

const stage = document.getElementById("stage");
const bouncingPictures = [];

// CREATE 15 BOUNCING PICTURES

function addPictures() {

 pictureFiles.forEach((file, i) => {

  for (let n = 0; n < 3; n++) {

   const img = document.createElement("img");

   img.src = file;
   img.alt = "Prank character picture " + (i + 1);
   img.className = "character-picture";

   img.onerror = () => {
    img.alt = "Character picture could not load";
   };

   stage.appendChild(img);

   bouncingPictures.push({
    element: img,
    x: Math.random() * Math.max(1, stage.clientWidth - 100),
    y: Math.random() * Math.max(1, stage.clientHeight - 120),
    vx: (Math.random() < .5 ? -1 : 1) * (1.5 + Math.random() * 2.5),
    vy: (Math.random() < .5 ? -1 : 1) * (1.5 + Math.random() * 2.5),
    angle: Math.random() * 30 - 15,
    spin: (Math.random() < .5 ? -1 : 1) * (.15 + Math.random() * .3)
   });

  }

 });

 bouncePictures();
}

// MAKE PICTURES BOUNCE AROUND

function bouncePictures() {

 if (!active) return;

 const w = stage.clientWidth;
 const h = stage.clientHeight;

 bouncingPictures.forEach(p => {

  const el = p.element;
  const pw = el.offsetWidth;
  const ph = el.offsetHeight;

  p.x += p.vx;
  p.y += p.vy;
  p.angle += p.spin;

  if (p.x <= 0) {
   p.x = 0;
   p.vx = Math.abs(p.vx);
  }

  if (p.x + pw >= w) {
   p.x = Math.max(0, w - pw);
   p.vx = -Math.abs(p.vx);
  }

  if (p.y <= 0) {
   p.y = 0;
   p.vy = Math.abs(p.vy);
  }

  if (p.y + ph >= h) {
   p.y = Math.max(0, h - ph);
   p.vy = -Math.abs(p.vy);
  }

  el.style.left = p.x + "px";
  el.style.top = p.y + "px";
  el.style.transform = "rotate(" + p.angle + "deg)";

 });

 animationFrame = requestAnimationFrame(bouncePictures);
}

// CHARACTER DIALOGUE

function changeCharacter() {

 if (!active) return;

 const c = characters[index];

 document.getElementById("character").textContent = c.name;
 document.getElementById("character").style.color = c.color;

 document.getElementById("dialogue").textContent =
  c.lines[Math.floor(Math.random() * c.lines.length)];

 index = (index + 1) % characters.length;

 dialogueTimer = setTimeout(changeCharacter, 2600);
}

// RANDOM SPAM

function makeSpam() {

 if (!active) return;

 const messages = [
  "YOU FELL FOR IT!",
  "NOW'S YOUR CHANCE TO BE A [BIG SHOT]!",
  "BUY MY [PRODUCT]!",
  "WELCOME ONE AND ALL!",
  "REALITY IS AN ILLUSION!",
  "HAHAHAHAHAHA!",
  "CAINE HAS ENTERED THE CHAT!",
  "BILL CIPHER IS WATCHING!",
  "LIMITED TIME OFFER!",
  "CLICK HERE FOR [KROMER]!",
  "THE SHOW MUST GO ON!"
 ];

 const area = document.getElementById("spamArea");

 const box = document.createElement("div");

 box.className = "spam";

 box.textContent =
  messages[Math.floor(Math.random() * messages.length)];

 area.appendChild(box);

 while (area.children.length > 18) {
  area.removeChild(area.firstChild);
 }

 spamTimer = setTimeout(makeSpam, 1100);
}

// 10 MINUTE TIMER

function countdown() {

 if (!active) return;

 const m = Math.floor(timeLeft / 60);
 const s = timeLeft % 60;

 document.getElementById("timer").textContent =
  String(m).padStart(2, "0") + ":" +
  String(s).padStart(2, "0");

 if (timeLeft <= 0) {
  finish();
  return;
 }

 timeLeft--;

 clockTimer = setTimeout(countdown, 1000);
}

// START THE SHOW

function startGame() {

 if (active) return;

 active = true;

 document.getElementById("welcome").style.display = "none";
 document.getElementById("game").style.display = "block";

 addPictures();
 changeCharacter();
 makeSpam();
 countdown();
}

// END THE SHOW

function finish() {

 active = false;

 clearTimeout(dialogueTimer);
 clearTimeout(clockTimer);
 clearTimeout(spamTimer);

 cancelAnimationFrame(animationFrame);

 document.getElementById("game").style.display = "none";
 document.getElementById("ending").style.display = "block";
}

</script>
</body>
</html>
