docker run -d --name feedback-redis -d redis

docker build -t feedback -f docker/Dockerfile . 

docker run -ti -v $(pwd):/app -p 3000:3000 --name feedback --link feedback-redis:redis feedback
