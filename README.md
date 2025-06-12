# github-actions-runner-dockerized

## run the below commands

git clone repo

### Go to the folder
cd /github-actions-runner-dockerized

### initialize swarm cluster
docker swarm init

### Run the stack
docker stack deploy -c docker-compose.yml gh-runner

### If you want to increase the number of replicas:
you can edit the docker-compose.yml file replicas section and then do "docker stack deploy -c docker-compose.yml gh-runner" again

### 

### Optional (You can modify the Dockerfile if you want to make your own custom image)

