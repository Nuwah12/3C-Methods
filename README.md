## 3C Analysis methods for Faryabi Lab
Hosted here are analysis / processing methods for Chromatin Conformtion Capture (3C) experiments.
* [Faryabi Lab DockerHub](https://hub.docker.com/)
* [Juicer](https://github.com/aidenlab/juicer)
* [Cooler](https://github.com/open2c/cooler)
* [hic2cool](https://github.com/4dn-dcic/hic2cool)
* [Homer](http://homer.ucsd.edu/homer/interactions/)

### Overview of methods included in this repository
#### `/processing`
* **Workflows**: 
* `make_homer_input.sh`: Convert Juicer's `merged_nodup.txt` (or, really any file in [AidenLab's "long" format](https://github.com/aidenlab/juicer/wiki/Pre#long-format)) to a [Homer-compatible format](http://homer.ucsd.edu/homer/interactions/HiCtagDirectory.html). This new input is then used to create a Tag Directory via Homer's `makeTagDirectory`.
#### `/visualization`
* 
#### `/quantify_matrix`
* `FetchPixelFromMatrixGivenBedpe.py`: Given a matrix in `.cool/.mcool` form and a `BEDPE` file of interacting coordinates, extract raw and normalized contact counts.
