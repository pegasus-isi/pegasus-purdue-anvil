# pegasus-purdue-anvil

A Jupyter Lab container with Pegasus to be used on Anvil.

Build:

```
docker build -t registry.anvil.rcac.purdue.edu/pegasus/pegasus-notebook:latest .
```

Test:

```
docker run -it --rm -p 8888:8888 registry.anvil.rcac.purdue.edu/pegasus/pegasus-notebook:latest
```

