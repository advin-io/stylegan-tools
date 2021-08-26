# StyleGAN2-ADA-PyTorch Toolset

![Teaser image](./docs/projected.png)

## Description

This is my toolset for [StyleGAN2-ADA-PyTorch](https://github.com/NVlabs/stylegan2-ada-pytorch/).

### Requirements

* [Nvidia Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html)

## Docker

Build the image and run with

```bash
user@host:~$ cd stylegan-tools # move to repo directory
user@host:~$ docker/docker_build.sh # call others the same way
user@host:~$ docker/docker_run.sh # call others the same way
```

## Utilities

All utilities can be found under [utils/](./utils) and can be called with

```bash
user@host:~$ cd stylegan-tools # move to repo directory
user@host:~$ utils/Download.sh # call others the same way
```

* [Download.sh](./utils/Download.sh) - Download tool for limited datasets and most pretrained models. (you will need shape-predictor)
* [AlignFaces.sh](./utils/AlignFaces.sh) - Single-instance human face alignment via Nvidia's [FFHQ method](https://github.com/NVlabs/ffhq-dataset/blob/master/download_ffhq.py). (required before projections can be done)
* [ProjectImage.sh](./utils/ProjectImage.sh) - Projects a single input image into latent space (allows you to blend styles)
* [GenerateImage.sh](./utils/GenerateImage.sh) - Use the Generator to create a new image based on an output seed of the pretrained model. Not too useful, but a nice "Hello world"
