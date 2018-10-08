express = require 'express'
io = require 'socket.io'
http = require 'http'

fire = require('socket.io-emitter')({host: 'feedback-redis', port: 6379})
redisAdapter = require 'socket.io-redis'

app = express()
server = http.createServer app
io = io server, adapter: redisAdapter(host: 'feedback-redis')

app.use express.static 'public'

app.get '/', (req, res) -> 
	res.sendFile(__dirname + '/index.html')

fire.redis.on 'error', console.log

io.on 'connect', (socket) -> 
	socket.emit 'news', hello: 'world'
	socket.on 'my other event', (data) ->
		fire.emit 'time', hello: 'world'
		console.log data

setInterval () ->
  fire.emit('time', new Date);
, 5000

server.listen 3000, () ->
	console.log "server stared at http://localhost:3000"