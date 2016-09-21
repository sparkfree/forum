<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css">
<meta name="viewport" content="width=device-width, initial-scale=1">
<canvas></canvas>

<style type="text/css">
		body{
			background-color: #f0ffff;
			text-align: center;
		}
</style>
	
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-1.8.3.js"></script>
	<script type="text/javascript">
		$(function(){
			$("#register").hide();
			
		});
		function register(){
			$("#login").hide();
			$("#register").show();
		}
		function login(){
			$("#register").hide();
			$("#login").show();
		}
	</script>
	
<div class="absolute-center">
<!--     <h3>MOVE AROUND YOUR MOUSE!</h3> -->
    
<!--     <h5><i>You can adjust the options by modifying lines 11 to 29 of the JavaScript code<br>Please note that upon resizing the page, it will have to reload</i></h5> -->
    
<!--     <span id="close"><i class="fa fa-fw fa-times-circle-o"></i></span> -->

		<div style="margin-left: 450px;">
  		<span id="btnlogin" onclick="login()">登录</span>&nbsp;&nbsp;
  		<span id="btnregister" onclick="register()">注册</span>
  		<br/><br/>
  		<div id="login">
  			<form action="userlogin.do" method="post">
    		<span>账号</span>&nbsp;&nbsp;<input name="account" id="account" type="text"><br/><br/>
    		<span>密码</span>&nbsp;&nbsp;<input name="password" id="password" type="password"><br/><br/>
    		<input type="submit" value="登录">
    		</form>
  		</div>
  		
  		<div id="register">
  			<form action="userregister.do" method="post">
    		<span>账号</span>&nbsp;&nbsp;<input name="account" id="account" type="text"/><br/><br/>
    		<span>密码</span>&nbsp;&nbsp;<input name="password" id="password" type="password"><br/><br/>
    		<span>手机号</span>&nbsp;<input name="phonenumber" id="phonenumber" type="text"><br/><br/>
    		<input type="submit" value="注册">
    		</form>
  		</div>
  	</div>
  	
</div>
<style>
@import 'https://fonts.googleapis.com/css?family=Open+Sans:300|Roboto:400';
body {
    width: 100vw;
    height: 100vh;
    overflow: hidden;
    margin: 0;
    padding: 0;
    background: #1f263b;
    background: -moz-linear-gradient(top, #1f263b 0%, #2c3654 100%);
    background: -webkit-linear-gradient(top, #1f263b 0%, #2c3654 100%);
    background: linear-gradient(to bottom, #1f263b 0%, #2c3654 100%);
}

div.absolute-center {
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    opacity: 1;
    visibility: visible;
    transition: all .5s;
}

h3,
h5 {
    padding: 10px 30px 10px 30px;
    box-sizing: border-box;
    background: rgba(255, 255, 255, 1);
    box-shadow: 0 0 5px 0 black;
    font-family: 'Open Sans';
    font-weight: 300;
    text-align: center;
    letter-spacing: 3px;
}

span#close {
    position: absolute;
    top: -15px;
    left: -30px;
    color: white;
    font-size: 30px;
    text-shadow: 0 0 5px black;
    cursor: pointer;
}

canvas {
    //border: 2px solid;
}
</style>
<script>
	//ninivert, September 2016

/*VARIABLES*/

canvas = document.getElementsByTagName('canvas')[0];
canvas.width = document.body.clientWidth;
canvas.height = document.body.clientHeight;

var ctx = canvas.getContext('2d');

/*Modify options here*/

//possible characters that will appear
var characterList = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'];

//stocks possible character attributes
var layers = {
    n: 5, //number of layers
    letters: [100, 40, 30, 20, 10], //letters per layer (starting from the deepest layer)
    coef: [0.1, 0.2, 0.4, 0.6, 0.8], //how much the letters move from the mouse (starting from the deepest layer)
    size: [16, 22, 36, 40, 46], //font size of the letters (starting from the deepest layer)
    color: ['#fff', '#eee', '#ccc', '#bbb', '#aaa'], //color of the letters (starting from the deepest layer)
    font: 'Courier' //font family (of every layer)
};

/*End of options*/

var characters = [];
var mouseX = document.body.clientWidth / 2;
var mouseY = document.body.clientHeight / 2;

var rnd = {
    btwn: function(min, max) {
        return Math.floor(Math.random() * (max - min) + min);
    },
    choose: function(list) {
        return list[rnd.btwn(0, list.length)];
    }
};

/*LETTER DRAWING*/

function drawLetter(char) {
    ctx.font = char.size + 'px ' + char.font;
    ctx.fillStyle = char.color;

    var x = char.posX + (mouseX - canvas.width / 2) * char.coef;
    var y = char.posY + (mouseY - canvas.height / 2) * char.coef;

    ctx.fillText(char.char, x, y);
}

/*ANIMATION*/

document.onmousemove = function(ev) {
    mouseX = ev.pageX - canvas.offsetLeft;
    mouseY = ev.pageY - canvas.offsetTop;

    if (window.requestAnimationFrame) {
        requestAnimationFrame(update);
    } else {
        update();
    }
};

function update() {
    clear();
    render();
}

function clear() {
    ctx.clearRect(0, 0, canvas.width, canvas.height);
}

function render() {
    for (var i = 0; i < characters.length; i++) {
        drawLetter(characters[i]);
    }
}

/*INITIALIZE*/

function createLetters() {
    for (var i = 0; i < layers.n; i++) {
        for (var j = 0; j < layers.letters[i]; j++) {

            var character = rnd.choose(characterList);
            var x = rnd.btwn(0, canvas.width);
            var y = rnd.btwn(0, canvas.height);

            characters.push({
                char: character,
                font: layers.font,
                size: layers.size[i],
                color: layers.color[i],
                layer: i,
                coef: layers.coef[i],
                posX: x,
                posY: y
            });

        }
    }
}

createLetters();
update();

/*REAJUST CANVAS AFTER RESIZE*/

window.onresize = function() {
    location.reload();
};

document.getElementById('close').onclick = function() {
    this.parentElement.style.visibility = 'hidden';
    this.parentElement.style.opacity = '0';
}
</script>