LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

MY_ROOT := ../..

common_CFLAGS := -Wpointer-arith -Wwrite-strings -Wunused -Winline -Wnested-externs -Wmissing-declarations -Wmissing-prototypes -Wno-long-long -Wfloat-equal -Wno-multichar -Wsign-compare -Wno-format-nonliteral -Wendif-labels -Wstrict-prototypes -Wdeclaration-after-statement -Wno-system-headers -DHAVE_CURL_CONFIG_H 

LOCAL_C_INCLUDES := \
	../../thirdparty/jbig2dec \
	../../thirdparty/openjpeg/libopenjpeg \
	../../thirdparty/jpeg \
	../../thirdparty/mujs \
	../../thirdparty/zlib \
	../../thirdparty/freetype/include \
	../../scripts/freetype \
	../../scripts/jpeg \
	../../scripts/openjpeg \
	../../thirdparty/curl/lib \
	../../thirdparty/curl/include

LOCAL_CFLAGS := \
	-DFT2_BUILD_LIBRARY -DDARWIN_NO_CARBON -DHAVE_STDINT_H \
	-DOPJ_HAVE_STDINT_H \
	'-DFT_CONFIG_MODULES_H="slimftmodules.h"' \
	'-DFT_CONFIG_OPTIONS_H="slimftoptions.h"'
ifdef NDK_PROFILER
LOCAL_CFLAGS += -pg -DNDK_PROFILER -O2
endif
ifdef MEMENTO
LOCAL_CFLAGS += -DMEMENTO -DMEMENTO_LEAKONLY
endif

LOCAL_CFLAGS += $(common_CFLAGS)

LOCAL_MODULE := mupdfthirdparty
LOCAL_SRC_FILES := \
	$(MY_ROOT)/thirdparty/mujs/one.c \
	$(MY_ROOT)/thirdparty/jbig2dec/jbig2.c \
	$(MY_ROOT)/thirdparty/jbig2dec/jbig2_arith.c \
	$(MY_ROOT)/thirdparty/jbig2dec/jbig2_arith_iaid.c \
	$(MY_ROOT)/thirdparty/jbig2dec/jbig2_arith_int.c \
	$(MY_ROOT)/thirdparty/jbig2dec/jbig2_generic.c \
	$(MY_ROOT)/thirdparty/jbig2dec/jbig2_halftone.c \
	$(MY_ROOT)/thirdparty/jbig2dec/jbig2_huffman.c \
	$(MY_ROOT)/thirdparty/jbig2dec/jbig2_image.c \
	$(MY_ROOT)/thirdparty/jbig2dec/jbig2_metadata.c \
	$(MY_ROOT)/thirdparty/jbig2dec/jbig2_mmr.c \
	$(MY_ROOT)/thirdparty/jbig2dec/jbig2_page.c \
	$(MY_ROOT)/thirdparty/jbig2dec/jbig2_refinement.c \
	$(MY_ROOT)/thirdparty/jbig2dec/jbig2_segment.c \
	$(MY_ROOT)/thirdparty/jbig2dec/jbig2_symbol_dict.c \
	$(MY_ROOT)/thirdparty/jbig2dec/jbig2_text.c \
	$(MY_ROOT)/thirdparty/openjpeg/libopenjpeg/bio.c \
	$(MY_ROOT)/thirdparty/openjpeg/libopenjpeg/cidx_manager.c \
	$(MY_ROOT)/thirdparty/openjpeg/libopenjpeg/cio.c \
	$(MY_ROOT)/thirdparty/openjpeg/libopenjpeg/dwt.c \
	$(MY_ROOT)/thirdparty/openjpeg/libopenjpeg/event.c \
	$(MY_ROOT)/thirdparty/openjpeg/libopenjpeg/function_list.c \
	$(MY_ROOT)/thirdparty/openjpeg/libopenjpeg/image.c \
	$(MY_ROOT)/thirdparty/openjpeg/libopenjpeg/invert.c \
	$(MY_ROOT)/thirdparty/openjpeg/libopenjpeg/j2k.c \
	$(MY_ROOT)/thirdparty/openjpeg/libopenjpeg/jp2.c \
	$(MY_ROOT)/thirdparty/openjpeg/libopenjpeg/mct.c \
	$(MY_ROOT)/thirdparty/openjpeg/libopenjpeg/mqc.c \
	$(MY_ROOT)/thirdparty/openjpeg/libopenjpeg/openjpeg.c \
	$(MY_ROOT)/thirdparty/openjpeg/libopenjpeg/opj_clock.c \
	$(MY_ROOT)/thirdparty/openjpeg/libopenjpeg/phix_manager.c \
	$(MY_ROOT)/thirdparty/openjpeg/libopenjpeg/pi.c \
	$(MY_ROOT)/thirdparty/openjpeg/libopenjpeg/ppix_manager.c \
	$(MY_ROOT)/thirdparty/openjpeg/libopenjpeg/raw.c \
	$(MY_ROOT)/thirdparty/openjpeg/libopenjpeg/t1.c \
	$(MY_ROOT)/thirdparty/openjpeg/libopenjpeg/t1_generate_luts.c \
	$(MY_ROOT)/thirdparty/openjpeg/libopenjpeg/t2.c \
	$(MY_ROOT)/thirdparty/openjpeg/libopenjpeg/tcd.c \
	$(MY_ROOT)/thirdparty/openjpeg/libopenjpeg/tgt.c \
	$(MY_ROOT)/thirdparty/openjpeg/libopenjpeg/thix_manager.c \
	$(MY_ROOT)/thirdparty/openjpeg/libopenjpeg/tpix_manager.c \
	$(MY_ROOT)/thirdparty/jpeg/jaricom.c \
	$(MY_ROOT)/thirdparty/jpeg/jcomapi.c \
	$(MY_ROOT)/thirdparty/jpeg/jdapimin.c \
	$(MY_ROOT)/thirdparty/jpeg/jdapistd.c \
	$(MY_ROOT)/thirdparty/jpeg/jdarith.c \
	$(MY_ROOT)/thirdparty/jpeg/jdatadst.c \
	$(MY_ROOT)/thirdparty/jpeg/jdatasrc.c \
	$(MY_ROOT)/thirdparty/jpeg/jdcoefct.c \
	$(MY_ROOT)/thirdparty/jpeg/jdcolor.c \
	$(MY_ROOT)/thirdparty/jpeg/jddctmgr.c \
	$(MY_ROOT)/thirdparty/jpeg/jdhuff.c \
	$(MY_ROOT)/thirdparty/jpeg/jdinput.c \
	$(MY_ROOT)/thirdparty/jpeg/jdmainct.c \
	$(MY_ROOT)/thirdparty/jpeg/jdmarker.c \
	$(MY_ROOT)/thirdparty/jpeg/jdmaster.c \
	$(MY_ROOT)/thirdparty/jpeg/jdmerge.c \
	$(MY_ROOT)/thirdparty/jpeg/jdpostct.c \
	$(MY_ROOT)/thirdparty/jpeg/jdsample.c \
	$(MY_ROOT)/thirdparty/jpeg/jdtrans.c \
	$(MY_ROOT)/thirdparty/jpeg/jerror.c \
	$(MY_ROOT)/thirdparty/jpeg/jfdctflt.c \
	$(MY_ROOT)/thirdparty/jpeg/jfdctfst.c \
	$(MY_ROOT)/thirdparty/jpeg/jfdctint.c \
	$(MY_ROOT)/thirdparty/jpeg/jidctflt.c \
	$(MY_ROOT)/thirdparty/jpeg/jidctfst.c \
	$(MY_ROOT)/thirdparty/jpeg/jidctint.c \
	$(MY_ROOT)/thirdparty/jpeg/jmemmgr.c \
	$(MY_ROOT)/thirdparty/jpeg/jmemnobs.c \
	$(MY_ROOT)/thirdparty/jpeg/jquant1.c \
	$(MY_ROOT)/thirdparty/jpeg/jquant2.c \
	$(MY_ROOT)/thirdparty/jpeg/jutils.c \
	$(MY_ROOT)/thirdparty/zlib/adler32.c \
	$(MY_ROOT)/thirdparty/zlib/compress.c \
	$(MY_ROOT)/thirdparty/zlib/crc32.c \
	$(MY_ROOT)/thirdparty/zlib/deflate.c \
	$(MY_ROOT)/thirdparty/zlib/inffast.c \
	$(MY_ROOT)/thirdparty/zlib/inflate.c \
	$(MY_ROOT)/thirdparty/zlib/inftrees.c \
	$(MY_ROOT)/thirdparty/zlib/trees.c \
	$(MY_ROOT)/thirdparty/zlib/uncompr.c \
	$(MY_ROOT)/thirdparty/zlib/zutil.c \
	$(MY_ROOT)/thirdparty/freetype/src/base/ftbase.c \
	$(MY_ROOT)/thirdparty/freetype/src/base/ftbbox.c \
	$(MY_ROOT)/thirdparty/freetype/src/base/ftbitmap.c \
	$(MY_ROOT)/thirdparty/freetype/src/base/ftgasp.c \
	$(MY_ROOT)/thirdparty/freetype/src/base/ftglyph.c \
	$(MY_ROOT)/thirdparty/freetype/src/base/ftinit.c \
	$(MY_ROOT)/thirdparty/freetype/src/base/ftstroke.c \
	$(MY_ROOT)/thirdparty/freetype/src/base/ftsynth.c \
	$(MY_ROOT)/thirdparty/freetype/src/base/ftsystem.c \
	$(MY_ROOT)/thirdparty/freetype/src/base/fttype1.c \
	$(MY_ROOT)/thirdparty/freetype/src/base/ftxf86.c \
	$(MY_ROOT)/thirdparty/freetype/src/cff/cff.c \
	$(MY_ROOT)/thirdparty/freetype/src/cid/type1cid.c \
	$(MY_ROOT)/thirdparty/freetype/src/psaux/psaux.c \
	$(MY_ROOT)/thirdparty/freetype/src/pshinter/pshinter.c \
	$(MY_ROOT)/thirdparty/freetype/src/psnames/psnames.c \
	$(MY_ROOT)/thirdparty/freetype/src/raster/raster.c \
	$(MY_ROOT)/thirdparty/freetype/src/smooth/smooth.c \
	$(MY_ROOT)/thirdparty/freetype/src/sfnt/sfnt.c \
	$(MY_ROOT)/thirdparty/freetype/src/truetype/truetype.c \
	$(MY_ROOT)/thirdparty/freetype/src/type1/type1.c \
	$(MY_ROOT)/thirdparty/curl/lib/file.c \
	$(MY_ROOT)/thirdparty/curl/lib/timeval.c \
	$(MY_ROOT)/thirdparty/curl/lib/base64.c \
	$(MY_ROOT)/thirdparty/curl/lib/hostip.c \
	$(MY_ROOT)/thirdparty/curl/lib/progress.c \
	$(MY_ROOT)/thirdparty/curl/lib/formdata.c \
	$(MY_ROOT)/thirdparty/curl/lib/cookie.c \
	$(MY_ROOT)/thirdparty/curl/lib/http.c \
	$(MY_ROOT)/thirdparty/curl/lib/sendf.c \
	$(MY_ROOT)/thirdparty/curl/lib/ftp.c \
	$(MY_ROOT)/thirdparty/curl/lib/url.c \
	$(MY_ROOT)/thirdparty/curl/lib/dict.c \
	$(MY_ROOT)/thirdparty/curl/lib/speedcheck.c \
	$(MY_ROOT)/thirdparty/curl/lib/ldap.c \
	$(MY_ROOT)/thirdparty/curl/lib/ssluse.c \
	$(MY_ROOT)/thirdparty/curl/lib/version.c \
	$(MY_ROOT)/thirdparty/curl/lib/getenv.c \
	$(MY_ROOT)/thirdparty/curl/lib/escape.c \
	$(MY_ROOT)/thirdparty/curl/lib/mprintf.c \
	$(MY_ROOT)/thirdparty/curl/lib/telnet.c \
	$(MY_ROOT)/thirdparty/curl/lib/netrc.c \
	$(MY_ROOT)/thirdparty/curl/lib/getinfo.c \
	$(MY_ROOT)/thirdparty/curl/lib/transfer.c \
	$(MY_ROOT)/thirdparty/curl/lib/strequal.c \
	$(MY_ROOT)/thirdparty/curl/lib/easy.c \
	$(MY_ROOT)/thirdparty/curl/lib/security.c \
	$(MY_ROOT)/thirdparty/curl/lib/krb4.c \
	$(MY_ROOT)/thirdparty/curl/lib/krb5.c \
	$(MY_ROOT)/thirdparty/curl/lib/memdebug.c \
	$(MY_ROOT)/thirdparty/curl/lib/http_chunks.c \
	$(MY_ROOT)/thirdparty/curl/lib/strtok.c \
	$(MY_ROOT)/thirdparty/curl/lib/connect.c \
	$(MY_ROOT)/thirdparty/curl/lib/llist.c \
	$(MY_ROOT)/thirdparty/curl/lib/hash.c \
	$(MY_ROOT)/thirdparty/curl/lib/multi.c \
	$(MY_ROOT)/thirdparty/curl/lib/content_encoding.c \
	$(MY_ROOT)/thirdparty/curl/lib/share.c \
	$(MY_ROOT)/thirdparty/curl/lib/http_digest.c \
	$(MY_ROOT)/thirdparty/curl/lib/md5.c \
	$(MY_ROOT)/thirdparty/curl/lib/curl_rand.c \
	$(MY_ROOT)/thirdparty/curl/lib/http_negotiate.c \
	$(MY_ROOT)/thirdparty/curl/lib/inet_pton.c \
	$(MY_ROOT)/thirdparty/curl/lib/strtoofft.c \
	$(MY_ROOT)/thirdparty/curl/lib/strerror.c \
	$(MY_ROOT)/thirdparty/curl/lib/hostasyn.c \
	$(MY_ROOT)/thirdparty/curl/lib/hostip4.c \
	$(MY_ROOT)/thirdparty/curl/lib/hostip6.c \
	$(MY_ROOT)/thirdparty/curl/lib/hostsyn.c \
	$(MY_ROOT)/thirdparty/curl/lib/inet_ntop.c \
	$(MY_ROOT)/thirdparty/curl/lib/parsedate.c \
	$(MY_ROOT)/thirdparty/curl/lib/select.c \
	$(MY_ROOT)/thirdparty/curl/lib/gtls.c \
	$(MY_ROOT)/thirdparty/curl/lib/sslgen.c \
	$(MY_ROOT)/thirdparty/curl/lib/tftp.c \
	$(MY_ROOT)/thirdparty/curl/lib/splay.c \
	$(MY_ROOT)/thirdparty/curl/lib/strdup.c \
	$(MY_ROOT)/thirdparty/curl/lib/socks.c \
	$(MY_ROOT)/thirdparty/curl/lib/ssh.c \
	$(MY_ROOT)/thirdparty/curl/lib/nss.c \
	$(MY_ROOT)/thirdparty/curl/lib/qssl.c \
	$(MY_ROOT)/thirdparty/curl/lib/rawstr.c \
	$(MY_ROOT)/thirdparty/curl/lib/curl_addrinfo.c \
	$(MY_ROOT)/thirdparty/curl/lib/socks_gssapi.c \
	$(MY_ROOT)/thirdparty/curl/lib/socks_sspi.c \
	$(MY_ROOT)/thirdparty/curl/lib/curl_sspi.c \
	$(MY_ROOT)/thirdparty/curl/lib/slist.c \
	$(MY_ROOT)/thirdparty/curl/lib/nonblock.c \
	$(MY_ROOT)/thirdparty/curl/lib/fopen.c \
	$(MY_ROOT)/thirdparty/curl/lib/conncache.c \
	$(MY_ROOT)/thirdparty/curl/lib/warnless.c \
	$(MY_ROOT)/thirdparty/curl/lib/pipeline.c \
	$(MY_ROOT)/thirdparty/curl/lib/wildcard.c \
	$(MY_ROOT)/thirdparty/curl/lib/bundles.c \
	$(MY_ROOT)/thirdparty/curl/lib/fileinfo.c \
	$(MY_ROOT)/thirdparty/curl/lib/if2ip.c

LOCAL_SRC_FILES := $(addprefix ../, $(LOCAL_SRC_FILES))

include $(BUILD_STATIC_LIBRARY)