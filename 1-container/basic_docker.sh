git clone https://github.com/ngoprek-kubernetes/kudemo.git && cd kudemo/halo

docker build --tag kudemo-halo:1.0 .

docker run --publish 8000:8080 --detach --name halo kudemo-halo:1.0

docker rm --force halo