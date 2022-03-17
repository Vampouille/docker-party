# Docker Party

Share docker socket with somebody else.

SHARING DOCKER SOCKET MEANS THAT YOU GIVE A FULL ADMINISTRATIVE ACCESS TO YOUR
HOST. THIS PROJECT IS FOR TRAINING PURPOSE.

## Usage

Start the "house" part of the project. You will need the IP address and port
where the "house" can be reach.

```shell
docker run --rm --name house -e HOUSE_USER=root -e HOUSE_HOST=<host ip> -e HOUSE_PORT=<port> -p <port>:22 vampouille/docker-party-house:latest
```

This container will generate a SSH key pair and a script to connect to the
"house".

Finally, retrieve and share the script:

```shell
docker cp house:/tmp/dancer.sh /tmp/dancer.sh
```

Share your local `/tmp/dancer.sh` script.

## Dancers

People that use your `dancer.sh` script will have to set their name.

Then, you can access the docker socket from "dancers".

## Manage dancers

You can list "dancers" with:

```shell
docker exec house dancer list
```

You can select a specific "dancer" with:

```shell
docker exec house dancer use <id of dancer>
```

Finally, you run docker command on the specific "dancer" workstation:

```shell
docker exec house docker ps
```
