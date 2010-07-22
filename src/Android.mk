LOCAL_PATH:= $(call my-dir)

# ========================================================
# vim
# ========================================================
include $(CLEAR_VARS)

LOCAL_SRC_FILES:= \
	buffer.c charset.c diff.c digraph.c edit.c eval.c ex_cmds.c ex_cmds2.c \
	ex_docmd.c ex_eval.c ex_getln.c fileio.c fold.c getchar.c hardcopy.c \
	hashtab.c if_cscope.c if_xcmdsrv.c main.c mark.c memfile.c memline.c \
	menu.c message.c misc1.c misc2.c move.c mbyte.c normal.c ops.c option.c \
	os_unix.c auto/pathdef.c popupmnu.c quickfix.c regexp.c screen.c search.c \
	spell.c syntax.c tag.c term.c ui.c undo.c version.c window.c \

LOCAL_C_INCLUDES += \
	$(LOCAL_PATH) \
	$(LOCAL_PATH)/proto \
	$(LOCAL_PATH)/auto

LOCAL_SHARED_LIBRARIES += \
	libncurses

LOCAL_CFLAGS += \
	-DHAVE_CONFIG_H \
	-lncurses

LOCAL_MODULE := vim
LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)
include $(BUILD_EXECUTABLE)

