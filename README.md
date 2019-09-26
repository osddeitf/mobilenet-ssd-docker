# MobileNet-SSD for docker

### Run
No need to clone this repository, run the following command, docker will pull from docker hub for you.
~~~bash
docker run -itd osddeitf/mobilenet-ssd-docker
~~~
### Train VOC dataset
- Prepare the `VOCdevkit` folder.
- Run docker images with additional options `--volume=<VOCdevkit parent dir>:/root/data`.

- Install additional Python dependencies.
~~~bash
apt install --no-install-recommends -y python-skimage python-protobuf
~~~

- Prepare dataset. Inside `/ssd/caffe/data/VOC0712` run:
~~~bash
./create_list.sh
./create_data.sh
~~~

- Create symbolic link to dataset.
~~~bash
cd /ssd/mobilenet
mkdir dataset
cd dataset
ln -s $HOME/data/VOCdevkit/VOC0712/lmdb/VOC0712_trainval_lmdb/ trainval_lmdb
ln -s $HOME/data/VOCdevkit/VOC0712/lmdb/VOC0712_test_lmdb/ test_lmdb
ln -s /ssd/caffe/data/VOC0712/labelmap_voc.prototxt
~~~

- Create train .prototxt in `/ssd/mobilenet`
~~~bash
./gen.sh 1.0
~~~
Will create `models/MobileNetSSD_train.prototxt` with `size=1.0`

- Training with `train.sh`.

By default, training will run on GPU 0. If you may want to train with different GPU, feel free to modify `train.sh` yourself