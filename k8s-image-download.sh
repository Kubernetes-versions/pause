#!/bin/bash
# KISS
# download images
# get image-list by 'kubeadm config images list'
# registry.cn-qingdao.aliyuncs.com/$imageName == k8s.gcr.io
rm -rf /tmp/version.txt
kubeadm config images list --kubernetes-version=${version} |awk -F'/' '{print $NF}' >> /tmp/version.txt
for imageName in `cat /tmp/version.txt`; do
	docker pull registry.cn-qingdao.aliyuncs.com/k8s-github/$imageName
	docker tag  registry.cn-qingdao.aliyuncs.com/k8s-github/$imageName k8s.gcr.io/$imageName
	docker rmi  registry.cn-qingdao.aliyuncs.com/k8s-github/$imageName
done
