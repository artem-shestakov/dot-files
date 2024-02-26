#!/bin/bash

echo "Check is UEFI Secure Boot Enabled or Disabled"
sudo mokutil --sb-state

echo "Install needed dependencies"
sudo dnf install -y kernel-devel kernel-headers gcc make dkms acpid libglvnd-glx libglvnd-opengl libglvnd-devel pkgconfig

echo "Disable nouveau"
echo "blacklist nouveau" | sudo tee /etc/modprobe.d/blacklist.conf 1>/dev/null 2>&1

echo "Edit /etc/default/grub"
sudo cp /etc/default/grub /etc/default/grub.bkp
sudo sed -r -i 's/(^GRUB_CMDLINE_LINUX=)"(.*)"/\1"\2 rd.driver.blacklist=nouveau nvidia-drm.modeset=1"/' /etc/default/grub

echo "Update grub2 conf"
sudo grub2-mkconfig -o /boot/grub2/grub.cfg

echo "Remove xorg-x11-drv-nouveau"
sudo dnf -y remove xorg-x11-drv-nouveau

echo "Generate initramfs"
sudo mv /boot/initramfs-$(uname -r).img /boot/initramfs-$(uname -r)-nouveau.img
sudo dracut /boot/initramfs-$(uname -r).img $(uname -r)

echo "Reboot to runlevel 3"
sudo systemctl set-default multi-user.target
sudo reboot