Build the Docker image locally (and call it dwimperl)

```
cd perl-docker/
docker build -t dwimperl .
```

Run the 'dwimperl' image as a Docker container and open a Linux shell.
When we exit the shell the container is destroyed.

```
docker run --rm -it dwimperl
```

Same as above but also map the current working directory to the /opt inside the Docker container
This only works on Unix systems:

```
docker run --rm -it -v $(pwd):/opt dwimperl
```

Same on Windwos looks something like this:

```
docker run --rm -it -v c:/users/gabor/dwimperl:/opt dwimperl
```
