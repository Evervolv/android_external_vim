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


copy_to := $(addprefix $(TARGET_OUT)/usr/share/$(LOCAL_MODULE)/,$(runtime_files))
$(copy_to) : PRIVATE_MODULE := system_sharedir
$(copy_to) : $(TARGET_OUT)/usr/share/$(LOCAL_MODULE)/% : $(LOCAL_PATH)/% | $(ACP)
	$(transform-prebuilt-to-target)


ALL_PREBUILT += $(copy_to)

