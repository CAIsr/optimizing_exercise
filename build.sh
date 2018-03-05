
imageName='fsl_robex'
buildDate=`date +%Y%m%d`

#install neurodocker
#pip3 install --no-cache-dir https://github.com/kaczmarj/neurodocker/tarball/master --user

#upgrade neurodocker
#pip install --no-cache-dir https://github.com/kaczmarj/neurodocker/tarball/master --upgrade

neurodocker generate \
	--base ubuntu:xenial \
	--pkg-manager apt \
	--copy ROBEXv12.linux64.tar.gz /ROBEXv12.linux64.tar.gz \
	--run="tar -xf /ROBEXv12.linux64.tar.gz" \
	--run="rm /ROBEXv12.linux64.tar.gz" \
	--run="ln -s /ROBEX/runROBEX.sh /bin" \
	--install build-essential \
	 	libgtk2.0-dev libgtk-3-dev libwebkitgtk-dev libwebkitgtk-3.0-dev \
		libjpeg-turbo8-dev libtiff5-dev libsdl1.2-dev libgstreamer1.0-dev \
		libgstreamer-plugins-base1.0-dev libnotify-dev freeglut3-dev \
	--fsl version=5.0.10 \
	--user=neuro \
	--workdir /home/neuro \
	--no-check-urls \
	> Dockerfile.${imageName}


sudo docker build -t ${imageName}:$buildDate -f  Dockerfile.${imageName} .

#sudo docker run -it ${imageName}:$buildDate

docker tag ${imageName}:$buildDate caid/${imageName}:$buildDate
#docker login
docker push caid/${imageName}:$buildDate
docker tag ${imageName}:$buildDate caid/${imageName}:latest
docker push caid/${imageName}:latest


echo "BootStrap:docker" > Singularity.${imageName}
echo "From:caid/${imageName}" >> Singularity.${imageName}

sudo singularity build ${imageName}_${buildDate}.simg Singularity.${imageName}

#singularity shell --bind $PWD:/data ${imageName}_${buildDate}.simg
#singularity exec --bind $PWD:/data fsl_robex_20180305.simg runROBEX.sh /data/magnitude.nii.nii /data/stripped.nii /data/mask.nii

