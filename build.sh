
imageName='fsl_robex'
buildDate=`date +%Y%m%d`

#install neurodocker
#pip3 install --no-cache-dir https://github.com/kaczmarj/neurodocker/tarball/master --user

#upgrade neurodocker
#pip install --no-cache-dir https://github.com/kaczmarj/neurodocker/tarball/master --upgrade

neurodocker generate \
	--base neurodebian:stretch-non-free \
	--pkg-manager apt \
	--user=neuro \
	--workdir /home/neuro \
	--no-check-urls \
	> Dockerfile_${imageName}

#	--fsl version=5.0.10 \

sudo docker build -t ${imageName}:$buildDate -f  Dockerfile_${imageName} .

