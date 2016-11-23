NODEJS_GIT_REPOSITORY = https://github.com/nodejs/node.git
NODEJS_VERSION = v6.5.0

ifeq ($(OS),Windows_NT)
	OPERATING_SYSTEM = win32
else
	UNAME_S := $(shell uname -s)
	ifeq ($(UNAME_S),Linux)
		OPERATING_SYSTEM = linux
	endif
	ifeq ($(UNAME_S),Darwin)
		OPERATING_SYSTEM = darwin
	endif
endif

ifeq ($(OS),Windows_NT)
	MKDIR_P = cmd.exe /c md
	RM_RF = cmd.exe /c rd /s /q
	CP = cmd.exe /c copy
else
	MKDIR_P = mkdir -p
	RM_RF = rm -rf
	CP = cp
endif

node:
	git clone --depth 1 --branch $(NODEJS_VERSION) $(NODEJS_GIT_REPOSITORY) $@
	git -C $@ am --ignore-whitespace < patches/static-entry-point.patch

out:
	$(MKDIR_P) $@

out/node-$(OPERATING_SYSTEM)-x64: node out
	cd $< && ./configure --dest-cpu x64 && make -j 4
	$(CP) $</out/Release/node $@

out/node-$(OPERATING_SYSTEM)-x86: node out
	cd $< && ./configure --dest-cpu x86 && make -j 4
	$(CP) $</out/Release/node $@

out/node-$(OPERATING_SYSTEM)-x86.exe: node out
	cd $< && ./vcbuild.bat release nosign x86
	$(CP) $<\Release\node.exe $(subst /,\,$@)

out/node-$(OPERATING_SYSTEM)-x64.exe: node out
	cd $< && ./vcbuild.bat release nosign x64
	$(CP) $<\Release\node.exe $(subst /,\,$@)

.PHONY: build-x64 build-x86 clean

ifeq ($(OS),Windows_NT)
build-x64: out/node-$(OPERATING_SYSTEM)-x64.exe
build-x86: out/node-$(OPERATING_SYSTEM)-x86.exe
endif
ifeq ($(OPERATING_SYSTEM),darwin)
build-x64: out/node-$(OPERATING_SYSTEM)-x64
endif
ifeq ($(OPERATING_SYSTEM),linux)
build-x64: out/node-$(OPERATING_SYSTEM)-x64
build-x86: out/node-$(OPERATING_SYSTEM)-x86
endif

clean:
	$(RM_RF) node
	$(RM_RF) out
