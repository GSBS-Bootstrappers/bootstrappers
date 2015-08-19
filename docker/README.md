Docker for bootstrappers website
=============


#Build  
```{bash}
docker build -t bootstrappers .
```

#Copy out files  
Assumes there is a directory called /data/docker/bootstrappers

```{bash}
docker run -ti --rm -v /data/docker/bootstrappers/:/mnt bootstrappers /root/copyfs.sh
```

#Run container
This will host the site on localhost:8100 which can then be proxied 
```{bash}
./runBootstrappersCon.sh yes
```
