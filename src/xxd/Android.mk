LOCAL_PATH:= $(call my-dir)

# ========================================================
# xxd (hex editor)
# ========================================================
include $(CLEAR_VARS)

LOCAL_SRC_FILES:= \
	xxd.c

LOCAL_CFLAGS := -DUNIX

LOCAL_MODULE := xxd
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)
include $(BUILD_EXECUTABLE)

