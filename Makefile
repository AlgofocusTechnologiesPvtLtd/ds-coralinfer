LIB:=libnvdsgst_coralinfer.so

NVDS_VERSION?=5.0

GST_INSTALL_DIR?=/opt/nvidia/deepstream/deepstream-$(NVDS_VERSION)/lib/gst-plugins/

install: $(LIB)
	cp -rv $(LIB) $(GST_INSTALL_DIR)

