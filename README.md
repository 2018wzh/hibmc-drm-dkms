# hibmc-drm DKMS module

This repository packages the HiSilicon BMC DRM driver under `src/` as an external kernel module that can be built/installed via DKMS.

## Layout
- `src/`: driver sources and kernel Makefile (Kbuild compatible)
- `dkms.conf`: DKMS configuration
- `Makefile`: convenience wrapper for local builds (not required by DKMS)

## Prerequisites
Install headers and toolchain matching your running kernel:

```bash
# Debian/Ubuntu
sudo apt install build-essential linux-headers-(uname -r)

# RHEL/CentOS/Fedora
sudo dnf install @development-tools kernel-devel-(uname -r)
```

If Secure Boot is enabled, sign the module or disable Secure Boot before loading; otherwise the module may fail to load.

## Build & install with DKMS
From the repository root (where `dkms.conf` lives):

```bash
# Register this source with DKMS
sudo dkms add .

# Build the module
sudo dkms build hibmc-drm/3c7623f

# Install the module
sudo dkms install hibmc-drm/3c7623f

# Load the module (optional)
sudo modprobe hibmc-drm
```

Remove/clean:

```bash
sudo dkms remove hibmc-drm/3c7623f --all
```

## Local build (optional, without DKMS)
Use the top-level Makefile to build as an external module:

```bash
make
make clean
```

The wrapper invokes the kernel build system in `src/` and forces `CONFIG_DRM_HISI_HIBMC=m` to enable the module target.

## Notes
- Kernel headers path: ensure `/lib/modules/(uname -r)/build` exists, or override with `make KDIR=/path/to/kernel/build`.
- If you hit missing symbols/API changes, verify the target kernel's DRM interfaces match this source; for older/newer kernels, minor compatibility tweaks may be required based on compiler errors.