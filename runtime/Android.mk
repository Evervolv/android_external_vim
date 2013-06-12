LOCAL_PATH:= $(call my-dir)

#========================================================
# vim runtime
#========================================================
include $(CLEAR_VARS)

LOCAL_MODULE := vim

runtime_files := \
	scripts.vim \
	indent.vim \
	indoff.vim \
	filetype.vim \
	ftoff.vim

VIM_SHARED := $(TARGET_OUT)/usr/share/$(LOCAL_MODULE)/
VIM_CONFIGS := $(addprefix $(LOCAL_PATH)/,$(runtime_files))
$(VIM_CONFIGS): VIM_BINARY := $(LOCAL_MODULE)
$(VIM_CONFIGS): $(LOCAL_INSTALLED_MODULE)
	@echo "Install: $@ -> $(VIM_SHARED)"
	@mkdir -p $(VIM_SHARED)
	$(hide) cp $@ $(VIM_SHARED)


vim_colors := \
	default.vim \
	desert.vim

VIM_SHARED_COLORS := $(VIM_SHARED)/colors/
VIM_COLORS := $(addprefix $(LOCAL_PATH)/colors/,$(vim_colors))
$(VIM_COLORS): $(VIM_CONFIGS)
	@echo "Install: $@ -> $(VIM_SHARED_COLORS)"
	@mkdir -p $(VIM_SHARED_COLORS)
	$(hide) cp $@ $(VIM_SHARED_COLORS)


vim_syntax := \
	awk.vim \
	config.vim \
	conf.vim \
	cpp.vim \
	c.vim \
	diff.vim \
	doxygen.vim \
	html.vim \
	vb.vim \
	css.vim \
	javascript.vim \
	java.vim \
	manual.vim \
	sh.vim \
	syncolor.vim \
	synload.vim \
	syntax.vim \
	vim.vim

VIM_SHARED_SYNTAX := $(VIM_SHARED)/syntax/
VIM_SYNTAX := $(addprefix $(LOCAL_PATH)/syntax/,$(vim_syntax))
$(VIM_SYNTAX): $(VIM_CONFIGS)
	@echo "Install: $@ -> $(VIM_SHARED_SYNTAX)"
	@mkdir -p $(VIM_SHARED_SYNTAX)
	$(hide) cp $@ $(VIM_SHARED_SYNTAX)

ALL_DEFAULT_INSTALLED_MODULES += $(VIM_CONFIGS) $(VIM_COLORS) $(VIM_SYNTAX)

ALL_MODULES.$(LOCAL_MODULE).INSTALLED := \
    $(ALL_MODULES.$(LOCAL_MODULE).INSTALLED) $(VIM_CONFIGS) $(VIM_COLORS) $(VIM_SYNTAX)

#========================================================
# Vimrc
#========================================================
include $(CLEAR_VARS)

LOCAL_MODULE := vimrc
LOCAL_MODULE_TAGS := eng
LOCAL_MODULE_CLASS := ETC

LOCAL_SRC_FILES := vimrc_example.vim

include $(BUILD_PREBUILT)
