<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2024/5/17
  Time: 16:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>实验四</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: bisque;
            height: 100%;
            width: 100%;
        }
        .a{
            text-align: center;
            font-family:FangSong;
            font-size: 25px;
            padding-top: 13%;
        }

        .container {
            max-width: 100%;
            padding-top: 2%;
            margin: 20px auto;
            text-align: center;
        }
        .nav-link {
            display: inline-block;
            margin: 10px;
            padding: 10px 20px;
            text-decoration: none;
            color: #fff;
            background-color: #4CAF50;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }
        .nav-link:hover {
            background-color: #45a049;
        }

    </style>
</head>
<body>
<div >

    <div class="a">
        <h1 ><strong>实验四 面向对象软件案例分析与开发</strong></h1>

    </div>
    <div class="container">

        <a href="search.jsp" class="nav-link">查找</a>
        <a href="update.jsp" class="nav-link">更新</a>
        <a href="insert.jsp" class="nav-link">插入</a>
        <a href="dele.jsp" class="nav-link">删除</a>
        <a href="upload.jsp" class="nav-link">Excel导入</a>
    </div>
    <div id="background">
        <canvas id="canvas"></canvas>
    </div>
</div>

<script  type="text/javascript" src="js/swiper-bundle.min.js"></script>
<script type="text/javascript">
    // 设置div背景的宽高
    background = document.getElementById("background")
    background.style.width = innerWidth + 'px'
    background.style.height = innerHeight + 'px'


    // 获取canvas对象
    var canvas = document.getElementById("canvas")
    // 获取画笔
    var ctx = canvas.getContext("2d")

    // 设置canvas宽高
    canvas.height = innerHeight
    canvas.width = innerWidth


    // 定义一个粒子数组
    var particlesArray = []
    // 定义页面内粒子的数量
    var count = parseInt(canvas.width / 80 * canvas.height / 80)


    // 定义粒子类
    class Particle {
        constructor(x, y) {
            this.x = x
            this.y = y
            // x，y轴的移动速度  -0.5 -- 0.5
            this.directionX = Math.random() - 0.5
            this.directionY = Math.random() - 0.5
        }

        // 更新点的坐标
        update() {
            this.x += this.directionX
            this.y += this.directionY
        }

        // 绘制粒子
        draw() {
            ctx.beginPath()
            ctx.arc(this.x, this.y, 2, 0, Math.PI * 2)
            ctx.closePath()
            ctx.fillStyle = "white"
            ctx.fill()
        }
    }

    // 创建粒子
    function createParticle() {
        // 生成一个点的随机坐标
        var x = Math.random() * innerWidth
        var y = Math.random() * innerHeight

        particlesArray.push(new Particle(x, y))
    }

    // 处理粒子
    // 先更新坐标，再绘制出来
    function handleParticle() {
        for(var i = 0; i < particlesArray.length; i++) {
            var particle = particlesArray[i]
            particle.update()
            particle.draw()
            // 超出范围就将这个粒子删除
            if(particle.x < 0 || particle.x > canvas.width || particle.y < 0 || particle.y > canvas.height) {
                particlesArray.splice(i, 1)
            }

            // 绘制两个点之间的连线
            for(var j = i + 1; j < particlesArray.length; j++) {
                dx = particlesArray[j].x - particlesArray[i].x
                dy = particlesArray[j].y - particlesArray[i].y
                dist = Math.sqrt(Math.pow(dx, 2) + Math.pow(dy, 2))
                if(dist < 100) {
                    ctx.beginPath()
                    ctx.strokeStyle = "rgba(255, 255, 255, " + (1 - dist / 100)
                    ctx.moveTo(particlesArray[i].x, particlesArray[i].y)
                    ctx.lineTo(particlesArray[j].x, particlesArray[j].y)
                    ctx.closePath()
                    ctx.lineWidth = 1
                    ctx.stroke()
                }
            }
        }
    }

    function draw() {
        // 首先清空画布
        ctx.clearRect(0, 0, canvas.width, canvas.height)
        // 如果粒子数量小于规定数量，就生成新的粒子
        if(particlesArray.length < count) {
            createParticle()
        }

        // 处理粒子
        handleParticle()
    }

    // 设置定时器
    setInterval(draw, 10)

</script>
</body>
</html>

