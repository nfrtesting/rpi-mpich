# pi-mpich
MPICH for running on a Raspberry PI cluster (based off NLKNguyen/alpine-mpich and ContinUSE/kubernetes-coreos-cluster examples/mpich)


This repo, running build.sh, updates the jenkinsci/docker and then runs a build.  It generates images for all three flavors with -$ARCH in the tag:
- wroney/rpi-mpich-alpine-$ARCH:latest

On a 32 bit Pi environment, arch is arm7l, under 64 bit for a Pi3 the arch is aarch64.  Three manifest yamls are provided for use with [estesp/manifest-tool](https://github.com/estesp/manifest-tool).  This allows multi-arch manifesting for the two images as:
- wroney/rpi-mpich-alpine:latest

>./manifest-tool push from-spec manifest-alpine.yaml

# BUILD ERRORS INFORMATION!
When building on a Raspberry Pi 3+ (1GB) for the aarch64 variant (using Hypriot 64 bit) you will get an error 137/error4 from the MPICC compile for mpi4py.  Googling for this will leave you scratching your head for quite a while.  The problem is memory, as the error codes so clearly give you no hint!  Get around it with this sequence:
1.  Shutdown everything you can.  I pulled a node from my kubernetes cluster, brought down kubelet and made certain no docker containers were running (done by removeing from the k8s cluster)
2.  Add a small USB drive to the Raspberry Pi3.  You may need to install ntfs-3g in order for the drive to not be read-only due to the issues with the standard ntfs drivers.  ntfs-3g /dev/sda1 /mnt/edrive is the command used for the remainder of this sequence.
3.  dd if=/dev/zero of=/mnt/edrive/swapfile.swp bs=1M count=1024  #this creates a 1GB swapfile
4.  chmod 600 /mnt/edrive/swapfile.swp #remove permissions warning
5.  mkswap /mnt/edrive/swapfile.swp
6.  swapon /mnt/edrive/swapfile.swp
If you run top, you'll now see you have 1GB of swap available.  When you are done using this Pi as a build instance, make sure you remove swap since that will mess up k8s:  swapoff /mnt/edrive/swapfile.swp
