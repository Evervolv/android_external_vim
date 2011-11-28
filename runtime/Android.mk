LOCAL_PATH:= $(call my-dir)
#========================================================
# vim runtime
# ========================================================
include $(CLEAR_VARS)

LOCAL_MODULE := vim

runtime_files := \
	$(shell cd $(LOCAL_PATH) && ls -1 colors/*.vim) \
	scripts.vim \
	indent.vim \
	indoff.vim \
	filetype.vim \
	ftoff.vim 

VIM_SHARED := $(TARGET_OUT)/usr/share/$(LOCAL_MODULE)/
VIM_CONFIGS := $(addprefix $(LOCAL_PATH)/runtime/,$(runtime_files))
$(VIM_CONFIGS): VIM_BINARY := $(LOCAL_MODULE)
$(VIM_CONFIGS): $(LOCAL_INSTALLED_MODULE)
	@echo "Install: $@ -> $(VIM_SHARED)"
	@mkdir -p $(VIM_SHARED)
	$(hide) cp $@ $(VIM_SHARED)

ALL_DEFAULT_INSTALLED_MODULES += $(VIM_CONFIGS)

ALL_MODULES.$(LOCAL_MODULE).INSTALLED := \
    $(ALL_MODULES.$(LOCAL_MODULE).INSTALLED) $(VIM_CONFIGS)

