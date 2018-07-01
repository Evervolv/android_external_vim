
vim_src := $(call my-dir)

# ========================================================
# etc/vimrc
# ========================================================

LOCAL_PATH := $(vim_src)
include $(CLEAR_VARS)

LOCAL_MODULE := vimrc
LOCAL_MODULE_TAGS := eng
LOCAL_MODULE_CLASS := ETC

LOCAL_SRC_FILES := vimrc.android

include $(BUILD_PREBUILT)

# ========================================================
# vim
# ========================================================

LOCAL_PATH := $(vim_src)/src
include $(CLEAR_VARS)

# vim variants: TINY SMALL CM NORMAL BIG HUGE
#
# NORMAL, BIG and HUGE are almost the same (1.1M)
# TINY and SMALL are similar to busybox vi (460K)
#
# CM profile is between SMALL and NORMAL (780K)
# with syntax and utf8 (mbyte) support
#
vim_variant := CM

LOCAL_SRC_FILES := \
	auto/pathdef.c \
	blowfish.c \
	buffer.c \
	channel.c \
	charset.c \
	dict.c \
	diff.c \
	digraph.c \
	edit.c \
	eval.c \
	evalfunc.c \
	ex_cmds.c \
	ex_cmds2.c \
	ex_docmd.c \
	ex_eval.c \
	ex_getln.c \
	fileio.c \
	fold.c \
	getchar.c \
	hardcopy.c \
	hashtab.c \
	if_cscope.c \
	if_xcmdsrv.c \
	json.c \
	list.c \
	main.c \
	mark.c \
	mbyte.c \
	memfile.c \
	memline.c \
	menu.c \
	message.c \
	misc1.c \
	misc2.c \
	move.c \
	normal.c \
	ops.c \
	option.c \
	os_unix.c \
	popupmnu.c \
	quickfix.c \
	regexp.c \
	screen.c \
	search.c \
	sha256.c \
	spell.c \
	syntax.c \
	tag.c \
	term.c \
	ui.c \
	undo.c \
	userfunc.c \
	version.c \
	window.c

# to reduce vim size, manually define wanted features
ifeq ($(vim_variant),CM)
    LOCAL_CFLAGS += -DFEAT_SMALL=1 -DFEAT_MBYTE=1 \
	-DFEAT_SYN_HL=1 -DFEAT_CINDENT=1 -DFEAT_COMMENTS=1 -DFEAT_EVAL=1 -DFEAT_AUTOCMD=1 \
	-DFEAT_USR_CMDS=1 -DFEAT_EX_EXTRA=1 -DFEAT_CMDL_COMPL=1 \
	-DFEAT_LISTCMDS=1 -DFEAT_CMDL_INFO=1 -DFEAT_SEARCH_EXTRA=1
ifeq ($(TARGET_IS_64_BIT), true)
    LOCAL_CFLAGS += -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=1
endif
endif

LOCAL_C_INCLUDES += \
	external/libselinux/include \
	external/libncurses/include \
	$(LOCAL_PATH)/proto \
	$(LOCAL_PATH)/auto

LOCAL_SHARED_LIBRARIES += \
	libselinux \
	libncurses \
	libm \
	libdl

LOCAL_CFLAGS += \
	-DFEAT_$(vim_variant)=1 \
	-DHAVE_CONFIG_H \
	-DSYS_VIMRC_FILE=\"/system/etc/vimrc\"

LOCAL_MODULE := vim
LOCAL_MODULE_TAGS := eng
LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)
LOCAL_REQUIRED_MODULES := vimrc
include $(BUILD_EXECUTABLE)

# ========================================================
# vim runtime files
# ========================================================
ifeq (vim,$(filter vim, $(ALL_MODULES)))

vim_runtime_path := $(vim_src)/runtime

vim_runtime_files := \
	scripts.vim \
	indent.vim \
	indoff.vim \
	filetype.vim \
	ftoff.vim

vim_doc_files := \
	help.txt intro.txt tags \
	motion.txt editing.txt scroll.txt \
	options.txt term.txt

vim_colors_files := \
	default.vim \
	desert.vim

vim_syntax_files := \
	logcat.vim \
	awk.vim \
	config.vim \
	conf.vim \
	cpp.vim \
	c.vim \
	css.vim \
	diff.vim \
	doxygen.vim \
	html.vim vb.vim \
	xml.vim dtd.vim \
	context.vim \
	gitcommit.vim \
	help.vim \
	javascript.vim \
	java.vim \
	lua.vim \
	manual.vim \
	markdown.vim \
	pod.vim \
	sh.vim \
	syncolor.vim \
	synload.vim \
	syntax.vim \
	vim.vim

vim_plugin_files := \
	matchparen.vim \

vim_autoload_files := \
	spacehi.vim

VIM_SHARED := $(TARGET_OUT)/usr/share/vim

vim_runtime_files := \
  $(vim_runtime_files) \
  $(addprefix doc/, $(vim_doc_files)) \
  $(addprefix colors/, $(vim_colors_files)) \
  $(addprefix syntax/, $(vim_syntax_files)) \
  $(addprefix plugin/, $(vim_plugin_files)) \
  $(addprefix autoload/, $(vim_autoload_files)) \

$(vim_runtime_files): $(LOCAL_BUILT_MODULE)
	@echo "Install: $(VIM_SHARED)/$@"
	@mkdir -p $(dir $(VIM_SHARED)/$@)
	$(hide) cp $(vim_runtime_path)/$@ $(VIM_SHARED)/$@

ALL_DEFAULT_INSTALLED_MODULES += $(vim_runtime_files)

ALL_MODULES.$(LOCAL_MODULE).INSTALLED := \
  $(ALL_MODULES.$(LOCAL_MODULE).INSTALLED) \
  $(addprefix $(VIM_SHARED)/, $(vim_runtime_files))

ifneq ($(filter B wB,$(MAKEFLAGS)),)
# Allow to push runtime files with 'mmp -B'
vim: $(vim_runtime_files)
	@echo "Forced install of runtime files..."
endif

endif
