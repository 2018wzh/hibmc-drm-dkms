KDIR ?= /lib/modules/$(shell uname -r)/build
PWD := $(shell pwd)

.PHONY: all modules clean

all: modules

modules:
	$(MAKE) -C $(KDIR) M=$(PWD)/src CONFIG_DRM_HISI_HIBMC=m modules

clean:
	$(MAKE) -C $(KDIR) M=$(PWD)/src clean
